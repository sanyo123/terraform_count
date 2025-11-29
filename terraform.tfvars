vm_config = [
  {
    vm_name             = "vm1"
    location            = "East US"
    resource_group_name = "olu_nsg"
    vm_size             = "Standard_B1s"
    admin_username      = "adminuser"
    admin_password      = "P@ssw0rd123!"
    address_space = [ "10.1.0.0/24" ]
    address_prefixes = [ "10.1.0.0/25" ]
    tags = {
      environment = "dev"
    }
  }
    ,
    {
        vm_name             = "vm2"
        location            = "East US"
        resource_group_name = "olu_nsg1"
        vm_size             = "Standard_B1s"
        admin_username      = "adminuser"
        admin_password      = "P@ssw0rd123!"
        address_space = [ "10.0.0.0/24" ]
        address_prefixes = [ "10.0.0.0/25" ]
        tags = {
        environment = "dev"
        }
    }
    ]      