#!/bin/sh

# Create the playground folder
source ../../scripts/createPlaygroundFodler.sh

# Create the tf file
echo 'provider "kubernetes" {}' > k8s.tf

set -x

# Check the tf file
cat k8s.tf 

# Initialize terrafrom 
terraform init

# validate the tf file
terraform validate

echo '--------------------------------------------------------'

# Change the tf file to make it not valid
echo 'provider "kubernetes2" {}' > k8s.tf

# validate the tf file
terraform validate
