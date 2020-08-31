# Notes:
# 1. Set values of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

terraform {
  required_version = ">= 0.12.6, < 0.14"

  required_providers {
    aws = ">= 2.46, < 4.0"
  }
}

provider "aws" {
  region = "..."
}

###############
# Local values
###############
locals {
  name = "tfworkshop-userX"

  tags = {
    Name  = local.name
    Owner = "userX"
  }
}

##################################################
# VPC
##################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = local.name

  cidr = "..."

  azs             = ["..."]
  private_subnets = ["..."]
  public_subnets  = ["..."]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.tags
}

##################################################
# Launch configuration and autoscaling
##################################################
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
}

data "template_file" "ec2_userdata" {
  template = <<EOF
#cloud-config
runcmd:
  - yum install -y nginx
  - service nginx start
EOF

}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = local.name

  # Launch configuration
  image_id                     = "..." # @todo: use data-source aws_ami.amazon_linux
  instance_type                = "..."
  security_groups              = "..." # @todo: use output from ec2_security_group module (remember to convert it to a list)
  user_data                    = "..." # @todo: use data-source template_file.ec2_userdata
  key_name                     = ""
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true

  # Autoscaling group
  vpc_zone_identifier = "..." # @todo: use public_subnet output from vpc module
  health_check_type   = "EC2"
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1

  tags_as_map = local.tags
}

##################################################
# EC2 security group
##################################################
module "ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name = local.name

  description = "EC2 security group with publicly open HTTP and SSH ports"
  vpc_id      = "..." # @todo: use output from vpc module

  ingress_cidr_blocks = "..."
  ingress_rules       = ["..."]

  egress_cidr_blocks = ["..."]
  egress_rules       = ["..."]

  tags = local.tags
}
