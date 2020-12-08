# Cluster-EKS

Create cluster EKS using [kustomize](https://kustomize.io/) to create environments/overlays, [eksctl](https://eksctl.io/) to create cluster and [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) to apply manifest files on cluster.

## Configurar

Edit the files:
  - `.env` (dont commit this file) from example: `.env.example`;
  - `./overlays/dev/eks/eks.yaml`: configs from cluster;

## Executar
  1. Create cluster;
  2. Install cert-manager on cluster from [helm](https://helm.sh/);
  3. Configure the following features on kubernetes cluster (autoscaling, elb, coredns, calico,  metricsServer);

Execute `make all` or `make help` to more options.