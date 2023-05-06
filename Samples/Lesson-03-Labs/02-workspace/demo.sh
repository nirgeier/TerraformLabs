#!/bin/bash

terraform init
terraform workspace new dev
terraform workspace new prod

terraform workspace select dev
terraform apply \
     -var-file="./dev/vars.tf"

terraform workspace select prod
terraform apply \
     -var-file="./prod/vars.tf" 
