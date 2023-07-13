## General

variable "subscription_id" {
  type        = string
  description = "Spoke/Workload Subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID for this environment/subscription"
}

## Backup Specific

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
      hour_interval = string
      hour_duration = string
    })
    retention_daily = object({
      count = number
    })
  }))
}
