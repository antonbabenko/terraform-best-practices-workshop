# Application module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| content | Content of file on S3 | `any` | n/a | yes |
| key | S3 file key | `any` | n/a | yes |
| s3\_bucket | S3 bucket to use | `string` | `"tmp-tfstates"` | no |

## Outputs

| Name | Description |
|------|-------------|
| file\_url | File URL |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
