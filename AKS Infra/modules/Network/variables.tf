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

