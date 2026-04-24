import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test('ホームページの critical 違反はゼロ', async ({ page }) => {
  await page.goto('http://localhost:3000');
  const results = await new AxeBuilder({ page })
    .withTags(['wcag2aa', 'wcag21aa', 'wcag22aa'])
    .analyze();
  const critical = results.violations.filter(v => v.impact === 'critical');
  expect(critical).toEqual([]);
});
