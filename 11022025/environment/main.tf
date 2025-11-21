

resource "azurerm_resource_group" "rgs" {
  for_each = var.rgs
  name     = each.value.name
  location = each.value.location
}


resource "azurerm_storage_account" "stg" {
  for_each                 = var.stg
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  depends_on = [
    azurerm_resource_group.rgs
  ]
}

resource "azurerm_storage_container" "infra_containers" {
  for_each = var.infra_containers
  name     = each.value.name
  storage_account_id = lookup(
    { for k, v in azurerm_storage_account.stg : v.name => v.id },
    each.value.storage_account_name
  )
  container_access_type = each.value.container_access_type

  depends_on = [azurerm_storage_account.stg]
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
    }
  }
  depends_on = [
    azurerm_resource_group.rgs
  ]
}


resource "azurerm_network_interface" "nics" {
  for_each            = var.nics
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration.name
    subnet_id                     = each.value.ip_configuration.subnet_id
    private_ip_address_allocation = each.value.ip_configuration.private_ip_address_allocation
  }
  depends_on = [
    azurerm_resource_group.rgs,
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_public_ip" "infra_pips" {
  for_each            = var.infra_pips
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  depends_on = [
    azurerm_resource_group.rgs
  ]
}


# resource "azurerm_network_security_group" "nsgs" {
#   for_each            = var.nsgs
#   name                = each.value.name
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name

#   security_rule {
#     name                       = "test123"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#   depends_on = [
#     azurerm_resource_group.rgs
#   ]
# }

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.nics[each.value.nic_id].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
 
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "infra_key_vaults" {
  for_each = var.infra_key_vaults
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = each.value.sku_name

dynamic "access_policy" {
    for_each = each.value.access_policies
    content {
      tenant_id = access_policy.value.tenant_id
      object_id = access_policy.value.object_id

      key_permissions     = access_policy.value.key_permissions
      secret_permissions  = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }
}

