variable "billing_account_name" {
  description = "(Required) The Billing Account Name of the MCA account."
  type        = string
}

variable "billing_profile_name" {
  description = "(Required) The Billing Profile Name in the above Billing Account."
  type        = string
}

variable "invoice_section_name" {
  description = "(Required) The Invoice Section Name in the above Billing Profile."
  type        = string
}

variable "root_name" {
  description = "(Required) Will set a custom Display Name value for the Enterprise-scale root Management Group."
  type        = string
}

variable "root_parent_id" {
  description = "(Required) The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones."
  type        = string
}

variable "subscription_id" {
  description = "(Required) Azure Subscription ID for the provider to authenticate against."
  type        = string
}

variable "tenant_id" {
  description = "(Required) Azure Tenant ID for the provider to authenticate against."
  type        = string
}

# variable "tfc_organization" {
#   description = "The HCP Terraform Organization name for the Federated Identity Credentials."
#   type        = string
# }

# variable "tfc_project" {
#   description = "The HCP Terraform Project name for the Federated Identity Credentials."
#   type        = string
# }

# variable "tfc_workspace_mapping" {
#   description = "A mapping of landing zone keys (e.g. 'connectivity', 'identity') to their respective workspaces."
#   type = map(object({
#     network    = string
#     restricted = string
#   }))
# }

# variable "tfc_workspace_policy" {
#   description = "The HCP Terraform Workspace name for the dedicated Policy SPN."
#   type        = string
# }
