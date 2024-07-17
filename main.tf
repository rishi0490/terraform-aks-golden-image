# Define the resource group with a fixed name
resource "azurerm_resource_group" "rg" {
  name     = "rg-dev-env-persistent"
  location = var.resource_group_location  # Use your preferred location here
}

# Define the AKS cluster with a fixed name and reference the fixed resource group
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "aks-persistent-dev-env-golden-image"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-persistent-dev-env-golden-image"  # Use a suitable DNS prefix

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey  # Update as per your SSH key setup
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

# Create a managed disk from snapshot with fixed details
resource "azurerm_managed_disk" "golden_image_disk" {
  name                 = "golden-image-disk"
  location             = azurerm_resource_group.rg.location  # Ensure to use the same location as the resource group
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Copy"
  disk_size_gb         = 30
  source_resource_id   = "/subscriptions/69f97305-29d1-4c9c-905e-822101d326d5/resourceGroups/rg-for-persistant-system-dev-env-golden-aks/providers/Microsoft.Compute/disks/managed-disk-for-goldenvm-from-snapshot"
}

# Define AKS node pool with fixed details
resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  name                  = "agentpool"
  vm_size               = "Standard_D2_v2"
  node_count            = 3
  node_labels = {
    "nodepool-type" = "golden-image"
  }

  tags = {
    Environment = "dev"
  }
}
