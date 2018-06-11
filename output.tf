output "base_url" {
  value = "https://core-api-mgmt-${var.env}.azure-api.net/${local.api_base_path}"
}

output "api_name" {
  value = "${local.api_name}"
}

output "api_product_name" {
  value = "${local.api_product_name}"
}

output "resource_group_name" {
  value = "${local.resource_group_name}"
}
