//resource "tls_private_key" "deployer" {
//  algorithm = "RSA"
//}
//
//resource "aws_key_pair" "deployer" {
//  key_name_prefix = "deployer-key"
//  public_key = tls_private_key.deployer.public_key_openssh
//}
