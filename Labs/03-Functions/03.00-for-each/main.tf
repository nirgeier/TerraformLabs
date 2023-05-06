locals {

  file_names = ["aa", "b", "c", "a"]

}

resource "local_file" "demo1" {

  for_each = { for key, value in local.file_names : key => value }

  //content  = local.files[each.key].file_content
  //filename = "${path.cwd}/${local.files[each.key].file_name}.txt"
  content  = each.value
  filename = "${path.cwd}/${each.key}.txt"

}
