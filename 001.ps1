######################
## Receipe 001
## Fun-with-variables
######################

<#  

    Theoretical background: 

    (a) Variables and special characters
    "In fact, a variable name can contain literally any character you want, as long as you follow a couple of simple rules. There are two notations
    for variables. The simple notation starts with a dollar sign followed by a sequence of characters, which can include letters, numbers, the underscore, and the colon [..]
    The colon in a variable name is used as a drive separator [..], which requires enclosing the variable name in braces, allows you to use any character in a variable name"
    Payette, Siddaway: PowerShell in action (3rd ed)

    (b) Scopes  
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes

    (c) Remote variables
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_variables

#>


## Try
${global:test} = 42
Get-Variable -Name 'test'
function foo { ${test} }; foo
Start-Job -ScriptBlock { ${using:test} } | Wait-Job | Receive-Job
Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock { ${using:test} }

## Cry
${global:another-test} = 43
Get-Variable -Name 'another-test'
function foo { ${another-test} }; foo
Start-Job -ScriptBlock { ${using:another-test} } | Wait-Job | Receive-Job
Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock { ${using:another-test} }
