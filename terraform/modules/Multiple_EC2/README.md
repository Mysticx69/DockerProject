<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>2.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>2.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.EC2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_EC2_counter"></a> [EC2\_counter](#input\_EC2\_counter) | Number of EC2 to deploy | `number` | `1` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | Ami ID to deploy | `string` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Decide if you want auto public IP on your instances | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environement where EC2 are deployed | `string` | `"production"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type (T2.micro... etc) | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Key\_pair for EC2 | `string` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to spawn EC2 in | `string` | `null` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of SG to attach EC2 to | `set(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_EC2_PrivateIP"></a> [EC2\_PrivateIP](#output\_EC2\_PrivateIP) | n/a |
| <a name="output_EC2_name"></a> [EC2\_name](#output\_EC2\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->