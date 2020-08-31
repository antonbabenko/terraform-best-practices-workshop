# Notes:
# 1. Set values of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

provider "aws" {
  region  = "us-west-1"
  version = "~> 3.0"
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
    region = "us-west-2"
    key    = "us-west-2/network/terraform.tfstate"
  }
}

module "my_app" {
  source = "git@github.com:antonbabenko/terraform-best-practices-workshop.git//modules/application"

  filename = "text.txt"
  content  = "Hello, I am using VPC ID: ${data.terraform_remote_state.network.vpc_id}"
}

//output "s3_file_url" {
//  value = module.my_app.???
//}

// Show the URL of the file uploaded to S3


// @todo: Copy the rest of configuration where application resources were created from solutions/1-network/main.tf

