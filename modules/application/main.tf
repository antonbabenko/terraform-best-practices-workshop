variable "key" {
  description = "S3 file key"
}

variable "content" {
  description = "Content of file on S3"
}

variable "s3_bucket" {
  description = "S3 bucket to use"
  default     = "tmp-tfstates"
}

data "aws_s3_bucket" "this" {
  bucket = var.s3_bucket
}

resource "aws_s3_bucket_object" "this" {
  bucket  = var.s3_bucket
  key     = "files/${var.key}"
  content = var.content
  acl     = "public-read"
}

output "file_url" {
  description = "File URL"
  value       = "https://${data.aws_s3_bucket.this.bucket_domain_name}/${aws_s3_bucket_object.this.key}"
}
