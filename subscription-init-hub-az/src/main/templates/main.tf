####### Fortinet #######

data "azurerm_client_config" "current" {}

# access keyvault pour admin user/password

/* Commented because not fully seized

module "hub_vpn_gw" {
  source          = "./modules/ha-port1-mgmt-crosszone-3ports"
  subscription_id = data.azurerm_client_config.current.subscription_id
  client_id       = data.azurerm_client_config.current.client_id
  #client_secret = data.azurerm_client_config.current.XXXX
  tenant_id = data.azurerm_client_config.current.tenant_id

  location           = var.location
  resourcegroup_name = var.vnet_resourcegroup_name
  vnet_name          = var.vnet_name

  license_type = "payg"
  #adminusernamed = module.keyvault....
  #adminpassword  = module.keyvault....

  publiccidr  = "10.178.2.0/26"
  privatecidr = "10.178.2.192/26"
  hasynccidr  = "10.178.2.64/26"
  hamgmtcidr  = "10.178.2.128/26"

  activeport1     = "10.178.2.67"
  activeport1mask = "255.255.255.192"
  activeport2     = "10.178.2.68"
  activeport2mask = "255.255.255.192"
  activeport3     = "10.178.2.131"
  activeport3mask = "255.255.255.192"
  activeport4     = "10.178.2.132"
  activeport4mask = "255.255.255.192"

  passiveport1     = "10.178.2.69"
  passiveport1mask = "255.255.255.192"
  passiveport2     = "10.178.2.70"
  passiveport2mask = "255.255.255.192"
  passiveport3     = "10.178.2.133"
  passiveport3mask = "255.255.255.192"
  passiveport4     = "10.178.2.134"
  passiveport4mask = "255.255.255.192"
  port1gateway     = ""
  port2gateway     = ""

  #bootstrap-active = ""
  #bootstrap-passive = ""
}
*/

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
  name                = "KV_HUB_WE"
  location            = var.location
  resource_group_name = var.vnet_resourcegroup_name
  vnet_name           = var.vnet_name
  subnet_name         = ""
  sku                 = "standard"
}

