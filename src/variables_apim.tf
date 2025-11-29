variable "apim_resource_id" {
  description = "The resource id of the API Management service"
  type        = string
}

variable "apim_workspace" {
  type = object({
    name         = string
    display_name = optional(string)
    description  = optional(string)
  })
  default     = null
  description = <<DESCRIPTION
The API Management workspace configuration

- `name` - The name of the API Management workspace.
- `display_name` - (Optional) The display name of the API Management workspace.
- `description` - (Optional) The description of the API Management workspace.
DESCRIPTION

  validation {
    condition     = var.apim_workspace == null || can(regex("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$", var.apim_workspace.name))
    error_message = "apim_workspace.name must contain only letters, numbers and dashes. Dashes must be between letters/numbers (no leading/trailing/consecutive dashes)."
  }
}
