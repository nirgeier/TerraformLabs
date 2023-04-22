#!/bin/sh

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

# Create the desired files
terraform apply --auto-approve

# View the console for the given count
terraform show

# View the output
tree  .

