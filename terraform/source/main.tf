
resource "azurerm_backup_policy_vm" "policy" {
  for_each = { for bp in var.backup_policies : bp.name => bp }

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.vault.name
  recovery_vault_name = data.azurerm_recovery_services_vault.existing.name
  policy_type         = each.value.policy_type

  backup {
    frequency     = each.value.backup.frequency
    time          = each.value.backup.time
    hour_interval = lookup(each.value.backup, "hour_interval", null)
    hour_duration = lookup(each.value.backup, "hour_duration", null)
  }

  dynamic "retention_daily" {
    for_each = lookup(each.value, "retention_daily", null) != null ? [each.value.retention_daily] : []
    content {
      count = retention_daily.value.count
    }
  }

  dynamic "retention_weekly" {
    for_each = lookup(each.value, "retention_weekly", null) != null ? [each.value.retention_weekly] : []
    content {
      weekdays = retention_weekly.value.weekdays
      count    = retention_weekly.value.count
    }
  }

  dynamic "retention_monthly" {
    for_each = lookup(each.value, "retention_monthly", null) != null ? [each.value.retention_monthly] : []
    content {
      count = retention_monthly.value.count
    }
  }

  dynamic "retention_yearly" {
    for_each = lookup(each.value, "retention_yearly", null) != null ? [each.value.retention_yearly] : []
    content {
      months = retention_yearly.value.months
      weeks  = retention_yearly.value.weeks
      count  = retention_yearly.value.count
    }
  }
}

resource "azurerm_backup_protected_vm" "vm" {
  for_each = var.vms

  resource_group_name = data.azurerm_virtual_machine.vm[each.key].resource_group_name
  recovery_vault_name = data.azurerm_recovery_services_vault.existing.name
  source_vm_id        = data.azurerm_virtual_machine.vm[each.key].id
  backup_policy_id    = azurerm_backup_policy_vm.policy[each.value.backup_policy].id
}
