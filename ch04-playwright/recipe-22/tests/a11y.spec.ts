import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

const BASE_URL = process.env.BASE_URL ?? 'http://localhost:3000';

// WCAG 2.2 AA = 2.0/2.1/2.2 の レベル A + AA をすべて含める
const WCAG22_AA_TAGS = ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'wcag22aa'];

const pages = [
  { name: 'トップ', path: '/' },
  { name: '商品詳細', path: '/products/1' },
  { name: 'カート', path: '/cart' },
];

for (const { name, path } of pages) {
  test(`${name}ページのWCAG 2.2 AA準拠`, async ({ page }, testInfo) => {
    await page.goto(`${BASE_URL}${path}`);
    await page.waitForLoadState('networkidle');

    const results = await new AxeBuilder({ page })
      .withTags(WCAG22_AA_TAGS)
      .analyze();

    // 全結果を HTML レポートに添付（CI の artifact から確認できる）
    await testInfo.attach(`axe-${name}.json`, {
      body: JSON.stringify(results, null, 2),
      contentType: 'application/json',
    });

    // 失敗時に読みやすい形で違反を表示
    const summary = results.violations.map(v => ({
      id: v.id,
      impact: v.impact,
      help: v.help,
      helpUrl: v.helpUrl,
      targets: v.nodes.map(n => n.target.join(' ')),
    }));

    expect(summary, `${name}ページ (${path}) に WCAG 2.2 AA 違反があります`).toEqual([]);
  });
}
