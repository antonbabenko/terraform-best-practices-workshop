# Notes:
# 1. Set values of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

provider "aws" {
  region  = "us-west-1"
  version = ">= 2.12.0"
}

// Enable remote state to keep tfstate in the shared S3 bucket (should be created in advance outside of terraform)
terraform {
  backend "s3" {
    region = "us-west-1"
    bucket = "tmp-tfstates"
    key    = "us-west-1/app/terraform.tfstate"
  }
}

// Specify where Terraform should access remote state for the network layer.
// The values which remote state outputs are available to use - "${data.terraform_remote_state.network.public_subnets}"
data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket = "tmp-tfstates"
    region = "us-west-1"
    key    = "us-west-1/network/terraform.tfstate"
  }
}

// @todo: Copy the rest of configuration where application resources were created from solutions/1-network/main.tf

