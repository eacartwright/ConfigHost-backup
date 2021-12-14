#$VerbosePreference = 'Continue'
#$DebugPreference = 'Continue'
$CompanyRoot = Split-Path $PSScriptRoot
$ConfigRoot = $PSScriptRoot
$ConfigScript = $PSCommandPath
$ConfigName = ($MyInvocation.MyCommand.Name).Replace('.ps1','')
$ConfigIni = "$ConfigRoot\$ConfigName.ini"
$ConfigLog = "$ConfigRoot\Logs\$ConfigName.log"
$DeploymentAssets = "$ConfigRoot\DeploymentAssets"
$Shortcuts = "$CompanyRoot\Shortcuts"
$ComputerPolicy = "$env:SystemRoot\System32\GroupPolicy\Machine\registry.pol"
$UserPolicy  = "$env:SystemRoot\System32\GroupPolicy\User\registry.pol"
$FormUpdated = $null
$PSCommandArgs = @()
$NewSettings = [ordered]@{}
$RegexSection = '^\[(.+)\]$'
$RegexFunction = '^\s*([^#[\n](?!=)\w+)$'
$RegexFunctionStrArg = '^\s*([^#].+?)\s*=\s*(.+)\s*$'
$RegexFunctionIntArg = '^\s*([^#].+?)\s*=\s*(\d+)\s*$'
$IgnoreSettings = @(
    'RequireAdmin'
    'ImportModule'
)
$Settings = [ordered]@{
    Computer = [ordered]@{
        RequireAdmin = $null
        ImportModule = 'PolicyFileEditor'
        SetThisPCLabel = $null
        DisableCheckForUpdates = $null
        DisableDefender = $null
        DisableSmartScreen = $null
        DisableUAC = $null
        DisableIEPasswordAutoComplete = $null
        DisableIEPopupMgmt = $null
        DisableIEFirstRunWizard = $null
        DisableIESuggestedSites = $null     
        DisableIESmileyButton  = $null
    }
    User = [ordered]@{
        RequireAdmin = $null
        ImportModule = 'PolicyFileEditor'
        HidePeople = $null
        HideTaskView = $null
        ControlPanelView = $null
        RemoveFaxPrinter = $null
        DisableIENewEdgeTab = $null
        ShowIEMenuBar = $null
        ShowIEFavoritesBar = $null
        ShowIEStatusBar = $null
        LockIEToolbars = $null
    }
}
<#$IgnoreSettings = @(
    'RequireAdmin'
    'ImportModule'
    'CloseApps'
    'EmptyRecycleBin'
    'EnableNetAdapters'
    'ResetDelayedDesktop'
    'ClearDefaultWebCaches'
    'AddDefaultUser'
    'ShowNewNetFlyout'
    'UninstallCommApps'
    'RestartShell'
    'SetRunOnce'
    'CopyFinalizeSetup'
)
$Settings = [ordered]@{
    Computer = [ordered]@{
        RequireAdmin = 1                        # Utility
        ImportModule = 'PolicyFileEditor'       # Utility
        ResetDelayedDesktop = $null             # Utility
        ClearDefaultWebCaches = $null           # Utility
        ShowNewNetFlyout = 0                    # Utility
        SetRunOnceRun = $null                   # Utility
        AddDefaultUser = $null                  # User Accounts
        SetTheme = $null                        # Shell
        SetThisPCLabel = $null                  # Shell/Desktop
        DisableEdgeShortcut = $null             # Shell/Desktop
        DisableCortana = $null                  # Shell/Taskbar
        DisableWebSearch = $null                # Shell/Taskbar
        ShowAllSysTrayIcons = $null             # Shell/Taskbar
        DisableActionCenter = $null             # Shell/Taskbar
        Hide3DObjectsFolder = $null             # Shell/File Exlorer
        HidePerfLogsFolder = $null              # Shell/File Exlorer
        SetAppAssociations = $null              # Shell/Files
        DisableFastStartup = $null              # Power
        SetSleepSettings = $null                # Power/sleep/screen saver/lock screen
        SetDisplayTimeout = $null               # Power/sleep/screen saver/lock screen
        DisableLockScreen = $null               # Power/sleep/screen saver/lock screen
        DisablePrivateFirewall = $null          # Security
        DisableLLMNR = $null                    # Security
        DisableDefender = $null                 # Security
        DisableSmartScreen = $null              # Security
        DisableUAC = $null                      # Security
        DisableSecurityNotifications = $null    # Security (Shell/Notifications)
        DisableLocation = $null                 # Privacy
        DisableAutoUpdate = $null               # Windows Update
        DisableCheckForUpdates = $null          # Windows Update
        HideMissingUpdatesIcon = $null          # Windows Update
        InstallHPPCL6UPD = $null                # Devices/Printers
        DisableAutoDefaultPrinter = $null       # Devices/Printers
        DisableNCDAutoSetup = $null             # Devices/Printers
        RemoveFaxPrinter = $null                # Devices/Printers
        RemoveXPSPrinter = $null                # Devices/Printers
        EnableNumLock = $null                   # Devices/Keyboard
        DisableIEFirstRunWiz = $null            # Web Browsers/Internet Explorer
        DisableIEPopupMgmt = $null              # Web Browsers/Internet Explorer
        DisableIEAutoComplete = $null           # Web Browsers/Internet Explorer
        DisableIESuggestedSites = $null         # Web Browsers/Internet Explorer
        DisableIESmileyButton = $null           # Web Browsers/Internet Explorer
        SetIESearchEngine = $null               # Web Browsers/Internet Explorer
        SetIENewTab = $null                     # Web Browsers/Internet Explorer
        DisableXboxDVR = $null                  # Apps/Citrix
    }
    User = [ordered]@{
        RequireAdmin = 1                        # Utility
        ImportModule = 'PolicyFileEditor'       # Utility
        CloseApps = $null                       # 
        EnableTitleBarColor = $null             # Shell
        AddDesktopIcons = $null                 # Shell/Desktop
        SetFileExplorerOpen = $null             # Shell/File Explorer
        HideSyncNotifications = $null           # Shell/File Explorer
        DisableNavPaneRecent = $null            # Shell/File Explorer
        AddNavPaneRecycleBin = $null            # Shell/File Explorer
        CleanStartMenu = $null                  # Shell/Start menu
        SetTaskbarGrouping = $null              # Shell/Taskbar
        ShowTaskbarSearch = $null               # Shell/Taskbar
        HideTaskView = $null                    # Shell/Taskbar
        HideTaskbarPeople = $null               # Shell/Taskbar
        DisableNotifications = $null            # Shell/Notifications
        SetScreenSaverTimeout = $null           # Sleep/screen saver/lock screen
        SetNetworkPrivate = $null               # Security
        AddIETrustedSites = @()                 # Web Browsers/Internet Explorer
        SetIEHomepage = $null                   # Web Browsers/Internet Explorer
        SetIEFavorites = $null                  # Web Browsers/Internet Explorer
        ShowIEMenuBar = $null                   # Web Browsers/Internet Explorer
        ShowIEFavoritesBar = $null              # Web Browsers/Internet Explorer
        ShowIEStatusBar = $null                 # Web Browsers/Internet Explorer
        LockIEToolbars = $null                  # Web Browsers/Internet Explorer
        HideIEEdgeButton = $null                # Web Browsers/Internet Explorer
        DisableOfficeProtectedView = $null      # Apps/Office 365
        RemoveAdobeShortcut = $null             # Apps/Adobe Acrobat
        LoadOpenShellSettings = $null           # Apps/Open Shell
        AddCustomShortcuts = $null
        UninstallCommApps = $null               # Utility
        EmptyRecycleBin = $null                 # Utility
        CopyFinalizeSetup = $null               # Utility
        ShowNewNetFlyout = 1                    # Utility
        RestartShell = $null                    # Utility
    }
}
$FinalizeSetup = [ordered]@{
    InstallCitrix = $null
    BeginFinalizeSetup = $null
    ActivateWindows = $null
    SetUserPassword = $null
    OpenContinuum = $null
    InstallWebroot = $null
    ConfigWarpDrive = $null
    ActivateOffice = $null
    EnableBitlocker = $null
    EndFinalizeSetup = $null
}
#>

# Log
function LogMessage {
    param (
        [int]$stream,    
        [string]$source,
        [string]$message
    )
    $timestamp = Get-Date -Format s
    $logMessage = "[$timestamp] $source $message"

    switch ($stream) {
        1 { Write-Output $logMessage }
        2 { Write-Error $logMessage }
        3 { Write-Warning $logMessage }
        4 { Write-Verbose $logMessage }
        5 { Write-Debug $logMessage }
        6 { Write-Information $logMessage }
    }
}

# Rerun this script as administrator
function RequireAdmin {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
        Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs
        exit
    }
}

# Hide console window
function HideConsole {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
    [Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(),0)
}

# Import a PowerShell module
function ImportModule {
    param (
        [string]$moduleString
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    [array]$modules = ($moduleString -split ",").Trim()
    foreach ($module in $modules) {
        $modulePath = "$env:ProgramFiles\WindowsPowerShell\Modules\$module"
        LogMessage 6 $source "Importing $module"
        if (!(Test-Path $modulePath)) {
            Start-Process xcopy.exe -ArgumentList "`"$DeploymentAssets\$module`" `"$modulePath`" /E /I /Q /Y" -NoNewWindow -Wait
        }
        if (!(Get-Module $module)) {
            Import-Module $module
        }
    }
}

# Create variables for settings
function CreateVariables {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    foreach ($section in $Settings.GetEnumerator()) {
        foreach ($setting in $Settings[$section.Name].GetEnumerator()) {
            Set-Variable -Name $setting.Name -Value $setting.Value -Scope global
        }
    }
}

# Get live state of settings
function GetLiveState {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    foreach ($section in $Settings.GetEnumerator()) {
        foreach ($setting in $Settings[$section.Name].GetEnumerator()) {
            if ($IgnoreSettings -notcontains $setting.Name) {
                Invoke-Expression "$($setting.Name) ?"
            }
        }
    }
}

# Parse INI file
function ParseIniFile {
    param (
        [string]$iniFile
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    $script:Ini = [ordered]@{}
    switch -regex -file $iniFile {
        $RegexSection {
            $section = $matches[1]
            $Ini[$section] = [ordered]@{}
        }
        $RegexFunction {
            $Ini[$section][$matches[1]] = 'True'
        }
        $RegexFunctionStrArg {
            $Ini[$section][$matches[1]] = $matches[2]
        }
        $RegexFunctionIntArg {
            $Ini[$section][$matches[1]] = [int]$matches[2]
        }
    }
}

# Parse extra arguments
function ParseCommandArg {
    param (
        [string]$commandArg
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    switch -regex ($commandArg) {
        $RegexFunction {
            $NewSettings[$matches[1]] = 'True'
        }
        $RegexFunctionStrArg {
            $NewSettings[$matches[1]] = $matches[2]
        }
        $regexFunctionIntArg {
            $NewSettings[$matches[1]] = [int]$matches[2]
        }
    }
}

# Display GUI
function RunGui {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    
    [void][System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')
    [void][System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    [void][System.Windows.Forms.Application]::EnableVisualStyles()
    . (Join-Path $PSScriptRoot 'ConfigHostGUI.ps1')
}

# Main
function RunMain {
    param (
        $runArgs
    )
    Start-Transcript -Path $ConfigLog #-Append
    LogMessage 6 "[$($MyInvocation.MyCommand)]" $runArgs

    . (Join-Path $PSScriptRoot 'ConfigHostSettings.ps1')

    # Handle arguments
    if ($runArgs.Length -gt 0) {
        $i = 0
        while ($i -lt $runArgs.Length) {
            switch ($runArgs[$i]) {
                '-ini' {
                    $iniSection = $runArgs[++$i]
                    $PSCommandArgs += "-ini $iniSection"
                    ParseIniFile $ConfigIni
                    $NewSettings = $Ini[$iniSection]
                }
                '-gui' {
                    RunGui
                }
                default {
                    $PSCommandArgs += $runArgs[$i]
                    ParseCommandArg $runArgs[$i]
                }
            }
            $i++
        }

        # Call the respective function for the setting
        foreach ($setting in $NewSettings.GetEnumerator()) {
            if ($setting.Value -like 'True') {
                Invoke-Expression $setting.Name
            }
            else {
                Invoke-Expression "$($setting.Name) '$($setting.Value)'"
            }
        }
    }
    Stop-Transcript
}

RunMain $args
