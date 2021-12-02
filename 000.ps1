#####################################################################
## Receipe 000
## Our role model Lee Holmes has dedicated this fun function to us:
## https://twitter.com/Lee_Holmes/status/1428510273309057026/photo/1
## Have a look at his marvellous cookbook:
## 💙 https://www.powershellcookbook.com 💙
#####################################################################

function curse { 
    param ($curse)
    $error | ForEach-Object -Process { & $curse }   
}

try {
    1/$null
    Get-Process -Name asdfafdasdfasdf
}
catch {
    'Oops!'
}
curse {
    'Dang it!'
}
