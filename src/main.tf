##############################################
# Central Operating Model for API Management
##############################################
resource "azurerm_role_assignment" "sp_apim_contributor" {
  count = var.apim_workspace == null ? 1 : 0

  principal_id         = var.service_principal_object_id
  role_definition_name = "API Management Service Contributor"
  scope                = var.apim_resource_id
}

resource "azurerm_role_assignment" "owner_group_apim_contributor" {
  count = var.apim_workspace == null ? 1 : 0

  principal_id         = var.owner_group_id
  role_definition_name = "API Management Service Contributor"
  scope                = var.apim_resource_id
}

resource "azurerm_role_assignment" "contributor_group_apim_contributor" {
  count = var.apim_workspace == null ? 1 : 0

  principal_id         = var.contributor_group_id
  role_definition_name = "API Management Service Contributor"
  scope                = var.apim_resource_id
}

resource "azurerm_role_assignment" "reader_group_apim_reader" {
  count = var.apim_workspace == null ? 1 : 0

  principal_id         = var.reader_group_id
  role_definition_name = "API Management Service Reader Role"
  scope                = var.apim_resource_id
}

##############################################
# Decentral Operating Model for API Management
##############################################
resource "azapi_resource" "apim_workspace" {
  count                     = var.apim_workspace != null ? 1 : 0
  type                      = "Microsoft.ApiManagement/service/workspaces@2024-05-01"
  name                      = var.apim_workspace.name
  parent_id                 = var.apim_resource_id
  schema_validation_enabled = false # needed due to old azapi provider version in landing zone

  body = {
    properties = {
      description = var.apim_workspace.description
      displayName = var.apim_workspace.name
    }
  }
}

resource "azurerm_role_assignment" "sp_apim_workspace_contributor" {
  count      = var.apim_workspace != null ? 1 : 0
  depends_on = [azapi_resource.apim_workspace]

  principal_id         = var.service_principal_object_id
  role_definition_name = "API Management Workspace Contributor"
  scope                = azapi_resource.apim_workspace[0].id
}

resource "azurerm_role_assignment" "owner_group_apim_workspace_contributor" {
  count      = var.apim_workspace != null ? 1 : 0
  depends_on = [azapi_resource.apim_workspace]

  principal_id         = var.owner_group_id
  role_definition_name = "API Management Workspace Contributor"
  scope                = azapi_resource.apim_workspace[0].id
}

resource "azurerm_role_assignment" "contributor_group_apim_workspace_contributor" {
  count      = var.apim_workspace != null ? 1 : 0
  depends_on = [azapi_resource.apim_workspace]

  principal_id         = var.contributor_group_id
  role_definition_name = "API Management Workspace Contributor"
  scope                = azapi_resource.apim_workspace[0].id
}

resource "azurerm_role_assignment" "reader_group_apim_workspace_reader" {
  count      = var.apim_workspace != null ? 1 : 0
  depends_on = [azapi_resource.apim_workspace]

  principal_id         = var.reader_group_id
  role_definition_name = "API Management Workspace Reader"
  scope                = azapi_resource.apim_workspace[0].id
}
