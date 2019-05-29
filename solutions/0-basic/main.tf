# Notes:
# 1. Set values of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

provider "aws" {
  region  = "us-west-1"
  version = ">= 2.12.0"
}

variable "name" {
  description = "Name of EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
}

###################################################################
# Data sources to get VPC, subnets, security group and AMI details
###################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
  name   = "default"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.amazon_linux.image_id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${element(data.aws_subnet_ids.all.ids, 0)}"

  tags {
    Name = "${var.name}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}
