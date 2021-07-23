########################################
## Receipe 002
## One scriptblock to pipe them all ...
########################################

## First things first: lets create some objects
$characters = @'
Name, FirstAppearance
Charlie Brown,1950
Snoopy,1950
Schroeder,1951
Lucy van Pelt,1952
Linus van Pelt,1952
Sally Brown,1959
Peppermint Patty,1966
Woodstock,1966
Marcie,1971
Rerun van Pelt,1972
Spike,1975
'@ | ConvertFrom-Csv

## TRY 
$characters | ForEach-Object -Process {
    "$($psitem.name) appeared in $($psitem.FirstAppearance) for the first time."
} | Write-Host -ForegroundColor (Get-Random -Minimum 1 -Maximum 14) -BackgroundColor (Get-Random -Minimum 1 -Maximum 14)

## CRY 
foreach ($character in $characters) {
    "$($character.name) appeared in $($character.FirstAppearance) for the first time."
} | Write-Host -ForegroundColor (Get-Random -Minimum 1 -Maximum 14) -BackgroundColor (Get-Random -Minimum 1 -Maximum 14)

## FINALLY: "One Scriptblock to rule them all .."
& {
    foreach ($character in $characters) {
        "$($character.name) appeared in $($character.FirstAppearance) for the first time."
    }
} | Write-Host -ForegroundColor (Get-Random -Minimum 1 -Maximum 14) -BackgroundColor (Get-Random -Minimum 1 -Maximum 14)

<#
    Epilogue: 

    ForEach-Object is an important cmdlet, it's in the DNA of PowerShell. It supports the pipeline in/out and the 
    automatic variable $_ / $psitem. It's not performance optimized in first place, it's resource-saving. 

    Sove devs don't like Foreach-Object; they stick to the well-known foreach loop, but this item does not support
    the pipeline .. until you use a scriptblock to wrap it all. 

    Credits go to @TobiasPSP for hightlighting this workaround and @concentrateddon for his persistent use of $psitem.     

#>
