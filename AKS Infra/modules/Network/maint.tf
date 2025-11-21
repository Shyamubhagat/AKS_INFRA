resource "azurerm_virtual_network" "vnets" {
    for_each = var.networks
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    name = each.value.name
    address_space = each.value.address_space

    dynamic "subnet" {
        for_each = each.value.subnets
        content{
            name = subnet.value.name
            address_prefixes = subnet.value.address_prefixes
        }
      
    }
  
}

resource "azurerm_public_ip" "infra_pips" {
  for_each            = var.networks
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}


resource "azurerm_network_security_group" "nsgs" {
  for_each            = var.networks
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "nsg_rule_name"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "nicsassociation" {
  for_each = var.networks

  subnet_id                 = tolist(azurerm_virtual_network.vnets[each.key].subnet)[0].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}