data "aws_s3_bucket_object" "test_object" {
    bucket = "${var.s3_bucket_name}"
    key    = "${var.s3_object_key}"
}

