ifneq (,$(wildcard ./.env))
    include .env
    export
		ENV_FILE_PARAM = --env-file .env
endif
IMG_DOCKER=swirfneblin/eks-agent

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
		@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

create-cluster: ## Create eks cluster
	  docker run --rm -v $(PWD):/app -w /app/ --network host --privileged $(ENV_FILE_PARAM) $(IMG_DOCKER) \
		/bin/bash -c "./scripts/create-cluster.sh | bash"

install-certmanager: ## Install cert-manager on cluster
	  docker run --rm -v $(PWD):/app -w /app/ --network host --privileged $(ENV_FILE_PARAM) $(IMG_DOCKER) \
		/bin/bash -c "./scripts/cert-manager.sh | bash"

install-kubernetes-crd: ## Configure autoscaler, clusterIssuer, LB, calico, metricsserver, coredns, chronyd
	  docker run --rm -v $(PWD):/app -w /app/ --network host --privileged $(ENV_FILE_PARAM) $(IMG_DOCKER) \
		/bin/bash -c "./scripts/install-k8-files.sh | bash"

all: create-cluster install-certmanager install-kubernetes-crd