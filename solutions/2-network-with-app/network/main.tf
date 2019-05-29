# Notes:
# 1. Set values of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

provider "aws" {
  region  = "us-west-1"
  version = ">= 2.12.0"
}

// Enable remote state to keep them in the shared S3 bucket (should be created in advance outside of terraform)
terraform {
  backend "s3" {
    region = "us-west-1"
    bucket = "tmp-tfstates"
    key    = "us-west-1/network/terraform.tfstate"
  }
}

// @todo: Copy the rest of configuration where network resources were created from solutions/1-network/main.tf

