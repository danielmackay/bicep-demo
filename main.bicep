param location string = resourceGroup().location
param namePrefix string = 'stg'
param globalRedundancy bool = false 

var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}' // generates unique name based on resource group ID

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'Storage' 
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS' // if true --> GRS, else --> LRS
  }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${stg.name}/default/logs'
// dependsOn will be added when the template is compiled
}

output storageId string = stg.id // output resourceId of storage account
output computedStorageName string = stg.name
output blobEndpoint string = stg.properties.primaryEndpoints.blob // replacement for reference(...).*

