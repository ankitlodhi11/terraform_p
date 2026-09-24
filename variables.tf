variable "rgs" {
  description = "List of Resource Groups"

  type = map(object({
    name     = string
    location = string
   
  }))
  }
variable "vnets" {
  description = "List of Virtual Networks"

  type = map(object({
    name          = string
    address_space = list(string)
    location      = string
    rg            = string
  }))
}

variable "subnets" {
  description = "Subnet configuration"

  type = map(object({
    name          = string
    rg            = string
    vnet          = string
    address_space = list(string)
  }))
}

variable "nics" {
  description = "Network Interface configuration"

  type = map(object({
    name     = string
    location = string
    rg       = string
    subnet   = string
  }))
}