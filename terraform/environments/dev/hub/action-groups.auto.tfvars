action_groups = {
  "alz" = {
    resource_group    = "rg-hub-core-001"
    action_group_name = "ag-alz-4ls"
    location          = "global"

    email_config = [
      {
        recipient = "alz-4ls"
        address   = "alz4ls@justice.gov.uk"
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