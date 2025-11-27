variable "apim_resource_id" {
  description = "The resource id of the API Management service"
  type        = string
}

variable "apim_workspace" {
  type = object({
    name        = string
    description = string
  })
  default     = null
  description = <<DESCRIPTION
The API Management workspace configuration

- `name` - The name of the API Management workspace.
- `description` - The description of the API Management workspace.
DESCRIPTION
}
