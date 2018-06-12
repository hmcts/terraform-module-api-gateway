# local variables related with the API's policy
locals {
  # certificate thumbprints wrapped in XML-escaped double quotes and comma-separated
  allowed_cert_thumbprints_string = "${length(var.allowed_certificate_thumbprints) > 0
                                         ? format("&quot;%s&quot;", join("&quot;,&quot;", var.allowed_certificate_thumbprints))
                                         : ""
                                      }"

  backend_service_policy = "${var.backend_app_url == ""
                                ? ""
                                : "<set-backend-service base-url=\"${var.backend_app_url}\"/>"
                             }"

  api_policy = <<EOF
    <policies>
        <backend>
            <base/>
        </backend>
        <inbound>
            <base/>
            ${local.backend_service_policy}
            <choose>
                <when condition="@(context.Request.Certificate == null || !(new string[]{${local.allowed_cert_thumbprints_string}}.Any(t => t.ToUpper() == context.Request.Certificate.Thumbprint.ToUpper())))">
                    <return-response>
                        <set-status code="403" reason="Invalid client certificate"/>
                    </return-response>
                </when>
            </choose>
        </inbound>
        <outbound>
            <base/>
        </outbound>
        <on-error>
            <base/>
        </on-error>
    </policies>
  EOF
}
