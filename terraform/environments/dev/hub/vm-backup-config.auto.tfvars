vault_resource_group_name = "vault-resource-group"
vault_name = "my-recovery-vault"
vms = {
  vm1 = {
    resource_group = "rg-hub-poltest-01"
    backup_policy = "Hourly_backup_policy_1"
  }
  vm2 = {
    resource_group = "rg-hub-poltest-01"
    backup_policy = "Daily_backup_policy_1"
  }
}

