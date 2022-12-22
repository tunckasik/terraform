resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku = "Standard"
}

data "azurerm_public_ip" "pip" {
  name = var.pip_name
  resource_group_name = var.rg_name
  depends_on = [
    azurerm_public_ip.pip
  ]
}