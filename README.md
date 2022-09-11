# Info

ArgoCD setup for bhav demo purposes

## Setup bashrc

```shell
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
do="-o yaml --dry-run=client"
ycrt="--format=yaml --cert=~/.seal/public-key-cert.pem"
```

## Install ArgoCD on cluster

Assumes your current context is set up.

```shell
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
Or
```shell
helm repo add argo https://argoproj.github.io/argo-helm
helm install --namespace argocd --name argocd argo/argo-cd
```

## Install ArgoCD CLI (optional)

Assumes amd arch.

```shell
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
```

## Bootstrap

Deploy Bootstrap Application:

```shell
k apply -f ./bootstrap.yaml
```

## Accessing Argo Dashboard

If bootstrap was successful :^ ], just go to `https://argocd.ingress.local`

If not: 

```shell
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Access via: `https://localhost:8080/login`

## Retrieve Argo Dashboard Admin Password

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Don't forget to change the password.

## Rollbacks

When using plain deployments:

```shell
argocd app rollback <argocd_app_name> <history_id>
```

When using rollouts rollback is automatic based on provided analysis metric.

## Secrets Management

Example usage of sealed-secrets:
```shell
k create secret generic testsecret --from-literal=password=jasio1234 $do | kubeseal | tee sealed_secret.yaml
```

External Secrets can be used to mirror secrets stored in external vaults in a form of K8S Secret.

## Grafana Pass

Run:
```shell
k -n monitoringv2 get secrets grafana  -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
