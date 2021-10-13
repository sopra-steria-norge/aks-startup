# App Services DEV

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "aks-startup-rg"
  location = "Norway East"
  tags = {
    aks-startup = "aks-startup"
  }  
}

# resource "random_string" "random" {
#   length           = 4
#   special          = false
# }

resource "azurerm_storage_account" "main" {
  name                     = "aksstartupsttfstate" // Denne må være global unik i hele Azure
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "development"
    aks-startup = "aks-startup"
    id = "8595421a-26c9-5095-4367-38ed4100f210"
  }
}

resource "azurerm_storage_container" "main" {
  name                  = "terraformstate"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}
