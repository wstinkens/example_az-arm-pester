$TemplatePath = (Split-Path $myInvocation.MyCommand.Path) + "\" + "parameters.json"

$module = Get-Module Pester
if (-not $module){
    Write-Verbose "Installing Pester module"
    Install-Module pester -Force
}
Write-Verbose "Importing Pester module"
Import-Module Pester

$templateARM = Get-Content $TemplatePath -Raw -ErrorAction SilentlyContinue
$template = ConvertFrom-Json -InputObject $templateARM -ErrorAction SilentlyContinue

Describe 'ARM Parameters Validation' {
	Context 'File Validation' {
		It 'Parameters ARM File Exists' {
			Test-Path $TemplatePath -Include '*.json' | Should Be $true
		}

		It 'Is a valid JSON file' {
			$templateARM | ConvertFrom-Json -ErrorAction SilentlyContinue | Should Not Be $Null
	  }
  }
}