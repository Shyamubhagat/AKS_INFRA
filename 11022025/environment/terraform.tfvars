rgs = {
  rg1 = {
    name     = "infra-rg-001"
    location = "centralindia"
  }
  rg2 = {
    name     = "infra-rg-002"
    location = "centralindia"

  }
}

stg = {
  stg1 = {

    name                     = "infrastorageacct001"
    resource_group_name      = "infra-rg-001"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  stg2 = {

    name                     = "infrastorageacct002"
    resource_group_name      = "infra-rg-002"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

}


infra_containers = {
  "container1" = {
    name                  = "infracontainer001"
    storage_account_name  = "infrastorageacct001"
    container_access_type = "private"
  }
  "container2" = {
    name                  = "infracontainer002"
    storage_account_name  = "infrastorageacct002"
    container_access_type = "private"
  }
}

vnet = {
  "vnet1" = {
    name                = "infravnet001"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    address_space       = ["10.0.0.0/16"]
    subnets = {
      "subnet1" = {
        name             = "frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
    }
    subnet2 = {
        name             = "backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
    }
  }

}
}

nics = {
  "nic-frontend-vm-01" = {
    name                = "nic-frontend-vm-01"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    ip_configuration = {
      name                          = "ipconfig1"
      subnet_id                     = "/subscriptions/<subscription_id>/resourceGroups/infra-rg-001/providers/Microsoft.Network/virtualNetworks/infravnet001/subnets/frontend-subnet"
      private_ip_address_allocation = "Dynamic"
    }
  }
 
}

infra_pips = {
  "pip1" = {
    name                = "Infra-pip-001"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    allocation_method   = "Dynamic"
  }
  "pip2" = {
    name                = "Infra-pip-002"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    allocation_method   = "Dynamic"
  }
}

vms = {
  vm1 = {
    name                = "infra-vm-001"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    nic_id              = "nic-frontend-vm-01"
    size                = "Standard_DS1_v2"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd123!"
  }
  vm2 = {
    name                = "infra-vm-002"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    nic_id              = "nic-frontend-vm-01"
    size                = "Standard_DS1_v2"
    admin_username      = "azureuser"
    admin_password      = "P@ssw0rd123!"
  }
}

infra_key_vaults = {
  kv1 = {
    name                = "infrakeyvault001"
    location            = "centralindia"
    resource_group_name = "infra-rg-001"
    sku_name            = "standard"
    tenant_id           = "your-tenant-id"
  
    access_policies = {
      tenant_id           = "data.azurerm_client_config.current.tenant_id"
      object_id           = "your-object-id"
      key_permissions     = ["get", "list"]
      secret_permissions  = ["get", "list"]
      storage_permissions = ["get", "list"]
    
    }
  }
}