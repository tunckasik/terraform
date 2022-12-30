variable "rg_name" {
  default = "tf-rg"
}

variable "location" {
  default = "East US"
}

variable "vnet_name"{
    default = "tf-vnet"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default = "tf-subnet"
}

variable "subnet_address_space" {
  default = ["10.0.1.0/24"]
}

variable "nsg_name" {
  default = "tf-nsg"
}

variable "storageaccountname" {
  default = ""
}