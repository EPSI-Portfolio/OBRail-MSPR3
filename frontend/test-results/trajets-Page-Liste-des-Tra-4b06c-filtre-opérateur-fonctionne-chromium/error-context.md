# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: trajets.spec.ts >> Page Liste des Trajets >> le filtre opérateur fonctionne
- Location: tests\e2e\trajets.spec.ts:29:3

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.selectOption: Test timeout of 30000ms exceeded.
Call log:
  - waiting for locator('#operator-filter')

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
  3  | test.describe('Page Liste des Trajets', () => {
  4  |   test.beforeEach(async ({ page }) => {
  5  |     await page.goto('/trajets')
  6  |   })
  7  | 
  8  |   test('la page d\'accueil se charge correctement', async ({ page }) => {
  9  |     await expect(page).toHaveTitle(/ObRail/)
  10 |     await expect(page.locator('#page-title-trajets')).toBeVisible()
  11 |     await expect(page.locator('#trajets-list')).toBeVisible()
  12 |   })
  13 | 
  14 |   test('la barre de recherche filtre les trajets', async ({ page }) => {
  15 |     await page.locator('#search-input').fill('Paris')
  16 |     await page.locator('#search-btn').click()
  17 |     await expect(page.locator('#loader')).not.toBeVisible({ timeout: 5000 })
  18 |     await expect(page.locator('#results-count')).toBeVisible()
  19 |   })
  20 | 
  21 |   test('le filtre jour/nuit fonctionne', async ({ page }) => {
  22 |     await page.locator('#service-type-filter').selectOption('night')
  23 |     await expect(page.locator('#loader')).not.toBeVisible({ timeout: 5000 })
  24 |     // Toutes les cartes visibles doivent être de nuit
  25 |     const cards = page.locator('.trajet-card.night')
  26 |     await expect(cards.first()).toBeVisible()
  27 |   })
  28 | 
  29 |   test('le filtre opérateur fonctionne', async ({ page }) => {
> 30 |     await page.locator('#operator-filter').selectOption('SNCF')
     |                                            ^ Error: locator.selectOption: Test timeout of 30000ms exceeded.
  31 |     await page.locator('#search-btn').click()
  32 |     await expect(page.locator('#loader')).not.toBeVisible({ timeout: 5000 })
  33 |     await expect(page.locator('#results-count')).toBeVisible()
  34 |   })
  35 | 
  36 |   test('la pagination fonctionne', async ({ page }) => {
  37 |     const nextBtn = page.locator('#next-page-btn')
  38 |     if (await nextBtn.isVisible()) {
  39 |       const pageBefore = await page.locator('#current-page').textContent()
  40 |       await nextBtn.click()
  41 |       const pageAfter = await page.locator('#current-page').textContent()
  42 |       expect(pageBefore).not.toBe(pageAfter)
  43 |     }
  44 |   })
  45 | 
  46 |   test('un clic sur une carte navigue vers le détail', async ({ page }) => {
  47 |     await page.locator('.trajet-card').first().click()
  48 |     await expect(page).toHaveURL(/\/trajets\/\d+/)
  49 |     await expect(page.locator('#trajet-detail')).toBeVisible()
  50 |   })
  51 | })
```