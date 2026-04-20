<!-- markdownlint-disable MD033 MD041 -->
# Azure Subscription Terraform Module

This module provides a consistent and reusable way to provision Azure Subscriptions for a Microsoft Customer Agreement (MCA) and associate them with a specified Management Group.

## Permissions

The following permissions are required to use this module:

- **Azure Subscriptions (Billing)**: `Azure subscription creator` role.
  - For a Microsoft Customer Agreement (MCA), this role must be assigned at the **Invoice Section** scope corresponding to the `billing_scope_id` variable.
- **Azure Management Groups**: `Management Group Contributor` or `Owner` on the target Management Group.

## Authentications

Authentication to Azure should be handled via the root module's provider configuration. Dynamic Provider Credentials (OIDC) is the recommended approach for automation.

## Features

- Automates Azure Subscription creation under an MCA Billing Scope (Invoice Section).
- Automatically associates the new subscription with a target Azure Management Group.
- Includes a 60-minute creation timeout to accommodate slow backend API processes.

## Usage

```hcl
module "my_subscription" {
  source = "./modules/subscription"

  subscription_name   = "sub-my-workload"
  billing_scope_id    = var.billing_scope_id
  management_group_id = data.azurerm_management_group.target.id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.64 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.64 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group_subscription_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [azurerm_subscription.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_scope_id"></a> [billing\_scope\_id](#input\_billing\_scope\_id) | (Required) The Billing Scope ID for the Microsoft Customer Agreement (MCA) where the subscriptions will be created. | `string` | n/a | yes |
| <a name="input_management_group_id"></a> [management\_group\_id](#input\_management\_group\_id) | (Required) The Management Group ID to associate the subscription with. | `string` | n/a | yes |
| <a name="input_subscription_name"></a> [subscription\_name](#input\_subscription\_name) | (Required) The name of the subscription. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | The ID of the generated subscription. |
| <a name="output_subscription_name"></a> [subscription\_name](#output\_subscription\_name) | The name of the generated subscription. |

## External Documentation

- [azurerm\_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription)
- [azurerm\_management\_group\_subscription\_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association)
