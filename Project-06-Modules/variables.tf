variable "location" {
  default = "West US"
}

variable "rg_name" {
  default = "value"
  type = string
}

variable "database_rg_name" {
  default = "value"
  type = string

}

variable "sa_rg_name" {
  default = "value"
  type = string
}

variable "sa_costcenter" {
  type = string
}
variable "dev_costcenter" {
  type = string
}
variable "costcenter" {
  type = string
}

variable "env" {
  type = string
}