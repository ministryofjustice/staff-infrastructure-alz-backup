resource "azurerm_monitor_metric_alert" "backup_jobs_failed_alert" {
  name                = "BackupJobsFailed"
  resource_group_name = var.vault_resource_group_name
  scopes              = [data.azurerm_recovery_services_vault.existing.id] # ID of Recovery Services Vault

  criteria {
    metric_namespace = "Microsoft.RecoveryServices/vaults"
    metric_name      = "BackupJobsFailed"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0
  }

  action {
    action_group_id = azurerm_monitor_action_group.alz_mon.id
  }

  frequency = "PT1H" # Evaluate the conditions every 1 Hour

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags that happen outside of Terraform 
      # to avoid clashing with the Azure policy that already sets them elsewhere
      tags,
    ]
  }
}

resource "azurerm_monitor_metric_alert" "backup_jobs_completed_alert" {
  name                = "BackupJobsCompletedAlert"
  resource_group_name = var.vault_resource_group_name
  scopes              = [data.azurerm_recovery_services_vault.existing.id] # ID of Recovery Services Vault # ID of Recovery Services Vault

  criteria {
    metric_namespace = "Microsoft.RecoveryServices/vaults"
    metric_name      = "BackupJobsCompleted"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.alz_mon.id
  }

  frequency = "PT1H" # Evaluate the conditions every 1 Hour

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags that happen outside of Terraform 
      # to avoid clashing with the Azure policy that already sets them elsewhere
      tags,
    ]
  }
}