##
## Valid tf file
##
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.19.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
