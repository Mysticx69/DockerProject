<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.EC2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_EC2_counter"></a> [EC2\_counter](#input\_EC2\_counter) | Number of EC2 to deploy | `number` | n/a | yes |
| <a name="input_ami"></a> [ami](#input\_ami) | Ami ID to deploy | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environement where EC2 are deployed | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type (T2.micro... etc) | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key\_pair for EC2 | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to spawn EC2 in | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_EC2_PrivateIP"></a> [EC2\_PrivateIP](#output\_EC2\_PrivateIP) | n/a |
| <a name="output_EC2_name"></a> [EC2\_name](#output\_EC2\_name) | n/a |
<!-- END_TF_DOCS -->