variable "billing_scope_id" {
  description = "(Required) The Billing Scope ID for the Microsoft Customer Agreement (MCA) where the subscriptions will be created."
  type        = string
  sensitive   = true
}

variable "management_group_id" {
  description = "(Required) The Management Group ID to associate the subscription with."
  type        = string
}

variable "subscription_name" {
  description = "(Required) The name of the subscription."
  type        = string
}
