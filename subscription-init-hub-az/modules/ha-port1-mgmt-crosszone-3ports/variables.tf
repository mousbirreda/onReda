// Azure configuration
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "vnet_resourcegroup_name" {
  description = "Nom du resource group (rg)"
  type        = string
}

variable "vnet_name" {
  description = "Nom du virtual network (vnet)"
  type        = string
}

//  For HA, choose instance size that support 4 nics at least
//  Check : https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes
variable "size" {
  type    = string
  default = "Standard_F4"
}

// Availability zones only support in certain
// Check: https://docs.microsoft.com/en-us/azure/availability-zones/az-overview
variable "zone1" {
  type    = string
  default = "1"
}

variable "zone2" {
  type    = string
  default = "2"
}

variable "location" {
  type    = string
  default = "westeurope"
}

// To use custom image 
// by default is false
variable "custom" {
  default = false
}

//  Custom image blob uri
variable "customuri" {
  type    = string
  default = "<custom image blob uri>"
}

variable "custom_image_name" {
  type    = string
  default = "<custom image name>"
}

variable "custom_image_resource_group_name" {
  type    = string
  default = "<custom image resource group>"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default = "payg"
}

// enable accelerate network, either true or false, default is false
// Make the the instance choosed supports accelerated networking.
// Check: https://docs.microsoft.com/en-us/azure/virtual-network/accelerated-networking-overview#supported-vm-instances
variable "accelerate" {
  default = "true"
}

variable "publisher" {
  type    = string
  default = "fortinet"
}

variable "fgtoffer" {
  type    = string
  default = "fortinet_fortigate-vm_v5"
}

// BYOL sku: fortinet_fg-vm
// PAYG sku: fortinet_fg-vm_payg_2022
variable "fgtsku" {
  type = map(any)
  default = {
    byol = "fortinet_fg-vm"
    payg = "fortinet_fg-vm_payg_2023"
  }
}

// FOS version
variable "fgtversion" {
  type    = string
  default = "7.4.1"
}

variable "adminusername" {
  type    = string
  default = "azureadmin"
}

variable "adminpassword" {
  type    = string
  default = "Fortinet123#"
}

// HTTPS Port
variable "adminsport" {
  type    = string
  default = "8443"
}

variable "vnetcidr" {
  type = string
  validation {
    condition     = strcontains(var.vnetcidr, "/")
    error_message = "The range cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "publiccidr" {
  type = string
  validation {
    condition     = strcontains(var.publiccidr, "/")
    error_message = "The range cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "privatecidr" {
  type = string
  validation {
    condition     = strcontains(var.privatecidr, "/")
    error_message = "The range cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "hasynccidr" {
  type = string
  validation {
    condition     = strcontains(var.hasynccidr, "/")
    error_message = "The range cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}

variable "hamgmtcidr" {
  type = string
  validation {
    condition     = strcontains(var.hamgmtcidr, "/")
    error_message = "The range cidr should be [xxx.xxx.xxx.xxx/99]"
  }
}


// license file for the active fgt
variable "license" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.txt"
}

// license file for the passive fgt
variable "license2" {
  // Change to your own byol license file, license2.lic
  type    = string
  default = "license2.txt"
}

