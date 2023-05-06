#!/bin/bash

# First, install the HashiCorp tap, a repository of all our Homebrew packages.
# brew tap hashicorp/tap

# Now, install Packer with hashicorp/tap/packer.
# brew install hashicorp/tap/packer

# Remove old content
rm -rf packer_docker_tutorial

# Create a packer image
mkdir packer_docker_tutorial

# Navigate into the directory.
cd packer_docker_tutorial

# Create a file docker.pkr.hcl.
cat << EOF > ./docker.pkr.hcl
packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source = "github.com/hashicorp/docker"
    }
  }
}

##
##  Custom Dockerfile
##
source "docker" "custom" {
    image = "ubuntu"
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
  name    = "labs-packer"
  sources = [
    "source.docker.custom"
  ]
  
  post-processor "docker-tag" {
    repository = "nirgeier/packer"
    tags = ["0.0.8", "packer-demo"]
  }
}


EOF

# Initializa the packer
packer init .

# Same as with terraform 
# fmt / validate
packer fmt .
packer validate .

# Build the docker dontainer
packer build docker.pkr.hcl
