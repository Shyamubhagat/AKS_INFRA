variable "name" {
  type    = string
  default = "rg1"
}

variable "location" {
  type    = string
  default = "centralindia"
}

variable "tags" {
  type = map(string)
  default = {
    "managed by" = "terraform"
  }
}