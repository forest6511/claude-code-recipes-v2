-- remind-inactive-users.ts / bulk-sync.ts 用のダミーデータ
-- スキーマ: users(id, email, name, last_order_at) / orders(user_id, amount, created_at)
--   last_order_at は orders の最新 created_at を非正規化して持つ（bulk-sync.ts が参照）
-- 外部ユーザー = @example.com 以外（ここでは予約ドメイン example.org / example.net を使用）
BEGIN;

CREATE TABLE IF NOT EXISTS users (
  id            serial PRIMARY KEY,
  email         text UNIQUE,
  name          text,
  last_order_at timestamptz,
  created_at    timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE users ADD COLUMN IF NOT EXISTS last_order_at timestamptz;

CREATE TABLE IF NOT EXISTS orders (
  id         serial PRIMARY KEY,
  user_id    integer NOT NULL REFERENCES users(id),
  amount     integer NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS orders_user_id_created_at_idx ON orders (user_id, created_at);

INSERT INTO users (id, email, name) VALUES
  -- 社内 (@example.com)
  ( 1, 'sato@example.com',      '佐藤 花子'),   -- 最終注文 2 日前   → 対象外
  ( 2, 'suzuki@example.com',    '鈴木 一郎'),   -- 最終注文 10 日前  → 対象外
  ( 3, 'takahashi@example.com', '高橋 健太'),   -- 最終注文 45 日前  → 対象
  ( 4, 'tanaka@example.com',    '田中 美咲'),   -- 最終注文 90 日前  → 対象
  ( 5, 'ito@example.com',       NULL),          -- 最終注文 60 日前  → 対象（名前なし）
  ( 6, 'watanabe@example.com',  '渡辺 翔'),     -- 注文なし (NULL)   → bulk-sync では対象外
  ( 7, NULL,                    '山本 直子'),   -- email なし・5 日前 → 対象外
  ( 8, 'nakamura@example.com',  '中村 優'),     -- 境界 29 日前      → 対象外
  ( 9, 'kobayashi@example.com', '小林 陽介'),   -- 境界 31 日前      → 対象
  -- 外部
  (10, 'alice@example.org',     'Alice Smith'), -- 最終注文 50 日前  → 対象（外部）
  (11, 'bob@example.net',       'Bob Jones'),   -- 最終注文 3 日前   → 対象外
  (12, 'carol@example.org',     'Carol White'), -- 注文なし (NULL)   → bulk-sync では対象外
  (13, 'dave@example.net',      'Dave Brown')   -- 最終注文 100 日前 → 対象（外部）
ON CONFLICT (id) DO NOTHING;
SELECT setval('users_id_seq', (SELECT max(id) FROM users));

INSERT INTO orders (user_id, amount, created_at) VALUES
  ( 1, 3200, now() - interval '2 days'),
  ( 1, 1500, now() - interval '40 days'),
  ( 2, 8900, now() - interval '10 days'),
  ( 3, 2400, now() - interval '45 days'),
  ( 4, 5600, now() - interval '90 days'),
  ( 4,  980, now() - interval '120 days'),
  ( 5, 1200, now() - interval '60 days'),
  ( 7, 4300, now() - interval '5 days'),
  ( 8, 2100, now() - interval '29 days'),
  ( 9, 3300, now() - interval '31 days'),
  (10, 7700, now() - interval '50 days'),
  (11, 2600, now() - interval '3 days'),
  (13, 4100, now() - interval '100 days'),
  (13, 1900, now() - interval '200 days');

-- orders から last_order_at を埋める
UPDATE users u
SET last_order_at = o.max_at
FROM (SELECT user_id, max(created_at) AS max_at FROM orders GROUP BY user_id) o
WHERE o.user_id = u.id;

-- readonly ロールに参照権限を付与
GRANT SELECT ON users, orders TO claude_readonly;

COMMIT;
