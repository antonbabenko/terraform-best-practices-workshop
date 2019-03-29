terraform {
  required_version = "~> 0.11"

  //  backend "s3" {
  //    bucket = "tfworkshop"
  //    key    = "iam-users.tfstate"
  //    region = "eu-west-1"
  //    dynamodb_table = "tfworkshop"
  //  }
}

provider "aws" {
  version             = "~> 2.3.0"
  region              = "eu-west-1"
  allowed_account_ids = ["905033465232"]

  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true

  assume_role {
    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  }
}
