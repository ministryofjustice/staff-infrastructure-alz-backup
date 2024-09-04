# Set Terraform version, backend parameters set at pipeline level
terraform {
  backend "azurerm" {
    # Not required when run in pipeline, only required for command line testing
    storage_account_name = "samojtfstate003"
    resource_group_name  = "rg-prod-tfstate-001"
    container_name       = "tfstate"
    key                  = "dogs-staging-vm-backup.terraform.tfstate"
  }
}
