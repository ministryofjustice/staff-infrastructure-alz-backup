vault_resource_group_name = "rg-ns-demo-TF"
vault_name                = "RSV-test-demo"

backup_policies = [
  {
    name        = "Policy-sqls-vm-backup"
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