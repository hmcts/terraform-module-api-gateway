data "template_file" "namespace_template" {
  template = "${file("${path.module}/azuredeploy.json")}"
}

locals {
  default_resource_group_name         = "core-infra-${var.env}"
  resource_group_name                 = "${var.resource_group_name == ""
                                             ? local.default_resource_group_name
                                             : var.resource_group_name
                                          }"

  default_api_name                    = "${var.product}-api-gateway-${var.env}"
  api_name                            = "${var.api_name == "" ? local.default_api_name : var.api_name}"

  default_api_product_name            = "${var.product}-api-product-${var.env}"
  api_product_name                    = "${var.api_product_name == ""
                                             ? local.default_api_product_name
                                             : var.api_product_name
                                          }"

  default_api_management_service_name = "core-api-mgmt-${var.env}"
  api_management_service_name         = "${var.api_management_service_name == ""
                                             ? local.default_api_management_service_name
                                             : var.api_management_service_name
                                          }"

  default_api_base_path               = "${var.product}"
  api_base_path                       = "${var.api_base_path == ""
                                             ? local.default_api_base_path
                                             : var.api_base_path
                                          }"
}

resource "azurerm_template_deployment" "api" {
  template_body       = "${data.template_file.namespace_template.rendered}"
  name                = "${var.product}-api-gateway-${var.env}"
  deployment_mode     = "Incremental"
  resource_group_name = "${local.resource_group_name}"

  parameters          = {
    apiManagementServiceName = "${local.api_management_service_name}"
    apiName                  = "${local.api_name}"
    productName              = "${local.api_product_name}"
    swaggerJsonUrl           = "${var.swagger_json_url}"
    apiBasePath              = "${local.api_base_path}"
    apiPolicy                = "${local.api_policy}"
  }
}
