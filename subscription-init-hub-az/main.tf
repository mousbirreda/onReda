
####### Datasources #######
data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "vnet_sub" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resourcegroup_name
}



#######  Subnet Front #######
resource "azurerm_subnet" "NET_PRD_FRONT_HUB_WE" {
  name                 = "NET_PRD_FRONT_HUB_WE"
  resource_group_name  = var.vnet_resourcegroup_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.cidr_front]
}



####### Fortinet #######
# access keyvault pour admin user/password
module "hub_fortinet" {
  source          = "./modules/ha-port1-mgmt-crosszone-3ports"
  subscription_id = data.azurerm_client_config.current.subscription_id
  client_id       = data.azurerm_client_config.current.client_id
  # A externaliser dans un keyvault !
  client_secret = "data.azurerm_client_config.current.client_secret"
  tenant_id     = data.azurerm_client_config.current.tenant_id

  location                = var.location
  vnet_resourcegroup_name = var.vnet_resourcegroup_name
  vnet_name               = var.vnet_name

  license_type = "payg"
  # A externaliser dans un keyvault !
  adminusername = "admin-forti"
  adminpassword = "DLMA-Oney2024$"

  vnetcidr    = data.azurerm_virtual_network.vnet_sub.address_space[0]
  publiccidr  = var.cidr_fortinet_external
  privatecidr = var.cidr_fortinet_internal
  hasynccidr  = var.cidr_fortinet_ha
  hamgmtcidr  = var.cidr_fortinet_mngt
}


####### VPN Gateway #######
module "hub_vpn_gw" {
  source             = "./modules/vpn-gw"
  name               = "VPN_GW_HUB_WE"
  resourcegroup_name = var.vnet_resourcegroup_name
  vnet_name          = var.vnet_name
  location           = var.location
  cidr_vpn_gw        = var.cidr_vpn_gw
  vpn_gw_sku         = var.vpn_gw_sku
}

####### Keyvault HUB #######
module "hub_keyvault" {
  source              = "./modules/keyvault"
  name                = "KV-PRD-HUB-WE"
  location            = var.location
  resource_group_name = var.vnet_resourcegroup_name
  vnet_name           = var.vnet_name
  subnet_id           = azurerm_subnet.NET_PRD_FRONT_HUB_WE.id
  sku                 = "standard"
}


