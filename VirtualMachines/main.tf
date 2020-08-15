provider "azurerm" {
    version = "2.22.0"
    subscription_id = var.subscriptionID
    features {}
}

resource "azurerm_virtual_machine" "airbus-azurevm" {
    count = 4
    name = "airbus-westus-vm-${count.index}"
    location = var.location
    resource_group_name = var.resourceGroupName
    network_interface_ids = ["${var.network_interface_id}"]
    vm_size = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }

    storage_os_disk {
        name = "disk-${count.index}"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name = "airbus-dev"
        admin_username = "devopsuser"
        admin_password = "Password@123!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
        # ssh_keys {
        #     path = "/home/devopsuser/.ssh/authorized_keys"
        #     key_data = file("~/.ssh/azure.pub")
        # }
    }

    tags = {
        environment = var.environment
    }
}