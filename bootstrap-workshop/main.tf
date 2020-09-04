terraform {
  required_version = ">= 0.12.6, < 0.14"

  required_providers {
    aws = ">= 2.46, < 4.0"
  }

  //  backend "s3" {
  //    bucket = "tfworkshop"
  //    key    = "iam-users.tfstate"
  //    region = "eu-west-1"
  //    dynamodb_table = "tfworkshop"
  //  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = ["905033465232"]

  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true

  assume_role {
    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  }
}

variable "aws_region" {
  description = "Default region for the workshop"
  default     = "eu-west-1"
}

variable "number_of_users" {
  description = "Number of users to create"
  type        = number
  default     = 20
}

locals {
  users = [for v in range(var.number_of_users) : format("user%d", v)]
}

data "aws_iam_account_alias" "current" {}

module "developers_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "~> 2.0"

  name                     = "developers"
  custom_group_policy_arns = ["arn:aws:iam::aws:policy/PowerUserAccess"]
  group_users              = [for v in local.users : module.user[v].this_iam_user_name]
}

module "user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 2.0"

  for_each = toset(local.users)

  name                          = each.value
  password_reset_required       = false
  create_iam_user_login_profile = false
  force_destroy                 = true
}

module "login_profile" {
  source = "./iam-user-login-profile"

  for_each = toset(local.users)

  username = module.user[each.key].this_iam_user_name
}

output "users" {
  value = { for v in toset(local.users) :
    v => join("     ", [
      "export AWS_ACCESS_KEY_ID=${module.user[v].this_iam_access_key_id} AWS_SECRET_ACCESS_KEY=${module.user[v].this_iam_access_key_secret} AWS_REGION=${var.aws_region}",
      "https://${data.aws_iam_account_alias.current.account_alias}.signin.aws.amazon.com/console/",
      "Username: ${module.login_profile[v].username}",
    "Password: ${module.login_profile[v].password}"])
  }
}
