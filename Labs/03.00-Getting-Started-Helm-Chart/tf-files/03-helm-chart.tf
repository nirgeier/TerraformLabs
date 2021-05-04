resource "helm_release" "local_helm" {
  # The name of the chart
  name = "codewizard-helm"

  # The path to the helm chart
  chart = "./codewizard-helm"

  # We want to run our helm in the desired namespace so we will refer to the namespace 
  # we wish to run it on.
  # In this sample we are reffereing to the namespace created prevoiusly
  namespace = kubernetes_namespace.namespace_codewizard.metadata.0.name
}
