#!/bin/sh

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

set -x

# Prin the tf file
cat *.tf 

# Remove any older resources so we will be able to see the changes
kubectl delete ns 05-apply

# validate the tf file
terraform plan

# Apply the changes
terraform apply -auto-approve 