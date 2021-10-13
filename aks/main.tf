# Container Registry


terraform {
  backend "azurerm" {
    resource_group_name  = "aks-startup-d-rg-aks-infrastructure-shared"
    storage_account_name = "aksstartupstorage"
    container_name       = "terraform"
    key                  = "aks-startup-tf-aks"
    subscription_id      = "${var.ARM_SUBSCRIPTION_ID}" // Dette fungerte ikke
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
  name     = "aks-startup-d-rg-aks-infrastructure"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-startup"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  dns_prefix          = "aks-startup"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}