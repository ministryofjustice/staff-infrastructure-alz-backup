backup_workload_policies = [
  {
    name                = "dogssqlbackup01"
    resource_group_name = "rg-smss-core-001"
    recovery_vault_name = "rsv-smss-core-001"
    workload_type       = "SQLDataBase"
    settings = {
      time_zone           = "UTC"
      compression_enabled = false
    }
    protection_policies = [
      {
        policy_type = "Full"
        backup = {
          frequency            = "Daily"
          time                 = "21:00"
          frequency_in_minutes = null
        }
        retention_daily = {
          count = 8
        }
        simple_retention = {
          count = null
        }
      },
      {
        policy_type = "Log"
        backup = {
          frequency            = null
          time                 = null
          frequency_in_minutes = 15
        }
        retention_daily = {
          count = null
        }
        simple_retention = {
          count = 8
        }
      }
    ]
  }
]