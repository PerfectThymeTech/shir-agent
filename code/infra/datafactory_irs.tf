resource "azurerm_data_factory_integration_runtime_self_hosted" "data_factory_integration_runtime_self_hosted" {
  name            = "SelfhostedIntegrationRuntime001"
  data_factory_id = azurerm_data_factory.data_factory.id

  description = "Self-Hosted Integration Runtime 001"

  depends_on = [
    azurerm_private_endpoint.data_factory_private_endpoint
  ]
}
