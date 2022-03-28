resource "azurerm_storage_account" "storage_account" {
  name                     = "gopalstatestorage"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version = "TLS1_2"
  enable_https_traffic_only = true 

  tags = {
    environment = "storageaccount"
  }
}
resource "azurerm_storage_container" "container" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}