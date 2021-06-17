// param location string = resourceGroup().location
// param namePrefix string = 'stg'
// param globalRedundancy bool = false 
// param currentYear string = utcNow('yyyy') // format utc time to year only
//
// var storageAccountName = '${namePrefix}${uniqueString(resourceGroup().id)}' // generates unique name based on resource group ID
//
// resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = if (currentYear == '2021') {
//   name: storageAccountName
//   location: location
//   kind: 'Storage' 
//   sku: {
//     name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS' // if true --> GRS, else --> LRS
//   }
// }

param storageAccountName string // need to be provided since it is existing

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageAccountName
}

param containerNames array = [
  'dogs'
  'cats'
  'fish'
]

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = [for name in containerNames: {
  name: '${stg.name}/default/${name}'
// dependsOn will be added when the template is compiled
}]

output storageId string = stg.id // output resourceId of storage account
output computedStorageName string = stg.name
output blobEndpoint string = stg.properties.primaryEndpoints.blob // replacement for reference(...).*
output containerProps array = [for i in range(0, length(containerNames)): blob[i].id]

