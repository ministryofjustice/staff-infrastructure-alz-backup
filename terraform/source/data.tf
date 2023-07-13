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

