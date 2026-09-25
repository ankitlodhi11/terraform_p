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

vmss = {

  vmss1 = {

    name                 = "vmss-example1"
    rg                   = "rg1"
    location             = "Central India"

    sku                  = "Standard_B2s"
    instances             = 2

    admin_username       = "azureuser"
    admin_password       = "MyStrongPassword@12345"

    computer_name_prefix = "vmss1"

    vnet = "vnet1"

    tags = {

      Environment = "Dev"
      Project     = "Terraform"
    }
  }


  vmss2 = {

    name                 = "vmss-example2"
    rg                   = "rg2"
    location             = "Central India"

    sku                  = "Standard_B2s"
    instances             = 2

    admin_username       = "azureuser"
    admin_password       = "MyStrongPassword@12345"

    computer_name_prefix = "vmss2"

    vnet = "vnet2"

    tags = {

      Environment = "Prod"
      Project     = "Terraform"
    }
  }

}

nsgs = {

  nsg1 = {

    name     = "vnet-example1-nsg"
    rg       = "rg1"
    location = "Central India"

    rules = {

      ssh = {

        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

      http = {

        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

      https = {

        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }


  nsg2 = {

    name     = "vnet-example2-nsg"
    rg       = "rg2"
    location = "Central India"

    rules = {

      ssh = {

        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

      http = {

        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

      https = {

        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

