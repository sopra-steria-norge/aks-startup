terraform {
    backend "azurerm" {
        resource_group_name  = "aks-startup-rg"
        storage_account_name = "aksstartupsttfstate"
        container_name       = "terraformstate"
        key                  = "aks.tfstate"
    }
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "> 2.0.0"
        }
        azuread = {
            source  = "hashicorp/azuread"
            version = "> 2.0.0"
        }
    }
}
