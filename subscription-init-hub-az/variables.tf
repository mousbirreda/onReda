
variable "vnet_resourcegroup_name" {
  description = "Nom du resource group (rg)"
  type        = string
}

variable "vnet_name" {
  description = "Nom du virtual network (vnet)"
  type        = string
}

variable "location" {
  description = "Region Azure"
  type        = string
  default     = "westeurope"
}

variable "vpn_gw_sku" {
  description = "sku type ( VpnGw2 VpnGw3 VpnGw4 VpnGw5 VpnGw2AZ VpnGw3AZ VpnGw4AZ VpnGw5AZ )"
  type        = string
  default     = "VpnGw2"
}

variable "cidr_front" {
  description = "Range CIDR pour le subnet front"
  type        = string
  validation {
    condition     = strcontains(var.cidr_front, "/")
    error_message = "The rang cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "cidr_vpn_gw" {
  description = "Range CIDR pour le subnet de la VPN gateway"
  type        = string
  validation {
    condition     = strcontains(var.cidr_vpn_gw, "/")
    error_message = "The rang cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "cidr_fortinet_external" {
  description = "Range CIDR pour le subnet Fortinet External"
  type        = string
  validation {
    condition     = strcontains(var.cidr_fortinet_external, "/")
    error_message = "The rang cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "cidr_fortinet_ha" {
  description = "Range CIDR pour le subnet Fortinet HA"
  type        = string
  validation {
    condition     = strcontains(var.cidr_fortinet_ha, "/")
    error_message = "The rang cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "cidr_fortinet_mngt" {
  description = "Range CIDR pour le subnet Fortinet Management"
  type        = string
  validation {
    condition     = strcontains(var.cidr_fortinet_mngt, "/")
    error_message = "The rang cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "cidr_fortinet_internal" {
  description = "Range CIDR pour le subnet Fortinet Internal"
  type        = string
  validation {
    condition     = strcontains(var.cidr_fortinet_internal, "/")
    error_message = "The rang cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

