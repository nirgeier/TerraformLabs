## `templatefile` function

- The `templatefile()` function accepts couple of inputs:
- A template file (\*.tftpl)
- Variable – which could be a list or map.

## File provisioned

- File provisioners provide a way to **copy** the files from the machine where Terraform code executes to the target resource.

- The source attribute specifies the file’s source path on the host machine, and the destination attribute specifies the desired path where the file needs to be copied on target.

### Helpers

- `jsonencode` and `yamlencode` functions
