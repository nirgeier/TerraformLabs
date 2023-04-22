#!/bin/sh

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

# Create the tf file
cat << EOF > k8s.tf
provider "kubernetes" {
  #  config_path    = "~/.kube/config"
  #  config_context = "minikube"
}

resource "kubernetes_namespace" "codewizard" {
  metadata {
    name = "codewizard"
  }
}

resource "kubernetes_deployment" "codewizard-deployment" {
  metadata {
    name = "deployment-example"
    labels = {
      app = "deployment-example"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "deployment-example"
      }
    }

    template {
      metadata {
        labels = {
          app = "deployment-example"
        }
      } #metadata

      spec {
        container {
          image = "nginx"
          name  = "nginx"
        } # container
      }   # spec 
    }
  }
}

resource "kubernetes_service" "codewizard-service" {
  metadata {
    name = "codewizard-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.codewizard-deployment.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 80
    }
  }
}
EOF

set -x

# For MacOS
# brew install graphviz

# Check the tf file
cat k8s.tf 

# Initialize terrafrom 
terraform init

# remove old state so we can see the changes
terraform destroy -auto-approve 

# validate the tf file
terraform plan

# validate the tf file
terraform graph | dot -Tsvg > graph.svg

# Display the image
open graph.svg
