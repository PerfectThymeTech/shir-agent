resource "azurerm_resource_group" "resource_group" {
  name     = "${local.prefix}-shir-rg"
  location = var.location
  tags     = var.tags
}
