resource "azurerm_resource_group" "rg" {
  name     = "rg-apim"
  location = "westeurope"
}

resource "azuread_application" "sp_app" {
  display_name = "sp_app"
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.sp_app.client_id
}

resource "azuread_group" "owner_group" {
  display_name     = "Owner Group"
  security_enabled = true
}

resource "azuread_group" "contributor_group" {
  display_name     = "Contributor Group"
  security_enabled = true
}

resource "azuread_group" "reader_group" {
  display_name     = "Reader Group"
  security_enabled = true
}

resource "azurerm_api_management" "apim" {
  name                = "apim"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "westeurope"
  publisher_name      = "publisher"
  publisher_email     = "mail@mail.org"
  sku_name            = "Premium_1"
}

module "defaults" {
  source = "../../src"

  # global
  service_principal_object_id = azuread_service_principal.sp.object_id
  owner_group_id              = azuread_group.owner_group.object_id
  contributor_group_id        = azuread_group.contributor_group.object_id
  reader_group_id             = azuread_group.reader_group.object_id

  # apim
  apim_resource_id = azurerm_api_management.apim.id
  apim_workspace = {
    name        = "apim-workspace"
    description = "APIM workspace"
  }
}
