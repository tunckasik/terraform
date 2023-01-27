variable "prefix" {
  default = "tf-docker-vm"
}
variable "location" {
  default = "East US"
}
variable "server-name" {
  type = string
  default = "docker-instance"
}

variable "docker-instance-ports" {
  type = list(number)
  description = "docker-instance-nsg-inbound-rules"
  default = [22, 80, 8080]
}
