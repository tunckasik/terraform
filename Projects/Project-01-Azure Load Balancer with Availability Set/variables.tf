variable "region" {
  description = "The Azure region to create things in."
  default     = "East US"
}
variable "vm_admin_password" {
  description = "Passwords for the root user in VMs."
  default     = "4321Boom!:)" # This should be hidden and passed as variable, doing this just for training purpose
}

variable "virtual_machine_count" {
  description = "Number of Virtual Machine for Production Environment"
  default     = 2
}
