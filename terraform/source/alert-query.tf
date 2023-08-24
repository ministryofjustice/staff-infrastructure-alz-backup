# BackupJobsFailed Alert
resource "azurerm_monitor_metric_alert" "backup_jobs_failed_alert" {
  count               = var.alert_backup_jobs_failed.enabled ? 1 : 0
  name                = "BackupJobsFailed"
  resource_group_name = var.vault_resource_group_name
  scopes              = [data.azurerm_recovery_services_vault.existing.id]


  criteria {
    metric_namespace = "Microsoft.RecoveryServices/vaults"
    metric_name      = "BackupJobsFailed"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.alert_backup_jobs_failed.threshold
  }
  action {
    action_group_id = azurerm_monitor_action_group.alz_mon[var.alert_backup_jobs_failed.action_group_name].id
  }

  frequency = var.alert_backup_jobs_failed.frequency

  window_size = "P1D"


  lifecycle {
    ignore_changes = [
      # Ignore changes to tags that happen outside of Terraform 
      # to avoid clashing with the Azure policy that already sets them elsewhere
      tags,
    ]
  }
}

# BackupJobsCompleted Alert
resource "azurerm_monitor_metric_alert" "backup_jobs_completed_alert" {
  count               = var.alert_backup_jobs_completed.enabled ? 1 : 0
  name                = "BackupJobsCompleted"
  resource_group_name = var.vault_resource_group_name
  scopes              = [data.azurerm_recovery_services_vault.existing.id]

  criteria {
    metric_namespace = "Microsoft.RecoveryServices/vaults"
    metric_name      = "BackupJobsCompleted"
    aggregation      = "Total"
    operator         = "Equals"
    threshold        = var.alert_backup_jobs_completed.threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.alz_mon[var.alert_backup_jobs_completed.action_group_name].id
  }

  frequency = var.alert_backup_jobs_completed.frequency

  window_size = "P1D"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# RestoreJobsFailed Alert
resource "azurerm_monitor_metric_alert" "restore_jobs_failed_alert" {
  count               = var.alert_restore_jobs_failed.enabled ? 1 : 0
  name                = "RestoreJobsFailed"
  resource_group_name = var.vault_resource_group_name
  scopes              = [data.azurerm_recovery_services_vault.existing.id]

  criteria {
    metric_namespace = "Microsoft.RecoveryServices/vaults"
    metric_name      = "RestoreJobsFailed"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.alert_restore_jobs_failed.threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.alz_mon[var.alert_restore_jobs_failed.action_group_name].id
  }

  frequency = var.alert_restore_jobs_failed.frequency

  window_size = "P1D"

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

