param location string = resourceGroup().location
param namePrefix string = 'stg'

param globalRedundancy bool = false 

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${namePrefix}${uniqueString(resourceGroup().id)}' // generates unique name based on resource group ID
  location: location
  kind: 'Storage' 
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS' // if true --> GRS, else --> LRS
  }
}

output storageId string = stg.id // output resourceId of storage account
