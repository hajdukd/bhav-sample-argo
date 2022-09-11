#!/usr/bin/env bash

echo "Creating application using imperative approach:"

APPLICATION="${1:-'Application is required!'}"
NAMESPACE="${2:-'Namespace is required!'}"
PATH_TO_CHART="${PATH_TO_CHART:?'charts/bhav'}"
REPOSITORY="${REPOSITORY:?'https://github.com/hajdukd/bhav-sample-infra.git'}"
KUBERNETES_SERVER="${KUBERNETES_SERVER:?'https://kubernetes.default.svc'}"

argocd app create "$APPLICATION" \
    --repo "$REPOSITORY" \
    --path "$PATH_TO_CHART" \
    --dest-server "$KUBERNETES_SERVER" \
    --dest-namespace "$NAMESPACE"
