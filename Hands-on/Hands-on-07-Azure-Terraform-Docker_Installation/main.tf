terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.39.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features{}
}

resource "azurerm_resource_group" "tf-rg" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
}
resource "azurerm_public_ip" "pip1" {
  name                = "${var.vm_name}-pip"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = var.location
  allocation_method   = "Static"
}
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.tf-rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id 
  }
}
resource "azurerm_network_security_group" "nsg1" {
    name                = "nsg_sshopen"
    location            = var.location
    resource_group_name = azurerm_resource_group.tf-rg.name

    security_rule {
        name                       = "AllowSSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
# To associate nsg with nic
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

data "template_file" "userdata" {
  template = file("${abspath(path.module)}/setupDocker.sh")
  vars = {
    server-name = var.server-name
  }
}
resource "azurerm_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.tf-rg.location
  resource_group_name   = azurerm_resource_group.tf-rg.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

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
    computer_name  = "hostname"
    admin_username = "azure-user"
    admin_password = "Password1234!"
    custom_data = data.template_file.userdata.rendered
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
        path = "/home/ccseyhan/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2mxA58gOFzLfMafP8Kt0ATpykipMMNntEJE41VYXlUdfA+C0ZJ821uv9yFqEiCGw6UPIrKxKPHQUve3gPqXOMCvfSi9c1+aCWjleJ/RHr/E+vej5V3FLuT1q1BMCvdv0MYal1q3bZHO3FPMdaDxdqijeO+TBXEtAaE1LoSG8VfmouS64CUhOmlMrkUS2aYvWS3AW9RK5jRcJSmX0ew4qW4zCC1DavmyBPXV+GuqxTVKqi1wypZlQhqSUnKcyUsWGWINyVlLRABbnSlGP5Ew44fjhhU3wI56HsbbHSeicn0IfnCltwM3Jh9ewEB4hHy4AQDVN2NjnnHh8oZXpkJ7pdzeyWQDhrYXiwdZNq1dn67cfAk6e21UngIvsMM/8rlVyNge/OLgCjQxLdb8BoMZ/XKfwdX47JId/6XubjhlbrJ5lo8GEFQCTEOc0n3PR4Zsv8UrlSR3nGM4x378kgE2ZdH4Bvqs3uHjZF47tfHS4BgH5pCHD0JgFiknPBRZ+8sN3yS+1m5X9GF6zty9iw/dw5u6PnfzZPQfzlykV+qwu9wn9ifUjWDm9OymiHonXR+BSRGSMKm31JilF8XZn3k5YOPnjNYANJpfW7pI2273pQcLkTHHP1kfNT5zr0nIwLmRqc9MRTE1tyEIZQAy9fQOAALFtoRKKpw3hb+NNuK7e43Q=="
    }
  }
  tags = {
    environment = "staging"
  }
}