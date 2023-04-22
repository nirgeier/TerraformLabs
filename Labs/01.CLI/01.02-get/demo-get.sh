#!/bin/sh

set -x

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

# Download the module
terraform get 

# View the output
tree -a .
