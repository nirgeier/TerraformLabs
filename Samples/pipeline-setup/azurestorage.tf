provider "azurerm" {
  features {}
}

data "azurerm_storage_account" "storage_account" {
  name                = local.config.backendConfigStorageAccountName
  resource_group_name = "Remote-State-rg"
}

data "azurerm_storage_account_sas" "storage_account" {
  connection_string = data.azurerm_storage_account.storage_account.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "17520h")

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
  }
}
