output "name" {
  value = "${local.name}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "private_subnetes" {
  value = "${module.vpc.private_subnets}"
}

output "ec2_security_group_name" {
  value = "${module.ec2_security_group.this_security_group_name}"
}

output "autoscaling_group_id" {
  value = "${module.autoscaling.this_autoscaling_group_id}"
}

output "launch_configuration_id" {
  value = "${module.autoscaling.this_launch_configuration_id}"
}

output "created_instance_public_ips" {
  value = "${data.aws_instance.created.*.public_ip}"
}
