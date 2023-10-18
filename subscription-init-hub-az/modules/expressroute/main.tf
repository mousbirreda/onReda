####### Express Route ######

resource "azurerm_express_route_circuit" "this" {
  name                  = "ER_${var.name}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  service_provider_name = "Equinix"
  peering_location      = var.peering_location
  bandwidth_in_mbps     = var.bandwidth_in_mbps

  sku {
    tier   = var.az_exproute_sku.tier
    family = var.az_exproute_sku.family
  }
}

resource "azurerm_express_route_circuit_peering" "this" {
  express_route_circuit_name = azurerm_express_route_circuit.this.name
  resource_group_name        = var.resource_group_name

  peering_type                  = "MicrosoftPeering"
  peer_asn                      = var.az_exproute_peering_customer_asn
  primary_peer_address_prefix   = var.az_exproute_peering_primary_address
  secondary_peer_address_prefix = var.az_exproute_peering_secondary_address
  vlan_id                       = var.az_exproute_peering_vlan_id
  shared_key                    = var.az_exproute_peering_shared_key

  dynamic "microsoft_peering_config" {
    for_each = var.az_exproute_peering_type == "MICROSOFT" ? [1] : []
    content {
      advertised_public_prefixes = var.az_exproute_peering_msft_advertised_public_prefixes
      customer_asn               = var.az_exproute_peering_msft_customer_asn
      routing_registry_name      = var.az_exproute_peering_msft_routing_registry_name
    }
  }
}



resource "azurerm_public_ip" "pip_er" {
  name                = "PIP_${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  # mode allocation a spécifier entre Static ou Dynamique
  allocation_method = "Dynamic"
  # SKU IP a specifier
  sku = "Basic"
  # ddos_protection_mode ?
}

resource "azurerm_subnet" "gw_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.cidr_er_gw]
}


resource "azurerm_virtual_network_gateway" "er_gw" {
  # name a spécifier !
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  type                     = "ExpressRoute"
  vpn_type                 = "RouteBased"
  sku                      = "Basic" # SKU à spécifer !
  active_active            = false
  enable_bgp               = false         # BGP ( confirmer par Machy)
  generation               = "Generation1" # Generation1 pour des raisons de coûts (Yves)
  express_route_circuit_id = azurerm_express_route_circuit.this.id

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip_er.id
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

resource "azurerm_virtual_network_gateway_connection" "connection-hub-hub4oney" {
  name                            = "CONN_${var.name}"
  resource_group_name             = var.resource_group_name
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

