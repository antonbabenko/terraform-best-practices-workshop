module "terraform_state_backend" {
  source     = "git::https://github.com/cloudposse/terraform-aws-tfstate-backend.git?ref=tags/0.9.0"
  namespace  = "......."
  stage      = "dev"
  name       = "terraform"
  region     = "eu-west-1"
  attributes = ["state"]
}

output "bucket_id" {
  value = module.terraform_state_backend.s3_bucket_id
}

output "terraform_backend_config" {
  value = module.terraform_state_backend.terraform_backend_config
}

output "bucket_region" {
  value = "eu-west-1"
}
