variable "location" {
  default = "East US"
}

variable "rg01" {
  default = "RG01"
}

variable "storageAccountName" {
  #dynamic; will be answered during terraform apply
}

variable "VM-01" {
  default = "VM-01"
}

variable "computer_name"{
  default = "hostname"
  }

variable "admin_username" {
  default = "bronzeAdmin"
}

variable "admin_password"{
  #dynamic; will be answered during applying
}