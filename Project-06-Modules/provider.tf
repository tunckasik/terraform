terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.35.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    #Configuration options
  features {}
}