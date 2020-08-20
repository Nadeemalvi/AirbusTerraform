provider "azurerm" {
    version = "2.22.0"
    subscription_id = var.subscriptionID
    tenant_id = var.tenantID
    features {}
}

resource "azurerm_resource_group" "airbus-rsgroup" {
    name = var.resourceGroupName
    location = var.location

    tags = {
        environment = var.environment
    }
}
