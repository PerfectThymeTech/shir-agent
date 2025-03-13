resource "azurerm_data_factory" "data_factory" {
  name                = "${local.prefix}-adf001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = var.tags
  identity {
    type = "SystemAssigned"
  }

  managed_virtual_network_enabled = true
  public_network_enabled          = false
}


data "azurerm_monitor_diagnostic_categories" "diagnostic_categories_data_factory" {
  resource_id = azurerm_data_factory.data_factory.id
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting_data_factory" {
  name                       = "logAnalytics"
  target_resource_id         = azurerm_data_factory.data_factory.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_categories_data_factory.log_category_groups
    content {
      category_group = entry.value
    }
  }

  dynamic "metric" {
    iterator = entry
    for_each = data.azurerm_monitor_diagnostic_categories.diagnostic_categories_data_factory.metrics
    content {
      category = entry.value
      enabled  = true
    }
  }
}

resource "azurerm_private_endpoint" "data_factory_private_endpoint" {
  name                = "${azurerm_data_factory.data_factory.name}-pe"
  location            = var.location
  resource_group_name = azurerm_data_factory.data_factory.resource_group_name
  tags                = var.tags

  custom_network_interface_name = "${azurerm_data_factory.data_factory.name}-nic"
  private_service_connection {
    name                           = "${azurerm_data_factory.data_factory.name}-pe"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    subresource_names              = ["dataFactory"]
  }
  subnet_id = azapi_resource.subnet_private_endpoints.id
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_id_data_factory == "" ? [] : [1]
    content {
      name = "${azurerm_data_factory.data_factory.name}-arecord"
      private_dns_zone_ids = [
        var.private_dns_zone_id_data_factory
      ]
    }
  }
}
