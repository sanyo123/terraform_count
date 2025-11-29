# Terraform Azure with count

Terraform configuration to provision Azure basics using `count` for scaling:
- Resource groups, virtual networks, and subnets
- Network interfaces and Ubuntu virtual machines

## Files
- `main.tf` VM/NIC/VNet/Subnet/NSG resources driven by `vm_config`.
- `variables.tf` Input variable definitions (list of VM configs, rules, etc.).
- `terraform.tfvars` Example values to drive a plan/apply.
- `providers.tf` Provider configuration for `hashicorp/azurerm`.
- `.gitignore` Terraform state and plan artifacts ignored.

## Usage
```sh
# initialize providers
terraform init

# review changes
terraform plan

# apply when ready
terraform apply
```

### Configure VMs
Set `vm_config` in `terraform.tfvars` as a list of VM objects:
```hcl
vm_config = [
  {
    vm_name             = "vm1"
    location            = "East US"
    resource_group_name = "my-rg"
    vm_size             = "Standard_B1s"
    admin_username      = "adminuser"
    admin_password      = "P@ssw0rd123!"
    tags = {
      environment = "dev"
    }
  }
]
```
Add more objects to create multiple VMs; `count = length(var.vm_config)` drives resource multiplicity.


## Notes
- Ensure Azure credentials are available to Terraform (e.g., `az login` or service principal env vars).
- Password auth is enabled for simplicity; consider SSH keys for production.
