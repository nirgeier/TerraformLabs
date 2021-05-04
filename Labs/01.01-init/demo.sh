#!/bin/sh

set -x

# Create the playground folder
source ../../scripts/createPlaygroundFodler.sh

# Create the tf file
echo 'provider "kubernetes" {}' > k8s.tf

# Check the tf file
cat k8s.tf 

# Initialize terrafrom 
terraform init

# View the output
tree -a .
