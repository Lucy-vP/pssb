##############################
## Receipe 003
## Fun with (Inner)Exceptions
##############################

## TRY 
Get-Date -Date 'Matryoshka' 

## CRY 
$Error[0].Exception.gettype().fullname                                # System.Management.Automation.ParameterBindingException
$Error[0].Exception.InnerException.gettype().fullname                 # System.Management.Automation.PSInvalidCastException
$Error[0].Exception.InnerException.InnerException.gettype().fullname  # System.FormatException

## FINALLY
function resolveErrorTypeRecursive {
    param (
        $exception 
    )
    ## Display (current) exception type
    $exception.GetType().fullname 
    
    ## Check if InnerException exists
    if ($exception.InnerException) {    
        resolveErrorTypeRecursive -exception $exception.InnerException
    }    
}

resolveErrorTypeRecursive -exception $error[0].Exception


## ONE MORE THING? 
try { Get-Date -Date 'Matryoshka' -ErrorAction Stop }
catch [System.Management.Automation.ParameterBindingException] { 1 }

try { Get-Date -Date 'Matryoshka' -ErrorAction Stop }
catch [System.Management.Automation.PSInvalidCastException] { 2 }

try { Get-Date -Date 'Matryoshka' -ErrorAction Stop }
catch [System.FormatException] { 3 }  # This should also be captured, right? 
finally { Write-Warning -Message 'The world is a messy place!' }

<#
    Epilogue: 

    "Exceptions can contain inner exceptions. This is often the case when the code you're calling catches an exception 
    and throws a different exception. The original exception is placed inside the new exception."
    https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-exceptions

    Lee Holmes published a receipe to handle this kind of nested errors where he utilizes a for-loop: 
    https://www.powershellcookbook.com/recipe/OkmH/program-resolve-an-error

    Lee's style: 
    $exception = $Error[0].Exception
    for ($i = 0; $exception; $i++, ($exception = $exception.InnerException)) {
        @{ $i = $exception.gettype().Fullname 
    }

    "FormatExceptions" can generally also be captured within a try/catch as you can see in the following example:    

    try { [datetime]::ParseExact('','yyyyMMddHHmmss',$null) }
    catch [System.Management.Automation.MethodInvocationException] { 4 }
    
    try { [datetime]::ParseExact('','yyyyMMddHHmmss',$null) }
    catch [System.FormatException] { 5 }

    about_Matryoshka 
    https://en.wikipedia.org/wiki/Matryoshka_doll
#>
