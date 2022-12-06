output "storage_account_name" {
    value = azurerm_storage_account.storageaccountname.name
    sensitive = false
    description = "value is good to know"
}