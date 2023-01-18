terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

# RG  # Vnet # Subnet
resource "azurerm_resource_group" "tf_rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_virtual_network" "tf-vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name
}

resource "azurerm_subnet" "tf-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.tf_rg.name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  address_prefixes     = var.subnet_address_space

}

# NSG
resource "azurerm_network_security_group" "tf-nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.tf_rg.location
  resource_group_name = azurerm_resource_group.tf_rg.name

  security_rule {
    name                       = "Allow SMB"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "445"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# To make a unique storage account name
resource "random_pet" "random_pet" {
  length = 4
  type = "alpha"
  case = lower
}

# SA
resource "azurerm_storage_account" "tf-sa" {
  name                     = "${random_pet.random_pet.id}"
  resource_group_name      = azurerm_resource_group.tf_rg.name
  location                 = azurerm_resource_group.tf_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}

# FileShare
resource "azurerm_storage_share" "tf-FileShare" {
  name                 = "filesharename"
  storage_account_name = azurerm_storage_account.tf-sa.name
  quota                = 50

}