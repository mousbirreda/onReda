
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

variable "cidr_er_gw" {
  description = "Range CIDR pour le subnet de la er gateway"
  type        = string
}

variable "peering_location" {
  description = "Peering Location (default : Paris)"
  type        = string
  default     = "Paris"
}

variable "bandwidth_in_mbps" {
  description = "Bandwidth in Mbps (Default : 50)"
  type        = number
  default     = 50
}


