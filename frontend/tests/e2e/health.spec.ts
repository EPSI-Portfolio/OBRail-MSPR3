import { test, expect } from '@playwright/test'

test.describe('Page État du Service', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/health')
  })

  test('la page état du service se charge correctement', async ({ page }) => {
    await expect(page.locator('#page-title-health')).toBeVisible()
    await expect(page.locator('#status-section')).toBeVisible()
  })

  test('l\'indicateur de statut s\'affiche', async ({ page }) => {
    await expect(page.locator('#status-indicator')).toBeVisible()
    await expect(page.locator('#status-dot')).toBeVisible()
    await expect(page.locator('#status-label')).toBeVisible()
  })

  test('le bouton actualiser fonctionne', async ({ page }) => {
    await expect(page.locator('#refresh-btn')).toBeVisible()
    await page.locator('#refresh-btn').click()
    // Vérifie que le loader apparaît puis disparaît
    await expect(page.locator('#status-indicator')).toBeVisible({ timeout: 5000 })
  })

  test('le lien Grafana est présent', async ({ page }) => {
    await expect(page.locator('#grafana-link')).toBeVisible()
    await expect(page.locator('#grafana-link')).toHaveAttribute('target', '_blank')
  })

  test('la dernière vérification s\'affiche après le check', async ({ page }) => {
    await expect(page.locator('#last-checked')).toBeVisible({ timeout: 8000 })
  })
})