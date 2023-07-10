vault_resource_group_name = "rg-hub-core-001"
vault_name                = "rsv-hub-core-001"

backup_policies = [
  {
    name        = "Policy-12-month-retention"
    policy_type = "V2"
    backup = {
      frequency = "Daily"
      time      = "23:00"
    }
    retention_daily = {
      count = 14
    }
    retention_weekly = {
      count    = 12
      weekdays = ["Sunday"]
    }
    retention_monthly = {
      count    = 12
      weekdays = ["Sunday"]
      weeks    = ["First"]
    }
  }
]
# In this example:

# The backup is taken daily at 11:00 PM.
# Daily backups are retained for 14 days.
# Weekly backups (taken every Sunday) are retained for 3 weeks.
# Monthly backups are retained for 4 months.