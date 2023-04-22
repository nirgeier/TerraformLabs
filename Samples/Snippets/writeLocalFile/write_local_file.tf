# Set the local file name
variable "file_name" {
  type = string

  ###
  ### Will this line work?
  ###
  default = "${path.module}/my_file.txt"
}

resource "local_file" "example" {
  content  = "Hello, World!"
  filename = var.file_name
}
