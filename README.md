# Cluster-EKS

Create cluster EKS using [kustomize](https://kustomize.io/) to create environments/overlays, [eksctl](https://eksctl.io/) to create cluster and [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) to apply manifest files on cluster.

## Configure

Edit the files:
  - `.env` (don't commit this file) from example: `.env.example`;
  - `./overlays/dev/eks/eks.yaml`: configs from cluster;

## Deploy
  1. Create cluster;
  2. Install cert-manager on cluster from [helm](https://helm.sh/);
  3. Configure the following features on kubernetes cluster (autoscaling, elb, coredns, calico,  metricsServer, vpa);

Execute `make all` or `make help` to more options.