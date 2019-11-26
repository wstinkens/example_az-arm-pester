param (
	[Parameter(Mandatory=$true)]
	[string]$TemplatePath 
)

$module = Get-Module Pester
if (-not $module){
    Write-Verbose "Installing Pester module"
    Install-Module pester -Force
}
Write-Verbose "Importing Pester module"
Import-Module Pester

$templateARM = Get-Content $TemplatePath -Raw -ErrorAction SilentlyContinue
$template = ConvertFrom-Json -InputObject $templateARM -ErrorAction SilentlyContinue

Describe 'ARM Template Validation' {
	Context 'File Validation' {
		It 'Template ARM File Exists' {
			Test-Path $TemplatePath -Include '*.json' | Should Be $true
		}

		It 'Is a valid JSON file' {
			$templateARM | ConvertFrom-Json -ErrorAction SilentlyContinue | Should Not Be $Null
	  }
  }
    Context 'Template Content Validation' {
      It "Contains all required elements" {
          $Elements = '$schema',
                      'contentVersion',
                      'outputs',
                      'parameters',
                      'resources',
                      'variables'                               
            $templateProperties = $template | Get-Member -MemberType NoteProperty | % Name
            $templateProperties | Should Be $Elements
        }
        It "Creates the expected resources" {
            $Elements = 'Microsoft.Network/networkInterfaces',
                        'Microsoft.Network/networkSecurityGroups', 
                        'Microsoft.Network/virtualNetworks', 
                        'Microsoft.Network/publicIpAddresses', 
                        'Microsoft.Compute/virtualMachines'
            $templateResources = $template.Resources.type
            $templateResources | Should Be $Elements
        }
  
    }
}