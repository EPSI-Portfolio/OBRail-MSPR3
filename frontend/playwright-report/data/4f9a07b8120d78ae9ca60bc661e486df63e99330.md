# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: stats.spec.ts >> Page Statistiques >> le graphique en barres s'affiche
- Location: tests\e2e\stats.spec.ts:20:3

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('#bar-chart-section')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('#bar-chart-section')

```

# Page snapshot

```yaml
- generic [ref=e2]:
  - generic [ref=e3]:
    - link "Vite logo" [ref=e4] [cursor=pointer]:
      - /url: https://vite.dev
      - img "Vite logo" [ref=e5]
    - link "React logo" [ref=e6] [cursor=pointer]:
      - /url: https://react.dev
      - img "React logo" [ref=e7]
  - heading "Vite + React + TypeScript" [level=1] [ref=e8]
  - generic [ref=e9]:
    - button "count is 0" [ref=e10] [cursor=pointer]
    - paragraph [ref=e11]:
      - text: Edit
      - code [ref=e12]: src/App.tsx
      - text: and save to test HMR
  - button "Call API" [ref=e14] [cursor=pointer]
  - paragraph [ref=e15]: Click on the Vite and React logos to learn more
```

# Test source

```ts
  1  | import { test, expect } from '@playwright/test'
  2  | 
  3  | test.describe('Page Statistiques', () => {
  4  |   test.beforeEach(async ({ page }) => {
  5  |     await page.goto('/stats')
  6  |   })
  7  | 
  8  |   test('la page statistiques se charge correctement', async ({ page }) => {
  9  |     await expect(page.locator('#page-title-stats')).toBeVisible()
  10 |   })
  11 | 
  12 |   test('les KPIs s\'affichent', async ({ page }) => {
  13 |     await expect(page.locator('#loader')).not.toBeVisible({ timeout: 8000 })
  14 |     await expect(page.locator('#kpi-total')).toBeVisible()
  15 |     await expect(page.locator('#kpi-day')).toBeVisible()
  16 |     await expect(page.locator('#kpi-night')).toBeVisible()
  17 |     await expect(page.locator('#kpi-countries')).toBeVisible()
  18 |   })
  19 | 
  20 |   test('le graphique en barres s\'affiche', async ({ page }) => {
  21 |     await expect(page.locator('#loader')).not.toBeVisible({ timeout: 8000 })
> 22 |     await expect(page.locator('#bar-chart-section')).toBeVisible()
     |                                                      ^ Error: expect(locator).toBeVisible() failed
  23 |     await expect(page.locator('#bar-chart')).toBeVisible()
  24 |   })
  25 | 
  26 |   test('le graphique circulaire s\'affiche', async ({ page }) => {
  27 |     await expect(page.locator('#loader')).not.toBeVisible({ timeout: 8000 })
  28 |     await expect(page.locator('#pie-chart-section')).toBeVisible()
  29 |     await expect(page.locator('#pie-chart')).toBeVisible()
  30 |   })
  31 | })
```