###
### Declare the required providers and the versions
###
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

###
### Define AWS provider using values from the global module
###
provider "aws" {
  region     = module.globals.region
  access_key = module.globals.access_key
  secret_key = module.globals.secret_key
}
