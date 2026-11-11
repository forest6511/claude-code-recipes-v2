// recipe-22 用デモサーバー（依存なし）: /, /products/1, /cart
const http = require('http');

const NAV = [['/', 'トップ'], ['/products/1', '商品詳細'], ['/cart', 'カート']];
const navItems = (current) => NAV.map(([href, label]) =>
  `      <li><a href="${href}"${href === current ? ' aria-current="page"' : ''}>${label}</a></li>`).join('\n');

const layout = (title, body, current) => `<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title} | デモストア</title>
<style>
  body { font-family: system-ui, sans-serif; margin: 0; color: #1a1a1a; background: #fff; }
  header, main, footer { padding: 16px 24px; }
  header { background: #1f3a5f; color: #fff; }
  header a { color: #fff; }
  nav ul { list-style: none; display: flex; gap: 16px; padding: 0; margin: 8px 0 0; }
  nav a { display: inline-block; padding: 8px 4px; min-height: 24px; }
  /* WCAG 1.4.11: 白背景では紺、紺背景(header)ではオレンジ → どちらも 3:1 以上 */
  a:focus-visible, button:focus-visible, input:focus-visible { outline: 3px solid #1f3a5f; outline-offset: 2px; }
  header a:focus-visible { outline-color: #f5a623; }
  nav a[aria-current="page"] { font-weight: bold; text-decoration-thickness: 3px; }
  /* WCAG 2.4.1: スキップリンク（フォーカス時のみ表示） */
  .skip-link { position: absolute; left: 8px; top: -100px; background: #fff; color: #1f3a5f; padding: 8px 12px; z-index: 10; }
  .skip-link:focus { top: 8px; }
  .hint { color: #444; margin: 4px 0; }
  .error { color: #b00020; font-weight: bold; margin: 4px 0; }
  input[aria-invalid="true"] { border: 2px solid #b00020; }
  button { font-size: 1rem; padding: 10px 16px; background: #1f3a5f; color: #fff; border: 0; border-radius: 4px; cursor: pointer; }
  footer { border-top: 1px solid #ccc; color: #444; }
</style>
</head>
<body>
<a class="skip-link" href="#main">本文へスキップ</a>
<header>
  <p><a href="/">デモストア</a></p>
  <nav aria-label="メイン">
    <ul>
${navItems(current)}
    </ul>
  </nav>
</header>
<main id="main" tabindex="-1">
${body}
</main>
<footer><p>&copy; 2026 デモストア</p></footer>
</body>
</html>`;

const pages = {
  '/': layout('トップ', `
  <h1>デモストアへようこそ</h1>
  <h2>おすすめ商品</h2>
  <ul>
    <li><a href="/products/1">ノートパソコン スタンドの詳細を見る</a></li>
  </ul>`, '/'),
  '/products/1': layout('ノートパソコン スタンド', `
  <h1>ノートパソコン スタンド</h1>
  <p>価格: 3,980円（税込）</p>
  <p>アルミ製で角度を6段階に調整できるスタンドです。</p>
  <form id="add-form" action="/cart" method="get" novalidate>
    <label for="qty">数量</label>
    <input id="qty" name="qty" type="number" min="1" value="1" inputmode="numeric"
           aria-describedby="qty-hint qty-error">
    <p id="qty-hint" class="hint">1以上の整数を入力してください</p>
    <p id="qty-error" class="error" role="alert"></p>
    <button type="submit">カートに追加</button>
  </form>
  <script>
    // WCAG 3.3.1 / 3.3.3: エラーをテキストで示し、aria-describedby / aria-invalid で入力欄に関連付ける
    document.getElementById('add-form').addEventListener('submit', (e) => {
      const qty = document.getElementById('qty');
      const err = document.getElementById('qty-error');
      const v = qty.value.trim();
      const msg = v === '' ? '数量を入力してください'
        : !/^\\d+$/.test(v) || Number(v) < 1 ? '数量は1以上の整数で入力してください（例: 1）'
        : '';
      err.textContent = msg;
      if (msg) {
        e.preventDefault();
        qty.setAttribute('aria-invalid', 'true');
        qty.focus();
      } else {
        qty.removeAttribute('aria-invalid');
      }
    });
  </script>`, '/products/1'),
  '/cart': layout('カート', `
  <h1>カート</h1>
  <table>
    <caption>カート内の商品</caption>
    <thead><tr><th scope="col">商品</th><th scope="col">数量</th><th scope="col">小計</th></tr></thead>
    <tbody><tr><td>ノートパソコン スタンド</td><td>1</td><td>3,980円</td></tr></tbody>
  </table>
  <p><button type="button">購入手続きへ進む</button></p>`, '/cart'),
};

http.createServer((req, res) => {
  const path = new URL(req.url, 'http://localhost').pathname;
  if (path === '/sitemap.xml') {
    res.writeHead(200, { 'Content-Type': 'application/xml; charset=utf-8' });
    return res.end(`<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${Object.keys(pages).map(p => `  <url><loc>http://localhost:3000${p}</loc></url>`).join('\n')}
</urlset>`);
  }
  const html = pages[path];
  res.writeHead(html ? 200 : 404, { 'Content-Type': 'text/html; charset=utf-8' });
  res.end(html ?? layout('見つかりません', '<h1>ページが見つかりません</h1>'));
}).listen(3000, () => console.log('Listening on http://localhost:3000'));
