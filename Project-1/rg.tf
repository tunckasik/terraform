resource "azurerm_resource_group" "logicalName_RG" {
    name = "Terra-RG"
    location = "West US"
    tags = {
      "costcenter" = "103"
      "env" = "dev"
    }
}