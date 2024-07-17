output "resource_group_name" {
  value = "rg-dev-env-persistent"  # Fixed resource group name
}

output "kubernetes_cluster_name" {
  value = "aks-persistent-dev-env-golden-image"  # Fixed AKS cluster name
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].password
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].username
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].host
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

output "node_pool_name" {
  value = azurerm_kubernetes_cluster_node_pool.node_pool.name
}

output "node_pool_id" {
  value = azurerm_kubernetes_cluster_node_pool.node_pool.id
}

output "node_pool_vm_size" {
  value = azurerm_kubernetes_cluster_node_pool.node_pool.vm_size
}

output "node_pool_node_count" {
  value = azurerm_kubernetes_cluster_node_pool.node_pool.node_count
}

output "node_pool_tags" {
  value = azurerm_kubernetes_cluster_node_pool.node_pool.tags
}
