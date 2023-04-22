# terraform {
#   required_providers {
#     template = {
#       source  = "hashicorp/template"
#       version = "2.2.0"
#     }

#     local = {
#       version = "~> 2.1"
#     }
#   }
# }

data "template_file" "init" {
  template = file("${path.module}/template.tpl")
  vars = {
    id = "abc"
  }
}

# data.template_file.init.rendered
