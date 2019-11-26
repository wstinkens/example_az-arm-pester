# example_az-arm-pester

## Install Pester

```
Install-Module -Name Pester
Import-Module -Name Pester
```

## Usage

```
New-AzResourcegroup -Name example_az-arm-pester
```

```
$sshpubkey = ""
$SecurePassword = ConvertTo-SecureString $sshpubkey –asplaintext –force
```

```
Test-AzResourceGroupDeployment -ResourceGroupName "example_az-arm-pester" -TemplateFile "template.json" -TemplateParameterFile "parameters.json" -adminPublicKey $SecurePassword
```

```
./template.unit.test.ps1 -TemplatePath .\template.json
```


```
./template.integration.test.ps1 -ResourceGroupName example_az-arm-pester
```

```
New-AzResourceGroupDeployment -ResourceGroupName "example_az-arm-pester" -TemplateFile "template.json" -TemplateParameterFile "parameters.json" -adminPublicKey $SecurePassword
```
