resource "kubernetes_namespace" "namespace_codewizard" {

  # Set the metadata of the namespace
  metadata {
    # Set the desired namespace name
    name = "codewizard"
  }
}
