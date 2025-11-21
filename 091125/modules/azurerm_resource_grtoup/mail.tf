resource "azurerm_resource_group" "rgs" {
    for_each = var.rgs
    name     = each.value.rg_name
    location = each.value.location
    tags = {
        environment = each.value.environment
        managed_by  = each.value.managed_by
        owner       = each.value.owner
    }
}