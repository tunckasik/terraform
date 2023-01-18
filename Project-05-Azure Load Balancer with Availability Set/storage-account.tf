resource "azurerm_storage_account" "storage_account_1" {
    name                     = "tfbronzesafx33"
    resource_group_name      = azurerm_resource_group.tf-bronze-rg.name
    location                 = azurerm_resource_group.tf-bronze-rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}