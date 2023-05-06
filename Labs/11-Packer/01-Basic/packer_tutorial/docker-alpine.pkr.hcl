packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

##
##  Builder from type docker
##
source "docker" "alpine" {
  image  = "alpine"
  commit = true
}

##
## What to build
##
build {
  name = "labs-packer"
  sources = [
    "source.docker.alpine"
  ]
}
