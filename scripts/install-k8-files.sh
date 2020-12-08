#!/bin/bash
## exit when any command fails
set -e

mkdir ~/.kube

eksctl utils write-kubeconfig --cluster ${CLUSTER_NAME}

## Generate yaml file to autoscaler, clusterIssuer, LB, calico, metricsserver, coredns
kustomize build overlays/${ENV}/k8s | envsubst "$(env | sed -e 's/=.*//' -e 's/^/\$/g')" > deploy.yaml
kubectl apply -f deploy.yaml

## Enable autoscaler
kubectl -n kube-system annotate deployment.apps/cluster-autoscaler \
  cluster-autoscaler.kubernetes.io/safe-to-evict="false" --overwrite

## Enable VPA
./base/vpa/hack/vpa-up.sh