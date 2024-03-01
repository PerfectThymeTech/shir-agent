resource "azurerm_container_group" "container_group" {
  name                = "${local.prefix}-aci001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = var.tags
  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.user_assigned_identity.id
    ]
  }

  container { # Todo
    commands     = []
    cpu          = "1.0"
    cpu_limit    = "3.0"
    memory       = "2.0"
    memory_limit = "4.0"
    image        = var.container_image_reference
    name         = "shir"
    ports {
      port     = 8060
      protocol = "TCP"
    }
    environment_variables = [
      #   { # Use default hostname value instead of manual value
      #     "NODE_NAME" = azurerm_data_factory_integration_runtime_self_hosted.data_factory_integration_runtime_self_hosted.name
      #   },
      {
        "ENABLE_HA" = "false"
      },
      {
        "HA_PORT" = "8060"
      },
      {
        "ENABLE_AE" = "false"
      },
      {
        "AE_TIME" = "600"
      },
    ]
    secure_environment_variables = [
      {
        "AUTH_KEY" = azurerm_data_factory_integration_runtime_self_hosted.data_factory_integration_runtime_self_hosted.primary_authorization_key
      }
    ]
    security {
      privilege_enabled = false
    }
    # volume {
    #   # Not supported for windows today
    # }
  }
  diagnostics {
    log_analytics {
      log_type      = "ContainerInsights"
      workspace_id  = data.azurerm_log_analytics_workspace.log_shared.workspace_id
      workspace_key = data.azurerm_log_analytics_workspace.log_shared.primary_shared_key
    }
  }
  dns_config { # Todo
    nameservers    = var.dns_server_ips
    # options        = []
    # search_domains = []
  }
  # dns_name_label = "${local.prefix}-pip001"   # Not required for Private
  # dns_name_label_reuse_policy = "TenantReuse" # Not required for Private
  exposed_port = []
  # image_registry_credential { # Todo for private container registry
  #   server                    = ""
  #   username                  = ""
  #   password                  = ""
  #   user_assigned_identity_id = azurerm_user_assigned_identity.user_assigned_identity.id
  # }
  ip_address_type = "Private"
  os_type         = "Windows"
  priority        = "Regular"
  restart_policy  = "OnFailure"
  sku             = "Standard"
  subnet_ids = [
    azapi_resource.subnet_container.id
  ]
  # zones = [ # Not supported for vnet injected container instances today
  #   "1",
  #   "2",
  #   "3"
  # ]
}
