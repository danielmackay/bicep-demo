param location string = resourceGroup().location
param namePrefix string = 'contoso'
param production bool = false

var storageName_var = '${namePrefix}${uniqueString(resourceGroup().id)}st'

resource storageName 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName_var
  location: location
  kind: 'Storage'
  sku: {
    name: (production ? 'Standard_ZRS' : 'Standard_LRS')
  }
}