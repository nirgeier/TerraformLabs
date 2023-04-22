#!/bin/sh

YELLOW='\033[0;33m'
RESET='\033[0m' # No Color

# Create the playground folder
source $(git rev-parse --show-toplevel)/scripts/createPlaygroundFodler.sh

# validate the tf file
terraform validate

sleep 5

# rename the ignore file to tf and validate again
mv *.ignore k8s.tf

echo ${YELLOW}
cat k8s.tf
echo ${RESET}

# validate the tf file
terraform validate

terraform validate -json