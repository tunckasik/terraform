resource "azurerm_resource_group" "tf-bronze-rg" {
    name     = "tf-bronze-rg"
    location = "${var.region}"
}