terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.34.0"
    }
  }
}

provider "azurerm" {
    features {}
}

#Creating a resource group
resource "azurerm_resource_group" "tf-rg01" {
    name = "tf-rg"
    location =  var.location
    tags = {
      "name" = "tf-01-rg"
    }
}

#Creating a storage account
resource "azurerm_storage_account" "tf-sa01" {
    name = var.storageaccountname.name1
}

#Creating a Virtual Machine 
