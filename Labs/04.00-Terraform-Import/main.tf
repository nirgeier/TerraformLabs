# Add the kubernetes provider 
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"

  # We need to set this port or the import might fail
  # This is the same port as we defined for the proxy
  host = "http://localhost:34567"
}

resource "kubernetes_namespace" "codewizard_namespace" {
  
}
