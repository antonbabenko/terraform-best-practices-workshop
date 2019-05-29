# Application module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| content | Content of file on S3 | string | n/a | yes |
| key | S3 file key | string | n/a | yes |
| s3\_bucket | S3 bucket to use | string | `"tmp-tfstates"` | no |

## Outputs

| Name | Description |
|------|-------------|
| file\_url | File URL |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
