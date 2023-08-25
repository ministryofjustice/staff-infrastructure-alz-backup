custom_query_rules = {
  "backup-failed-errors" = {
    description    = "Alert if any backups have failed in last 24 hours"
    resource_group = "rg-hub-core-001"
    location       = "uksouth"
    enabled        = true
    scope          = "/subscriptions/c5551d23-f465-4e90-9f4d-ef19eecff6a0/resourceGroups/rg-hub-core-001/providers/Microsoft.OperationalInsights/workspaces/log-hub-core-001" # Hub Log Analytics workspace
    severity       = 2
    action_group   = "alz"
    kql            = <<-QUERY
      AddonAzureBackupJobs
        | where JobOperation=="Backup"
        | summarize arg_max(TimeGenerated,*) by JobUniqueId
        | where JobStatus=="Failed"
    QUERY
    criteria = {
      aggregation             = "Count"
      aggregation_granularity = "PT1H" # Aggregate values into 60 minutes (1 hour) buckets
      operator                = "GreaterThan"
      threshold               = 5
      measure_column          = null   # not usually needed for "Count" aggregation
      eval_frequency          = "PT1H" # Run every 60 mins (1 hour)
    }
  },
  "no-backups-completed" = {
    description    = "Alert if no backups have been completed in last 24 hours"
    resource_group = "rg-hub-core-001"
    location       = "uksouth"
    enabled        = true
    scope          = "/subscriptions/c5551d23-f465-4e90-9f4d-ef19eecff6a0/resourceGroups/rg-hub-core-001/providers/Microsoft.OperationalInsights/workspaces/log-hub-core-001"
    severity       = 2
    action_group   = "alz"
    kql            = <<-QUERY
    AddonAzureBackupJobs
    | where TimeGenerated > ago(24h) and JobOperation == "Backup"
    | summarize max(TimeGenerated) by JobUniqueId
    | where JobStatus == "Completed"
    | count 
    | where tostring(0)
  QUERY
    criteria = {
      aggregation             = "Count"
      aggregation_granularity = "PT24H"
      operator                = "Equals"
      threshold               = 0
      measure_column          = null
      eval_frequency          = "PT24H"
    }
  }
}
