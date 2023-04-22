#!/bin/bash

# Interactive Terraform
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


# Echo commands for debbuging mode
set -x

# Install minikube
curl -fsSL -o minikube \
  https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

# Install helm
curl -fsSL -o get_helm.sh \
  https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh
