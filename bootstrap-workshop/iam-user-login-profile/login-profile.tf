locals {
  aws_cli_profile = "tfworkshop-admin"
  aws_cli_extra   = "" # "--profile ${local.aws_cli_profile}"
}

variable "username" {}

resource "random_pet" "password" {
  length = 2
}

resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "aws iam create-login-profile --user-name ${var.username} --password ${random_pet.password.id} --no-password-reset-required ${local.aws_cli_extra}"
  }
}

output "username" {
  value = var.username
}

output "password" {
  value = random_pet.password.id
}
