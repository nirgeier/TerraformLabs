
# Add the kubernetes provider 
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
resource "kubernetes_namespace" "namespace_codewizard" {

  # Set the metadata of the namespace
  metadata {
    # Set the desired namespace name
    name = "codewizard"
  }
}
resource "helm_release" "local_helm" {
  # The name of the chart
  name = "codewizard-helm"

  # The path to the helm chart
  chart = "./codewizard-helm"

  # We want to run our helm in the desired namespace so we will refer to the namespace 
  # we wish to run it on.
  # In this sample we are reffereing to the namespace created prevoiusly
  namespace = kubernetes_namespace.namespace_codewizard.metadata.0.name
}
