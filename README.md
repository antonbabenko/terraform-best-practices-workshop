# Terraform Best Practices Workshop materials

The goal of this workshop is to become familiar with some of best practices using Terraform.

This workshop is a practical hands-on addition to [Terraform Best Practices guide](https://www.terraform-best-practices.com/).

During or before the workshop, join Gitter chat room - [terraform-best-practices-workshop/Lobby](https://gitter.im/terraform-best-practices-workshop/Lobby)

## Instructor's preparation

 - [ ] Open new AWS account before the workshop, S3 bucket for remote states (`tfworkshop`), DynamoDB table for locking (`tfworkshop`)
 - [ ] Create IAM users in `Developers` group which has power-user access in this AWS account
 - [ ] Grant write access to this workshop repository to have code from attendees there (protect master branch)
 - [ ] Grant write access to terraform-aws-s3-bucket and terraform-aws-s3-object modules repositories (protect master branch)

### Attendee's checklist

* Install latest version of [Terraform](https://www.terraform.io/intro/getting-started/install.html).
* Install latest version of [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html).
* Make sure that you have [GitHub](https://github.com/) account created.
* Mac, Linux or Windows - all is fine as long as you can use it. If you want, you can get Linux box running using Vagrant+VirtualBox and install software from above on it.

## Practical task: Let's host a static web-site using AWS S3 and Route53

### Agenda for the workshop

* Resource modules
* Infrastructure modules
* Composition
* Evolution
* Combination and orchestration
* What's next?

### Resource modules

> Make 2 resource modules which create AWS S3 resources (bucket and object).
> These modules should be very flexible, so that anyone can use them.

Clone these repositories, make your own branch (`git checkout -b my-branch-name`), commit and push code to your branch, open a pull-request to review:

  * [terraform-aws-s3-bucket](https://github.com/terraform-aws-modules/terraform-aws-s3-bucket)
  * [terraform-aws-s3-object](https://github.com/terraform-aws-modules/terraform-aws-s3-object)

Resource modules should have these properties: clean code, feature-rich, sane defaults, tests/examples, documentation. Check ["Using Terraform continuously — Common traits in modules"](https://medium.com/@anton.babenko/using-terraform-continuously-common-traits-in-modules-8036b71764db) for more information.

#### Considerations:

  * Use existing bucket vs create new one?
  * Create one vs many resources (buckets and objects) using one module?

#### Use:

  * [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
  * [terraform-docs](https://github.com/segmentio/terraform-docs)

The result should be 2 resource modules, which we will use in the next task.

### Infrastructure modules

Create infrastructure modules called "static web-site" with these properties:

* Should support conditional creation of bucket or use existing one:

  * bucket_name is required
  * create_bucket = true/false
  * use data-source or call a resource module

* Tags should be required, because we want to track expenses

#### Use:

  * pre-commit-terraform (when hosted in a separate repository)
  * terraform-docs

The result should be an infrastructure module `static-web-site` which we will keep in this repo under `modules/static-web-site`, because it is not very generic, contains some enforcements (tagging), and satisfies the needs of this workshop (for now).

### Composition

There is a single AWS account, where resources for 2 environments (prod and staging) are located side-by-side in a single region (eu-west-1, for example).

Each attendee has his own project directory where this task should be completed - make your directory inside `projects` directory with your name.

#### Considerations:

* Resources should share nothing between environments
* Remote state should match project directory and S3 bucket: to create. Eg, `project/demo-user/eu-west-1/prod/terraform.tfstate`

### Evolution

Changing something here and there... How would you refactor this code?
Usage of `terraform state mv` command.

### Combination and orchestration

terragrunt (?) & data sources as glue

Optional task: Add route53 support for zone by name

### What's next?

* Make infrastructure module which manages several connected&related resources: create bucket, upload files there, create route53 zone and give everyone 2 subdomains (prod and staging).

The result should be an uploaded file which is reachable by URL.

### If there will be time available, we will learn about other related tools (Packer, Terragrunt, Atlantis, and few more)

## Feedback

Please provide your feedback to me by [email](mailto:anton@antonbabenko.com).

## License

This work is licensed under Apache 2 License. See LICENSE for full details.

