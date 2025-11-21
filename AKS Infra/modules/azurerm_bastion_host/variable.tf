variable "bastions" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "pip_ids" {
  type = map(string)
}
