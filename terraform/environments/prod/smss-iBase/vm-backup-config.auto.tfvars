vault_resource_group_name = "rg-smss-core-001"
vault_name                = "rsv-smss-core-001"
vms = {
  vm-ibase-win1 = {
    resource_group = "rg-smss-ibase-001"
    backup_policy  = "daily-backup-policy-1"
  }
  vm-ibase-sql1 = {
    resource_group = "rg-smss-ibase-001"
    backup_policy  = "daily-backup-policy-1"
  }
}

wk_vms = {
  vm-ibase-sql1 = {
    resource_group = "rg-smss-ibase-001"
    backup_policy  = "ibasesqlbackup01"
  }

}