import { test, expect } from '@playwright/test'

test.describe('Page Liste des Trajets', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/trajets')
  })

  test('la page d\'accueil se charge correctement', async ({ page }) => {
    await expect(page).toHaveTitle(/ObRail/)
    await expect(page.locator('#page-title-trajets')).toBeVisible()
    await expect(page.locator('#trajets-list')).toBeVisible()
  })

  test('la barre de recherche filtre les trajets', async ({ page }) => {
    await page.locator('#search-input').fill('Paris')
    await page.locator('#search-btn').click()
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 5000 })
    await expect(page.locator('#results-count')).toBeVisible()
  })

  test('le filtre jour/nuit fonctionne', async ({ page }) => {
    await page.locator('#service-type-filter').selectOption('night')
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 5000 })
    const cards = page.locator('.tcard--night')
    await expect(cards.first()).toBeVisible()
  })

  test('le filtre opérateur fonctionne', async ({ page }) => {
    await page.locator('#operator-filter').selectOption('SNCF')
    await page.locator('#search-btn').click()
    await expect(page.locator('#loader')).not.toBeVisible({ timeout: 5000 })
    await expect(page.locator('#results-count')).toBeVisible()
  })

  test('la pagination fonctionne', async ({ page }) => {
    const nextBtn = page.locator('#next-page-btn')
    if (await nextBtn.isVisible()) {
      const pageBefore = await page.locator('#current-page').textContent()
      await nextBtn.click()
      const pageAfter = await page.locator('#current-page').textContent()
      expect(pageBefore).not.toBe(pageAfter)
    }
  })

  test('un clic sur une carte navigue vers le détail', async ({ page }) => {
    await page.locator('.tcard').first().click()
    await expect(page).toHaveURL(/\/trajets\/\d+/)
    await expect(page.locator('#trajet-detail')).toBeVisible()
  })
})