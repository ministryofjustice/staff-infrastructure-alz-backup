backup_policies = [
  {
    name        = "Hourly_backup_policy_1"
    policy_type = "V2"
    backup = {
      frequency     = "Hourly"
      time          = "23:30"
      hour_interval = "4"
      hour_duration = "12"
    }
    retention_daily = {
      count = 7
    }
  },
  {
    name        = "Daily_backup_policy_1"
    policy_type = "V2"
    backup = {
      frequency     = "Daily"
      time          = "23:00"
    }
    retention_daily = {
      count = 14
    }
  }
]