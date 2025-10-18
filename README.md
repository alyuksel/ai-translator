# ai-translator

Application de traduction utilisant l'IA pour une traduction adaptée au besoin des utilisateurs.

## Backend (FastAPI)

Un premier squelette d'API est disponible dans `backend/`.

### Installation

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Il faut créer le venv avec la version de Python 3.11.14

### Lancement du serveur

```bash
uvicorn app.main:app --reload
```

L'API expose pour l'instant :

- `GET /health` pour vérifier l'état du service
- `POST /translate` qui retourne une traduction simulée en attendant l'intégration du modèle IA

### Tests automatisés

```bash
cd backend
PYTHONPATH=. pytest
```

### Vérification manuelle rapide

Une fois le serveur démarré, vous pouvez vérifier les routes principales avec `curl` :

```bash
curl http://127.0.0.1:8000/health

curl -X POST http://127.0.0.1:8000/translate \
  -H "Content-Type: application/json" \
  -d '{
        "text": "Bonjour tout le monde",
        "source_language": "fr",
        "target_language": "en",
        "tone": "friendly",
        "detail_level": "detailed",
        "include_examples": true
      }'
```
