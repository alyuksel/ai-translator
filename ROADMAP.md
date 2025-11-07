# ROADMAP

Cette feuille de route reprend le contenu de PLAN.md et le décline en tâches concrètes avec un statut explicite. Elle est destinée à évoluer au fil du projet.

## Légende
- [DONE] terminé
- [WIP] en cours
- [TODO] à faire
- [BLOCKED] bloqué (préciser la cause)

## Résumé – Statut actuel
- [DONE] Backend FastAPI minimal: endpoints `/health`, `/translate`, schémas Pydantic, service mock, tests unitaires écrits
- [DONE] Exécuter la suite Pytest localement sous Python 3.11 et valider
- [DONE] Version Python cible: 3.11 (confirmée) — à documenter et outiller (venv, CI)
- [WIP] Frontend Flutter (squelette créé, appel `/translate` mock opérationnel)
- [TODO] Intégration fournisseur IA (remplacement du mock)
- [WIP] Qualité/CI: workflow tests backend en place (pytest). Lint/typecheck (ruff/black/mypy), pre-commit et CI Flutter à faire
- [TODO] Déploiement (Docker, hébergement), observabilité, sécurité, données

## Jalons (issues/epics)

### M1 — MVP technique
- [WIP] Initialiser projet Flutter (structure dossiers, navigation, écrans Saisie/Résultats/Préférences) — squelette + écran principal livrés
- [WIP] Consommer l’API `/translate` (mock) depuis Flutter, gestion d’état (Riverpod/BLoC) — appel HTTP direct implémenté
- [WIP] Back-end minimal en place (validation d’entrée, segments) — OK sous Python 3.11
- [TODO] Exécuter la suite Pytest localement (Python 3.11)

### M2 — Intégration IA & personnalisation
- [TODO] Définir interface `TranslatorProvider` et brancher un provider (OpenAI/DeepL/Google)
- [TODO] Gérer clés/API via variables d’environnement et configuration
- [TODO] Personnalisation (ton, niveau de détail, exemples) depuis le frontend relié aux enums backend
- [TODO] Préparer profils utilisateur (stockage local, synchronisation ultérieure)

### M3 — Durcissement & bêta
- [TODO] Authentification (si nécessaire), quotas et persistance de l’historique (PostgreSQL)
- [TODO] Tests d’intégration (frontend-backend), tests UI Flutter, E2E
- [TODO] Monitoring, crash reporting, préparation builds stores

### M4 — Version publique
- [TODO] Optimisations UX (mode hors-ligne partiel, partage, audio)
- [TODO] CI/CD complet (builds mobiles, déploiements backend), i18n de l’app
- [TODO] Monétisation (freemium, abonnements, crédits)

## Détails par domaine

### Backend API (FastAPI)
- [DONE] Squelette FastAPI avec routes `/health`, `/translate`
- [DONE] Schémas `TranslationRequest`, `TranslationResponse`, enums `Tone`, `DetailLevel`
- [DONE] Service `translate_text` mock retournant traduction + segments
- [DONE] Tests unitaires de base (`health`, `translate`, validation) écrits
- [DONE] Compatibilité: code utilise `match/case` (OK Python ≥3.10, cible 3.11)
- [TODO] Homogénéiser l’environnement: venv/CI/doc alignés sur Python 3.11
- [TODO] CORS, configuration `.env` (pydantic-settings), validations codes langues
- [TODO] Limitation de débit (rate limiting) simple côté API

### Intégration IA & personnalisation
- [TODO] Interface `TranslatorProvider` + implémentation provider réel
- [TODO] Prompt système “traducteur IA pédagogique”, injection préférences (ton/détail/exemples/domaine)
- [TODO] Segments enrichis (exemples, notes culturelles) fournis par l’IA
- [TODO] Stratégie de coût/latence et timeouts, retry, journalisation prompts

### Frontend Flutter
- [WIP] Structure projet (ui/screens, ui/widgets, services): squelette + écran principal + client API
- [WIP] Écrans: Saisie/Config + Résultats implémentés partiellement; Historique & Préférences à faire
- [TODO] Internationalisation (flutter_localizations, intl), thèmes clair/sombre, accessibilité
- [TODO] Cache hors-ligne de résultats récents

### Données & stockage
- [TODO] MVP: stockage local (frontend) pour préférences/historique
- [TODO] Backend: abstraction de persistance puis PostgreSQL (comptes, quotas, historique, stats)
- [TODO] Migrations (Alembic) et modèles de données

### Qualité logicielle & tests
- [DONE] Tests backend de base écrits (non exécutés en l’état)
- [TODO] Étendre tests backend (contrats, cas d’erreur, provider IA mocké)
- [TODO] Tests d’intégration API + frontend, tests UI Flutter, E2E
- [TODO] Lint/Format/Type-check: `ruff`, `black`, `mypy`; hooks `pre-commit`
- [TODO] Couverture minimale (ex. 80%) et rapport en CI

### Déploiement & exploitation
- [TODO] Dockerfile backend, docker-compose (API + DB)
- [TODO] Hébergement (Railway/Render/Fly.io/AWS) avec secrets
- [WIP] CI GitHub Actions: tests backend opérationnels; lint/typecheck et tests Flutter + builds à ajouter
- [TODO] Observabilité: logs structurés, métriques (Prometheus), tracing (optionnel)

### Sécurité & configuration
- [TODO] Gestion des secrets (.env, vault), rotation clés, scopes
- [TODO] Authentification (clé API/JWT) si besoin, CORS strict
- [TODO] Politique d’erreurs et durcissement des dépendances

### Documentation & DX
- [DONE] README de base (installation backend, run, tests, curls)
- [TODO] `ARCHITECTURE.md` (vision d’ensemble, flux, choix techniques)
- [WIP] Documentation frontend ajoutée; Spécification OpenAPI enrichie (exemples, descriptions) à compléter
- [DONE] Section “Versions supportées” (Python 3.11 requis) et mise à jour README/CI

## Prochaines actions immédiates (ordre suggéré)
1) [DONE] Confirmer/propager Python 3.11 dans l’IDE et la CI, recréer le venv si nécessaire
2) [DONE] Exécuter les tests backend sous Python 3.11 et corriger si besoin
3) [WIP] Initialiser le projet Flutter (squelette + appel `/translate`), valider le flux bout‑à‑bout avec le mock
4) [TODO] Mettre en place `ruff`/`black`/`mypy` + `pre-commit` et une CI minimale (lint+tests)
5) [TODO] Définir `TranslatorProvider` et ajouter un provider IA mockable en tests

## Notes de blocage
- Aucun blocage connu lié à la version Python dès lors que 3.11 est utilisé et sélectionné dans l’IDE/CI.

## Historique
- 2025‑10‑18: création initiale de cette roadmap à partir de PLAN.md et de l’état du repo.
- 2025‑11‑05: alignement Python 3.11 (venv, `.python-version`, CI backend), exécution tests OK, création du squelette Flutter (appel `/translate`), mise à jour README et roadmap.
