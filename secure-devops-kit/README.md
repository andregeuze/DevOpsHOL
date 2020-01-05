# Secure DevOps Kit for Azure

This lab contains instructions to explore the possibilities of the Micorosoft Secure DevOps kit. This kit contains several tools to scan and monitor security in Azure in the following categories:
- Subscription Security
- Secure Development
- Security in CICD
- Continuous Assurance
- Alerting & Monitoring
- Cloud Risk Governance

This instructions are based on the following documentation
- [Getting started with the Secure DevOps Kit for Azure!](https://azsk.azurewebsites.net/00b-Getting-Started/Readme.html)

## Prerequisites
- PowerShell installed on local machine
- Active Azure subscription

## Preparations
1. Install Azure CLI on your local machine
    1. Open PowerShell prompt
    1. Execute the command: `Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'` this will install the Azure CLI on your local machine

1. Make sure you have the right PowerShell version
    - The Secure DevOps Kit requires PowerShell version 5.0 or higher
    - You can easily check the current installed PowerShell version by executing the following command in Powershell: `$PSVersionTable`
    - If your PowerShell version is not 5.0 or higher, please make sure that your PowerShell will be updated to 5.0 or higher

1. Install Secure DevOps Kit on your local machine
    1. Open PowerShell prompt and execute the command: `Install-Module AzSK -Scope CurrentUser`
    1. When the installation is finished you can easily check if the Secure DevOps Kit is correctly installed by executing the command: `azsk`. If the Secure DevOps Kit is correctly installed it will show all available commands.


## Run the Subscription Security Report (Subscription Security)
The Subscription Security Report will scan your Azure subscription on security issues.

1. Open a PowerShell prompt
1. The PowerShell prompt must be connected to your Azure environment before you can run the report. To connect the prompt with Azure execute the command: `Add-AzureAccount`. 
1. For running the Subscription Security Report you must known your subscription id. By executing the command: `Get-AzureSubscription` you can view your subscription details.
1. Now run the Subscription Security Report with the command: `Get-AzSKSubscriptionSecurityStatus -SubscriptionId <your subscription id>`
1. After the scan is completed a new file explorer will open with the scan results. Open the .csv file and examine the scan results.

## Run Azure Services Security Report (Subscription Security / Secure Development)
The Azure Services Security Report will scan your Azure resources on security issues.

1. Open a PowerShell prompt
1. The PowerShell prompt must be connected to your Azure environment before you can run the report. To connect the prompt with Azure execute the command: `Add-AzureAccount`. 
1. For running the Azure Services Security Report you must known your subscription id. By executing the command: `Get-AzureSubscription` you can view your subscription details.
1. Now run the Subscription Security Report with the command: `Get-AzSKAzureServicesSecurityStatus -SubscriptionId <your subscription id>`
1. After the scan is completed a new file explorer will open with the scan results. Open the .csv file and examine the scan results.

## Setup a Log Analytics workspace (Alerting & Monitoring)
A Log Analytics workspace is an Azure resource which can be used to easily anlyze all the Secure DevOps Kit events.

1. Using the [Azure Portal](https://portal.azure.com), create a new Log Analytics workspace.
1. Open a PowerShell prompt and make sure that the prompt is connected with Azure
1. Connect your local machine to the Log Analytics workspace by execute the command: `Set-AzSKMonitoringSettings -WorkspaceID <your workspace id> -SharedKey <your shared key>`. The workspaceID and SharedKey can be found in Azure at your Log Analytics workspace --> Advanced settings.
1. Now generate a new event by execute the command: `Get-AzSKAzureServicesSecurityStatus -SubscriptionId <your subscription id>`
1. Go back to the [Azure Portal](https://portal.azure.com) and your Log Analytics workspace. There go to Search and execute the search query: `search * | where type == "AzSK_CL"`. This will show your recently generated event and all the other events as well.