import { test, expect } from '@playwright/test'

test.describe('Page Statistiques', () => {

  test.beforeEach(async ({ page }) => {
    await page.goto('/stats')
  })

  test('la page statistiques se charge correctement', async ({ page }) => {
    await    await expect(page.locator('#page-title-stats')).toBeVisible()
  })

  test('les KPIs s\'affichent', async ({ page }) => {
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 8000 })

    await expect(page.locator('#kpi-total')).toBeVisible()
    await expect(page.locator('#kpi-day')).toBeVisible()
    await expect(page.locator('#kpi-night')).toBeVisible()
    await expect(page.locator('#kpi-countries')).toBeVisible()
  })

  test('le graphique en barres s\'affiche', async ({ page }) => {
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 8000 })

    await expect(page.locator('#bar-chart-section')).toBeVisible()
    await expect(page.locator('#bar-chart')).toBeVisible()
  })

        test('le graphique circulaire s\'affiche', async ({ page }) => {
  // Activer l'onglet Émissions CO₂
  await page.getByRole('tab', { name: 'Émissions CO₂' }).click()

  // Attendre que la section et le graphique apparaissent
  await expect(page.getByTestId('pie-chart-section')).toBeVisible()
  await expect(page.getByTestId('pie-chart')).toBeVisible({ timeout: 10000 })
})

})