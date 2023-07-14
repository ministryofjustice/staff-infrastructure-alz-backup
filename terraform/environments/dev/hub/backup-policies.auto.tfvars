backup_policies = [
  {
    name        = "daily_backup_policy_1"
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
    name        = "weekly_backup_policy_1"
    policy_type = "V2"
    backup = {
      frequency = "Weekly"
      time      = "23:00"
    }
    retention_weekly = {
      weekdays = ["Monday"]
      count    = 4
    }
  },
  {
    name        = "yearly_backup_policy_1"
    policy_type = "V2"
    backup = {
      frequency = "Yearly"
      time      = "23:00"
    }
    retention_yearly = {
      months            = ["January", "July"]
      weeks             = ["First", "Third"]
      count             = 5
    }
  }
]