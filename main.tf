terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "1.0.1"
    }
  }
}

provider "azuredevops" {
  # Configuration options
}

resource "azuredevops_project" "example" {
  name               = "Example Project"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
  description        = "Managed by Terraform"
  features = {
    "testplans" = "disabled"
    "artifacts" = "disabled"
  }
}