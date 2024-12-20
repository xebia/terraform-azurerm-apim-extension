terraform {
  required_version = "~> 1.1, <= 1.9.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 2.1.0, < 3.0.0"
    }
  }
}
