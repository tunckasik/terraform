resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}

data "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  resource_group_name = var.rg_name
  depends_on = [
    azurerm_virtual_network.vnet
  ]

}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.vnet_name}_subnet0"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.address_prefix_subnet]
}

data "azurerm_subnet" "subnet" {
  name = "${var.vnet_name}_subnet0"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  depends_on = [
    azurerm_subnet.subnet
  ]
}