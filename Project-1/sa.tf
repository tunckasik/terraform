resource "azurerm_storage_account" "storageaccountname" {
  name                     = var.storageaccountname
  resource_group_name      = azurerm_resource_group.logicalName_RG.name
  location                 = azurerm_resource_group.logicalName_RG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}