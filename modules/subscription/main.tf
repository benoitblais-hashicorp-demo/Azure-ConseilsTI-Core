terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Subscriptions creation
resource "azurerm_subscription" "this" {
  subscription_name = var.subscription_name
  billing_scope_id  = var.billing_scope_id

  timeouts {
    create = "60m"
    read   = "15m"
  }
}

# Subscriptions associations to Management Groups
resource "azurerm_management_group_subscription_association" "this" {
  management_group_id = var.management_group_id
  subscription_id     = "/subscriptions/${azurerm_subscription.this.subscription_id}"
}