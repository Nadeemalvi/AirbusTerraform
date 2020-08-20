provider "azurerm" {
    version = "2.22.0"
    subscription_id = var.subscriptionID
    tenant_id = var.tenantID
    client_id = "1d27002f-29c0-4755-b106-c6ef550a3610"
    client_secret = "otNKzvOfd5Q-QAlmAloWgNJ-7_F33s-~-Z"
    features {}
}

resource "azurerm_resource_group" "airbus-rsgroup" {
    name = var.resourceGroupName"1d27002f-29c0-4755-b106-c6ef550a3610"
    client_secret = "otNKzvOfd5Q-QAlmAloWgNJ-7_F33s-~-Z"
    location = var.location

    tags = {
        environment = var.environment
    }
}
