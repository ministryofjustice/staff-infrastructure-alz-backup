vault_resource_group_name = "rg-eucs-print-azup-001"
vault_name                = "rsv-uprint01-core-001"
vms = {
    vmazup001 = {
        resource_group = "rg-eucs-print-azup-001"
        backup_policy  = "Policy-12-month-retention"
        }
}    

