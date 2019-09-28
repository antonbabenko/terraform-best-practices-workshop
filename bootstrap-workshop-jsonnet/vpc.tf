provider "aws" {
  alias = "eu-west-1"

  region              = "eu-west-1"
  allowed_account_ids = ["905033465232"]

  assume_role {
    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias = "eu-central-1"

  region              = "eu-central-1"
  allowed_account_ids = ["905033465232"]

  assume_role {
    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias = "us-west-1"

  region              = "us-west-1"
  allowed_account_ids = ["905033465232"]

  assume_role {
    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias = "us-east-1"

  region              = "us-east-1"
  allowed_account_ids = ["905033465232"]

  assume_role {
    role_arn = "arn:aws:iam::905033465232:role/OrganizationAccountAccessRole"
  }
}

module "vpc_eu-west-1" {
  source = "./vpc-with-defaults"

  providers = {
    aws = aws.eu-west-1
  }
}

module "vpc_eu-central-1" {
  source = "./vpc-with-defaults"

  providers = {
    aws = aws.eu-central-1
  }
}

module "vpc_us-west-1" {
  source = "./vpc-with-defaults"

  providers = {
    aws = aws.us-west-1
  }
}

module "vpc_us-east-1" {
  source = "./vpc-with-defaults"

  providers = {
    aws = aws.us-east-1
  }
}
