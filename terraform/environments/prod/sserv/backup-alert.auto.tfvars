custom_query_rules = {
  "backup-failed-errors" = {
    description    = "Alert if any backups have failed in last 24 hours"
    resource_group = "rg-shared-core-001"
    location       = "uksouth"
    enabled        = true
    scope          = "/subscriptions/295f66cf-5554-4bfe-b3f7-3db13f27e4ca/resourceGroups/rg-shared-core-001/providers/Microsoft.OperationalInsights/workspaces/log-shared-core-003" # Hub Log Analytics workspace
    severity       = 2
    action_group   = "alz"
    kql            = <<-QUERY
      AddonAzureBackupJobs
        | where TimeGenerated > ago(24h) and JobOperation == "Backup" and JobStatus == "Failed"
        | project JobUniqueId
    QUERY
    criteria = {
      aggregation             = "Count"
      aggregation_granularity = "P1D" # Aggregate values into 24 hours (1 day) buckets
      operator                = "GreaterThan"
      threshold               = 0     # Alert when even a single failed backup is detected
      measure_column          = null  # not usually needed for "Count" aggregation
      eval_frequency          = "P1D" # Run every 24 hours (1 day)
    }
  },
  "no-backups-completed" = {
    description    = "Alert if no backups have been completed in last 24 hours"
    resource_group = "rg-shared-core-001"
    location       = "uksouth"
    enabled        = true
    scope          = "/subscriptions/295f66cf-5554-4bfe-b3f7-3db13f27e4ca/resourceGroups/rg-shared-core-001/providers/Microsoft.OperationalInsights/workspaces/log-shared-core-003"
    severity       = 2
    action_group   = "alz"
    kql            = <<-QUERY
      AddonAzureBackupJobs
        | where TimeGenerated > ago(24h) and JobOperation == "Backup" and JobStatus == "Completed"
        | project JobUniqueId
    QUERY
    criteria = {
      aggregation             = "Count"
      aggregation_granularity = "P1D"
      operator                = "Equal"
      threshold               = 0
      measure_column          = null
      eval_frequency          = "P1D"
    }
  }
}
