resource "azurerm_availability_set" "a_set" {
  name                         = "tf-a_set"
  location                     = azurerm_resource_group.tf-bronze-rg.location
  resource_group_name          = azurerm_resource_group.tf-bronze-rg.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 20
  managed                      = true
}

resource "azurerm_storage_container" "storage_container" {
  count                 = var.virtual_machine_count
  name                  = "tfstoragecontainer${count.index}"
  storage_account_name  = azurerm_storage_account.storage_account_1.name
  container_access_type = "private"
}

resource "azurerm_network_interface" "nic" {
  count               = var.virtual_machine_count
  name                = "tf-nic_${count.index}"
  location            = azurerm_resource_group.tf-bronze-rg.location
  resource_group_name = azurerm_resource_group.tf-bronze-rg.name

  ip_configuration {
    name                          = "tf-nic_ip_config_${count.index}"
    subnet_id                     = azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count                 = var.virtual_machine_count
  name                  = "tf-vm_${count.index}"
  location              = azurerm_resource_group.tf-bronze-rg.location
  resource_group_name   = azurerm_resource_group.tf-bronze-rg.name
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  vm_size               = "Standard_DS1_v2"
  availability_set_id   = azurerm_availability_set.a_set.id

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "tf-osdisk_${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "tf-datadisk_${count.index}"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = "1023"
    create_option     = "Empty"
    lun               = 0
  }

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name  = "tf-vm_${count.index}"
    admin_username = "bronze"
    admin_password = var.vm_admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
