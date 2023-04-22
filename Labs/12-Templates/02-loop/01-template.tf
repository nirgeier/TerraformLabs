resource "local_file" "template-demo" {
  content  = templatefile("template.tftpl", {})
  filename = "${path.module}/output.txt"
}
