terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}

resource "azuredevops_project" "example" {
  name               = "Teste Project"
  work_item_template = "Agile"
  version_control    = "Git"
  visibility         = "private"
  description        = "Managed by Terraform"
}

data "azuredevops_group" "example-project-readers" {
  project_id = azuredevops_project.example.id
  name       = "Readers"
}

resource "azuredevops_area_permissions" "example-root-permissions" {
  project_id = azuredevops_project.example.id
  principal  = data.azuredevops_group.example-project-readers.id
  path       = "/readers"
  permissions = {
    CREATE_CHILDREN = "Deny"
    GENERIC_READ    = "Allow"
    DELETE          = "Deny"
    WORK_ITEM_READ  = "Allow"
  }
}