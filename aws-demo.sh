#!/bin/bash

# Generate the desired ssh keys,
# We will name them aws for this tutorial

# echo "y" - For overwrite the existing key if its exist

# ssh-keygen -  Cli tool for generating ssh key
#               -q  =   Quiet mode
#               -t  =   ssh type
#               -b  =   Number of bytes, in this case 2048
#               -N  =   Provides the new passphrase - in this case empty one
#               -f  =   File name to which to save the keys
echo "y" |          \
    ssh-keygen      \
        -q          \
        -t  rsa     \
        -b  2048    \
        -N ''       \
        -f  ~/.ssh/aws_terraform_key

# Add the ssh key
ssh-add ~/.ssh/aws_terraform_key

# Create a folder named Terraform
rm -rf Terraform
mkdir -p Terraform

# Create the demo modules for this lab
mkdir -p Terraform/modules/globals
mkdir -p Terraform/modules/ec2_instance

# Create the vars.tf file with the required variables
###
### TODO: Fill in the required values with your credentials
###
cat << EOF > Terraform/modules/globals/vars.tf
###
### AWS instance configuration
###

output "region" {
  description = "The target region for our ec2 instance"
  value = "us-east-1"
}

output "availability_zone" {
  description = "The availability zone for our ec2 & volumes"
  value = "us-east-1a"
}

output "access_key" {
  description = "AWS access key"
  value     = "..."
  sensitive = true
}

output "secret_key" {
  description = "AWS secret_key"
  value     = "..."
  sensitive = true
}
EOF

# Create the main.tf file
# In this file we will import out global module
cat << EOF > Terraform/main.tf
# "import" the global module with the vars
module "globals" {
  source = "./modules/globals"
}
EOF

cat << EOF > Terraform/provider.tf
### 
### Declare the required providers and the versions
###
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
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
EOF

cat << EOF > Terraform/modules/ec2_instance/globals.tf
# Import the globals module so we will be able to use its variables
module "globals" {
  source = "../globals"
}
EOF

# Define the AMI as variable
cat << EOF >> Terraform/modules/globals/vars.tf

###
### The EC2 AMI
###
output "ami" {
    description = "AWS ami for ecs instance"
    value = "ami-052efd3df9dad4825"
}

###
### The instance type (EC2 size)
###
output "instance_type" {
    description = "The size (type) of the desired EC2 instance"
    value = "t2.micro"
}

###
### Which key pair we will be used for ssh connection
###
output "key_name" {
    description = "The ssh key pair for ssh connection"
    value = "aws_terraform_key"
}
EOF

###
### Create the EC2 Instance
###
cat << EOF > Terraform/modules/ec2_instance/instance.tf
resource "aws_instance" "instance" {

    ami             = module.globals.ami
    instance_type   = module.globals.instance_type
    key_name        = module.globals.key_name

    # Set the desired availability zone
    availability_zone = module.globals.availability_zone

    # The name of our EC2 instance
    tags = {
      Name = "Dummy machine"
    }

}
EOF

cat << EOF >> Terraform/main.tf

# "import" the global module with the vars
module "ec2_instance" {
  source = "./modules/ec2_instance"
}
EOF

cat << EOF > Terraform/modules/ec2_instance/key_pair.tf
resource "aws_key_pair" "aws_ssh_key" {
  key_name   = "aws_terraform_key"
  public_key = file("~/.ssh/aws_terraform_key.pub")
}
EOF

cat << EOF > Terraform/modules/ec2_instance/instance.tf
resource "aws_instance" "instance" {

    ami           = module.globals.ami
    instance_type = module.globals.instance_type
    key_name      = module.globals.key_name

    # Set the desired availability zone
    availability_zone = module.globals.availability_zone

    # Link to the VPC (Security group) which we assign this instance under
    vpc_security_group_ids = [aws_security_group.main.id]

    # The name of our EC2 instance
    tags = {
      Name = "Dummy machine"
    }

    connection {
        type        = "ssh"
        host        = self.public_ip
        user        = "ubuntu"
        private_key = file("~/.ssh/aws")
        timeout     = "1m"
    }
}
EOF

cat << EOF >> Terraform/modules/ec2_instance/security_group.tf

resource "aws_security_group" "main" {
  name        = "security_group"
  description = "Security Group for ec2 instance"

  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}
EOF

cat << EOF >> Terraform/modules/ec2_instance/volume.tf
##
## Create volume for the EC2 instance
##
resource "aws_ebs_volume" "ebs_volume" {

  # Set the desired availability zone
  availability_zone = module.globals.availability_zone

  # Set the desired disk size
  size = 500

  # Set the volume name
  tags = {
    Name = "Instance-Vol"
  }
}
EOF


cat << EOF > Terraform/modules/ec2_instance/volume_attachment.tf

##
## Attach the volume for the EC2 instance
##
resource "aws_volume_attachment" "ebs_att" {

  # The path for the volume (mount)
  device_name = "/dev/sdh"

  # The attached volume id
  volume_id = aws_ebs_volume.ebs_volume.id

  # The attached instance
  instance_id = aws_instance.instance.id
}
EOF

cat << EOF > Terraform/modules/ec2_instance/startup.sh

#!/bin/bash
echo \$(date) > timestamp.txt
EOF

cat << EOF > Terraform/modules/ec2_instance/user_data.tf
###
### Declare the template file you wish to use
###
data "template_file" "startup_script" {
  template = file("\${path.module}/startup.sh")
}
EOF

cat << EOF > Terraform/modules/ec2_instance/instance.tf
resource "aws_instance" "instance" {

  ami           = module.globals.ami
  instance_type = module.globals.instance_type
  key_name      = module.globals.key_name

  # Set the desired availability zone
  availability_zone = module.globals.availability_zone

  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "Dummy machine"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "touch hello.txt",
  #     "echo helloworld remote provisioner >> hello.txt",
  #   ]
  # }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/aws")
    timeout     = "1m"
  }

  # Attach the startup script
  user_data = data.template_file.startup_script.rendered
}
EOF

# Test that the instance can be created
cd Terraform
terraform init -upgrade
terraform apply --auto-approve