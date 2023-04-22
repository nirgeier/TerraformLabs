locals {
  my_obj = {
    id   = "1234",
    name = "Name1"
  }
}

resource "local_file" "template-demo" {
  content  = templatefile("template.txt", local.my_obj)
  filename = "${path.module}/output.txt"
}
