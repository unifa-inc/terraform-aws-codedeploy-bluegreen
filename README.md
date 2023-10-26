# terraform-aws-codedeploy-bluegreen
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
| [aws_codedeploy_app.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app) | resource |
| [aws_codedeploy_deployment_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_deployment_group) | resource |
| [aws_iam_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cognito](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_on_timeout"></a> [action\_on\_timeout](#input\_action\_on\_timeout) | When to reroute traffic from an original environment to a replacement environment in a blue/green deployment. | `string` | `"CONTINUE_DEPLOYMENT"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of the application. | `any` | n/a | yes |
| <a name="input_auto_rollback_enabled"></a> [auto\_rollback\_enabled](#input\_auto\_rollback\_enabled) | Indicates whether a defined automatic rollback configuration is currently enabled for this Deployment Group. | `bool` | `true` | no |
| <a name="input_auto_rollback_events"></a> [auto\_rollback\_events](#input\_auto\_rollback\_events) | The event type or types that trigger a rollback. | `list(string)` | <pre>[<br>  "DEPLOYMENT_FAILURE",<br>  "DEPLOYMENT_STOP_ON_ALARM"<br>]</pre> | no |
| <a name="input_blue_target_group"></a> [blue\_target\_group](#input\_blue\_target\_group) | Name of the blue target group. | `any` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The ECS Cluster name. | `any` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the all resources. | `string` | `"Managed by Terraform"` | no |
| <a name="input_green_target_group"></a> [green\_target\_group](#input\_green\_target\_group) | Name of the green target group. | `any` | n/a | yes |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | Path in which to create the IAM Role and the IAM Policy. | `string` | `"/"` | no |
| <a name="input_prod_listener_arns"></a> [prod\_listener\_arns](#input\_prod\_listener\_arns) | List of Amazon Resource Names (ARNs) of the load balancer listeners. | `list(string)` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The ECS Service name. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources. | `map` | `{}` | no |
| <a name="input_termination_wait_time_in_minutes"></a> [termination\_wait\_time\_in\_minutes](#input\_termination\_wait\_time\_in\_minutes) | The number of minutes to wait after a successful blue/green deployment before terminating instances from the original environment. | `number` | `5` | no |
| <a name="input_test_listener_arns"></a> [test\_listener\_arns](#input\_test\_listener\_arns) | List of Amazon Resource Names (ARNs) of the load balancer to route test traffic listeners. | `list(string)` | `[]` | no |
| <a name="input_trigger_events"></a> [trigger\_events](#input\_trigger\_events) | Default Notification Events | `list` | <pre>[<br>  "DeploymentStart",<br>  "DeploymentSuccess",<br>  "DeploymentFailure",<br>  "DeploymentStop",<br>  "DeploymentRollback",<br>  "DeploymentReady"<br>]</pre> | no |
| <a name="input_trigger_target_arn"></a> [trigger\_target\_arn](#input\_trigger\_target\_arn) | Arn of the Amazon SNS. | `list` | `[]` | no |
| <a name="input_wait_time_in_minutes"></a> [wait\_time\_in\_minutes](#input\_wait\_time\_in\_minutes) | The number of minutes to wait before the status of a blue/green deployment changed to Stopped if rerouting is not started manually. | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codedeploy_app_id"></a> [codedeploy\_app\_id](#output\_codedeploy\_app\_id) | Amazon's assigned ID for the application. |
| <a name="output_codedeploy_app_name"></a> [codedeploy\_app\_name](#output\_codedeploy\_app\_name) | The application's name. |
| <a name="output_codedeploy_deployment_group_id"></a> [codedeploy\_deployment\_group\_id](#output\_codedeploy\_deployment\_group\_id) | Application name and deployment group name. |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this IAM Policy. |
| <a name="output_iam_policy_description"></a> [iam\_policy\_description](#output\_iam\_policy\_description) | The description of the IAM Policy. |
| <a name="output_iam_policy_document"></a> [iam\_policy\_document](#output\_iam\_policy\_document) | The policy document of the IAM Policy. |
| <a name="output_iam_policy_id"></a> [iam\_policy\_id](#output\_iam\_policy\_id) | The IAM Policy's ID. |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | The name of the IAM Policy. |
| <a name="output_iam_policy_path"></a> [iam\_policy\_path](#output\_iam\_policy\_path) | The path of the IAM Policy. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the IAM Role. |
| <a name="output_iam_role_create_date"></a> [iam\_role\_create\_date](#output\_iam\_role\_create\_date) | The creation date of the IAM Role. |
| <a name="output_iam_role_description"></a> [iam\_role\_description](#output\_iam\_role\_description) | The description of the IAM Role. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM Role. |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | The stable and unique string identifying the IAM Role. |
<!-- END_TF_DOCS -->