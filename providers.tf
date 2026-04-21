provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  use_oidc = true
  use_cli  = false
}

# provider "azuread" {
#   tenant_id = var.tenant_id
#   use_oidc  = true
#   use_cli   = false
# }
