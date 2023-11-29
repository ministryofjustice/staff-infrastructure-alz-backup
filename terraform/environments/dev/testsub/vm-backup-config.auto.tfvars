vault_resource_group_name = "rg-windows-avzone-src-001"
vault_name                = "rsv-example-recovery-vault"
vms = {
 vm-svmon-win-01 = {
    resource_group = "rg-azmon-test-001"
    backup_policy  = "En-Policy-12-month-retention"
  }
 vm-test-linux-02 = {
    resource_group = "rg-azmon-test-001"
    backup_policy  = "En-Policy-12-month-retention"
  }
}

