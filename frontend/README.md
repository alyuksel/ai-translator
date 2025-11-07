# Frontend Flutter (AI Translator)

Ce répertoire contient le squelette Flutter consommant l'API FastAPI mockée.

## Prérequis

- Flutter 3.22+ (SDK compatible avec Dart 3.4+)
- Un backend en cours d'exécution (`uvicorn app.main:app --reload` dans `backend/`)

## Installation

```bash
cd frontend
flutter pub get
```

Pour les plateformes natives (Android/iOS), vous pouvez exécuter `flutter create .` afin de générer les dossiers manquants si besoin. Le code Dart existant sera conservé.

## Lancement

```bash
flutter run -d chrome            # Web
flutter run -d macos             # macOS
flutter run -d android|ios       # Plateformes mobiles
```

L'application enverra une requête POST vers `http://127.0.0.1:8000/translate`. Ajustez `TranslatorApi.baseUrl` si vous déployez le backend ailleurs.

## Tests

```bash
flutter test
```

> Les tests exigent que les dépendances aient été installées via `flutter pub get`.
