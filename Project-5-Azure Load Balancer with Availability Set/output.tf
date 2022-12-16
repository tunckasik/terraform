output "frontend_id" {
  value = "${azurerm_subnet.frontend_subnet.id}"
}

output "backend_id" {
  value = "${azurerm_subnet.backend_subnet.id}"
}

output "load_balancer_ip" {
  value = "${azurerm_public_ip.frontend_lb_pip.ip_address}"
}