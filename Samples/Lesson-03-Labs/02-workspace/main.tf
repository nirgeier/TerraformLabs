resource "local_file" "demo1" {

  content  = "${terraform.workspace}-workspace"
  filename = "${path.cwd}/${terraform.workspace}.txt"

}
