# General
variable "subscription_id" {
  type        = string
  description = "Spoke/Workload Subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for this environment/subscription"
}

# Remote state details, for data lookups

variable "remote_state_hub_sa_name" {
  type        = string
  description = "Storage account that stores core Hub state"
}

variable "remote_state_hub_rg_name" {
  type        = string
  description = "Resource Group that contains core Hub state"
}

variable "remote_state_hub_container" {
  type        = string
  description = "Storage Account container that contains Hub state file"
}

variable "remote_state_hub_file" {
  type        = string
  description = "State file name in Storage Account Container"
}

variable "action_groups" {
  type = map(object({
    resource_group    = string
    location          = string
    action_group_name = string
    email_config      = list(map(string))
    logic_app_config  = list(map(string))
  }))
  description = "Action group definitions."
  default     = null
}

variable "vault_resource_group_name" {
  description = "The name of the resource group where the Recovery Services vault and backup policies are located."
  type        = string
}

variable "vault_name" {
  description = "The name of the Recovery Services vault."
  type        = string
}

variable "vms" {
  description = "Information about the VMs to backup."
  type = map(object({
    resource_group = string
    backup_policy  = string
  }))
}


variable "wk_vms" {
  description = "Information about the VMs to backup."
  type = map(object({
    resource_group = string
    backup_policy  = string
  }))
  default = {}
}
variable "backup_policies" {
  description = "The backup policies."
  type = list(object({
    name        = string
    policy_type = string
    backup = object({
      frequency     = string
      time          = string
      hour_interval = optional(string)
      hour_duration = optional(string)
    })
    retention_daily = optional(object({
      count = number
    }))
    retention_weekly = optional(object({
      weekdays = list(string)
      count    = number
    }))
    retention_monthly = optional(object({
      count    = number
      weekdays = optional(list(string))
      weeks    = optional(list(string))
    }))
  }))
  default = []
}


# Variable for backup vm workload like sql and saphana

variable "backup_workload_policies" {
  description = "A list of backup workload policy configurations. Includes support for 'Full', 'Differential', and 'Log' policy types."
  type = list(object({
    name                = string
    resource_group_name = string
    recovery_vault_name = string
    workload_type       = string
    settings = object({
      time_zone           = string
      compression_enabled = bool
    })
    protection_policies = list(object({
      policy_type = string // Can be 'Full', 'Differential', or 'Log'
      backup = object({
        frequency            = string // Used for 'Full' and 'Differential', ignored for 'Log'
        time                 = string // Used for 'Full' and 'Differential', ignored for 'Log'
        frequency_in_minutes = number // Used for 'Log', should be null or ignored for 'Full' and 'Differential'
      })
      retention_daily = object({
        count = number // Applicable for 'Full' and 'Differential' backups
      })
      simple_retention = object({
        count = number // Used for 'Log' backups
      })
    }))
  }))
  default = []
}



# Variables for Alerts

# Custom queries (to covery everything else)

variable "custom_query_rules" {
  type = map(object({
    description    = string
    resource_group = string
    scope          = string
    location       = string
    enabled        = bool
    severity       = number
    action_group   = string
    kql            = string
    criteria = object({
      aggregation             = string
      aggregation_granularity = string
      operator                = string
      threshold               = number
      measure_column          = string # not usually needed for "count" aggregation
      eval_frequency          = string
    })


  }))
  description = "Configuration for Backup Alerts"
  default     = null
}




