resource "azurerm_monitor_action_group" "alz_mon" {
  provider            = azurerm.spoke
  for_each            = var.action_groups
  location            = each.value.location
  name                = each.value.action_group_name
  resource_group_name = each.value.resource_group
  short_name          = each.key

  dynamic "email_receiver" {
    for_each = each.value.email_config
    content {
      name          = email_receiver.value["recipient"]
      email_address = email_receiver.value["address"]
    }
  }

  dynamic "logic_app_receiver" {
    for_each = each.value.logic_app_config
    content {
      name                    = logic_app_receiver.value["logic_app_function"]
      resource_id             = data.terraform_remote_state.alz_core_hub.outputs.monitor_logicapp_ids[logic_app_receiver.value.logic_app]
      callback_url            = sensitive(data.terraform_remote_state.alz_core_hub.outputs.monitor_logicapp_trigger_url[logic_app_receiver.value.logic_app])
      use_common_alert_schema = true
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags that happen outside of Terraform 
      # to avoid clashing with the Azure policy that already sets them elsewhere
      tags,
    ]
  }
}