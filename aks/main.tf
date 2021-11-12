# Setting up AKS and Container registry

variable "AKS_STARTUP_ACR_NAME" {
  type    = string
  default = "aksstartup"
}

data "azurerm_resource_group" "main" {
  name     = "aks-startup-rg"
  provider = azurerm.dev
}

resource "azurerm_container_registry" "main" {
  name                = var.AKS_STARTUP_ACR_NAME
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "Standard"
  admin_enabled       = true
  provider            = azurerm.dev
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
  
  provider = azurerm.dev
}
