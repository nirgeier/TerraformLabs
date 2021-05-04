#!/bin/sh

set -x

# Create the playground folder
source ../../scripts/createPlaygroundFodler.sh

# Create the module file
cat <<EOF > module.tf
module "consul" {
  source  = "hashicorp/consul/aws"
  version = "0.0.5"
}
EOF

# Check the tf file
cat module.tf

# Initialize terrafrom 
terraform init

# Download the module
terraform get 

# View the output
tree -a .
