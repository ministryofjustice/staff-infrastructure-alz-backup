terraform {
  backend "azurerm" {
    storage_account_name = "samojtfstate001"
    resource_group_name  = "rg-terraform-statefiles-001"
    container_name       = "tfstate"
    key                  = "devtest-vm-worload-backup.terraform.tfstate"
  }
}