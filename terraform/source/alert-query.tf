resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alz_custom" {
  provider             = azurerm.spoke
  for_each             = var.custom_query_rules
  name                 = "alert-query-${each.key}"
  location             = each.value.location
  resource_group_name  = each.value.resource_group
  scopes               = [each.value.scope]
  description          = each.value.description
  enabled              = each.value.enabled
  evaluation_frequency = each.value.criteria["eval_frequency"] # make the eval frequency same as aggregation time bucket
  window_duration      = each.value.criteria["aggregation_granularity"]
  severity             = each.value.severity

  criteria {
    query                   = each.value.kql
    time_aggregation_method = each.value.criteria["aggregation"]
    threshold               = each.value.criteria["threshold"]
    operator                = each.value.criteria["operator"]
    metric_measure_column   = each.value.criteria["measure_column"]
  }

  action {
    action_groups = [azurerm_monitor_action_group.alz_mon[each.value.action_group].id]
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags that happen outside of Terraform 
      # to avoid clashing with the Azure policy that already sets them elsewhere
      tags,
    ]
  }
}