# App Services DEV

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "aks-startup-d-rg-aks-infrastructure-shared"
  location = "Norway East"
  tags = {
    aks-startup = "aks-startup"
  }  
}

resource "azurerm_storage_account" "main" {
  name                     = "aksstartupstorage" // Denne må være global unik i hele Azure
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "development"
    aks-startup = "aks-startup"
  }
}

resource "azurerm_storage_container" "main" {
  name                  = "terraform"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}
