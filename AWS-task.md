# AWS - Terraform Lab

- In this lab we will be learning how to create EC2 instance with the following resources:

  - Key-Pair
  - EC2 instance
  - Security Group
  - Volumes

- The EC2 instance will have an attached volume and we will be using the ssh key to login into the instance.

- We will practice by writing `Modules` as well

### 01. Create ssh keys pair

- The first step is to create the `ssh` keys pair

```bash
# Generate the desired ssh keys,
# We will name them aws for this tutorial

# echo "y" - For overwrite the existing key if its exist

# ssh-keygen -  Cli tool for generating ssh key
#           -q  =   Quiet mode
#           -t  =   ssh type
#           -b  =   Number of bytes, in this case 2048
#           -N  =   Provides the new passphrase - in this case empty one
#           -f  =   File name to which to save the keys
echo "y" |              \
      ssh-keygen        \
            -q          \
            -t  rsa     \
            -b  2048    \
            -N ''       \
            -f  ~/.ssh/aws_terraform_key
```

### 02. Create terraform folder and modules

```bash
# Create a folder named Terraform
rm -rf Terraform

# Create the demo modules for this lab
mkdir -p Terraform/modules/globals
mkdir -p Terraform/modules/ec2_instance

```

### 03. Create terraform global module

- The global module will contain all the global variables.
- Since we will be using it as input for outer modules we will declare the variables as output variables
- For this demo we will add them along the way.
- First lets create the variables for AWS credentials

**TODO: Fill in the required values with your credentials**

```hcl
# Terraform/modules/globals/vars.tf

output "region" {
    value = "..."
}

output "availability_zone" {
    value = "..."
}

output "access_key" {
    value     = "..."
    sensitive = true
}

output "secret_key" {
    value     = "..."
    sensitive = true
}
```

### 04. Create the `Terraform/main.tf`

- Lets create the `main.tf` file, in our case its a pretty simple one.
- We need to "import" our global module so we will be able to use the vars

```hcl
# Terraform/main.tf

# "import" the global module with the vars
module "globals" {
    source = "./modules/globals"
}
```

### 05. Create `Terraform/provider.tf`

- The next task is to create the provider
- In this case it will be AWS
- We will also use the variables from our `global` module

```hcl
# Terraform/provider.tf

###
### Declare the required providers and the versions
###
terraform {
    required_providers {
      aws = {
          source    =   "hashicorp/aws"
          version   =   "4.25.0"
      }
    }
}

###
### Define AWS provider using values from the global module
###
provider "aws" {
    region      = module.globals.region
    access_key  = module.globals.access_key
    secret_key  = module.globals.secret_key
}
```

### 06. Create terraform ec2 module

- The second module is our ec2 instance
- First we need to "import" the global module
- Import the globals module so we will be able to use its variables

```hcl
# Terraform/modules/ec2_instance/globals.tf

module "globals" {
    source = "../globals"
}
```

- Next step is to create the EC2 instance.
- For our EC2 we will need an AMI. search [here](https://cloud-images.ubuntu.com/locator/ec2/) for the desired AMI
- Once we know which AMI we wish to use, instance size and more.
- Lets define them as parameter as variable

```hcl
# Terraform/modules/globals/vars.tf

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
```

- Now lets create the EC2 instance tf file

```hcl
# Terraform/modules/ec2_instance/instance.tf
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
```

- Add the ec2 module to the `main.tf`

```hcl
# Terraform/main.tf

module "ec2_instance" {
    source = "./modules/ec2_instance"
}
```

- Lets test and verify that our code is working as expected
- We will run terraform plan to check it and see the output

```bash
# Switch to our demo module
cd Terraform

# Execute terraform commands
terraform init -upgrade
terraform plan
```

- Output:

  ```sh
  Upgrading modules...
  - ec2_instance in modules/ec2_instance
  - ec2_instance.globals in modules/globals
  - globals in modules/globals

  Initializing the backend...

  Initializing provider plugins...
  - Finding hashicorp/aws versions matching "4.25.0"...
  - Using previously-installed hashicorp/aws v4.25.0

  Terraform has been successfully initialized!
  ```

### 07. Check liveness of our EC2 instance

- In order to verify that our EC2 is running we will use ssh connection.
- For this to work we will add the previously created `~/.ssh/aws_terraform_key.pub` ssh key pair
- Lets define and declare the key pair resource

```hcl
# Terraform/modules/ec2_instance/key_pair.tf

resource "aws_key_pair" "aws_ssh_key" {
    key_name   = "aws_terraform_key"
    public_key = file("~/.ssh/aws_terraform_key.pub")
}
```

- Add the required content to our instance resource

```hcl
# Terraform/modules/ec2_instance/instance.tf

# Add this inside the ec2 resource block
connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("~/.ssh/aws_terraform_key")
    timeout     = "1m"
    }
```

- Before we can test it we need to create a security group which will allow us to establish ssh connection

### 08. Create `security_group`

- Security group is _"like"_ firewall which defined ips, port etc which are whitelisted for establishing a connection to our resources.
- In this demo we will use the following security_group.
- Review the Ingress rules

```hcl
# Terraform/modules/ec2_instance/security_group.tf

resource "aws_security_group" "main" {
    name        = "Security_group"
    description = "Security Group for ec2 instance"

    egress = [
      {
          cidr_blocks       = ["0.0.0.0/0", ]
          description       = ""
          from_port         = 0
          ipv6_cidr_blocks  = []
          prefix_list_ids   = []
          protocol          = "-1"
          security_groups   = []
          self              = false
          to_port           = 0
      }
    ]
    ingress = [
      {
          cidr_blocks       = ["0.0.0.0/0", ]
          description       = ""
          from_port         = 22
          ipv6_cidr_blocks  = []
          prefix_list_ids   = []
          protocol          = "tcp"
          security_groups   = []
          self              = false
          to_port           = 22
      }
    ]
}

```

- Now lets add the vpc (security group) to our instance

```hcl
# Terraform/modules/ec2_instance/instance.tf

# Add this inside the ec2 resource block
resource "aws_instance" "instance" {
    ...

    # Link to the VPC (Security group) which we assign this instance under
    vpc_security_group_ids = [aws_security_group.main.id]

    }
```

### 09. Create specific volume for the EC2

- The default EC2 disk is usually a small in capacity.
- We wish to create and mount a bigger disk to our EC2.
- In order to do so we will create a `Volume` and then attach it to our EC2 instance

<br/>

- First lets create the Volume

```hcl
# Terraform/modules/ec2_instance/volume.tf

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
```

### 10. Attach the volume for the EC2

- Once that we have our volume, lets mount it under our instance

```hcl
# Terraform/modules/ec2_instance/volume_attachment.tf

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
```

---

- At this point we have an EC@ instance, lets verify that its running and we can connect to it.
- Once the EC2 is working we wish to add a startup script fo the machine
- Terraform support this option by adding entry to our instance so lets do it.

### 11. Create a startup script

- Lets create a dummy script for initializing the machine
- Create the script:

```sh
# Terraform/modules/ec2_instance/startup.sh

#!/bin/bash
echo $(date) > timestamp.txt
```

### 12. Create the template file

- Next step is to inform Terraform that we wish to use a template file for our startup script
- To do so we will create the following resource:

```hcl
# Terraform/modules/ec2_instance/user_data.sh

###
### Declare the template file you wish to use
###
data "template_file" "startup_script" {
  template = file("${path.module}/startup.sh")
}
```

### 13. Add the `user_data` entry

- Now lets add the script entry to our instance
- Add the following line to our `instance.tf`

```hcl
# Terraform/modules/ec2_instance/instance.tf

# Add this inside the ec2 resource block
resource "aws_instance" "instance" {
    ...

    # Attach the startup script
    user_data = data.template_file.startup_script.rendered

    }

```
