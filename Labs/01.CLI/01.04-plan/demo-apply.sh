#!/bin/sh

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

set -x

# Prin the tf file
cat *.tf 

# Remove any older resources so we will be able to see the changes
#terraform destroy -auto-approve 

# validate the tf file
terraform plan

terraform apply -auto-approve