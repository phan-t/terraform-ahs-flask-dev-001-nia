data "azurerm_resource_group" "this" {
  name = element(local.rg_name, 0)
}

data "azurerm_firewall" "this" {
  name                = element(local.firewall_name, 0)
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_firewall_network_rule_collection" "this" {
  name                = element(local.service_name, 0)
  azure_firewall_name = data.azurerm_firewall.this.name
  resource_group_name = data.azurerm_resource_group.this.name
  priority            = 100
  action              = "Allow"

  rule {
    name = "https"

    source_addresses = local.service_ip_addresses

    destination_ports = local.service_ports

    destination_addresses = [
      "0.0.0.0",
    ]

    protocols = [
      "TCP",
    ]
  }
}