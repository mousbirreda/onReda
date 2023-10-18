
variable "name" {
  description = "Name of the vpn gateway, and prefix for subresources"
  type        = string
}

variable "resourcegroup_name" {
  description = "Nom du resource group (rg)"
  type        = string
}

variable "vnet_name" {
  description = "Nom du virtual network (vnet)"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "westeurope"
}

variable "cidr_vpn_gw" {
  description = "Range CIDR pour le subnet de la VPN gateway"
  type        = string
}

variable "vpn_gw_sku" {
  description = "Range CIDR pour le subnet de la VPN gateway"
  type        = string
  default     = "VpnGw2"
  # ["VpnGw1", "VpnGw2", "VpnGw3", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ"]
}




/*
# Variables to be tuned for vpn gw connection
variable "peer_virtual_network_gateway_id" {
   description = "ID of the peer virtual_network_gateway"
   type = string
}

variable "gateway_connection_protocol" {
   description = "Protocol for gateway connection"
   type = string
}

# Variable to be tuned for ipsec vpn gw connection
variable "local_networks_ipsec_policy" {
   description = "ipsec policy parameters"
   type = object (
    dh_group = string
    ike_encryption = string
    ike_integrity = string
    ipsec_encryption = string
    ipsec_integrity = string
    pfs_group = string
    sa_datasize = string
    sa_lifetime = string
  )
  default = null
}
*/
