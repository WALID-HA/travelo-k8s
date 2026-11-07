# Travelo sur Kubernetes (Devoir 2)

Manifests Kubernetes de l'application 3-tiers Travelo (React, Spring Boot, MySQL), namespace `travelo`.
Images : `vvalid/travelo-frontend:1.0`, `vvalid/travelo-backend:1.1` (Docker Hub), `mysql:8.4`.

| Fichier | Contenu |
|---|---|
| 00-namespace.yaml | Namespace `travelo` |
| 01-quotas.yaml | ResourceQuota + LimitRange (CPU / mémoire) |
| 02-secret.yaml | Mots de passe MySQL |
| 03-configmap.yaml | Configuration backend + script de données |
| 04-database.yaml | MySQL : StatefulSet + Service headless |
| 05-backend.yaml | Spring Boot : Deployment (2 réplicas) + Service |
| 06-frontend.yaml | React/nginx : Deployment (2 réplicas) + Service |
| 07-pdb.yaml | PodDisruptionBudgets |
| 08-rbac.yaml | ServiceAccount + Role + RoleBinding (lecture seule) |
| 09-ingress.yaml | Ingress `frontend.exam.local` / `backend.exam.local` |

## Déploiement

    minikube start --driver=docker --cpus=4 --memory=4096
    minikube addons enable ingress
    kubectl apply -f .
    minikube tunnel        # dans un 2e terminal

Fichier `hosts` : `127.0.0.1 frontend.exam.local backend.exam.local`
