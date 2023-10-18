####### VPN Gateway #######
resource "azurerm_public_ip" "pip_gw" {
  name                = "PIP_${var.name}"
  resource_group_name = var.resourcegroup_name
  location            = var.location
  # mode allocation a spécifier entre Static ou Dynamique
  allocation_method = "Dynamic"
  # SKU IP a specifier
  sku = "Basic"
  # ddos_protection_mode ?
}

resource "azurerm_subnet" "gw_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.cidr_vpn_gw]
}


resource "azurerm_virtual_network_gateway" "vpn_gw" {
  # name a spécifier !
  name                = var.name
  resource_group_name = var.resourcegroup_name
  location            = var.location
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = var.vpn_gw_sku # ["VpnGw1", "VpnGw2", "VpnGw3", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ"]
  active_active       = false
  enable_bgp          = false         # BGP a specifier
  generation          = "Generation1" # Generation1 choisie pour le coût (Yves)

  #bgp_settings {
  #     asn             = var.bgp_asn_number
  #     peering_address = var.bgp_peering_address
  #     peer_weight     = var.bgp_peer_weight
  # }

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip_gw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gw_subnet.id
  }

  #vpn_client_configuration {
  #     address_space = [var.client_address_cidr]
  #     root_certificate {
  #       name             = "point-to-site-root-certifciate"
  #       public_cert_data = vpn.value.certificate
  #     }
  #     vpn_client_protocols = vpn.value.vpn_client_protocols
  # }
}

/*
resource "azurerm_virtual_network_gateway_connection" "connection-hub-hub4oney" {
  name                            = "CONN_${var.name}"
  resource_group_name             = var.resourcegroup_name
  location                        = var.location
  type                            = "IPSec" # "Vnet2Vnet" ??
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpn_gw.id
  peer_virtual_network_gateway_id = var.peer_virtual_network_gateway_id
  connection_protocol             = var.gateway_connection_protocol

  ipsec_policy {
    dh_group         = var.local_networks_ipsec_policy.dh_group
    ike_encryption   = var.local_networks_ipsec_policy.ike_encryption
    ike_integrity    = var.local_networks_ipsec_policy.ike_integrity
    ipsec_encryption = var.local_networks_ipsec_policy.ipsec_encryption
    ipsec_integrity  = var.local_networks_ipsec_policy.ipsec_integrity
    pfs_group        = var.local_networks_ipsec_policy.pfs_group
    sa_datasize      = var.local_networks_ipsec_policy.sa_datasize
    sa_lifetime      = var.local_networks_ipsec_policy.sa_lifetime
  }
}
*/

