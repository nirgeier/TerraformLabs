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