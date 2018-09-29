resource "aws_s3_bucket_object" "plain_object" {
    bucket        = "${var.s3_bucket_name}"
    key           = "${var.s3_object_key}"
    source        = "${var.s3_file_path}"
    storage_class = "${var.s3_storage_class}"
    etag          = "${md5(file("${var.s3_file_path}"))}"
}

