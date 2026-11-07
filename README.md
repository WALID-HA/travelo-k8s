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

Cluster : Kubernetes intégré à Docker Desktop (Settings → Kubernetes → Enable Kubernetes).

    kubectl config use-context docker-desktop
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/cloud/deploy.yaml
    kubectl apply -f .

Fichier `hosts` : `127.0.0.1 frontend.exam.local backend.exam.local`, puis http://frontend.exam.local

## Bonus A : base de données gérée par un Operator (`operator/`)

MySQL Operator for Kubernetes (Oracle) : un `InnoDBCluster` de 3 serveurs MySQL (Group Replication) + MySQL Router remplace le StatefulSet.

    helm repo add mysql-operator https://mysql.github.io/mysql-operator/
    helm install mysql-operator mysql-operator/mysql-operator -n mysql-operator --create-namespace
    kubectl delete -f 04-database.yaml
    kubectl apply -f operator/

## Bonus B : Skaffold (`skaffold/skaffold.yaml`)

Construit les images depuis le code source du Devoir 1, les pousse sur Docker Hub et redéploie à chaque modification :

    skaffold dev -f skaffold/skaffold.yaml --cleanup=false

## Bonus C : chart Helm (`helm/travelo`, publié dans `charts/`)

    helm repo add travelo https://raw.githubusercontent.com/WALID-HA/travelo-k8s/main/charts
    helm install travelo travelo/travelo -n helm --create-namespace
