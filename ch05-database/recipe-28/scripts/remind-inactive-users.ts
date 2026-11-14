/**
 * 過去 N 日（既定 30 日）に注文が 0 件のユーザーへリマインドメールを送る。
 *
 *   1. Postgres から対象ユーザーを取得
 *   2. ユーザーごとに Notion「顧客メモ」データソースから最新メモを取得
 *   3. メール送信（既定は dry-run。実送信は --send を付けたときだけ）
 *
 * ⚠ 前提（仮定）— 実環境に合わせて CONFIG / SQL を修正すること
 *   - Postgres: users(id, email, name) と orders(user_id, created_at) がある
 *   - Notion:   「顧客メモ」に Email 型プロパティ「メール」と
 *               リッチテキスト型プロパティ「メモ」がある
 *   - メール:   "MailKit SDK" は TypeScript 向けのものが確認できなかったため、
 *               Mailer インターフェースの背後で Nodemailer を仮実装している
 *
 * 実行例:
 *   npx tsx scripts/remind-inactive-users.ts            # dry-run（送信しない）
 *   npx tsx scripts/remind-inactive-users.ts --send     # 実送信
 *
 * 必要な環境変数:
 *   DATABASE_URL                 Postgres DSN（読み取り専用ユーザーで十分）
 *   NOTION_TOKEN                 Notion インテグレーションのトークン
 *   NOTION_MEMO_DATA_SOURCE_ID   「顧客メモ」のデータソース ID
 *   SMTP_URL                     例: smtps://user:pass@smtp.example.com:465（--send 時のみ必須）
 *   MAIL_FROM                    例: "Example Shop <noreply@example.com>"（--send 時のみ必須）
 *   INACTIVE_DAYS                省略時 30
 */
import pg from "pg";
import { Client as NotionClient, isFullPage } from "@notionhq/client";
import nodemailer from "nodemailer";

// ---------------------------------------------------------------------------
// 設定
// ---------------------------------------------------------------------------

const CONFIG = {
  inactiveDays: Number(process.env.INACTIVE_DAYS ?? 30),
  notion: {
    // TODO: 実際の「顧客メモ」DB のプロパティ名に合わせる
    emailProperty: "メール",
    memoProperty: "メモ",
    /** 1 ユーザーあたり取得するメモの件数（新しい順） */
    memosPerUser: 3,
  },
  /** Notion API のレート制限（平均 3 req/s）を超えないための待機時間 */
  notionIntervalMs: 350,
} as const;

const SEND = process.argv.includes("--send");

function requireEnv(name: string): string {
  const v = process.env[name];
  if (!v) throw new Error(`環境変数 ${name} が設定されていません`);
  return v;
}

// ---------------------------------------------------------------------------
// 1. Postgres: 過去 N 日に注文 0 件のユーザー
// ---------------------------------------------------------------------------

type InactiveUser = {
  id: number;
  email: string;
  name: string | null;
  /** 期間を問わず 1 件でも注文があるか（文面の出し分けに使う） */
  has_ordered: boolean;
};

// 「過去 N 日に注文 0 件」には、これまで一度も注文していないユーザーも含まれる。
// 除外したい場合は EXISTS (… 期間を問わない注文 …) の条件を追加する。
// TODO: テーブル名・カラム名を実際のスキーマに合わせる
const INACTIVE_USERS_SQL = `
  SELECT u.id, u.email, u.name,
         EXISTS (SELECT 1 FROM orders o2 WHERE o2.user_id = u.id) AS has_ordered
  FROM users u
  WHERE u.email IS NOT NULL
    AND NOT EXISTS (
      SELECT 1
      FROM orders o
      WHERE o.user_id = u.id
        AND o.created_at >= now() - make_interval(days => $1::int)
    )
  ORDER BY u.id
`;

async function fetchInactiveUsers(databaseUrl: string, days: number): Promise<InactiveUser[]> {
  const client = new pg.Client({ connectionString: databaseUrl });
  await client.connect();
  try {
    const { rows } = await client.query<InactiveUser>(INACTIVE_USERS_SQL, [days]);
    return rows;
  } finally {
    await client.end();
  }
}

// ---------------------------------------------------------------------------
// 2. Notion: 顧客メモ
// ---------------------------------------------------------------------------

async function fetchMemos(notion: NotionClient, dataSourceId: string, email: string): Promise<string[]> {
  const res = await notion.dataSources.query({
    data_source_id: dataSourceId,
    filter: { property: CONFIG.notion.emailProperty, email: { equals: email } },
    sorts: [{ timestamp: "created_time", direction: "descending" }],
    page_size: CONFIG.notion.memosPerUser,
  });

  const memos: string[] = [];
  for (const page of res.results) {
    if (!isFullPage(page)) continue;
    const prop = page.properties[CONFIG.notion.memoProperty];
    if (prop?.type !== "rich_text") continue;
    const text = prop.rich_text.map((t) => t.plain_text).join("").trim();
    if (text) memos.push(text);
  }
  return memos;
}

// ---------------------------------------------------------------------------
// 3. メール送信（送信手段は Mailer の実装を差し替えれば変更できる）
// ---------------------------------------------------------------------------

type MailMessage = { to: string; subject: string; text: string };

interface Mailer {
  send(msg: MailMessage): Promise<void>;
}

class NodemailerMailer implements Mailer {
  private transport;
  constructor(smtpUrl: string, private from: string) {
    this.transport = nodemailer.createTransport(smtpUrl);
  }
  async send(msg: MailMessage): Promise<void> {
    await this.transport.sendMail({ from: this.from, ...msg });
  }
}

class DryRunMailer implements Mailer {
  async send(msg: MailMessage): Promise<void> {
    console.log(`--- [dry-run] To: ${msg.to}\nSubject: ${msg.subject}\n\n${msg.text}\n`);
  }
}

// ⚠「顧客メモ」が社内向けのメモなら、本文にそのまま載せると顧客に内部情報が漏れる。
//   顧客に見せてよい専用プロパティを読むか、メモは文面の選択だけに使うよう調整すること。
function buildMessage(user: InactiveUser, memos: string[]): MailMessage {
  // 名前がない場合は「お客様」単独にする（「お客様 様」にしない）
  const greeting = user.name ? `${user.name} 様` : "お客様";
  // 一度も注文していないユーザーに「最後のご注文から…」と書かない
  const intro = user.has_ordered
    ? `いつもご利用ありがとうございます。最後のご注文から ${CONFIG.inactiveDays} 日以上が経ちました。`
    : "ご登録いただきありがとうございます。";
  const lines = [
    greeting,
    "",
    intro,
    "新着商品やお得な情報をご用意していますので、ぜひまたお立ち寄りください。",
  ];
  if (memos.length > 0) {
    lines.push("", ...memos.map((m) => `・${m}`));
  }
  return { to: user.email, subject: "お久しぶりです — 新着のご案内", text: lines.join("\n") };
}

// ---------------------------------------------------------------------------
// main
// ---------------------------------------------------------------------------

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));

async function main() {
  const databaseUrl = requireEnv("DATABASE_URL");
  const notion = new NotionClient({ auth: requireEnv("NOTION_TOKEN") });
  const dataSourceId = requireEnv("NOTION_MEMO_DATA_SOURCE_ID");
  const mailer: Mailer = SEND
    ? new NodemailerMailer(requireEnv("SMTP_URL"), requireEnv("MAIL_FROM"))
    : new DryRunMailer();

  const users = await fetchInactiveUsers(databaseUrl, CONFIG.inactiveDays);
  console.log(`対象ユーザー: ${users.length} 件（${SEND ? "送信" : "dry-run"}）`);

  let sent = 0;
  const failures: { email: string; error: string }[] = [];

  for (const user of users) {
    try {
      const memos = await fetchMemos(notion, dataSourceId, user.email);
      await mailer.send(buildMessage(user, memos));
      sent++;
    } catch (err) {
      // 1 件の失敗で全体を止めず、最後にまとめて報告する
      failures.push({ email: user.email, error: err instanceof Error ? err.message : String(err) });
    }
    await sleep(CONFIG.notionIntervalMs);
  }

  console.log(`完了: 成功 ${sent} 件 / 失敗 ${failures.length} 件`);
  for (const f of failures) console.error(`  失敗: ${f.email} — ${f.error}`);
  if (failures.length > 0) process.exitCode = 1;
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
