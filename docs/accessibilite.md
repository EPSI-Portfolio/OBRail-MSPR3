# Déclaration d'accessibilité — ObRail Europe

## Contexte et engagement

Le frontend d'ObRail Europe a été conçu dans une démarche d'accessibilité
numérique, conformément aux exigences du **Référentiel Général d'Amélioration de
l'Accessibilité (RGAA)**, qui transpose en France la norme européenne
**EN 301 549 V2.1.2** et les recommandations **WCAG 2.1** (Web Content
Accessibility Guidelines).

Le niveau de conformité visé est **WCAG 2.1 niveau AA**.

Cette déclaration décrit le niveau d'accessibilité atteint, les techniques mises
en œuvre, les résultats des tests réalisés et les limites connues, dans un esprit
de transparence.

---

## Niveau de conformité

L'application est **partiellement conforme** au niveau AA des WCAG 2.1.
« Partiellement conforme » signifie que la majorité des critères sont respectés,
mais que certains points, identifiés et documentés ci-dessous, restent à
améliorer.

### Résultats des audits automatisés (Lighthouse)

Des audits d'accessibilité ont été réalisés avec **Google Lighthouse**
(catégorie Accessibilité), page par page, sur l'application en fonctionnement :

| Page | Score Lighthouse (Accessibilité) |
|---|---|
| Liste des trajets (`/trajets`) | **96 / 100** |
| Statistiques (`/stats`) | **95 / 100** |

Ces scores traduisent un bon niveau d'accessibilité. Les audits automatisés ne
couvrant qu'une partie des critères, ils sont complétés par les choix de
conception décrits ci-dessous.

---

## Techniques d'accessibilité mises en œuvre

L'accessibilité a été intégrée dès la conception de l'interface, et non ajoutée
a posteriori. Les mesures suivantes sont présentes dans le code :

### Navigation au clavier

- **Lien d'évitement** (« skip link ») permettant aux utilisateurs au clavier
  d'atteindre directement le contenu principal sans parcourir la navigation
  (critère WCAG 2.4.1).
- **Indicateurs de focus visibles** sur tous les éléments interactifs, via une
  règle `:focus-visible` appliquant un contour net (critère WCAG 2.4.7).
- Aucun `tabindex` supérieur à 0, garantissant un ordre de tabulation naturel et
  cohérent.

### Structure sémantique

- Région principale identifiée par une balise `<main>` (landmark), facilitant la
  navigation avec les technologies d'assistance.
- Hiérarchie de titres respectant un ordre séquentiel (h1 → h2 → h3) sans saut de
  niveau.
- Langue de la page déclarée (`<html lang="fr">`), permettant aux lecteurs
  d'écran de prononcer correctement le contenu (critère WCAG 3.1.1).
- Un élément `<title>` descriptif est présent sur chaque page.

### ARIA et lecteurs d'écran

- Système d'onglets de la page Statistiques implémenté avec les rôles ARIA
  appropriés (`role="tablist"`, `role="tab"`, `role="tabpanel"`) et les attributs
  d'état (`aria-selected`, `aria-controls`).
- Classe utilitaire `sr-only` fournissant du texte réservé aux lecteurs d'écran
  (visuellement masqué mais annoncé).
- Icônes décoratives marquées `aria-hidden="true"` pour ne pas polluer la
  restitution vocale.
- Attributs ARIA valides et cohérents avec les rôles utilisés (confirmé par
  l'audit Lighthouse).

### Adaptabilité et confort visuel

- **Interface responsive** avec points de rupture à 1024 px, 768 px et 480 px :
  le contenu se réorganise sans perte d'information ni défilement horizontal
  (critère WCAG 1.4.10).
- **Tailles de police fluides** (`clamp()`) qui s'adaptent à la taille de l'écran
  et supportent le zoom.
- **Zoom non bloqué** : la balise viewport n'empêche pas l'agrandissement de la
  page (critère WCAG 1.4.4).
- **Thème clair et thème sombre** sélectionnables par l'utilisateur, offrant une
  alternative de contraste.

---

## Limites connues

Dans un souci d'honnêteté, les points suivants restent perfectibles :

- **Contraste de certains textes secondaires** : quelques textes gris clair
  (descriptions de graphiques, libellés discrets) présentent un ratio de
  contraste légèrement inférieur au seuil AA (4,5:1) sur fond blanc. Un
  ajustement de la couleur concernée est identifié comme correctif.
- **Graphiques (Recharts)** : les visualisations de données reposent sur un rendu
  graphique dont l'accessibilité aux lecteurs d'écran est partielle. Les données
  sous-jacentes restent toutefois accessibles sous forme de tableaux et de
  cartes textuelles à côté des graphiques.
- **Tests manuels approfondis** (navigation complète au lecteur d'écran NVDA /
  VoiceOver) non encore réalisés de façon exhaustive : recommandés en complément
  des audits automatisés.

---

## Méthodologie de test

- **Outil** : Google Lighthouse (Chromium), catégorie Accessibilité, mode
  Navigation, profil Desktop.
- **Périmètre** : pages principales de l'application en fonctionnement réel
  (trajets, statistiques).
- **Date des tests** : juin 2026.

Les audits automatisés détectent un sous-ensemble des critères. Une revue manuelle
complète (parcours clavier intégral, test sur lecteur d'écran, vérification fine
des contrastes) constitue l'étape suivante d'amélioration continue.

---

## Voies de recours et amélioration continue

L'accessibilité est traitée dans une démarche d'amélioration continue. Les limites
identifiées ci-dessus constituent la feuille de route des prochaines itérations :
correction des contrastes secondaires, enrichissement de l'accessibilité des
graphiques (alternatives textuelles, descriptions), et campagne de tests manuels
sur technologies d'assistance.