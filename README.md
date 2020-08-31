# Terraform Best Practices Workshop materials

The goal of this workshop is to become familiar with some of the best practices using Terraform, discover existing solutions, Terraform modules, and tools.

This workshop is a practical hands-on addition to [Terraform Best Practices guide](https://www.terraform-best-practices.com/), which has been created and provided by [Anton Babenko](https://github.co/antonbabenko). Some rights reserved.

Please, send your feedback by email to [anton@antonbabenko.com](mailto:anton@antonbabenko.com).

If you are looking for a Terraform trainer, mentor for your project, or other Terraform/AWS services, please send an inquiry to [Betajob company](https://www.betajob.com/).


## Attendee's checklist

- [ ] Follow `@antonbabenko` on [GitHub](https://github.com/antonbabenko), [Twitter](https://twitter.com/antonbabenko), [Linkedin](https://linkedin.com/in/antonbabenko).
- [ ] Join chat room on Gitter during or before the workshop - [gitter.im/terraform-best-practices-workshop/Lobby](https://gitter.im/terraform-best-practices-workshop/Lobby).
- [ ] Install the latest version of [Terraform 0.13](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- [ ] Install the latest version of [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).
- [ ] Make sure that you have a [GitHub](https://github.com/) account created.
- [ ] Mac, Linux or Windows - all is fine as long as you can use it. If you want, you can get a Linux box running using Vagrant+VirtualBox and install software from above on it.
- [ ] Access credentials to manage resources in the workshop's AWS account will be provided at the beginning of it (if requested by attendees).


## "Terraform AWS modules" workshop goal

Learn how to manage AWS infrastructure using existing building blocks - [terraform-aws-modules](https://github.com/terraform-aws-modules).


### Agenda

- [x] [Terraform AWS modules](https://github.com/terraform-aws-modules) are a collection of reusable building blocks of AWS infrastructure supported by the community.
- [x] Explore [Terraform Registry](https://registry.terraform.io) and check out [terraform-aws-modules](https://registry.terraform.io/modules/terraform-aws-modules) listed there.
- [x] Task "Basic Terraform". Read [tasks/0-basic/README.md](https://github.com/antonbabenko/terraform-best-practices-workshop/blob/master/tasks/0-basic/README.md) for more details.
- [x] Task "Network Stack" - VPC, Autoscaling, Security Group, ELB, ALB, RDS. Read [tasks/1-network/README.md](https://github.com/antonbabenko/terraform-best-practices-workshop/blob/master/tasks/1-network/README.md) for more details.
- [ ] Task "IAM resources" - IAM users, groups, permissions, roles, multiple AWS accounts, assuming roles.
- [ ] Task "Working with Terraform in a team using Atlantis" - Setup [Atlantis](https://runatlantis.io) to run on AWS Fargate using [terraform-aws-atlantis module](https://github.com/terraform-aws-modules/terraform-aws-atlantis) and integrate it with infrastructure repository.


### Resources

* [Official Terraform documentation](https://www.terraform.io/docs/index.html)
* [Terraform AWS provider documentation](https://www.terraform.io/docs/providers/aws/index.html)
* [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform) to have Terraform code automatically formatted before committing.
* [terraform-docs](https://github.com/segmentio/terraform-docs) to have documentation for variables and outputs automatically updated before committing.
* Slides for many of my talks and training are available [here](https://www.slideshare.net/AntonBabenko/).


## Instructor's checklist

 - [x] Verify access to a workshop AWS account (`905033465232`), S3 bucket for remote states (`tfworkshop`), DynamoDB table for locking (`tfworkshop`). Region - `eu-west-1`.
 - [x] Before workshop - create IAM users and IAM group (`developers`) by running `cd bootstrap-workshop && terraform init && terraform apply`.
 - [x] After workshop - remove all resources in the whole AWS account by running `cd bootstrap-workshop && make aws-nuke-for-real` or remove just IAM users and IAM group by running `cd bootstrap-workshop && terraform init && terraform destroy`.


## License

This work licensed under Apache 2 License. See LICENSE for full details.

