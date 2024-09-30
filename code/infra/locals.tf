locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.environment}"
  resource_providers_to_register = [
    "Microsoft.Authorization",
    "Microsoft.Web",
    "Microsoft.Insights",
    "Microsoft.KeyVault",
    "Microsoft.ManagedIdentity",
    "Microsoft.Network",
    "Microsoft.Resources",
  ]

  # Container locals
  container_registry_url   = split("/", var.container_image_reference)[0]
  container_registry_image = trimprefix(var.container_image_reference, "${local.container_registry_url}/")

  # Resource locals
  virtual_network = {
    resource_group_name = split("/", var.vnet_id)[4]
    name                = split("/", var.vnet_id)[8]
  }
  network_security_group = {
    resource_group_name = split("/", var.nsg_id)[4]
    name                = split("/", var.nsg_id)[8]
  }
  route_table = {
    resource_group_name = split("/", var.route_table_id)[4]
    name                = split("/", var.route_table_id)[8]
  }
  log_analytics_workspace = {
    subscription_id     = split("/", var.log_analytics_workspace_id)[2]
    resource_group_name = split("/", var.log_analytics_workspace_id)[4]
    name                = split("/", var.log_analytics_workspace_id)[8]
  }

  # Logging locals
  diagnostics_configurations = [
    {
      log_analytics_workspace_id = var.log_analytics_workspace_id
      storage_account_id         = ""
    }
  ]

  # CMK locals
  customer_managed_key = null
}
