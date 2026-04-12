# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: health.spec.ts >> Page État du Service >> le bouton actualiser fonctionne
- Location: tests\e2e\health.spec.ts:19:3

# Error details

```
Error: expect(locator).toBeVisible() failed

Locator: locator('#refresh-btn')
Expected: visible
Timeout: 5000ms
Error: element(s) not found

Call log:
  - Expect "toBeVisible" with timeout 5000ms
  - waiting for locator('#refresh-btn')

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
  3  | test.describe('Page État du Service', () => {
  4  |   test.beforeEach(async ({ page }) => {
  5  |     await page.goto('/health')
  6  |   })
  7  | 
  8  |   test('la page état du service se charge correctement', async ({ page }) => {
  9  |     await expect(page.locator('#page-title-health')).toBeVisible()
  10 |     await expect(page.locator('#status-section')).toBeVisible()
  11 |   })
  12 | 
  13 |   test('l\'indicateur de statut s\'affiche', async ({ page }) => {
  14 |     await expect(page.locator('#status-indicator')).toBeVisible()
  15 |     await expect(page.locator('#status-dot')).toBeVisible()
  16 |     await expect(page.locator('#status-label')).toBeVisible()
  17 |   })
  18 | 
  19 |   test('le bouton actualiser fonctionne', async ({ page }) => {
> 20 |     await expect(page.locator('#refresh-btn')).toBeVisible()
     |                                                ^ Error: expect(locator).toBeVisible() failed
  21 |     await page.locator('#refresh-btn').click()
  22 |     // Vérifie que le loader apparaît puis disparaît
  23 |     await expect(page.locator('#status-indicator')).toBeVisible({ timeout: 5000 })
  24 |   })
  25 | 
  26 |   test('le lien Grafana est présent', async ({ page }) => {
  27 |     await expect(page.locator('#grafana-link')).toBeVisible()
  28 |     await expect(page.locator('#grafana-link')).toHaveAttribute('target', '_blank')
  29 |   })
  30 | 
  31 |   test('la dernière vérification s\'affiche après le check', async ({ page }) => {
  32 |     await expect(page.locator('#last-checked')).toBeVisible({ timeout: 8000 })
  33 |   })
  34 | })
```