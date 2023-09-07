backup_policies = [
  {
    name        = "Policy-4-month-retention"
    policy_type = "V2"
    backup = {
      frequency     = "Daily"
      time          = "23:00"
    }
    retention_daily = {
      count = 14
    }
    retention_weekly = {
      weekdays = ["Sunday"]
      count    = 12
    }
    retention_monthly = {
      weekdays = ["Sunday"]
      weeks    = [1]
      count    = 12
    }
  }
]
# In this example:

# The backup is taken daily at 11:00 PM.
# Daily backups are retained for 14 days.
# Weekly backups (taken every Sunday) are retained for 3 weeks.
# Monthly backups are retained for 4 months.