resource "kubernetes_namespace" "codewizard" {
  metadata {
    name = "07-refresh"
  }
}
