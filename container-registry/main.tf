# Container Registry

variable "AKS_STARTUP_ACR_NAME" {
  type = string
}


terraform {
  backend "azurerm" {
    resource_group_name  = "aks-startup-d-rg-aks-infrastructure-shared"
    storage_account_name = "aksstartupstorage"
    container_name       = "terraform"
    key                  = "aks-startup-tf-containerregistry"
    subscription_id      = "${var.ARM_SUBSCRIPTION_ID}"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "main" {
  name     = "aks-startup-d-rg-aks-infrastructure"
}

resource "azurerm_container_registry" "main" {
  name                = "${var.AKS_STARTUP_ACR_NAME}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "Standard"
  admin_enabled       = false
}