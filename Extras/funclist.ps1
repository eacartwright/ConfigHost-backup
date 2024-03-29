$scriptPath = 'C:\Dev\ConfigHost\ConfigHost.ps1'
(Get-ChildItem -Path $scriptPath -Recurse |
    Select-String -Pattern 'function') |
    ForEach-Object { $_.Line.Substring(9) } |
    Out-File -FilePath "$(Split-Path $scriptPath)\FuncList.txt"
