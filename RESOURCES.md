<!-- BEGIN_TF_DOCS -->
> :warning: This documentation has been generated from terraform-docs. Any change to README.md file will be deleted!


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | git::https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler.git | n/a |
| <a name="module_db"></a> [db](#module\_db) | terraform-aws-modules/rds/aws | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | = 20.14.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.5.3 |
## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_patch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_kms_key.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.db_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ssm_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones | `map(list(string))` | n/a | yes |
| <a name="input_bastion_instance_type"></a> [bastion\_instance\_type](#input\_bastion\_instance\_type) | Type of the bastion instance | `string` | n/a | yes |
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Capacity type | `map(string)` | n/a | yes |
| <a name="input_cluster_addons_versions"></a> [cluster\_addons\_versions](#input\_cluster\_addons\_versions) | Cluster addons versions | `map(string)` | n/a | yes |
| <a name="input_database_subnet_size"></a> [database\_subnet\_size](#input\_database\_subnet\_size) | Size of subnets relative to base CIDR / 2 (bits to the right) | `number` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version of the DB engine | `map(string)` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Class of the DB instance | `map(string)` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Instance type | `map(list(string))` | n/a | yes |
| <a name="input_private_subnet_size"></a> [private\_subnet\_size](#input\_private\_subnet\_size) | Size of subnets relative to base CIDR / 2 (bits to the right) | `number` | n/a | yes |
| <a name="input_public_subnet_size"></a> [public\_subnet\_size](#input\_public\_subnet\_size) | Size of subnets relative to base CIDR / 2 (bits to the right) | `number` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `map(map(string))` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database"></a> [database](#output\_database) | n/a |
| <a name="output_github_oidc_role"></a> [github\_oidc\_role](#output\_github\_oidc\_role) | n/a |
| <a name="output_kms_key"></a> [kms\_key](#output\_kms\_key) | n/a |
| <a name="output_private"></a> [private](#output\_private) | n/a |
| <a name="output_public"></a> [public](#output\_public) | n/a |
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.8.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.54.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.54.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |
<!-- END_TF_DOCS -->    