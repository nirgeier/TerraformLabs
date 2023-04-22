data "azuread_application" "service_principal" {
  display_name = local.config.clientName
}

resource "random_password" "service_principal" {
  length = 16
}

resource "azuread_service_principal_password" "service_principal" {
  service_principal_id = local.config.clientId
  value                = random_password.service_principal.result
}
