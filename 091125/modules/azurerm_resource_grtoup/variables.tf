variable "rgs" {
  type = map(object({
    rg_name     = string
    location    = string
    tags        = map(string)
    environment = string
    managed_by  = string
    owner       = string
  }))
}
