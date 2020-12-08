#!/bin/bash
## exit when any command fails
set -e

## Generate yaml file to EKS cluster creation
kustomize build overlays/${ENV}/eks > eks.yaml

mkdir ~/.kube

## Create cluster
eksctl create cluster -f eks.yaml
eksctl utils write-kubeconfig --cluster ${CLUSTER_NAME}
eksctl utils update-cluster-logging --config-file eks.yaml --approve