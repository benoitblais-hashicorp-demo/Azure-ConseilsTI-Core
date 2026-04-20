## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.64.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subscriptions"></a> [subscriptions](#module\_subscriptions) | ./modules/landing_zone_subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.level_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_5](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_6](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_scope_id"></a> [billing\_scope\_id](#input\_billing\_scope\_id) | (Required) The Billing Scope ID for the Microsoft Customer Agreement (MCA) where the subscriptions will be created. | `string` | n/a | yes |
| <a name="input_root_name"></a> [root\_name](#input\_root\_name) | (Required) Will set a custom Display Name value for the Enterprise-scale root Management Group. | `string` | n/a | yes |
| <a name="input_root_parent_id"></a> [root\_parent\_id](#input\_root\_parent\_id) | (Required) The root\_parent\_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | (Required) Azure Subscription ID for the provider to authenticate against. | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Required) Azure Tenant ID for the provider to authenticate against. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_management_group"></a> [azurerm\_management\_group](#output\_azurerm\_management\_group) | Returns the configuration data for all Management Groups created. |
| <a name="output_subscriptions"></a> [subscriptions](#output\_subscriptions) | Returns the map of all provisioned subscriptions including their IDs, display names, and associated Management Groups. Useful for secondary workspaces to configure SPNs and Policies. |
