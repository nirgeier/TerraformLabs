#!/bin/bash

# rm      -rf demo_folder
# mkdir   -p  demo_folder
cd          demo_folder

TEMPLATE_FILE="template.tpl"
OUTPUT_FILE="output.txt"

## 
## Write the yaml file
## This is teh content for our demo
##
cat << EOF > input.yaml

dev: "10.10.10.10"
stg: "10.10.10.20"
prod: "10.10.10.30"

EOF

##
## Create the main tf file for this demo
##
cat << EOF > $TEMPLATE_FILE
%{for env, ip in local.yaml_data~}
    \${env} - \${ip} 
%{endfor~}
EOF

##
## Create the template file for the yaml output
## !!! Important:
##  Set this contnet (the template code) to your needs
##  For the 
cat << EOF > main.tf
locals{
    # Decalre the name of the yaml file
    yaml_file = "input.yaml"

    # Decalre the name of the template file
    template_file  = "$TEMPLATE_FILE"

    # Decalre the name of the output file
    output_file  = "$OUTPUT_FILE"
    
    # Convert the yaml file to HCL
    yaml_data = yamldecode(file("./\${local.yaml_file}"))
}

###
## 2 options:
##  local_file
##  template_file

##
## This file is for debugging the code
## We will print out the desired values
## 
resource "local_file" "debugger" {
  content  = <<-EOT
    %{for env, ip in local.yaml_data~}
    \${env} - \${ip} 
    %{endfor~}
  EOT
  filename = local.output_file
}

#### Option 2: template file
data "template_file" "output" {
  template = file("./\${local.template_file}")
  vars = {
    // Optional : pass the values instead of have them hard-coded in the template
  }
}

EOF


cat main.tf

# remove old content (if any)
rm -rf .terraform 

# validate and format the files
terraform init
# terraform fmt
# terraform validate
terraform apply -auto-approve


