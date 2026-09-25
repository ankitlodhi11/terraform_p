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

variable "vmss" {

  type = map(object({

    name                 = string
    rg                   = string
    location             = string
    sku                  = string
    instances             = number
    admin_username       = string
    admin_password       = string
    computer_name_prefix = string
    vnet                 = string
    tags                 = map(string)

  }))
}

variable "nsgs" {
  type = map(object({

    name     = string
    rg       = string
    location = string

    rules = map(object({

      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string

    }))

  }))
}

