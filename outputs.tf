output "dapr_components" {
  description = "A map of dapr components connected to this environment. The map key is the supplied input to var.storages. The map value is the azurerm-formatted version of the entire dapr_components resource."
  value       = local.dapr_component_outputs
}

output "id" {
  description = "The ID of the resource."
  value       = azapi_resource.this_environment.id
}

output "name" {
  description = "The name of the resource"
  value       = azapi_resource.this_environment.name
}

output "resource" {
  description = "The Container Apps Managed Environment resource."
  value = {
    id                  = azapi_resource.this_environment.id
    name                = azapi_resource.this_environment.name
    resource_group_name = data.azurerm_resource_group.parent.name
    location            = azapi_resource.this_environment.location

    # outputs provided by the AzureRM provider
    dapr_application_insights_connection_string = try(azapi_resource.this_environment.output.properties.daprAIConnectionString, null)
    infrastructure_subnet_id                    = try(azapi_resource.this_environment.output.properties.vnetConfiguration.infrastructureSubnetId, null)
    internal_load_balancer_enabled              = try(azapi_resource.this_environment.output.properties.vnetConfiguration.internal, null)
    log_analytics_workspace_id                  = try(azapi_resource.this_environment.output.properties.appLogsConfiguration.logAnalyticsConfiguration.customerId, null)
    tags                                        = try(azapi_resource.this_environment.tags, null)
    workload_profiles                           = local.workload_profile_outputs
    zone_redundancy_enabled                     = try(azapi_resource.this_environment.output.properties.zoneRedundant, null)

    # outputs provided by the AzureRM provider known after apply
    default_domain                   = azapi_resource.this_environment.output.properties.defaultDomain
    docker_bridge_cidr               = try(azapi_resource.this_environment.output.properties.vnetConfiguration.dockerBridgeCidr, null)
    platform_reserved_cidr           = try(azapi_resource.this_environment.output.properties.vnetConfiguration.platformReservedCidr, null)
    platform_reserved_dns_ip_address = try(azapi_resource.this_environment.output.properties.vnetConfiguration.platformReservedDnsIP, null)
    static_ip_address                = azapi_resource.this_environment.output.properties.staticIp

    # additional outputs not yet supported by the AzureRM provider
    custom_domain_verification_id          = try(azapi_resource.this_environment.output.properties.customDomainConfiguration.customDomainVerificationId, null)
    dapr_azure_monitor_instrumentation_key = try(azapi_resource.this_environment.output.properties.daprAIInstrumentationKey, null)
    infrastructure_resource_group          = try(azapi_resource.this_environment.output.properties.infrastructureResourceGroup, null)
    mtls_enabled                           = try(azapi_resource.this_environment.output.properties.peerAuthentication.mtls.enabled, false)
  }
}

output "storages" {
  description = "A map of storage shares connected to this environment. The map key is the supplied input to var.storages. The map value is the azurerm-formatted version of the entire storage shares resource."
  value       = local.storages_outputs
}
