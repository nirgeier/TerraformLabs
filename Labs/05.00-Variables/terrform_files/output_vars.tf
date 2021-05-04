output "namespace_uid" {
  # Get the auto generated uid of the namespace
  value = kubernetes_namespace.codewizard_namespace.metadata[0].uid
}