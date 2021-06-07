// Define Networkin parameters
param vnetName string
param vnetaddressPrefix string
param subnetPrefix string
param vnetLocation string = 'westeurope'
param subnetName string = 'WVD'

//Create Vnet and Subnet
resource vnet 'Microsoft.Network/virtualNetworks@2019-12-01' = {
  name: vnetName
  location: vnetLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetaddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

//Create NSG
resource symbolicname 'Microsoft.Network/networkSecurityGroups@2020-07-01' = {
  name: '${vnetName}NSG'
  location: vnetLocation
}

output subnetId string = vnet.properties.subnets[0].id
output vnetId string = vnet.id
