resource "kubernetes_namespace" "codewizard" {
  metadata {
    name = "codewizard"
  }
}
