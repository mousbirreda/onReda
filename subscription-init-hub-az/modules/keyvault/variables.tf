
variable "name" {
  description = "Name of the keyvault, and prefix for subresources (only 3-24 characters alphanumeric or dashes)"
  type        = string
}

variable "location" {
  description = "Region Azure"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Nom du resource group (rg)"
  type        = string
}

variable "vnet_name" {
  description = "Nom du virtual network (vnet)"
  type        = string
}

variable "subnet_id" {
  description = "ID du subnet"
  type        = string
}

variable "sku" {
  description = "Keyvault SKU"
  type        = string
  default     = "standard"
}

variable "enabled_for_deployment" {
  type    = bool
  default = false
}

variable "enabled_for_disk_encryption" {
  type    = bool
  default = false
}

variable "enabled_for_template_deployment" {
  type    = bool
  default = false
}

variable "soft_delete_retention_days" {
  type    = number
  default = 90
}

variable "enable_rbac_authorization" {
  type    = bool
  default = false
}

variable "enable_purge_protection" {
  type    = bool
  default = false
}

