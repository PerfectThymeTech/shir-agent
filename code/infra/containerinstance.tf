resource "azurerm_container_group" "container_group" {
  name                = "${local.prefix}-aci001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_container_app.name
  tags                = var.tags
  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.user_assigned_identity.id
    ]
  }

  container { # Todo
    commands = []
    cpu      = ""
    cpu_limit = ""
    memory = ""
    memory_limit = ""
    image = ""
    name = "shir"
    ports {
      port = 80
      protocol = "TCP"
    }
    environment_variables = [
      {
        "NODE_NAME" = ""
      },
      {
        "ENABLE_HA" = "false"
      },
      {
        "HA_PORT" = ""
      },
      {
        "ENABLE_AE" = ""
      },
      {
        "AE_TIME" = ""
      },
    ]
    secure_environment_variables = [
      {
        "AUTH_KEY" = ""
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
    nameservers    = []
    options        = []
    search_domains = []
  }
  # dns_name_label = "${local.prefix}-pip001"
  # dns_name_label_reuse_policy = "TenantReuse" # Todo
  exposed_port = []
  image_registry_credential { # Todo
    server                    = ""
    username                  = ""
    password                  = ""
    user_assigned_identity_id = azurerm_user_assigned_identity.user_assigned_identity.id
  }
  ip_address_type = "Private"
  os_type         = "Windows"
  priority        = "Regular"
  restart_policy  = "Always"
  # sku = "" # Only required for GPU
  subnet_ids = [
    azapi_resource.subnet_container.id
  ]
  zones = [
    "1",
    "2",
    "3"
  ]
}
