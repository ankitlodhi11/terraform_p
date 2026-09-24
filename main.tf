
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

