tenant_id       = "0bb413d7-160d-4839-868a-f3d46537f6af"
subscription_id = "6d5d7ebc-2b02-46ab-a77d-7b1a35ed0b86" # EUCS ( shared with uprint)

#For looking up data values from the core Hub state
remote_state_hub_sa_name   = "samojtfstate001"
remote_state_hub_rg_name   = "rg-terraform-statefiles-001"
remote_state_hub_container = "tfstate"
remote_state_hub_file      = "hubdev.terraform.tfstate"