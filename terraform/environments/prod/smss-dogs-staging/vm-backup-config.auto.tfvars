vault_resource_group_name = "rg-smss-core-001"
vault_name                = "rsv-smss-core-001"

# Workload vm to backup
vms = {
  vm-dogs-app01st = {
    resource_group = "rg-smss-dogs-staging-001"
    backup_policy  = "daily-backup-policy-dogs-staging"
  }
  vm-dogs-sql01st = {
    resource_group = "rg-smss-dogs-staging-001"
    backup_policy  = "daily-backup-policy-dogs-staging"
  }
}
