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