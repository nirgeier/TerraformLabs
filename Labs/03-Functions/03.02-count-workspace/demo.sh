#!/bin/bash

terraform init

terraform workspace new dev
terraform workspace new prod

terraform workspace select dev

terraform apply \
    -var-file="$(terraform workspace show)/vars.tf"

terraform workspace select prod

terraform apply \
    -var-file="$(terraform workspace show)/vars.tf"