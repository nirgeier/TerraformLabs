locals {
  # Decalre the name of the yaml file
  yaml_file = "input.yaml"

  # Decalre the name of the template file
  template_file = "template.tpl"

  # Decalre the name of the output file
  output_file = "output.txt"

  # Convert the yaml file to HCL
  yaml_data = yamldecode(file("./${local.yaml_file}"))
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
    ${env} - ${ip} 
    %{endfor~}
  EOT
  filename = local.output_file
}

#### Option 2: template file
data "template_file" "output" {
  template = file("./${local.template_file}")
  vars = {
    yaml_data = local.yaml_data
  }
}

