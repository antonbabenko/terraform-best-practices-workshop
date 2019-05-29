provider "aws" {
  region = "us-west-1"
}

module "application" {
  source = "../"

  content = "test"
  key     = "test.txt"
}

output "s3_file" {
  value = "${module.application.file_url}"
}
