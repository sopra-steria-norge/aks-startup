# Azure Key Vault


terraform {
  backend "azurerm" {
    resource_group_name  = "aks-startup-d-rg-aks-infrastructure-shared"
    storage_account_name = "aksstartupstorage"
    container_name       = "terraform"
    key                  = "aks-startup-tf-aks-keyvault"
    subscription_id      = "${var.ARM_SUBSCRIPTION_ID}"
  }
}

provider "azurerm" {
  features {
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "main" {}

data "azurerm_resource_group" "main" {
  name = "aks-startup-d-rg-aks-infrastructure"
}

resource "azurerm_key_vault" "main" {
  name                        = "aks-startupkeyvault"
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.main.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.main.tenant_id
    object_id = data.azurerm_client_config.main.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
