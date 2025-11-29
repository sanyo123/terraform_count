resource "azurerm_network_interface" "this" {
    count = length(var.vm_config)
    name                = "${var.vm_config[count.index].vm_name}-nic"
    location            = var.vm_config[count.index].location
    resource_group_name = var.vm_config[count.index].resource_group_name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.this[count.index].id
        private_ip_address_allocation = "Dynamic"
    }
  
  depends_on = [ azurerm_resource_group.this ]
}

resource "azurerm_virtual_machine" "this" {
    count = length(var.vm_config) 
    name                  = var.vm_config[count.index].vm_name
    location              = var.vm_config[count.index].location
    resource_group_name   = var.vm_config[count.index].resource_group_name
    vm_size               = var.vm_config[count.index].vm_size
    network_interface_ids = [ azurerm_network_interface.this[count.index].id ]
    
    storage_os_disk {
        name              = "${var.vm_config[count.index].vm_name}-osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    
    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
    
    os_profile {
        computer_name  = var.vm_config[count.index].vm_name
        admin_username = var.vm_config[count.index].admin_username
        admin_password = var.vm_config[count.index].admin_password
    }
    
    os_profile_linux_config {
        disable_password_authentication = false
    }
    
    tags = var.vm_config[count.index].tags
  depends_on = [ azurerm_network_interface.this, azurerm_subnet.this, azurerm_resource_group.this ]
}

resource "azurerm_resource_group" "this" {
    count = length(var.vm_config)
    name     = var.vm_config[count.index].resource_group_name
    location = var.vm_config[count.index].location
  
}

resource "azurerm_virtual_network" "this" {
    count = length(var.vm_config)
    name                = "${var.vm_config[count.index].resource_group_name}-vnet"
    location            = var.vm_config[count.index].location
    resource_group_name = var.vm_config[count.index].resource_group_name
    address_space       = var.vm_config[count.index].address_space

    depends_on = [ azurerm_resource_group.this ]
    }

resource "azurerm_subnet" "this" {
    count = length(var.vm_config)
    name                 = "${var.vm_config[count.index].resource_group_name}-subnet"
    resource_group_name  = var.vm_config[count.index].resource_group_name
    virtual_network_name = azurerm_virtual_network.this[count.index].name
    address_prefixes     = var.vm_config[count.index].address_prefixes
    depends_on = [ azurerm_virtual_network.this ]
}


resource "azurerm_virtual_network_peering" "this" {
    count = length(var.vm_config)
    name = "${var.vm_config[count.index].resource_group_name}-peering"
    resource_group_name = var.vm_config[count.index].resource_group_name
    virtual_network_name = azurerm_virtual_network.this[count.index].name
    remote_virtual_network_id = azurerm_virtual_network.this[ (count.index + 1) % length(var.vm_config) ].id
    allow_virtual_network_access = true
    allow_forwarded_traffic = true

    depends_on = [ azurerm_virtual_network.this, azurerm_resource_group.this ]
  
}

