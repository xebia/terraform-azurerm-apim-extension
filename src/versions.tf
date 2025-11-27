terraform {
  required_version = ">=1.9.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 2.1.0, < 3.0.0"
    }
  }
}
