# Notes:
# 1. Set values of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

terraform {
  required_version = ">= 0.12.6, < 0.14"

  required_providers {
    aws = ">= 2.46, < 4.0"
  }
}

provider "aws" {
  region  = "eu-west-1"
  version = "~> 3.0"

  //  allowed_account_ids = ["905033465232"] # 835367859851 - anton-demo; 905033465232 - tfworkshop

  //  # Alternatively, IAM role can be assumed
  //  assume_role {
  //    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  //  }
}

locals {
  #######################
  # EDIT BELOW THIS LINE
  #######################
  name = "tfworkshop-userX"

  tags = {
    Name  = local.name
    Owner = "userX"
  }
  #######################
  # EDIT ABOVE THIS LINE
  #######################
}

data "aws_caller_identity" "this" {
}

##################################################
# VPC
##################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = local.name

  cidr = "10.10.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  //  # Use arguments below with data-source aws_availability_zones.available to span resources in all availability zones
  //  azs            = [for v in data.aws_availability_zones.available.names : v]
  //  public_subnets = [for k, v in data.aws_availability_zones.available.names : cidrsubnet("10.10.0.0/16", 8, k)]

  enable_dns_hostnames = true
  enable_dns_support   = true

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
  image_id                     = data.aws_ami.amazon_linux.id
  instance_type                = "t2.micro"
  security_groups              = [module.ec2_security_group.this_security_group_id]
  user_data                    = data.template_file.ec2_userdata.rendered
  key_name                     = ""
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true

  # Autoscaling group
  vpc_zone_identifier = module.vpc.public_subnets
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
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp", "all-icmp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.tags
}

##################################################
# This code may not be working when there are no matching instances.
# Alternatively use AWS CLI:
# aws ec2 describe-instances --filters 'Name=tag:Name,Values=tfworkshop-*' --output json --region eu-west-1 | jq -r '.Reservations[].Instances[].PublicIpAddress'
##################################################
//data "aws_instance" "created" {
//  instance_tags = local.tags
//
//  depends_on = [module.autoscaling]
//}
