output "virtual_network_ids" {
  value       = {
    for k, v in azurerm_virtual_network.vnets : k => v.id
  }
}

# output "public_ip_addresses" {
#   value       = {
#     for k, v in azurerm_public_ip.infra_pips : k => v.ip_address
#   }
# }

output "network_security_group_ids" {
  value       = {
    for k, v in azurerm_network_security_group.nsgs : k => v.id
  }
}

output "subnet_ids" {
  value = {
    for k, v in azurerm_virtual_network.vnets :
    k => tolist(v.subnet)[0].id
  }
}

output "bastion_subnet_ids" {
  value = {
    for k, v in azurerm_virtual_network.vnets :
    k => [
      for s in v.subnet : s.id if s.name == "bastion_subnet"
    ][0]
  }
}

output "public_ip_ids" {
  value = {
    for k, v in azurerm_public_ip.infra_pips :
    k => v.id
  }
}