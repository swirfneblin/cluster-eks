#!/bin/bash
## exit when any command fails
set -e

mkdir ~/.kube

eksctl utils write-kubeconfig --cluster ${CLUSTER_NAME}

[[ $(kubectl get ns cert-manager | grep -ic cert-manager) -eq 1 ]] \
&& echo "cert-manager ja configurado" \
&& exit 0

## Certmanager
kubectl create ns cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install cert-manager jetstack/cert-manager \
  --version v1.0.0-beta.0 --namespace cert-manager \
  --set installCRDs=true \
  --set 'extraArgs={--dns01-recursive-nameservers-only,--dns01-recursive-nameservers=8.8.8.8:53\,1.1.1.1:53}'