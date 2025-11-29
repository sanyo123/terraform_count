output "resource_groups" {
  description = "Resource group IDs keyed by name"
  value       = { for k, rg in azurerm_resource_group.unique : k => rg.id }
}

output "virtual_network_ids" {
  description = "IDs of created virtual networks"
  value       = azurerm_virtual_network.this[*].id
}

output "subnet_ids" {
  description = "IDs of created subnets"
  value       = azurerm_subnet.this[*].id
}

output "network_interface_ids" {
  description = "IDs of created network interfaces"
  value       = azurerm_network_interface.this[*].id
}

output "vm_ids" {
  description = "IDs of created virtual machines"
  value       = azurerm_virtual_machine.this[*].id
}
