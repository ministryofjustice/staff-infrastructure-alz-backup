vault_resource_group_name = "rg-hub-core-001"
vault_name                = "rsv-hub-core-001"
vms = {
  vm1 = {
    resource_group = "rg-hub-poltest-01"
    backup_policy  = "daily_backup_policy_1"
  }
  vm2 = {
    resource_group = "rg-hub-poltest-01"
    backup_policy  = "weekly_backup_policy_1"
  }
}

