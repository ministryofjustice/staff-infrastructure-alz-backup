vault_resource_group_name = "rg-smss-core-001"
vault_name                = "rsv-smss-core-001"

# Workload vm to backup
vms = {
  vm-dogs-app01 = {
    resource_group = "rg-smss-dogs-001"
    backup_policy  = "daily-backup-policy-1"
  }
  vm-dogs-sql01 = {
    resource_group = "rg-smss-dogs-001"
    backup_policy  = "daily-backup-policy-1"
  }
}
