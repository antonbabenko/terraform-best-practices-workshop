# Network Stack on AWS

## Goal

Learn how to manage Network Stack on AWS which consists of VPC resources (subnets, routes, routing tables, NAT gateways, VPC endpoints, etc) using [Terraform AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) published in [Terraform Registry](https://registry.terraform.io).

Integrate VPC with other resources (eg., autoscaling, security group).


## Tasks

1. Explore Terraform Registry - [https://registry.terraform.io](https://registry.terraform.io).
1. Explore examples of using [terraform-aws-vpc module](https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/master/examples).
1. Using [terraform-aws-vpc module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) create VPC for the real scenario (eg, 3 public subnets, 3 private subnets, single NAT gateway).
1. Using [terraform-aws-autoscaling module](https://github.com/terraform-aws-modules/terraform-aws-autoscaling/) create an autoscaling group which will always have 1 EC2 instance running in public subnet. Install and run `nginx` service when instance starts.
1. Using [terraform-aws-security-group module](https://github.com/terraform-aws-modules/terraform-aws-security-group/) create a security group for EC2 instances where HTTP and SSH ports are open.


## Solutions

Solutions are inside [solutions/1-network](https://github.com/antonbabenko/terraform-best-practices-workshop/tree/master/solutions/1-network) directory.


## Extra tasks

1. Verify that EC2 instance has been launched (using `aws_instance` data source, AWS CLI, AWS Console).

1. Connect to EC2 instance by SSH (eg, using EC2 keypair)

1. Using [terraform-aws-elb module](https://github.com/terraform-aws-modules/terraform-aws-elb/) create a public-facing Elastic Load Balancer which will stay in front of EC2 instances launched by an autoscaling group
