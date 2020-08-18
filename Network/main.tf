provider "azurerm" {
    version = "2.22.0"
    subscription_id = var.subscriptionID
    features {}
}

resource "azurerm_network_security_group" "airbus-nsg" {
    name = "Airbus-NSG"
    location = var.location
    resource_group_name = var.resourceGroupName
}

resource "azurerm_network_security_rule" "Port80" {
    name                        = "Allow80"
    priority                    = 102
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "TCP"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_network_security_group.airbus-nsg.resource_group_name
    network_security_group_name = azurerm_network_security_group.airbus-nsg.name
}

resource "azurerm_network_security_rule" "Port443" {
    name                        = "Allow443"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "TCP"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_network_security_group.airbus-nsg.resource_group_name
    network_security_group_name = azurerm_network_security_group.airbus-nsg.name
}

resource "azurerm_network_security_rule" "Port22" {
    name                        = "Allow22"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "TCP"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_network_security_group.airbus-nsg.resource_group_name
    network_security_group_name = azurerm_network_security_group.airbus-nsg.name
}

resource "azurerm_virtual_network" "airbus-vnet" {
    name = "airbus-vnet"
    location = var.location
    resource_group_name = var.resourceGroupName
    address_space = ["10.0.0.0/16"]
    dns_servers = ["8.8.8.8","8.8.4.4"]

    tags = {
        environment = var.environment
    }
}

resource "azurerm_subnet" "airbus-subnet" {
    name = "airbus-subnet"
    resource_group_name = azurerm_network_security_group.airbus-nsg.resource_group_name
    virtual_network_name = azurerm_virtual_network.airbus-vnet.name
    address_prefix = "10.0.1.0/24"
}

resource "azurerm_public_ip" "airbus-publicip" {
    count = 4
    name = "airbus-publicIP-${count.index}"
    location = var.location
    resource_group_name = azurerm_network_security_group.airbus-nsg.resource_group_name
    allocation_method = "Static"
    ip_version = "IPv4"

    tags = {
        environment = var.environment
    }
}

resource "azurerm_network_interface" "airbus-vminterface" {
    count = 4
    name = "airbusvm-interface-${count.index}"
    location = azurerm_network_security_group.airbus-nsg.location
    resource_group_name = azurerm_network_security_group.airbus-nsg.resource_group_name

    ip_configuration {
        name = "airbus-config-${count.index}"
        subnet_id = azurerm_subnet.airbus-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = element(azurerm_public_ip.airbus-publicip.*.id, count.index)
    }

    tags = {
        environment = var.environment
    }
}