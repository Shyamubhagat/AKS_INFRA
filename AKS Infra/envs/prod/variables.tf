variable "rgs" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}

variable "networks" {
  type = map(object({
    resource_group_name = string
    location            = string
    name                = string
    pip_name            = string
    address_space       = list(string)
    allocation_method   = string
    sku                 = string
    nsg_name            = string
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))

}
variable "key_vaults" {

}

variable "vms" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    nic_name            = string        # <-- ADD THIS
    nsg_name            = string        # <-- ADD THIS
    vm_name             = string        # <-- ADD THIS

    allocation_method   = string
    sku                 = string
    tags                = map(string)

    size                = string
    admin_username      = string
    admin_password      = string
    disable_password_authentication = bool

    publisher           = string
    offer               = string
    version             = string
  }))
}


variable "bastions" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}




