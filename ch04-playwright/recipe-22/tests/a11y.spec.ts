import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

const pages = [
  { name: 'トップ', path: '/' },
  { name: '商品詳細', path: '/products/1' },
  { name: 'カート', path: '/cart' },
];

for (const { name, path } of pages) {
  test(`${name}ページのWCAG 2.2 AA準拠`, async ({ page }) => {
    await page.goto(`http://localhost:3000${path}`);

    const results = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa', 'wcag21aa', 'wcag22aa', 'best-practice'])
      .analyze();

    expect(results.violations).toEqual([]);
  });
}
