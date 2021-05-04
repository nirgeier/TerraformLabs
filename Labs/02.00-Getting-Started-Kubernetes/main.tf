# Add the kubernetes provider 
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"
}
# Create Kubernetes namespace
resource "kubernetes_namespace" "tf_namespace_advanced" {

  # Set the metadata of the namespace
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "example-value"
    }

    # Set the desired namespace name
    name = "codewizard"
  }
}
