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
      version = ">= 0.0.7"
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
      "USER www-data",
      "WORKDIR /var/www",
      "ENV HOSTNAME www.example.com",
      "VOLUME /test1 /test2",
      "EXPOSE 80 443",
      "LABEL version=1.0",
      "ONBUILD RUN date",
      "CMD [\"nginx\", \"-g\", \"daemon off;\"]"
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
