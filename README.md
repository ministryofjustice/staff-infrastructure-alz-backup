# ALZ VM Backup Configurations

This repository contains Terraform code to manage backups for Azure Virtual Machines (VMs) using Recovery Services vaults. It's designed to provide a self-service backup capability for VMs, allowing users to specify their own VMs and backup policies.

## Overview

The Terraform code in this repository creates backup policies in a specified Recovery Services vault and associates them with existing VMs. Each VM can be in a different resource group, and each VM can have its own backup policy. The backup policies are created separately and can be reused for multiple VMs.

## Pre-requisites

This configuration is intended for managing backups for existing VMs. The VMs and the Recovery Services vault should already exist in Azure.

## Usage

The configuration uses several input variables to customize the backup policies and VMs.
Users can specify the details of their VMs and backup policies in a the auto.tfvars files.

- `backup-policies.auto.tfvars`: This contains `backup_policies` which is a list of backup policies. Each item in the list is an object that specifies backup policy.

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
