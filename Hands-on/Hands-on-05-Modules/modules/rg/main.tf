resource "azurerm_resource_group" "rg" {
    name = "${var.rg_name}-${var.env}"
    location = var.location
    tags = {
          "costcenter"  = var.costcenter
          "env"         = var.env
          "createdBy"   = "terraform"
    }
}