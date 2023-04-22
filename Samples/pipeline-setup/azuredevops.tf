provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/"
  personal_access_token = "" # YOUR TOKEN HERE
}

data "azuredevops_project" "project" {
  name = local.config.projectName
}

data "azuredevops_git_repository" "repository" {
  project_id = data.azuredevops_project.project.id
  name       = local.config.repoName
}

resource "azuredevops_variable_group" "variable_group" {
  project_id   = data.azuredevops_project.project.id
  name         = local.config.pipelineName
  description  = "Variable group for ${local.config.envType} pipeline"
  allow_access = true

  variable {
    name  = "service_name"
    value = local.config.serviceConnectionName
  }

  variable {
    name  = "key_vault_name"
    value = local.config.keyVaultName
  }

  variable {
    name  = "prefix"
    value = local.config.envType
  }

}

resource "azuredevops_build_definition" "pipeline" {
  project_id = data.azuredevops_project.project.id
  name       = local.config.pipelineName

  ci_trigger {
    use_yaml = true
  }

  schedules {
    branch_filter {
      include = [local.config.trigger[0]]
    }
    days_to_build              = ["Wed", "Sun"]
    schedule_only_with_changes = true
    start_hours                = 10
    start_minutes              = 59
    time_zone                  = "(UTC) Coordinated Universal Time"
  }

  repository {
    repo_type   = local.config.repoType
    repo_id     = data.azuredevops_git_repository.repository.id
    branch_name = local.config.trigger[0]
    yml_path    = "/pipelines/azure-pipelines.yml"
  }

  variable_groups = [azuredevops_variable_group.variable_group.id]
}
