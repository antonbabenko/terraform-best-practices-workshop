# Terraform Basics - EC2 instance

## Goal

Create EC2 instance running Amazon Linux AMI in the public subnet (default VPC) using aws_instance resource and aws_ami data-source.


## Tasks

1. Make sure to install Terraform 0.11
1. Start with updating content of `main.tf` in this directory (see sub-tasks in that file)
1. Optionally, split content into `main.tf`, `variables.tf` and `outputs.tf` for better readability


## Solutions

Solutions are inside [solutions/0-basic](https://github.com/antonbabenko/terraform-best-practices-workshop/tree/master/solutions/0-basic) directory.


## Extra tasks

1. Verify that EC2 instance has been launched (using `aws_instance` data source, AWS CLI or AWS Console).

1. Connect to EC2 instance by SSH (eg, using EC2 keypair)

1. Using [terraform-aws-elb module](https://github.com/terraform-aws-modules/terraform-aws-elb/) create a public-facing Elastic Load Balancer which will stay in front of EC2 instances launched by an autoscaling group
