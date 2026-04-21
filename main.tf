# The following resource blocks and for_each logic are used to ensure Management Group deployment respects the
# hierarchical dependencies between Management Groups and their parents. A local variable is used to merge the
# response from each block to return the configuration data in a single object.
# Azure only supports a Management Group depth of 6 levels.

resource "azurerm_management_group" "level_1" {
  for_each = local.azurerm_management_group_level_1

  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"

}

resource "azurerm_management_group" "level_2" {
  for_each = local.azurerm_management_group_level_2

  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"

  depends_on = [azurerm_management_group.level_1]

}

resource "azurerm_management_group" "level_3" {
  for_each = local.azurerm_management_group_level_3

  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"

  depends_on = [azurerm_management_group.level_2]

}

resource "azurerm_management_group" "level_4" {
  for_each = local.azurerm_management_group_level_4

  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"

  depends_on = [azurerm_management_group.level_3]

}

resource "azurerm_management_group" "level_5" {
  for_each = local.azurerm_management_group_level_5

  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"

  depends_on = [azurerm_management_group.level_4]

}

resource "azurerm_management_group" "level_6" {
  for_each = local.azurerm_management_group_level_6

  name                       = each.value.id
  display_name               = each.value.display_name
  parent_management_group_id = "${local.provider_path.management_groups}${each.value.parent_management_group_id}"

  depends_on = [azurerm_management_group.level_5]

}

# Subscriptions creation and assignment via module

data "azurerm_billing_mca_account_scope" "this" {
  billing_account_name = var.billing_account_name
  billing_profile_name = var.billing_profile_name
  invoice_section_name = var.invoice_section_name
}

module "subscriptions" {
  source = "./modules/subscription"

  for_each = {
    for k, v in local.es_core_landing_zones : k => v
    if can(v.subscription_name)
  }

  subscription_name   = each.value.subscription_name
  billing_scope_id    = data.azurerm_billing_mca_account_scope.this.id
  management_group_id = "${local.provider_path.management_groups}${each.key}"

  # Ensure the hierarchy level is created first. Because we don't know the exact level easily in a generic map,
  # we depend on all management groups. 
  depends_on = [
    azurerm_management_group.level_1,
    azurerm_management_group.level_2,
    azurerm_management_group.level_3,
    azurerm_management_group.level_4,
    azurerm_management_group.level_5,
    azurerm_management_group.level_6
  ]
}

# # ---------------------------------------------------------------------------------------------------------------------
# # Identity & RBAC Configuration
# # ---------------------------------------------------------------------------------------------------------------------

# resource "azurerm_role_definition" "restricted_contributor" {
#   name        = "Platform Restricted Contributor"
#   scope       = azurerm_management_group.level_1[local.root_id].id
#   description = "Restricted Contributor for Platform Landing Zones. Cannot mutate routing or network structures."

#   permissions {
#     actions = [
#       "*"
#     ]
#     not_actions = [
#       "Microsoft.Authorization/*/Delete",
#       "Microsoft.Authorization/*/Write",
#       "Microsoft.Authorization/elevateAccess/Action",
#       "Microsoft.Blueprint/blueprintAssignments/write",
#       "Microsoft.Blueprint/blueprintAssignments/delete",
#       "Microsoft.Compute/galleries/share/action",
#       "Microsoft.Network/virtualNetworks/write",
#       "Microsoft.Network/virtualNetworks/delete",
#       "Microsoft.Network/routeTables/write",
#       "Microsoft.Network/routeTables/delete",
#       "Microsoft.Network/networkSecurityGroups/write",
#       "Microsoft.Network/networkSecurityGroups/delete"
#     ]
#     data_actions     = []
#     not_data_actions = []
#   }
# }

# # Policy SPN (assigned at the MG scope)
# resource "azuread_application" "policy" {
#   display_name = "spn-lz-policy-mgmt"
#   owners       = []
# }

# resource "azuread_service_principal" "policy" {
#   client_id = azuread_application.policy.client_id
# }

# resource "azuread_application_flexible_federated_identity_credential" "policy" {
#   application_id = azuread_application.policy.id
#   display_name   = "fic-tfc-policy-mgmt"
#   description    = "Deployments for policy management from HCP Terraform"
#   audiences      = ["api://AzureADTokenExchange"]
#   issuer         = "https://app.terraform.io"
#   subject        = "organization:${var.tfc_organization}:project:${var.tfc_project}:workspace:${var.tfc_workspace_policy}"
# }

# resource "azurerm_role_assignment" "policy_mgmt" {
#   scope                = azurerm_management_group.level_1[local.root_id].id
#   role_definition_name = "Resource Policy Contributor"
#   principal_id         = azuread_service_principal.policy.object_id
# }

# # Subscriptions Identity assignment via module
# module "identity" {
#   source = "./modules/landing_zone_identity"

#   for_each = {
#     for k, v in local.es_core_landing_zones : k => v
#     if can(v.subscription_name)
#   }

#   subscription_name         = split("-", each.key)[1] # e.g. "connectivity", "identity"
#   subscription_id           = module.subscriptions[each.key].subscription_id
#   custom_restricted_role_id = azurerm_role_definition.restricted_contributor.role_definition_resource_id
#   tfc_organization          = var.tfc_organization
#   tfc_project               = var.tfc_project
#   tfc_workspace_network     = var.tfc_workspace_mapping[split("-", each.key)[1]].network
#   tfc_workspace_restricted  = var.tfc_workspace_mapping[split("-", each.key)[1]].restricted
# }

