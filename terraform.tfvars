rgs = {
  rg1 = {
    name     = "rg-example1"
    location = "Central India"
  }
  rg2 = {
    name     = "rg-example2"
    location = "Central India"
  }
}
vnets = {
  vnet1 = {
    name          = "vnet-example1"
    address_space = ["10.0.0.0/16"]
    location      = "Central India"
    rg            = "rg1"
  }
  vnet2 = {
    name          = "vnet-example2"
    address_space = ["10.1.0.0/16"]
    location      = "Central India"
    rg            = "rg2"
  }
}

subnets = {
  dev = {
    name          = "dev"
    rg            = "dev-rg"
    vnet          = "dev"
    address_space = ["10.0.0.0/16"]
  }

  prod = {
    name          = "prod"
    rg            = "prod-rg"
    vnet          = "prod"
    address_space = ["10.1.0.0/16"]
  }
}

nics = {
  dev = {
    name     = "dev"
    location = "Central India"
    rg       = "dev-rg"
    subnet   = "dev"
  }

  prod = {
    name     = "prod"
    location = "Central India"
    rg       = "prod-rg"
    subnet   = "prod"
  }
}