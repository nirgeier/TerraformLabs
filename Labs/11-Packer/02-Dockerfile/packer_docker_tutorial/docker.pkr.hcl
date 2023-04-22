packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

##
##  Custom Dockerfile
##
source "docker" "custom" {
  image  = "ubuntu"
  commit = true
  changes = [
    "USER root",
    "WORKDIR /var/www",
    #"RUN apt update",
    #"RUN apt upgrade",
    "CMD echo 'Hello from Docker container'"
  ]
}

##
## What to build
##
build {
  name = "labs-packer"
  sources = [
    "source.docker.custom"
  ]

  post-processor "docker-tag" {
    repository = "nirgeier/packer"
    tags       = ["0.0.8", "packer-demo"]
  }
}


