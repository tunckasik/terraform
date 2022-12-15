## Terraform-Project-1.2: Managing Azure resources with Terraform commands.

### Project Outcomes
At the end of the that terraform file we will be able to generate on Azure;
Markup : * Resource group
         * Storage Account
         * Virtual Virtual Network
         * Virtual Machine and some other dependency resources.

### Resource Group
Start with creating a new file as named main.tf
From the terminal, first, login the azure portal with using “az login” command.
After login your azure portal, provision below commands:
---
terraform init
terraform plan
terraform apply
---

### Storage Account:
On the left pane of the terraform website find azurerm_storage_account
---
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
---

Use the entire template into terraform file and use same commands as mentioned above in **Resource Group**. You can see in the last picture on azure portal which is storage account created from terraform.

### Virtual Machine
Search for virtual machine script from terraform web site;

To create VM we should have a Resource Group, a Virtual network, Subnet, NIC and IP User ID with password OS.
Therefore we do all together while virtual machine creating.

### Used commands during the project

**terraform state list command**
The terraform state list command is used to list resources within a Terraform state. Terraform stores information about your infrastructure in a state file. This state file keeps track of resources created by your configuration and maps them to real-world resources. Here is the outcomes when applied;
---
> terraform state list
azurerm_network_interface.NIC-1
azurerm_resource_group.RG-1
azurerm_storage_account.SA-1
azurerm_subnet.Subnet-1
azurerm_virtual_network.VNET-1
azurerm_virtual_machine.VM-1
---

**fmt command**
"terraform fmt" command reformat your configuration file in the standard style.
---
terraform fmt
---

**terraform apply -refresh-only command.**
The terraform apply -refresh-only command is used to update the state file with the real-world infrastructure. This can be used to detect any drift from the last-known state, and to update the state file.

---
terraform apply -refresh-only
---