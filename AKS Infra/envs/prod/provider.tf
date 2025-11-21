terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg3"
    storage_account_name = "shyamstg1"
    container_name       = "shyamcontainer"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "85002d33-efb7-4e6a-8e6d-7457837654e2"
}
