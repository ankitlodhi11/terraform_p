
resource "azurerm_resource_group" "rgs" {
   for_each = var.rgs
   
   name  = each.value.name
   location = each.value.location
}
 
resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets
  name                = each.value.name
   address_space       = each.value.address_space
   location            = each.value.location
   resource_group_name = azurerm_resource_group.rgs[each.value.rg].name
}

resource "azurerm_subnet" "subnet" {
  for_each = var.vnets
  name                 = "${each.value.name}-subnet"
  resource_group_name  = azurerm_resource_group.rgs[each.value.rg].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = [cidrsubnet(each.value.address_space[0], 8, 1)]
}
resource "azurerm_network_interface" "nic" {
   for_each = var.vnets
   name                = "${each.value.name}-nic"
   location            = each.value.location
   resource_group_name = azurerm_resource_group.rgs[each.value.rg].name
   
   ip_configuration {
      name                          = "internal"
      subnet_id                     = azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation = "Dynamic"
   }
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {

  for_each = var.vmss

  name                = each.value.name
  resource_group_name = azurerm_resource_group.rgs[each.value.rg].name
  location            = each.value.location

  sku      = each.value.sku
  instances = each.value.instances

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  disable_password_authentication = false

  computer_name_prefix = each.value.computer_name_prefix

  source_image_reference {

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {

    name    = "${each.value.name}-nic"
    primary = true

    ip_configuration {

      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet[each.value.vnet].id
    }
  }

  upgrade_mode = "Manual"

  tags = each.value.tags
}

resource "azurerm_network_security_group" "nsg" {

  for_each = var.nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rgs[each.value.rg].name

  dynamic "security_rule" {

    for_each = each.value.rules

    content {

      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol

      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range

      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {

  for_each = var.vnets

  subnet_id = azurerm_subnet.subnet[each.key].id

  network_security_group_id = azurerm_network_security_group.nsg[
    each.key == "vnet1" ? "nsg1" : "nsg2"
  ].id
}



