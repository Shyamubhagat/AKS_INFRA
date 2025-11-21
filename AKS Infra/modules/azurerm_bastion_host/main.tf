resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "config"
    subnet_id            = var.subnet_ids[each.key]
    public_ip_address_id = var.pip_ids[each.key]
  }
}
