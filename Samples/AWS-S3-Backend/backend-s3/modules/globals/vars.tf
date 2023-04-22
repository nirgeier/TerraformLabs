# AWS instance configuration
output "region" {
  value = "us-east-1"
}

output "availability_zone" {
  value = "us-east-1a"
}

output "access_key" {
  value     = "xxx"
  sensitive = true
}

output "secret_key" {
  value     = "xxx"
  sensitive = true
}



###
### The EC2 AMI
###
output "ami" {
  description = "AWS ami for ecs instance"
  value       = "ami-052efd3df9dad4825"
}

###
### The instance type (EC2 size)
###
output "instance_type" {
  description = "The size (type) of the desired EC2 instance"
  value       = "t2.micro"
}

###
### Which key pair we will be used for ssh connection
###
output "key_name" {
  description = "The ssh key pair for ssh connection"
  value       = "aws_terraform_key"
}
