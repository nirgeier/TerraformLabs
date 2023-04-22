### This demo will demonstrate the count function
### The demo will create local files witha prefix counter index
### https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "counter_demo" {

  # The count meta-argument accepts a whole number, 
  # and creates that many instances of the resource or module. 
  # Each instance has a distinct infrastructure object associated 
  # with it, and each is separately created, updated, or destroyed 
  # when the configuration is applied.

  # This `count` object has one attribute: `count.index` starting with 0
  count = 3

  # The content of the file
  content = "Count index: ${count.index}"

  # The file name to generate
  filename = "${path.cwd}/counter-${count.index}.txt"
}
