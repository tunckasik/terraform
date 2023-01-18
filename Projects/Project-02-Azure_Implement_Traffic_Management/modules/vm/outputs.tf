output "vm" {
  value = data.azurerm_virtual_machine.vm
}

output "nic" {
  value = data.azurerm_network_interface.nic
}