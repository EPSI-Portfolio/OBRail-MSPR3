import { test, expect } from '@playwright/test'

test.describe('Page Statistiques', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/stats')
  })

  test('la page statistiques se charge correctement', async ({ page }) => {
    await expect(page.locator('#page-title-stats')).toBeVisible({ timeout: 15000 })
  })

  test('les KPIs s\'affichent', async ({ page }) => {
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 15000 })
    await expect(page.locator('#kpi-total')).toBeVisible({ timeout: 15000 })
    await expect(page.locator('#kpi-day')).toBeVisible({ timeout: 15000 })
    await expect(page.locator('#kpi-night')).toBeVisible({ timeout: 15000 })
    await expect(page.locator('#kpi-countries')).toBeVisible({ timeout: 15000 })
  })

  test('le graphique en barres s\'affiche', async ({ page }) => {
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 15000 })
    await expect(page.locator('#bar-chart-section')).toBeVisible({ timeout: 15000 })
    await expect(page.locator('#bar-chart')).toBeVisible({ timeout: 15000 })
  })

  test('le graphique circulaire s\'affiche', async ({ page }) => {
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 15000 })
    await expect(page.locator('#pie-chart-section')).toBeVisible({ timeout: 15000 })
    await expect(page.locator('#pie-chart')).toBeVisible({ timeout: 15000 })
  })
})