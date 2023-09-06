action_groups = {
  "alz" = {
    resource_group    = "rg-hub-core-001"
    action_group_name = "ag-alz-4ls-backup"
    location          = "global"

    email_config = [
      {
        recipient = "alz-4ls"
        address   = "eucs3ls@justice"
      }
    ]
    logic_app_config = [
      {
        logic_app_function = "teams_integration"
        logic_app          = "alz_teams_integration"
      }
    ]
  }
}