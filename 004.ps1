####################################
## Receipe 004
## In search of the SANDBOX feature
####################################

## TRY 
Get-WindowsOptionalFeature -Online | Out-GridView -PassThru 

## CRY 
Get-WindowsOptionalFeature -Online -FeatureName '*Sandbox*'
Get-WindowsOptionalFeature -Online | Where-Object -FilterScript { $_.DisplayName -like '*Sandbox*'}

## CATCH
Get-WindowsOptionalFeature -Online -FeatureName * | Where-Object -FilterScript { $_.DisplayName -like '*Sandbox*'}

## FINALLY 
Enable-WindowsOptionalFeature -FeatureName 'Containers-DisposableClientVM' -NoRestart 
Get-WindowsOptionalFeature -Online -FeatureName * | Out-GridView -PassThru | Enable-WindowsOptionalFeature -Online -NoRestart 

<#
    WtF/Explanation

    The *-WindowsOptionalFeature cmdlets are nothing else than (poorly written) wrappers for dism.exe: 
    dism.exe /Online /Enable-Feature /FeatureName:'Containers-DisposableClientVM'
   
    dism.exe allows the modification of the running OS ("/Online") or a given WIM file ("/Image"). 

    For reasons that are a mystery to me, "Get-WindowsOptionalFeature" delivers a subset of information, 
    not including the Displayname property:
    Get-WindowsOptionalFeature -Online | Get-Member 
    => Microsoft.Dism.Commands.BasicFeatureObject

    You need to add the "-FeatureName" parameter, if you (also) want to search the Displayname property:
    Get-WindowsOptionalFeature -Online -FeatureName * | Get-Member 
    => Microsoft.Dism.Commands.AdvancedFeatureObject

    Final thoughts: 
    If you think it's a little too harsh to call these Cmdlets "poorly written", try this: 
    Enable-WindowsOptionalFeature -FeatureName 'Containers-DisposableClientVM' -NoRestart -WhatIf
    Enable-WindowsOptionalFeature -FeatureName 'Containers-DisposableClientVM' -NoRestart -Confirm

    "If life were easy, it wouldn't be difficult."
    Kermit The Frog 

#>
