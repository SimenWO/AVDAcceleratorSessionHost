metadata name = 'Test AVM module as to create session host for replacer'

targetScope = 'subscription'

param time string = utcNow()


@sys.description('AVD workload subscription ID, multiple subscriptions scenario. (Default: "")')
param avdWorkloadSubsId string = ''


//
// Resource tagging
//

@sys.description('Apply tags on resources and resource groups. (Default: false)')
param createResourceTags bool = false

@sys.description('The name of workload for tagging purposes. (Default: Contoso-Workload)')
param workloadNameTag string = 'Contoso-Workload'

@allowed([
  'Light'
  'Medium'
  'High'
  'Power'
])
@sys.description('Reference to the size of the VM for your workloads (Default: Light)')
param workloadTypeTag string = 'Light'

@allowed([
  'Non-business'
  'Public'
  'General'
  'Confidential'
  'Highly-confidential'
])
@sys.description('Sensitivity of data hosted (Default: Non-business)')
param dataClassificationTag string = 'Non-business'

@sys.description('Department that owns the deployment, (Dafult: Contoso-AVD)')
param departmentTag string = 'Contoso-AVD'

@allowed([
  'Low'
  'Medium'
  'High'
  'Mission-critical'
  'Custom'
])
@sys.description('Criticality of the workload. (Default: Low)')
param workloadCriticalityTag string = 'Low'

@sys.description('Tag value for custom criticality value. (Default: Contoso-Critical)')
param workloadCriticalityCustomValueTag string = 'Contoso-Critical'

@sys.description('Details about the application.')
param applicationNameTag string = 'Contoso-App'

@sys.description('Service level agreement level of the worload. (Contoso-SLA)')
param workloadSlaTag string = 'Contoso-SLA'

@sys.description('Team accountable for day-to-day operations. (workload-admins@Contoso.com)')
param opsTeamTag string = 'workload-admins@Contoso.com'

@sys.description('Organizational owner of the AVD deployment. (Default: workload-owner@Contoso.com)')
param ownerTag string = 'workload-owner@Contoso.com'

@sys.description('Cost center of owner team. (Default: Contoso-CC)')
param costCenterTag string = 'Contoso-CC'


@sys.description('FQDN of on-premises AD domain, used for FSLogix storage configuration and NTFS setup. (Default: "")')
param identityDomainName string

@sys.description('Creates an availability zone and adds the VMs to it. Cannot be used in combination with availability set nor scale set. (Default: true)')
param useAvailabilityZones bool = true

@sys.description('Set to deploy image from Azure Compute Gallery. (Default: false)')
param useSharedImage bool = false

@sys.description('Name of the existing Azure Application Security Group to associate with the session host.')
param existingAsgName string

@sys.description('Name of the existing Azure Key Vault to use for storing secrets.')
param existingKvName string

@allowed([
  'win10_21h2'
  'win10_21h2_office'
  'win10_22h2_g2'
  'win10_22h2_office_g2'
  'win11_21h2'
  'win11_21h2_office'
  'win11_22h2'
  'win11_22h2_office'
  'win11_23h2'
  'win11_23h2_office'
])
@sys.description('AVD OS image SKU. (Default: win11-22h2)')
param avdOsImage string = 'win11_22h2'

@allowed([
  'ADDS' // Active Directory Domain Services
  'EntraDS' // Microsoft Entra Domain Services
  'EntraID' // Microsoft Entra ID Join
])
@sys.description('The service providing domain services for Azure Virtual Desktop.')
param avdIdentityServiceProvider string

@allowed([
  'Dev' // Development
  'Test' // Test
  'Prod' // Production
])
@sys.description('The deployment environment. (Default: Dev)')
param deploymentEnvironment string = 'Dev'


@sys.description('Deploy Fslogix setup. (Default: false)')
param createAvdFslogixDeployment bool = false

@sys.description('Required, Eronll session hosts on Intune. (Default: false)')
param createIntuneEnrollment bool = false


@sys.description('Source custom image ID. (Default: "")')
param avdImageTemplateDefinitionId string = ''

@sys.description('Existing FSLogix storage resource ID.')
param fslogixStorageAccountName string = ''

@sys.description('Existing FSLogix file share name.')
param fslogixFileShareName string = ''

@sys.description('Specifies the securityType of the virtual machine. "ConfidentialVM" and "TrustedLaunch" require a Gen2 Image. (Default: TrustedLaunch)')
param securityType  string = 'TrustedLaunch'

@sys.description('Existing Azure log analytics workspace resource ID to connect to. (Default: "")')
param alaExistingWorkspaceResourceId string = ''

@sys.description('Specify the domainJoinUserName for the session host.')
param domainJoinUserName string = 'none'

@sys.description('Optional (Only used if you are deploying monitoring). Data collection rule ID to apply to the session host.')
param dataCollectionRuleId string = ''

@sys.description('Deploy AVD monitoring resources and setings. (Default: false)')
param deployMonitoring bool = false

@sys.description('Optional (Only used if you are using the zeroTrust part). Disk encryption set resource ID to use for the session host. (Default: "")')
param diskEncryptionSetResourceId string = ''

@sys.description('Optional (Only used if you are using the zeroTrust part). Specifies whether encryption should be enabled at host level. (Default: false)')
param encryptionAtHost bool = false

@sys.description('Specifies whether secure boot should be enabled on the virtual machine. This parameter is part of the UefiSettings. securityType should be set to TrustedLaunch or ConfidentialVM to enable UefiSettings. (Default: true)')
param secureBootEnabled bool = true

@sys.description('Specifies whether vTPM should be enabled on the virtual machine. This parameter is part of the UefiSettings. securityType should be set to TrustedLaunch or ConfidentialVM to enable UefiSettings. (Default: true)')
param vTpmEnabled bool = true

@sys.description('Optional. Custom OS Disk Size.')
param customOsDiskSizeGb string = ''

@sys.description('Name of the VM Scale Set Flex.')
param vmssFlexName string

param ImageReference object = {
  publisher: 'MicrosoftWindowsDesktop'
  offer: 'Windows-10'
  sku: '20h2-evd'
  version: 'latest'
}

//! Changed to fit with replacer hostpoolToken
@secure()
@sys.description('The token for the hostpool.')
param HostpoolToken string

//! Changed to fit with replacer hostpoolToken
@sys.description('Name of the VMs to deploy. Following the logic og the replacer.')
param VMNames array

//! Changed to fit with replacer Tags
param tags object = {

}
//! Changed to fit with replacer enableAcceleratedNetworking
@sys.description('''Enables accelerated Networking on the session hosts.
If using a Azure Compute Gallery Image, the Image Definition must have been configured with
the \'isAcceleratedNetworkSupported\' property set to \'true\'.
''')
param AcceleratedNetworking bool = true

//! Changed to fit with replacer existingHostPoolName
@sys.description('Name of the existing Host Pool to join the session host to.')
param HostPoolName string

//! Changed to fit with replacer avdVmLocalUserName
@sys.description('AVD session host local username.')
param AdminUsername string

@sys.description('Required. OU Path for the session hosts.')
param sessionHostOuPath string = ''

//! Changed to fit with replacer serviceObjectsRgName
@sys.description('Required. The name of the resource group where the service objects are located.')
param HostPoolResourceGroupName string

//! Changed to fit with replacer computeObjectsRgName
@sys.description('Required. The name of the resource group where the compute objects are located.')
param SessionHostResourceGroupName string

//! Changed to fit with replacer SubnetID
@sys.description('Subnet ID for your azure virtual desktop deployment.')
param SubnetID string

//! Changed to fit with replacer avdSessionHostsSize
@sys.description('Session host VM size.')
param VMSize string

//! Changed to fit with replacer diskType
@sys.description('OS disk type for session host. (Default: Premium_LRS)')
param DiskType string = 'Premium_LRS'

//! Changed to fit with replacer avdSessionHostLocation
@sys.description('Location where to deploy compute services. (Default: eastus2)')
param Location string = 'eastus2'

// -----------------
// Variables
// -----------------


var varBaseScriptUri = 'https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/'
var varSessionHostConfigurationScriptUri = '${varBaseScriptUri}scripts/Set-SessionHostConfiguration.ps1'
var varLocations = loadJsonContent('modules/variables/locations.json')
var varMarketPlaceGalleryWindows = loadJsonContent('modules/variables/osMarketPlaceImages.json')
var varSessionHostLocationLowercase = toLower(replace(Location, ' ', ''))
var varTimeZoneSessionHosts = varLocations[varSessionHostLocationLowercase].timeZone
var varSessionHostConfigurationScript = './Set-SessionHostConfiguration.ps1'
var varFslogixStorageFqdn = createAvdFslogixDeployment
  ? '${fslogixStorageAccountName}.file.${environment().suffixes.storage}'
  : ''
var varFslogixSharePath = createAvdFslogixDeployment
  ? '\\\\${fslogixStorageAccountName}.file.${environment().suffixes.storage}\\${fslogixFileShareName}'
  : ''

var varCustomResourceTags = createResourceTags
  ? {
      WorkloadName: workloadNameTag
      WorkloadType: workloadTypeTag
      DataClassification: dataClassificationTag
      Department: departmentTag
      Criticality: (workloadCriticalityTag == 'Custom') ? workloadCriticalityCustomValueTag : workloadCriticalityTag
      ApplicationName: applicationNameTag
      ServiceClass: workloadSlaTag
      OpsTeam: opsTeamTag
      Owner: ownerTag
      CostCenter: costCenterTag
    }
  : {}

//Created to dump the image reference
var imagereftest = ImageReference

var varAvdDefaultTags = {
    'cm-resource-parent': '/subscriptions/${avdWorkloadSubsId}}/resourceGroups/${HostPoolResourceGroupName}/providers/Microsoft.DesktopVirtualization/hostpools/${HostPoolName}'
    Environment: deploymentEnvironment
    ServiceWorkload: 'AVD'
    CreationTimeUTC: time
  }


resource asg 'Microsoft.Network/applicationSecurityGroups@2023-11-01' existing = {
  name: existingAsgName
  scope: resourceGroup('${avdWorkloadSubsId}', '${SessionHostResourceGroupName}')
}


module sessionHosts './modules/avdSessionHosts/deploy.bicep' = [for vm in VMNames : {
    name: 'SH-Batch-${vm}'
    params: {
      diskEncryptionSetResourceId: diskEncryptionSetResourceId
      timeZone: varTimeZoneSessionHosts
      asgResourceId: asg.id
      identityServiceProvider: avdIdentityServiceProvider
      createIntuneEnrollment: createIntuneEnrollment
      vmssFlexName: vmssFlexName
      computeObjectsRgName: SessionHostResourceGroupName
      domainJoinUserName: domainJoinUserName
      wrklKvName: existingKvName
      serviceObjectsRgName: HostPoolResourceGroupName
      identityDomainName: identityDomainName
      avdImageTemplateDefinitionId: avdImageTemplateDefinitionId
      sessionHostOuPath: sessionHostOuPath
      diskType: DiskType
      customOsDiskSizeGB: customOsDiskSizeGb
      location: Location
      vmName: vm
      vmSize: VMSize
      enableAcceleratedNetworking: AcceleratedNetworking
      securityType: securityType == 'Standard' ? '' : securityType
      secureBootEnabled: secureBootEnabled
      vTpmEnabled: vTpmEnabled
      subnetId: SubnetID
      useAvailabilityZones: useAvailabilityZones
      vmLocalUserName: AdminUsername
      subscriptionId: avdWorkloadSubsId
      encryptionAtHost: encryptionAtHost
      createAvdFslogixDeployment: createAvdFslogixDeployment
      fslogixSharePath: varFslogixSharePath
      fslogixStorageFqdn: varFslogixStorageFqdn
      sessionHostConfigurationScriptUri: varSessionHostConfigurationScriptUri
      sessionHostConfigurationScript: varSessionHostConfigurationScript
      marketPlaceGalleryWindows: varMarketPlaceGalleryWindows[avdOsImage]
      useSharedImage: useSharedImage
      tags: createResourceTags ? union(varCustomResourceTags, varAvdDefaultTags, tags) : varAvdDefaultTags
      deployMonitoring: deployMonitoring
      alaWorkspaceResourceId: deployMonitoring
        ? alaExistingWorkspaceResourceId
        : ''
      dataCollectionRuleId: deployMonitoring ? dataCollectionRuleId : ''
      hostpoolToken: HostpoolToken
    }
  }
]
