output "subnet" {
  value = data.azurerm_subnet.subnet
}

output "vnet" {
  value = data.azurerm_virtual_network.vnet
}