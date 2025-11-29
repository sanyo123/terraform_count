variable "vm_config" {
  description = "Configurations for virtual machines"
  type = list(object({
    vm_name             = string
    location            = string
    resource_group_name = string
    vm_size             = string
    admin_username      = string
    admin_password      = string
    address_space      = list(string)
    address_prefixes   = list(string)
    tags                = map(string)
  }))
  default = []
}
