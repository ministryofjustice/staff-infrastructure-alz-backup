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
      count = number
    }))
  }))
}

# Variables for Alerts

# BackupJobsFailed
variable "alert_backup_jobs_failed" {
  description = "Configuration for BackupJobsFailed alert"
  type = object({
    enabled           = bool
    threshold         = number
    frequency         = string
    action_group_name = string
  })
  default = {
    enabled           = true
    threshold         = 0
    frequency         = "PT1H"
    action_group_name = ""
  }
}

# BackupJobsCompleted
variable "alert_backup_jobs_completed" {
  description = "Configuration for BackupJobsCompleted alert"
  type = object({
    enabled           = bool
    threshold         = number
    frequency         = string
    action_group_name = string
  })
  default = {
    enabled           = true
    threshold         = 0
    frequency         = "PT1H"
    action_group_name = ""
  }
}

# RestoreJobsFailed
variable "alert_restore_jobs_failed" {
  description = "Configuration for RestoreJobsFailed alert"
  type = object({
    enabled           = bool
    threshold         = number
    frequency         = string
    action_group_name = string
  })
  default = {
    enabled           = false
    threshold         = 0
    frequency         = "PT1H"
    action_group_name = ""
  }
}




