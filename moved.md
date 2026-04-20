# Example assuming you used a map/set of keys like "identity", "connectivity", etc:

moved {
  from = azurerm_subscription.this["connectivity"]
  to   = module.subscriptions["connectivity"].azurerm_subscription.this
}

<!-- moved {
  from = azurerm_management_group_subscription_association.this["identity"]
  to   = module.subscriptions["identity"].azurerm_management_group_subscription_association.this
} -->