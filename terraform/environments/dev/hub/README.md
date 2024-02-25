<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | =1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.64.0 |
| <a name="provider_azurerm.spoke"></a> [azurerm.spoke](#provider\_azurerm.spoke) | 3.64.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_policy_vm.policy](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/resources/backup_policy_vm) | resource |
| [azurerm_backup_policy_vm_workload.backup_workload_policies](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/resources/backup_policy_vm_workload) | resource |
| [azurerm_backup_protected_vm.vm](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/resources/backup_protected_vm) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/data-sources/client_config) | data source |
| [azurerm_recovery_services_vault.existing](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/data-sources/recovery_services_vault) | data source |
| [azurerm_resource_group.vault](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/data-sources/resource_group) | data source |
| [azurerm_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/3.93.0/docs/data-sources/virtual_machine) | data source |
| [terraform_remote_state.alz_core_hub](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_groups"></a> [action\_groups](#input\_action\_groups) | Action group definitions. | <pre>map(object({<br>    resource_group    = string<br>    location          = string<br>    action_group_name = string<br>    email_config      = list(map(string))<br>    logic_app_config  = list(map(string))<br>  }))</pre> | `null` | no |
| <a name="input_backup_policies"></a> [backup\_policies](#input\_backup\_policies) | The backup policies. | <pre>list(object({<br>    name        = string<br>    policy_type = string<br>    backup = object({<br>      frequency     = string<br>      time          = string<br>      hour_interval = optional(string)<br>      hour_duration = optional(string)<br>    })<br>    retention_daily = optional(object({<br>      count = number<br>    }))<br>    retention_weekly = optional(object({<br>      weekdays = list(string)<br>      count    = number<br>    }))<br>    retention_monthly = optional(object({<br>      count    = number<br>      weekdays = optional(list(string))<br>      weeks    = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_backup_workload_policies"></a> [backup\_workload\_policies](#input\_backup\_workload\_policies) | A list of backup workload policy configurations. Includes support for 'Full', 'Differential', and 'Log' policy types. | <pre>list(object({<br>    name                = string<br>    resource_group_name = string<br>    recovery_vault_name = string<br>    workload_type       = string<br>    settings = object({<br>      time_zone           = string<br>      compression_enabled = bool<br>    })<br>    protection_policies = list(object({<br>      policy_type = string // Can be 'Full', 'Differential', or 'Log'<br>      backup = object({<br>        frequency            = string // Used for 'Full' and 'Differential', ignored for 'Log'<br>        time                 = string // Used for 'Full' and 'Differential', ignored for 'Log'<br>        frequency_in_minutes = number // Used for 'Log', should be null or ignored for 'Full' and 'Differential'<br>      })<br>      retention_daily = object({<br>        count = number // Applicable for 'Full' and 'Differential' backups<br>      })<br>      simple_retention = object({<br>        count = number // Used for 'Log' backups<br>      })<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_custom_query_rules"></a> [custom\_query\_rules](#input\_custom\_query\_rules) | Configuration for Backup Alerts | <pre>map(object({<br>    description    = string<br>    resource_group = string<br>    scope          = string<br>    location       = string<br>    enabled        = bool<br>    severity       = number<br>    action_group   = string<br>    kql            = string<br>    criteria = object({<br>      aggregation             = string<br>      aggregation_granularity = string<br>      operator                = string<br>      threshold               = number<br>      measure_column          = string # not usually needed for "count" aggregation<br>      eval_frequency          = string<br>    })<br><br><br>  }))</pre> | `null` | no |
| <a name="input_remote_state_hub_container"></a> [remote\_state\_hub\_container](#input\_remote\_state\_hub\_container) | Storage Account container that contains Hub state file | `string` | n/a | yes |
| <a name="input_remote_state_hub_file"></a> [remote\_state\_hub\_file](#input\_remote\_state\_hub\_file) | State file name in Storage Account Container | `string` | n/a | yes |
| <a name="input_remote_state_hub_rg_name"></a> [remote\_state\_hub\_rg\_name](#input\_remote\_state\_hub\_rg\_name) | Resource Group that contains core Hub state | `string` | n/a | yes |
| <a name="input_remote_state_hub_sa_name"></a> [remote\_state\_hub\_sa\_name](#input\_remote\_state\_hub\_sa\_name) | Storage account that stores core Hub state | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Spoke/Workload Subscription ID | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenant ID for this environment/subscription | `string` | n/a | yes |
| <a name="input_vault_name"></a> [vault\_name](#input\_vault\_name) | The name of the Recovery Services vault. | `string` | n/a | yes |
| <a name="input_vault_resource_group_name"></a> [vault\_resource\_group\_name](#input\_vault\_resource\_group\_name) | The name of the resource group where the Recovery Services vault and backup policies are located. | `string` | n/a | yes |
| <a name="input_vms"></a> [vms](#input\_vms) | Information about the VMs to backup. | <pre>map(object({<br>    resource_group = string<br>    backup_policy  = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
