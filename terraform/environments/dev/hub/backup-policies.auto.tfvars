backup_policies = [
  {
    name        = "weekly-backup-policy-1"
    policy_type = "V2"
    backup = {
      frequency = "Daily"
      time      = "20:00"
    }
    retention_daily = {
      count = 14
    }
  },
  {
    name        = "weekly-backup-policy-1"
    policy_type = "V2"
    backup = {
      frequency = "Weekly"
      time      = "22:00"
    }
    retention_weekly = {
      weekdays = ["Sunday"]
      count    = 4
    }
  }
]