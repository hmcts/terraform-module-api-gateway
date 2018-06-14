variable "env" {
  type = "string"
}

# Name of the product protected by this API. Doesn't need to match any existing name,
# but should be unique within its environment and obvious enough to tell what that service is.
variable "product" {
  type = "string"
}

# (Optional) Name of the resource group for the API.
variable "resource_group_name" {
  type = "string"
  default = ""
}

# (Optional) Name of the API to be created
variable "api_name" {
  type = "string"
  default = ""
}

# (Optional) Name of the API Management service in which the API should be created
variable "api_management_service_name" {
  type = "string"
  default = ""
}

# (Optional) Name of the associated product to be created with the API
variable "api_product_name" {
  type = "string"
  default = ""
}

# (Optional) The URL that should be used by the API to talk to the backend application.
# When not provided, the host and protocol defined in Swagger definition is used.
variable "backend_app_url" {
  type = "string"
  default = ""
}

# URL to the protected API's Swagger JSON definition
# This JSON has to specify HTTPS as the protocol
variable "swagger_json_url" {
  type = "string"
}

# Thumbprints of accepted client certificates (SSL) - only requests from those clients will be let through
variable "allowed_certificate_thumbprints" {
  type = "list"
  default = []
}

# (Optional) Base URL path of the API, which will result with the full URL being
# something like https://core-api-mgmt-....azure-api.net/{base path}
variable "api_base_path" {
  type = "string"
  default = ""
}
