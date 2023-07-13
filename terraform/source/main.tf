
resource "azurerm_backup_policy_vm" "policy" {
  for_each = { for bp in var.backup_policies : bp.name => bp }

  name                 = each.value.name
  resource_group_name  = data.azurerm_resource_group.vault.name
  recovery_vault_name  = data.azurerm_recovery_services_vault.existing.name
  policy_type          = each.value.policy_type

  backup {
    frequency     = each.value.backup.frequency
    time          = each.value.backup.time
    hour_interval = each.value.backup.hour_interval
    hour_duration = each.value.backup.hour_duration
  }

  retention_daily {
    count = each.value.retention_daily.count
  }
}

resource "azurerm_backup_protected_vm" "vm" {
  for_each = var.vms

  resource_group_name = each.value.resource_group
  recovery_vault_name = data.azurerm_recovery_services_vault.existing.name
  source_vm_id        = data.azurerm_virtual_machine.vm[each.key].id
  backup_policy_id    = azurerm_backup_policy_vm.policy[each.value.backup_policy].id
}
