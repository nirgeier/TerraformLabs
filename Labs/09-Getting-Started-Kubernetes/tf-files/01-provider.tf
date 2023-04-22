# Add the kubernetes provider 
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"
}
