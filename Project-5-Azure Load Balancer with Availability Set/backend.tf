terraform {
    backend "azurerm" {
        storage_account_name = "tfstatecontainerfxfx3223"       # Use unique name
        container_name       = "tfstatecontainer"               # Use own container name
        key                  = "terraform.tfstate"              # Add a name to the state file
        resource_group_name  = "tf-state-rg"                    # Use your own resource group name
    }
}