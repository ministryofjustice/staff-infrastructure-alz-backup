# ALZ VM Backup Configurations

This repository contains Terraform code to manage backups for Azure Virtual Machines (VMs) using Recovery Services vaults. It's designed to provide a self-service backup capability for VMs, allowing users to specify their own VMs and backup policies.

## Overview

The Terraform code in this repository creates backup policies in a specified Recovery Services vault and associates them with existing VMs. Each VM can be in a different resource group, and each VM can have its own backup policy. The backup policies are created separately and can be reused for multiple VMs.

Additionally this repository can also be used to configure backup policies (only) for SQL in Azure Database. The backup policy can then be used to discover and associate a SQL database for `Full`, `Differential` or `Log` backup of the databases as per requirement.

Please note at this time discovering and associating SQL DB to the backup workload policy is not possible via terraform azurerm provider. This can thus be done via portal, cli or powershell.

## Pre-requisites

This configuration is intended for managing backups for existing VMs. The VMs and the Recovery Services vault should already exist in Azure.

For backups of SQL databases on Azure ensure the SQL on Azure VM is a marketplace image. For other SQL deployments please ensure requirements are met as per [backup-azure-sql-database](https://learn.microsoft.com/en-us/azure/backup/backup-azure-sql-database)

## Usage

The configuration uses several input variables to customize the backup policies and VMs.
Users can specify the details of their VMs and backup policies in a the auto.tfvars files.

- `backup-policies.auto.tfvars`: This contains `backup_policies` which is a list of backup policies. Each item in the list is an object that specifies backup policy.

- `backup-workload-policies.auto.tfvars`: (Optional): This contains `backup_workload_policies` which is a list of backup policies for SQL database. See more details in the Attibute Breakdown section below. Each item in the list is an object that specifies backup policy.

- `vm-backup-config.auto.tfvars`: This contains `vms` which is a A map where each key is a VM name, and each value is an object containing the resource group name and the backup policy name for that VM.

- `vault_resource_group_name`: The name of the resource group where the Recovery Services vault and backup policies are located.

- `vault_name`: The name of the Recovery Services vault.

## Core Files

This repository includes the following files:

`variables.tf`: Contains the declaration of variables used in the configuration.
`data.tf`: Contains data blocks to fetch information about existing resources, such as the Recovery Services vault and VMs.
`main.tf`: Contains the resource blocks to create the backup policies and associate them with VMs.
`versions.tf`: Contains the provider configuration.

## Quick-Start

- Clone this repository and create a new branch
- Make amendments to the relevant files (fully explained below)
- Open a PR against `main`
- Wait for a member of the ALZ team to approve and deploy

## Full Usage

### Summary

## Configuration Files

There are two primary tfvars files that are used to drive the configurations:

- Backup Configuration (backup-policies.auto.tfvars): This file is responsible for defining the backup policies.
- VM Assignment (vm-backup-config.auto.tfvars): This file assigns specific backup policies to the desired virtual machines.

### Attribute Breakdown

### Backup Configuration (backup-policies.auto.tfvars)

This file defines the backup policies. Here's a brief overview of its attributes:

- `vault_resource_group_name`: The name of the resource group where the Recovery Services Vault resides.
- `vault_name`: The name of the Recovery Services Vault.
- `backup_policies`: A list of backup policies, where each policy can have attributes like name, frequency, retention days, etc.
- `backup_workload_policies` : 

```
This protection block allows to choose between the various backup types and attibutes are to be specified accordingly.
Please look at this subsection for guidance.

protection_policies = list(object({
      policy_type = string // Can be 'Full', 'Differential', or 'Log'
      backup = object({
        frequency              = string // Used for 'Full' and 'Differential', ignored for 'Log'
        time                   = string // Used for 'Full' and 'Differential', ignored for 'Log'
        frequency_in_minutes   = number // Used for 'Log', should be null or ignored for 'Full' and 'Differential'
      })
      retention_daily = object({
        count = number // Applicable for 'Full' and 'Differential' backups
      })
      simple_retention = object({
        count = number // Used for 'Log' backups
      })
    }))

    
```

- `Sample`

```
   vault_resource_group_name = "rg-hub-core-001"
   vault_name                = "rsv-hub-core-001"
   backup_policies = [...]
```

### VM Assignment ( vm-backup-config.auto.tfvars)

This file assigns the backup policies defined in the backup-policies.auto.tfvars to specific virtual machines. The attributes include

- `vms` : A map of virtual machines, where each VM can be associated with a specific backup policy.

- `Sample`

```
vms = {
  vm1 = {
    resource_group = "rg-hub-poltest-01"
    backup_policy  = "Policy-12-month-retention"
  }
  ...
}
```

## Monitoring and Alerting for Backups

Monitoring and alerting for backup jobs is accomplished via Azure Monitor. The Azure Landing Zone alerting repo found at [ALZ alerting repo](https://github.com/ministryofjustice/staff-infrastructure-alz-monitor-alerts) has two sample backup alerts in the [Dev testing](https://github.com/ministryofjustice/staff-infrastructure-alz-monitor-alerts/tree/main/terraform/environments/dev/testing) folder. Update the parameters in the backup alerts section of `custom-query-rules.auto.tfvars` file to configure alerts for your backup jobs.
