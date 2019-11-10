locals {
  aws_cli_profile = "tfworkshop-admin"
}

variable "username" {}

resource "random_pet" "password" {
  length = 2
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "aws iam create-login-profile --profile ${local.aws_cli_profile} --user-name ${var.username} --password ${random_pet.password.id} --no-password-reset-required"
  }
}

output "username" {
  value = var.username
}

output "password" {
  value = random_pet.password.id
}
