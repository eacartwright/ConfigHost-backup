$logFile = "{0}\GUI.log" -f [System.Environment]::GetFolderPath("Desktop")
Start-Transcript -Path $logFile

Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Controls.Add((New-Object System.Windows.Forms.Button -Property @{
            Text      = "PRESS ME"
            Width     = 100
            Height    = 100
            Add_Click = {
                Write-Output "1: Output message"
                Write-Error "2: Error message"
                Write-Warning "3: Warning message"
                Write-Verbose "4: Verbose message"
                Write-Debug "5: Debug message"
                Write-Information "6: Information message"
                Write-Host "Host message"
            }
        }))
$form.ShowDialog()
Stop-Transcript

<#
$VerbosePreference = 'Continue'
$DebugPreference = 'Continue'

function Write-Messages {
    Write-Output "1: Output message"
    Write-Error "2: Error message"
    Write-Warning "3: Warning message"
    Write-Verbose "4: Verbose message"
    Write-Debug "5: Debug message"
    Write-Information "6: Information message"
    Write-Host "Host message"
}

Write-Messages > OutputFile.txt
#>