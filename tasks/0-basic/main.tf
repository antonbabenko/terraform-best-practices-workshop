# Sub-tasks:
# 1. Create single AWS EC2 instance (web)
# 2. Add variables for all required arguments
# 3. Add data source to fetch ID of default security group, subnet and ID of Amazon linux AMI

provider "aws" {
  region = "..."
}

variable "name" {
  description = "Name of EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
}

data "aws_security_group" "default" {
  # ...
}

resource "aws_instance" "web" {
  ami           = "..."
  instance_type = "..."
  subnet_id     = "..."

  tags {
    Name = "..."
  }
}

output "public_ip" {
  value = "..."
}
