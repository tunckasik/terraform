terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.34.0"
    }
  }
}

provider "azurerm" {
    features {
        resource_group {
          prevent_deletion_if_contains_resources = false
        }
    }
}

#Creating a resource group
resource "azurerm_resource_group" "RG-1" {
    name = var.rg01
    location =  var.location
    tags = {
      "name" = "tf-01-rg"
    }
}

#Creating a storage account
resource "azurerm_storage_account" "SA-1" {
    name = lower(var.storageAccountName)
    resource_group_name = var.rg01
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

#Creating a Virtual Machine and its dependency resources
resource "azurerm_virtual_network" "VNET-1" {
  name                = "${var.VM-01}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg01
}

resource "azurerm_subnet" "Subnet-1" {
  name                 = "${var.VM-01}-Subnet-Internal"
  resource_group_name  = var.rg01
  virtual_network_name = azurerm_virtual_network.VNET-1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "NIC-1" {
  name                = "${var.VM-01}-nic"
  location            = var.location
  resource_group_name = var.rg01

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.Subnet-1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "VM-1" {
  name                  = var.VM-01
  location              = var.location
  resource_group_name   = var.rg01
  network_interface_ids = [azurerm_network_interface.NIC-1.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}