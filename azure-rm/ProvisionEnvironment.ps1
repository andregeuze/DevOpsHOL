$ErrorActionPreference = "stop"

$ResourceGroupName = "DevOpsHOL"
$ResourceGroupLocation = "West Europe"
$subscriptionName = "Services"

# Login and select subscription
if (Get-AzureRmContext | ForEach-Object { $_.Name -eq "Default" }) {
    Connect-AzureRmAccount | Out-Null
}
else {
    Get-AzureRmContext | Out-Null
}
Select-AzureRmSubscription -SubscriptionName $subscriptionName

"Creating new resource group for the lab..."
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Force

"Deploy the lab using an ARM template"
New-AzureRmResourceGroupDeployment `
    -Name "DevTestLab-DevOpsHOL" `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile .\json\devtestlab.json `
    -TemplateParameterFile .\json\devtestlab.parameters.json `
    -Verbose

"Deploy the lab VM using an ARM template"
New-AzureRmResourceGroupDeployment `
    -Name "VM-DevOpsHOL" `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile .\json\vm.json `
    -TemplateParameterFile .\json\vm.parameters.json `
    -Verbose
