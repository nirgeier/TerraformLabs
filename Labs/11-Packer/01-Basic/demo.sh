#!/bin/bash

# First, install the HashiCorp tap, a repository of all our Homebrew packages.
# brew tap hashicorp/tap

# Now, install Packer with hashicorp/tap/packer.
# brew install hashicorp/tap/packer

# Remove old content
rm -rf packer_tutorial

# Create a packer image
mkdir packer_tutorial

# Navigate into the directory.
cd packer_tutorial

# Create a file docker-alpine.pkr.hcl.
cat << EOF > ./docker-alpine.pkr.hcl
packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
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
  name    = "labs-packer"
  sources = [
    "source.docker.alpine"
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
packer build docker-alpine.pkr.hcl
