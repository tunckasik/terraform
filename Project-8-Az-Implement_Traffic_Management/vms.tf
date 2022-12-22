module "vm2" {
    source          = "./modules/vm"
    vm_name         = "az104-06-vm2"
    subnet_id       = module.vnet2.subnet.subnet_id
    resource_group  = module.rg1.rg.name
}

module "vm3" {
    source          = "./modules/vm"
    vm_name         = "az104-06-vm3"
    subnet_id       = module.vnet3.subnet.subnet_id
    resource_group  = module.rg1.rg.name
}

module "vm0" {
    source          = "./modules/vm"
    vm_name         = "az104-06-vm0"
    subnet_id       = module.subnet0.subnet.id
    resource_group  = module.rg1.rg.name
    ip_forwarding   = true
}

module "vm1" {
    source          = "./modules/vm"
    vm_name         = "az104-06-vm1"
    subnet_id       = module.subnet1.subnet.id
    resource_group  = module.rg1.rg.name
}

