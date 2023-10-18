####### Keyvault #######

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  soft_delete_retention_days      = var.soft_delete_retention_days
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.enable_purge_protection
}


resource "azurerm_private_endpoint" "pep" {
  name                = "PEP_${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "PRIVATE_LINK_${var.name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
  }
}

data "azurerm_private_endpoint_connection" "private-ip" {
  name                = azurerm_private_endpoint.pep.name
  resource_group_name = var.resource_group_name
  depends_on          = [azurerm_key_vault.kv]
}

#resource "azurerm_private_dns_zone" "zone" {
#  name                = "privatelink.vaultcore.azure.net"
#  resource_group_name = var.resource_group_name
#}

#resource "azurerm_private_dns_zone_virtual_network_link" "vent-link1" {
#  name                  = "DNS_ZONE_LINK_${var.name}"
#  resource_group_name   = var.resource_group_name
#  private_dns_zone_name = azurerm_private_dns_zone.zone.0.name
#  virtual_network_id    = var.vnet_name
#  registration_enabled  = true
#}

#resource "azurerm_private_dns_a_record" "arecord1" {
#  name                = azurerm_key_vault.kv.name
#  zone_name           = azurerm_private_dns_zone.zone.0.name
#  resource_group_name = var.resource_group_name
#  ttl                 = 300
#  records             = [data.azurerm_private_endpoint_connection.private-ip.0.private_service_connection.0.private_ip_address]
#}

