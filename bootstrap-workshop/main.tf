//This is not working yet, because Terraform 0.12.7 can't iterrate through modules


//terraform {
//  required_version = "~> 0.12"
//
//  required_providers {
//    aws = "~> 2.0"
//  }
//
//  //  backend "s3" {
//  //    bucket = "tfworkshop"
//  //    key    = "iam-users.tfstate"
//  //    region = "eu-west-1"
//  //    dynamodb_table = "tfworkshop"
//  //  }
//}
//
//provider "aws" {
//  region              = "eu-west-1"
//  allowed_account_ids = ["905033465232"]
//
//  skip_credentials_validation = true
//  skip_get_ec2_platforms      = true
//  skip_metadata_api_check     = true
//  skip_region_validation      = true
//
//  assume_role {
//    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
//  }
//}
//
//module "developers_group" {
//  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
//  version = "~> 2.3"
//
//  name = "developers"
//
//  custom_group_policy_arns = ["arn:aws:iam::aws:policy/PowerUserAccess"]
//  group_users = var.group_users
//
//}
//
//module "users" {
//  source = "terraform-aws-modules/iam/aws//modules/iam-user"
//  version = "~> 2.3"
//
//  password_reset_required = false
//  create_iam_user_login_profile = false
//  force_destroy = true
//  name =  "user1"
//}
//
//output "users" {
// value = "export AWS_ACCESS_KEY_ID=${module.user1.this_iam_access_key_id} AWS_SECRET_ACCESS_KEY=${module.user1.this_iam_access_key_secret} AWS_REGION=eu-west-1"
//}
