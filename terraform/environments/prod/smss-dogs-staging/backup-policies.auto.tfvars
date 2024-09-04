backup_policies = [
  {
    name        = "daily-backup-policy-dogs-staging"
    policy_type = "V2"
    backup = {
      frequency = "Daily"
      time      = "20:00"
    }
    retention_daily = {
      count = 14
    }
  }
]
