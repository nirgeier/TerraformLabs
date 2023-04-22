locals {
  names_obj = {
    name1 = {
      name        = "dev"
      other_value = "Other value"
    },
    name2 = {
      name        = "prod"
      other_value = "Other value"
    }
  }

  # Object of Objects
  contents_obj = {
    content1 = {
      content     = "dev_certificate"
      other_value = "Other value"
    },
    content2 = {
      content     = "prod_certificate"
      other_value = "Other value"
    }
  }

  # The zipmap "loops" over the object
  # What will happen if we will try to user lists?
  # Whay do we need the [*]? 
  map_from_arrs = zipmap(
    values(local.names_obj)[*].name,
  values(local.contents_obj)[*].content)
}

resource "local_file" "file_from_zipmap" {
  for_each = local.map_from_arrs
  content  = each.value
  filename = "./${path.module}/${each.key}-from-map.txt"
}
