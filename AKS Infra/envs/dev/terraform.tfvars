rgs = {
  gr1 = {
    name     = "todo_Infra_rg01"
    location = "centralindia"
    tags = {
      environment = "dev"
      owner       = "shyamu"
      managed_by  = "Terraform"
    }

  }
  gr2 = {
    name     = "todo_Infra_rg02"
    location = "centralindia"
    tags = {
      environment = "dev"
      owner       = "shyamu"
      managed_by  = "Terraform"
    }

  }
}
networks = {
  vnet1 = {
    resource_group_name = "todo_Infra_rg01"
    location            = "centralindia"
    name                = "infravnet001"
    address_space       = ["10.0.0.0/16"]

    pip_name            = "Infra_pip01"
    allocation_method   = "Static"
    sku                 = "Standard"
    nsg_name            = "frontend_nsg01"

    subnets = {
      subnet1 = {
        name              = "frontend_subnet01"
        address_prefixes  = ["10.0.1.0/24"]
      }
      subnet2 = {
        name              = "backend_subnet01"
        address_prefixes  = ["10.0.2.0/24"]
      }
      subnet3 = {
        name              = "bastion_subnet"
        address_prefixes  = ["10.0.3.0/24"]
      }
    }
  }
}


vms = {
  vm01 = {
    name                = "frontend_VM01"
    location            = "centralindia"
    resource_group_name = "todo_Infra_rg01"

    nic_name            = "frontend_nic01"      # 👈 Add this
    nsg_name            = "frontend_nsg01"      # 👈 Add this
    vm_name             = "frontend_VM01"       # 👈 Add this

    allocation_method   = "Static"
    sku                 = "Standard"

    tags = {
      env        = "dev"
      managed_by = "Terraform"
      owner      = "shyamu"
    }

    size                          = "Standard_F2"
    admin_username                = "Infraadmin1"
    admin_password                = "Infra_1234"
    disable_password_authentication = false

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    version   = "latest"
  }
    vm02 = {
    name                = "backend_VM01"
    location            = "centralindia"
    resource_group_name = "todo_Infra_rg01"

    nic_name            = "backend_nic01"      # 👈 Add this
    nsg_name            = "backend_nsg01"      # 👈 Add this
    vm_name             = "backend_VM01"       # 👈 Add this

    allocation_method   = "Static"
    sku                 = "Standard"

    tags = {
      env        = "dev"
      managed_by = "Terraform"
      owner      = "shyamu"
    }

    size                          = "Standard_F2"
    admin_username                = "Infraadmin2"
    admin_password                = "Infra_12345"
    disable_password_authentication = false

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    version   = "latest"
  }
}



key_vaults = {
  k1 = {
    name                        = "devinfra-kv-001"
    location                    = "centralindia"
    resource_group_name         = "infra-rg-001"
    enabled_for_disk_encryption = true
    tenant_id                   = "cffcc9a9-94fe-4afc-9989-213fb9f99086"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true
    sku_name                    = "standard"
    access_policies = {
      a1 = {
        tenant_id = "cffcc9a9-94fe-4afc-9989-213fb9f99086"
        object_id = "752d426a-c3e1-478e-bfaa-6fc8b5d611f2"

        key_permissions     = ["Get"]
        secret_permissions  = ["Get"]
        storage_permissions = ["Get"]
      }
    }
  }
}

bastions = {
  vnet1 = {
    name                = "dev-bastion-001"
    location            = "centralindia"
    resource_group_name = "todo_Infra_rg01"
  }
}