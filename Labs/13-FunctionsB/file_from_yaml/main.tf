locals {
  # The local file name to read
  yaml_file = "data.yaml"

  # "Convert" the file to HCL sytax
  yaml_data = yamldecode(file("./${local.yaml_file}"))
}

# # Create local file with the HCL synatx
# resource "local_file" "file_from_yaml" {
#   # Set the content of the file , in this case it will print a string (or object)
#   content  = tostring(local.yaml_data)
#   filename = "./${path.module}/output.txt"
# }

# Create local file with the HCL synatx
resource "local_file" "file_from_yaml" {
  # Loop over the keys (less usefull for yaml files, more for json files)
  for_each = local.yaml_data

  # Set the content of the file , in this case it will print a string (or object)
  content  = each.value
  filename = "./${path.module}/${each.key}-yaml.txt"
}
