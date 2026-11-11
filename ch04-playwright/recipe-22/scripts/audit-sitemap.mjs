// sitemap.xml の全URLを WCAG 2.2 AA で監査する（axe-core + 意味的チェック + フォーカス枠コントラスト）
// 使い方: node scripts/audit-sitemap.mjs [sitemapのURL]（既定: http://localhost:3000/sitemap.xml）
import { chromium } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
const SITEMAP = process.argv[2] ?? 'http://localhost:3000/sitemap.xml';
const xml = await (await fetch(SITEMAP)).text();
const urls = [...xml.matchAll(/<loc>\s*([^<]+?)\s*<\/loc>/g)].map(m => m[1]);
console.log('URLs:', urls);
const b = await chromium.launch();
const ctx = await b.newContext();
const out = {};
for (const url of urls) {
  const p = await ctx.newPage();
  const res = await p.goto(url); await p.waitForLoadState('networkidle');
  const axe = await new AxeBuilder({ page: p }).withTags(['wcag2a','wcag2aa','wcag21a','wcag21aa','wcag22aa']).analyze();
  const sem = await p.evaluate(() => {
    const issues = [];
    const hs = [...document.querySelectorAll('h1,h2,h3,h4,h5,h6')].map(h => +h.tagName[1]);
    if (!hs.includes(1)) issues.push(['heading', 'h1なし']);
    hs.forEach((l, i) => { if (i && l - hs[i-1] > 1) issues.push(['heading', `h${hs[i-1]}→h${l}`]); });
    const vague = /^(こちら|ここ|詳細|詳しく|もっと見る|続きを読む|click here|here|more|read more)$/i;
    document.querySelectorAll('a').forEach(a => { const t = (a.getAttribute('aria-label') || a.textContent).trim(); if (vague.test(t)) issues.push(['vague-link', `"${t}" -> ${a.getAttribute('href')}`]); });
    document.querySelectorAll('input:not([type=hidden]),select,textarea').forEach(i => {
      if (!i.labels?.length && !i.getAttribute('aria-label') && !i.getAttribute('aria-labelledby')) issues.push(['label', `#${i.id||i.name} ラベルなし`]);
      const constrained = i.required || i.min || i.max || i.pattern || i.type === 'email' || i.type === 'number';
      if (constrained && !i.getAttribute('aria-describedby') && !i.form?.noValidate) issues.push(['error-assoc', `#${i.id||i.name}: 制約付き入力にaria-describedbyなし（ブラウザ標準の検証のみ）`]);
    });
    for (const [sel, name] of [['main,[role=main]','main'],['nav,[role=navigation]','nav'],['footer,[role=contentinfo]','footer']]) {
      const n = document.querySelectorAll(sel).length; if (n !== 1 && !(name==='nav' && n>1)) issues.push(['landmark', `${name}: ${n}個`]);
    }
    if (!document.querySelector('a[href^="#"]')) issues.push(['skip-link', 'スキップリンクなし']);
    const here = location.pathname;
    const navCur = [...document.querySelectorAll('nav a')].find(a => a.getAttribute('href') === here);
    if (navCur && navCur.getAttribute('aria-current') !== 'page') issues.push(['aria-current', `nav "${navCur.textContent.trim()}" にaria-currentなし`]);
    return issues;
  });
  // focus-ring contrast via Tab
  const lum = c => { const [r,g,b] = c.match(/\d+/g).slice(0,3).map(v => { v/=255; return v<=0.03928? v/12.92 : ((v+0.055)/1.055)**2.4; }); return 0.2126*r+0.7152*g+0.0722*b; };
  const ratio = (a,b) => { const [x,y] = [lum(a),lum(b)].sort((m,n)=>n-m); return (x+0.05)/(y+0.05); };
  const focusIssues = [];
  for (let i = 0; i < 40; i++) {
    await p.keyboard.press('Tab');
    const f = await p.evaluate(() => { const e = document.activeElement; if (!e || e === document.body) return null;
      const cs = getComputedStyle(e); let n = e.parentElement, bg = 'rgba(0, 0, 0, 0)';
      while (n && (bg = getComputedStyle(n).backgroundColor) === 'rgba(0, 0, 0, 0)') n = n.parentElement;
      if (bg === 'rgba(0, 0, 0, 0)') bg = 'rgb(255, 255, 255)';
      return { label: (e.textContent.trim() || e.value || e.tagName).slice(0,30), tag: e.tagName.toLowerCase(), outline: cs.outlineStyle === 'none' ? null : cs.outlineColor, bg }; });
    if (!f) break;
    if (!f.outline) focusIssues.push(`${f.tag} "${f.label}": フォーカス枠なし`);
    else { const r = ratio(f.outline, f.bg); if (r < 3) focusIssues.push(`${f.tag} "${f.label}": 枠${f.outline} / 背景${f.bg} = ${r.toFixed(2)}:1`); }
  }
  out[url] = { status: res.status(), axe: axe.violations.map(v => ({ id: v.id, impact: v.impact, tags: v.tags.filter(t=>/^wcag\d/.test(t)), help: v.help, nodes: v.nodes.map(n=>n.target.join(' ')) })), sem, focusIssues: [...new Set(focusIssues)] };
  await p.close();
}
await b.close();
console.log(JSON.stringify(out, null, 1));
