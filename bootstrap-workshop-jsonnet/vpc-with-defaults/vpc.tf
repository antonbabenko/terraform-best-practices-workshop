locals {
  cidr = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

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
