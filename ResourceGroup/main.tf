#Terraform Script for Resouce Group
provider "azurerm" {
  version         = "2.22.0"
  subscription_id = var.subscriptionID
  tenant_id       = var.tenantID
  client_id       = var.clientID
  client_secret   = var.clientSecret
  features {}
}

resource "azurerm_resource_group" "airbus-rsgroup" {
  name     = var.resourceGroupName
  location = var.location

  tags = {
    environment = var.environment
  }
}
