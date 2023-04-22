resource "aws_instance" "demo_vm" {
  ami           = var.ami
  instance_type = var.type
  user_data     = templatefile("script.tftpl", { request_id = "REQ000129834", name = "John" })
  key_name      = "tftemplate"

  tags = {
    name = "Demo VM"
    type = "Templated"
  }
}
