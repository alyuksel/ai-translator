**Plan directeur mis à jour**

**1\. Vision produit**

* Offrir une expérience de traduction IA personnalisée qui adapte ton, niveau de détail, exemples pratiques et notes culturelles aux préférences de chaque utilisateur, avec une interface mobile unique ciblant Android et iOS via Flutter.  
* Étendre progressivement l’application vers un accompagnement linguistique complet (explications, analogies, corrections, prononciation).

**2\. Architecture globale**

**Frontend Flutter**

* **Structure applicative** : mise en place d’un projet Flutter avec des dossiers dédiés (ui/screens, ui/widgets, state, services) pour séparer pages, composants réutilisables, gestion d’état (ex. Riverpod/BLoC) et appels API.  
* **Écrans clés** :  
  1. Saisie et configuration (texte source, langues, préférences de ton/détail, bascule “inclure des exemples”).  
  2. Résultats de traduction enrichis (traduction principale, segments d’explications/exemples).  
  3. Historique & préférences (persistance locale avec shared\_preferences ou sqflite, synchronisation future côté backend).  
* **Internationalisation UI** : intégrer flutter\_localizations et intl pour traduire l’interface elle-même.  
* **Expérience utilisateur** : prise en compte des modes clair/sombre, accessibilité (taille de police, lecture vocale), scénarios hors ligne avec cache local des résultats récents.

**Backend FastAPI**

* **API existante** : conserver et étendre le squelette FastAPI déjà en place (/health, /translate) qui offre un flux minimum viable et une traduction simulée pour le frontend.

* **Schémas Pydantic** : exploiter les modèles TranslationRequest, TranslationResponse avec paramètres de ton, niveau de détail et segments structurés pour aligner backend et frontend.  
* **Service de traduction** : remplacer progressivement le service mock (translate\_text) par l’intégration avec le fournisseur IA choisi, tout en conservant la validation (texte non vide) et la génération de segments structurés utilisés aujourd’hui.  
* **Documentation & DX** : maintenir le README (installation, lancement, vérifications curl, tests pytest) comme point d’entrée développeur, et compléter avec une spécification OpenAPI générée automatiquement par FastAPI.

**Couche IA & personnalisation**

* Définir un prompt système stable décrivant le rôle de “traducteur IA pédagogique”.  
* Injecter dynamiquement les préférences utilisateur (ton, détail, exemples, domaine) dans le prompt.  
* Prévoir l’intégration d’un moteur de personnalisation (profil utilisateur, historique, niveau linguistique) pour contextualiser les requêtes.

**Données & stockage**

* **MVP** : stockage côté client (préférences, historique local).  
* **Évolutions** : ajouter une base de données (PostgreSQL) pour les comptes, quotas, historisation des traductions, statistiques d’usage.  
* Mettre en place une couche d’abstraction backend pour faciliter le passage de mock à persistance réelle.

**Qualité logicielle & tests**

* S’appuyer sur la suite Pytest existante (tests des endpoints /health et /translate, validation des erreurs) et l’étendre avec des cas d’usage supplémentaires lors de l’arrivée du vrai service IA.  
* Ajouter des tests de contrat (schemas), des tests d’intégration (frontend-backend), puis des tests UI (Flutter widget tests) et end-to-end (ex. integration\_test \+ backend mocké).  
* Mettre en place CI/CD (GitHub Actions) pour exécuter automatiquement tests backend et frontend.

**Déploiement & exploitation**

* Conteneuriser le backend FastAPI (Docker) et héberger sur un PaaS (Railway, Render, AWS, etc.) avec variables d’environnement sécurisées pour les clés IA.  
* Distribuer l’app Flutter via Google Play / App Store ; prévoir un pipeline CI pour build et tests (Codemagic, GitHub Actions \+ fastlane).  
* Implémenter la télémétrie (ex. Sentry, Firebase Crashlytics) et le suivi de performances.

**3\. Roadmap indicative**

1. **MVP technique**  
   * Structurer le projet Flutter, consommer l’API FastAPI existante (mock).  
   * Mettre en place la navigation, les écrans principaux et la gestion d’état.  
   * Valider le flux complet via tests manuels & automatisés backend.  
2. **Intégration IA & personnalisation**  
   * Connecter le service de traduction à l’API IA choisie.  
* Ajouter options de ton/détail/exemples côté frontend reliées aux enums backend.  
* Introduire profils utilisateur (stockage local), cache et premiers analytics.  
1. **Durcissement & lancement beta**  
   * Authentification (si nécessaire), quotas, persistance backend.  
   * Tests end-to-end, monitoring, préparation des builds stores.  
   * Collecter retours utilisateurs pour prioriser itérations.  
2. **Version publique**  
   * Optimisations UX (mode hors-ligne partiel, partage de traductions, audio).  
   * Automatisation CI/CD complète, internationalisation de l’app.  
   * Stratégies de monétisation (freemium, abonnements, crédits).

**Testing**

* ⚠️ Tests non exécutés (revue en lecture seule).

