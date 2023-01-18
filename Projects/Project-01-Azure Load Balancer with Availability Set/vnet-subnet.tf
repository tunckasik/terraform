resource "azurerm_virtual_network" "vnet" {
  name                = "tf-vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.tf-bronze-rg.location}"
  resource_group_name = "${azurerm_resource_group.tf-bronze-rg.name}"
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = "frontend_subnet"
  resource_group_name  = "${azurerm_resource_group.tf-bronze-rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes      = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "backend_subnet" {
  name                 = "backend_subnet"
  resource_group_name  = "${azurerm_resource_group.tf-bronze-rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefixes      = ["10.0.2.0/24"]
}