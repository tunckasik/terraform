resource "azurerm_virtual_network" "vnet1" {
  name                = "az104-06-vnet1"
  location            = var.location
  resource_group_name = module.rg1.rg.name
  address_space       = ["10.60.0.0/22"]
}

module "subnet0" {
  source         = "./modules/subnet"
  subnet_name    = "Subnet0"
  subnet_address = ["10.60.0.0/24"]
  rg_name        = module.rg1.rg.name
  vnet_name      = azurerm_virtual_network.vnet1.name
}
module "subnet1" {
  source         = "./modules/subnet"
  subnet_name    = "Subnet1"
  subnet_address = ["10.60.1.0/24"]
  rg_name        = module.rg1.rg.name
  vnet_name      = azurerm_virtual_network.vnet1.name
}
module "subnet_appgw" {
  source         = "./modules/subnet"
  subnet_name    = "Subnet-appgw"
  subnet_address = ["10.60.3.224/27"]
  rg_name        = module.rg1.rg.name
  vnet_name      = azurerm_virtual_network.vnet1.name
}
module "vnet2" {
  source                = "./modules/vnet"
  vnet_name             = "az104-06-vnet2"
  address_space         = ["10.62.0.0/22"]
  address_prefix_subnet = "10.62.0.0/24"
  rg_name               = module.rg1.rg.name
}
module "vnet3" {
  source                = "./modules/vnet"
  vnet_name             = "az104-06-vnet3"
  address_space         = ["10.63.0.0/22"]
  address_prefix_subnet = "10.63.0.0/24"
  rg_name               = module.rg1.rg.name
}