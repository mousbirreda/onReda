resource "random_id" "randomId" {
  keepers = {
    resource_group = var.vnet_resourcegroup_name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "fgtstorageaccount" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = var.vnet_resourcegroup_name
  location                 = var.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    environment = "Terraform HA AP SDN FortiGates - Crosszone 3 Ports"
  }
}
