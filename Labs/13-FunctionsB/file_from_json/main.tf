###
### data.yaml
### 
###   dev: dev-text
###   prod: prod-text
###   test: text-text

locals {
  json_file = "data.json"
  # Options: file or object
  json_data = jsondecode(file("./${local.json_file}"))
}

resource "local_file" "file_from_json" {
  for_each = local.json_data
  content  = each.value
  filename = "./${path.module}/${each.key}-json.txt"
}
