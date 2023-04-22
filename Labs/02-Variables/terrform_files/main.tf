# Add the kubernetes provider 
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"

}

# Create the desired namespace
resource "kubernetes_namespace" "codewizard_namespace" {

  # The namespace is defined in the variables
  metadata {
    name = var.namespace
  }

}
