output "subscription_id" {
  description = "The ID of the generated subscription."
  value       = azurerm_subscription.this.subscription_id
}

output "subscription_name" {
  description = "The name of the generated subscription."
  value       = azurerm_subscription.this.subscription_name
}
