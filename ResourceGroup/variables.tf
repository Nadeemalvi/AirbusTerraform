variable "subscriptionID" {
    type = string
    description = "Varible for the Azure Subscription ID"
}

variable "resourceGroupName" {
    type = string
    description = "Name of airbus resource group"
}

variable "location" {
    type = string
    description = "Location for the resource group"
}

variable "environment" {
    type = string
    description = "Environment name for Airbus Dev"
}