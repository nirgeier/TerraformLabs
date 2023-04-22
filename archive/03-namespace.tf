resource "kubernetes_namespace" "test" {
  metadata {
    name = "nginx"
  }
}