locals {
  cidr            = "10.0.0.0/16"
  aws_cli_profile = "tfworkshop-admin"
}

data "aws_region" "selected" {}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  # Creation of VPC is disabled, because we need just default VPC created using CLI
  create_vpc = false

  name = "default"

  cidr = local.cidr

  azs            = [for v in data.aws_availability_zones.available.names : v]
  public_subnets = [for k, v in data.aws_availability_zones.available.names : cidrsubnet(local.cidr, 8, k)]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_ipv6                     = true
  assign_ipv6_address_on_creation = true

  public_subnet_ipv6_prefixes = [for k, v in data.aws_availability_zones.available.names : k]
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "aws ec2 create-default-vpc --region ${data.aws_region.selected.name} --profile ${local.aws_cli_profile}"
  }
}
