terraform {
  required_version = "=1.9.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.36.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias           = "spoke"
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}