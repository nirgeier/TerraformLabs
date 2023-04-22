# Plan to add new keyvault as part of setup process

data "azurerm_key_vault" "infra_key_vault" {
  name                = local.config.keyVaultName
  resource_group_name = "Identity-rg"
}

resource "azurerm_key_vault_secret" "pipeline" {

  depends_on = [

  ]

  for_each     = local.pipeline_variables
  name         = each.key
  value        = each.value
  key_vault_id = data.azurerm_key_vault.infra_key_vault.id
}
