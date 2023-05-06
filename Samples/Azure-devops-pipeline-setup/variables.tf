data "azurerm_client_config" "current" {
}

locals {
  config = yamldecode(file("../dev-setup.yml"))
  pipeline_variables = {
    storage-account = local.config.backendConfigStorageAccountName
    container-name  = local.config.backendConfigContainerName
    client-id       = data.azuread_application.service_principal.application_id
    client-password = random_password.service_principal.result
    subscription-id = local.config.subscriptionId
    storage-key     = local.config.backendConfigKey
    sas-token       = data.azurerm_storage_account_sas.storage_account.sas
    tenant-id       = data.azurerm_client_config.current.tenant_id
  }
}
