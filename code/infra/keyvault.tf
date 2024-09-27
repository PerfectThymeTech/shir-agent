module "key_vault" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/keyvault?ref=main"
  providers = {
    azurerm = azurerm
    time    = time
  }

  location                             = var.location
  resource_group_name                  = azurerm_resource_group.resource_group.name
  tags                                 = var.tags
  key_vault_name                       = "${local.prefix}-kv001"
  key_vault_sku_name                   = "standard"
  key_vault_soft_delete_retention_days = 7
  diagnostics_configurations           = local.diagnostics_configurations
  subnet_id                            = azapi_resource.subnet_private_endpoints.id
  connectivity_delay_in_seconds        = var.connectivity_delay_in_seconds
  private_dns_zone_id_vault            = var.private_dns_zone_id_key_vault
}

resource "azurerm_key_vault_secret" "key_vault_secret_shir_key" {
  name         = "datafactory-shir-auth-key"
  key_vault_id = module.key_vault.key_vault_id

  content_type = "text/plain"
  value        = azurerm_data_factory_integration_runtime_self_hosted.data_factory_integration_runtime_self_hosted.primary_authorization_key

  depends_on = [
    module.key_vault.key_vault_setup_completed,
    azurerm_role_assignment.current_role_assignment_key_vault_administrator,
  ]
}
