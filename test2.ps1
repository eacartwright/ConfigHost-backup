function FunkyMonkey {
    [int]$script:Monkey = $null

    $Monkey
    $Monkey = 1
    $script:Monkey = 2
    #$Monkey    
}

FunkyMonkey
Write-Host "$Monkey"
