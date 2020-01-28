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

1. Extend your solution to make use of Terraform 0.12 expressions and make VPC resources to span across all availability zones available for you (replace hard-coded values in lists with [`for` expressions](https://www.terraform.io/docs/configuration/expressions.html#for-expressions) and [`cidrsubnet()` functions](https://www.terraform.io/docs/configuration/functions/cidrsubnet.html))

1. Create SSH key-pair to be able to SSH to instances. Create [TLS private key](https://www.terraform.io/docs/providers/tls/r/private_key.html) using `RSA` algorithm, and use it to create [EC2 key pair](https://www.terraform.io/docs/providers/aws/r/key_pair.html). Update launch configurations to launch instances using correct `key_name`.

1. Using [terraform-aws-elb module](https://github.com/terraform-aws-modules/terraform-aws-elb/) create a public-facing Elastic Load Balancer which will stay in front of EC2 instances launched by an autoscaling group.
