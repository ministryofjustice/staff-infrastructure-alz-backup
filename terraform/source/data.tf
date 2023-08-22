data "azurerm_resource_group" "vault" {
  name = var.vault_resource_group_name
}

data "azurerm_recovery_services_vault" "existing" {
  name                = var.vault_name
  resource_group_name = data.azurerm_resource_group.vault.name
}

data "azurerm_virtual_machine" "vm" {
  for_each = var.vms

  name                = each.key
  resource_group_name = each.value.resource_group
}

# Retrieve data from core ALZ state 

data "terraform_remote_state" "alz_core_hub" {
  backend = "azurerm"
  config = {
    storage_account_name = var.remote_state_hub_sa_name
    resource_group_name  = var.remote_state_hub_rg_name
    container_name       = var.remote_state_hub_container
    key                  = var.remote_state_hub_file
  }
}

data "azurerm_client_config" "current" {}