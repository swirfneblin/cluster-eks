#!/bin/bash
## exit when any command fails
set -e

mkdir ~/.kube
eksctl utils write-kubeconfig --cluster ${CLUSTER_NAME}

## Erase cluster
eksctl delete cluster --name ${CLUSTER_NAME}
