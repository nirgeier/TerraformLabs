provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"

}


resource "aws_instance" "example" {
  ami           = "ami-052efd3df9dad4825" # "ami-0d729a60"
  instance_type = "t3.micro"

  tags = {
    Name = "nirg"
  }
}

