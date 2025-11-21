variable "rgs" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "stg" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
  }))
}

variable "infra_containers" {
  type = map(object({
    name                 = string
    storage_account_name = string
    container_access_type = string
  }))
}

variable "vnet" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}

variable "nics" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    ip_configuration = object({
      name                          = string
      subnet_id                     = string
      private_ip_address_allocation = string
    })
  }))
}

variable "infra_pips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
  }))
  
}
# variable "nsgs" {
#   type = map(object({
#     name                = string
#     location            = string
#     resource_group_name = string
#   }))
# }

variable "vms" {
  type = map(object({
    name               = string
    location           = string
    resource_group_name = string
    nic_id             = string
    size               = string
    admin_username     = string
    admin_password     = string
  }))
}
# variable "os_disks" {
#   type = map(object({
#     caching              = string
#     storage_account_type = string
#   }))
  
# }


variable "infra_key_vaults" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    enabled_for_disk_encryption = optional(bool, false)
    sku_name            = string
    tenant_id           = string
    soft_delete_retention_days  = optional(number, 7)
    purge_protection_enabled    = optional(bool, false)
    access_policies = list(object({
      tenant_id           = string
      object_id           = string
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    }))
  }))
  }