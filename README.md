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

### Lancement du serveur

```bash
uvicorn app.main:app --reload
```

L'API expose pour l'instant :

- `GET /health` pour vérifier l'état du service
- `POST /translate` qui retourne une traduction simulée en attendant l'intégration du modèle IA
