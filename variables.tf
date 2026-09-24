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