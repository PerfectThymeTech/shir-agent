# User Assigned Identity
resource "azurerm_role_assignment" "uai_role_assignment_key_vault_secrets_user" {
  description          = "Required for Web App to access secrets via Key Vault references."
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.user_assigned_identity.user_assigned_identity_principal_id
  principal_type       = "ServicePrincipal"
}
