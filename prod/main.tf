resource "fastly_service_vcl" "service" {
  name            = var.service_name
  version_comment = var.version_comment
  activate        = false

  domain {
    name = var.service_domain
  }

  backend {
    name              = var.origin_name
    address           = var.origin_domain
    port              = 443
    use_ssl           = true
    ssl_cert_hostname = var.origin_domain
    ssl_sni_hostname  = var.origin_domain
    override_host     = var.origin_domain
  }

  vcl {
    name    = "main"
    content = file("${path.module}/vcl/main.vcl")
    main    = true
  }

  force_destroy = true
}
