resource "azurerm_public_ip" "frontend_lb_pip" {
    name                         = "tf-frontend_lb_pip"
    location                     = "${azurerm_resource_group.tf-bronze-rg.location}"
    resource_group_name          = "${azurerm_resource_group.tf-bronze-rg.name}"
    allocation_method            = "Static"
}

resource "azurerm_lb" "frontend_lb" {
    name                = "tf-frontend_lb"
    location            = azurerm_resource_group.tf-bronze-rg.location
    resource_group_name = azurerm_resource_group.tf-bronze-rg.name
    frontend_ip_configuration {
        name                          = "default"
        public_ip_address_id          = azurerm_public_ip.frontend_lb_pip.id
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_lb_backend_address_pool" "frontend_lb_backend_pool" {
    name                = "tf-frontend_lb_backend_pool"
    loadbalancer_id     = azurerm_lb.frontend_lb.id
}

resource "azurerm_lb_probe" "frontend_lb_probe_port80" {
    name                = "tf-frontend_lb_probe_port80"
    loadbalancer_id     = azurerm_lb.frontend_lb.id
    protocol            = "Tcp"
    port                = 80
}

resource "azurerm_lb_rule" "frontend_lb_rule_port80" {
    name                    = "tf-frontend_lb_rule_port80"
    loadbalancer_id         = azurerm_lb.frontend_lb.id
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.frontend_lb_backend_pool.id]
    probe_id                = azurerm_lb_probe.frontend_lb_probe_port80.id
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "default"
}

resource "azurerm_lb_probe" "frontend_lb_probe_port443" {
    name                = "tf-frontend_lb_probe_port443"
    loadbalancer_id     = azurerm_lb.frontend_lb.id
    protocol            = "Tcp"
    port                = 443
}

resource "azurerm_lb_rule" "port443" {
    name                    = "tf-lb-rule-443"
    loadbalancer_id         = azurerm_lb.frontend_lb.id
    backend_address_pool_ids = [azurerm_lb_backend_address_pool.frontend_lb_backend_pool.id]
    probe_id                = azurerm_lb_probe.frontend_lb_probe_port443.id
    protocol                       = "Tcp"
    frontend_port                  = 443
    backend_port                   = 443
    frontend_ip_configuration_name = "default"
}

