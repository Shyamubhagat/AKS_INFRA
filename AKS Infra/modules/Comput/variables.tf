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


variable "subnet_id" {
  type = string
}