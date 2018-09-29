provider "aws" {}

module "s3-object" {
    source         = "modules/static-web-site/s3-object"

    s3_object_key  = "${var.s3_object_key}"
    s3_bucket_name = "${var.s3_bucket_name}"
}

