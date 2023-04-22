#!/bin/sh

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

# View the output
tree -a .
