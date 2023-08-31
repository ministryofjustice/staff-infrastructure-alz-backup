vault_resource_group_name = "rg-shared-core-001"
vault_name                = "rsv-shared-core-003"
vms = {
  AZMOJADS004 = {
    resource_group = "rg-shared-ad-001"
    backup_policy  = "daily-backup-policy-1"
  }
  AZMOJADS005 = {
    resource_group = "rg-shared-ad-001"
    backup_policy  = "daily-backup-policy-1"
  }
  AZMOJADS006 = {
    resource_group = "rg-shared-ad-001"
    backup_policy  = "daily-backup-policy-1"
  }
  AZMOJADS007 = {
    resource_group = "rg-shared-ad-001"
    backup_policy  = "daily-backup-policy-1"
  }    
}

