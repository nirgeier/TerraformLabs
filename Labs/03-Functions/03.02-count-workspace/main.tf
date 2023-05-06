
variable "number_of_files" {}

resource "local_file" "demo1" {

  count = var.number_of_files

  content  = count.index
  filename = "${path.cwd}/${terraform.workspace}-${count.index}.txt"

}
