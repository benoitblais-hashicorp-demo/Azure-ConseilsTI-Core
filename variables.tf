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

variable "tfc_organization" {
  description = "(Required) The HCP Terraform Organization name."
  type        = string
}

variable "tfc_project" {
  description = "(Required) The HCP Terraform Project name."
  type        = string
}

variable "tfc_workspace_policies" {
  description = "(Required) The HCP Terraform Workspace name used for deployments and management of Azure Policies via HCP Terraform."
  type        = string

  validation {
    condition     = var.tfc_workspace_policies == "" || (var.tfc_organization != "" && var.tfc_project != "")
    error_message = "If 'tfc_workspace_policies' is provided, both 'tfc_organization' and 'tfc_project' must also be provided to create the Federated Identity Credential."
  }
}

variable "policy_spn_display_name" {
  description = "(Optional) The display name for the application registration of the Policy SPN. This SPN will be used for deployments and management of Azure Policies via HCP Terraform, ensuring consistent policy enforcement across the Landing Zones."
  type        = string
  default     = "spn-lz-policy-mgmt"
}
