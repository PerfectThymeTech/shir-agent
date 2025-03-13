resource "azapi_resource" "subnet_container" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
  name      = "ContainerSubnetShir"
  parent_id = data.azurerm_virtual_network.virtual_network.id

  body = {
    properties = {
      addressPrefix = var.subnet_cidr_container
      delegations = [
        {
          name = "ContainerDelegation"
          properties = {
            serviceName = "Microsoft.Web/serverfarms"
          }
        }
      ]
      ipAllocations = []
      networkSecurityGroup = {
        id = data.azurerm_network_security_group.network_security_group.id
      }
      privateEndpointNetworkPolicies    = "Enabled"
      privateLinkServiceNetworkPolicies = "Enabled"
      routeTable = {
        id = data.azurerm_route_table.route_table.id
      }
      serviceEndpointPolicies = []
      serviceEndpoints        = []
    }
  }
}

resource "azapi_resource" "subnet_private_endpoints" {
  type      = "Microsoft.Network/virtualNetworks/subnets@2022-07-01"
  name      = "PrivateEndpointSubnetShir"
  parent_id = data.azurerm_virtual_network.virtual_network.id

  body = {
    properties = {
      addressPrefix = var.subnet_cidr_private_endpoints
      delegations   = []
      ipAllocations = []
      networkSecurityGroup = {
        id = data.azurerm_network_security_group.network_security_group.id
      }
      privateEndpointNetworkPolicies    = "Enabled"
      privateLinkServiceNetworkPolicies = "Enabled"
      routeTable = {
        id = data.azurerm_route_table.route_table.id
      }
      serviceEndpointPolicies = []
      serviceEndpoints        = []
    }
  }

  depends_on = [
    azapi_resource.subnet_container
  ]
}
