param (
	[Parameter(Mandatory=$true)]
	[string]$ResourceGroupName 
)

$resources = Get-AzResource -ResourceGroupName $ResourceGroupName

Describe 'ARM Deployment Validation' {
    Context 'Template Deployment Validation' {
        It "Created the expected resources" {
            $Elements = 'Microsoft.Compute/disks',
                        'Microsoft.Compute/virtualMachines',
                        'Microsoft.Network/networkInterfaces',
                        'Microsoft.Network/networkSecurityGroups', 
                        'Microsoft.Network/publicIpAddresses',
                        'Microsoft.Network/virtualNetworks'
                                       
            $templateResources = $resources.ResourceType
            $templateResources | Should Be $Elements
        }
    }
}