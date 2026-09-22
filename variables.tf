variable "rgs" {
  description = "List of Resource Groups"

  type = map(object({
    name     = string
    location = string
   
  }))
  }
