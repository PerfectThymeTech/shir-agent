# General variables
location    = "northeurope"
environment = "dev"
prefix      = "shir"
tags = {
  workload = "shir-runners"
}
log_analytics_workspace_id = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/DefaultResourceGroup-NEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-8f171ff9-2b5b-4f0f-aed5-7fa360a1d094-NEU"

# SHIR variables

# Container variables
container_image_reference = "ghcr.io/perfectthymetech/shiragentazure:main"

# Network variables
vnet_id                          = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-dpml-network-rg/providers/Microsoft.Network/virtualNetworks/mycrp-prd-dpml-vnet001"
nsg_id                           = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-dpml-network-rg/providers/Microsoft.Network/networkSecurityGroups/mycrp-prd-dpml-nsg001"
route_table_id                   = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-dpml-network-rg/providers/Microsoft.Network/routeTables/mycrp-prd-dpml-rt001"
subnet_cidr_container            = "10.0.96.64/27"
subnet_cidr_private_endpoints    = "10.0.96.96/27"
private_dns_zone_id_key_vault    = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-global-dns/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
private_dns_zone_id_data_factory = "/subscriptions/8f171ff9-2b5b-4f0f-aed5-7fa360a1d094/resourceGroups/mycrp-prd-global-dns/providers/Microsoft.Network/privateDnsZones/privatelink.datafactory.azure.net"
dns_server_ips = [
  "10.0.0.4"
]
