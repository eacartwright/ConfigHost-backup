###############################################################
###  Utility
###############################################################

# Set RunOnce/Run registry information (load UserRunOnce, disable OneDrive auto-install)
function SetRunOnceRun {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    
    $runOnceName       = 'UserRunOnce'
    $runOnceCommand    = "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ConfigScript`" -ini User"
    $adminSID          = ((Get-LocalUser -Name 'Administrator').SID).Value
    $adminRunKey       = 'Registry::HKEY_USERS\$adminSID\Software\Microsoft\Windows\CurrentVersion\Run'
    $userRunKey        = 'Registry::HKEY_USERS\Default\Software\Microsoft\Windows\CurrentVersion\Run'
    $adminRunOnceKey   = 'Registry::HKEY_USERS\$adminSID\Software\Microsoft\Windows\CurrentVersion\RunOnce'
    $userRunOnceKey    = 'Registry::HKEY_USERS\Default\Software\Microsoft\Windows\CurrentVersion\RunOnce'

    # Load default user registry
    Start-Process reg.exe -ArgumentList 'load HKU\Default C:\Users\Default\NTUSER.DAT' -NoNewWindow -Wait

    # Add UserRunOnce for Administrator
    if (!(Test-Path $adminRunOnceKey)) {
        New-Item -Path $adminRunOnceKey -Force | Out-Null
    }
    Set-ItemProperty -Path $adminRunOnceKey -Name $runOnceName -Value $runOnceCommand
    
    # Add UserRunOnce to the default user
    if (!(Test-Path $userRunOnceKey)) {
        New-Item -Path $userRunOnceKey -Force | Out-Null
    }
    Set-ItemProperty -Path $userRunOnceKey -Name $runOnceName -Value $runOnceCommand
    
    # Remove OneDrive automatic setup (can be restarted at C:\Windows\SysWOW64\OneDriveSetup.exe)
    Remove-ItemProperty -Path $adminRunKey -Name 'OneDriveSetup' -Force
    Remove-ItemProperty -Path $userRunKey -Name 'OneDriveSetup' -Force
    
    # Unload default user registry
    [gc]::Collect()
    Start-Sleep 1
    Start-Process reg.exe -ArgumentList 'unload HKU\Default' -NoNewWindow -Wait
}

# Copy the Finalize Setup shortcut to the public desktop
function CopyFinalizeSetup {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    if (Test-Path $DeploymentAssets) {
        Copy-Item -Path "$DeploymentAssets\Finalize Setup.lnk" -Destination "$env:PUBLIC\Desktop" -ErrorAction SilentlyContinue
    }
}

# Undo fix for delayed login during setup (https://blogs.technet.microsoft.com/mniehaus/2015/08/23/windows-10-mdt-2013-update-1-and-hideshell)
function ResetDelayedDesktop {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DelayedDesktopSwitchTimeout' -Force
}

# Fix for new user poor performance (https://support.microsoft.com/en-us/help/4056823/performance-issue-with-custom-default-user-profile)
function ClearDefaultWebCaches {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    Remove-Item -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\INetCache\*' -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\WebCache\*' -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\WebCacheLock.dat' -Force -ErrorAction SilentlyContinue
    Remove-Item -Path 'C:\Users\Administrator\AppData\Local\Microsoft\Windows\INetCache\*' -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path 'C:\Users\Administrator\AppData\Local\Microsoft\Windows\WebCache\*' -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path 'C:\Users\Administrator\AppData\Local\Microsoft\Windows\WebCacheLock.dat' -Force -ErrorAction SilentlyContinue
}

# Update group policy
function UpdatePolicy {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    Start-Process cmd.exe -ArgumentList '/c gpupdate /force >nul' -NoNewWindow -Wait
}

# Restart shell
function RestartShell {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    Stop-Process -Name 'explorer' -Force
}

# Toggle new network flyout
function ShowNewNetFlyout {
    param (
        [int]$flyoutSetting
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]" $flyoutSetting
    
    if ($flyoutSetting -eq 0) {
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force | Out-Null
    }
    else {
        Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force
    }
}

# Uninstall Windows communication apps (Mail and Calendar) to clear taskbar of Mail app 
function UninstallCommApps {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    Get-AppxPackage -Name "microsoft.windowscommunicationsapps" -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\microsoft.windowscommunicationsapps_8wekyb3d8bbwe")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\microsoft.windowscommunicationsapps_8wekyb3d8bbwe" -Force | Out-Null
    }
}

# Empty the recycle bin (for theme file)
function EmptyRecycleBin {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    Clear-RecycleBin -DriveLetter C -Force -ErrorAction SilentlyContinue
}

# Change owner and permissions of registry key
function EnablePrivilege {
    param (
        # The privilege to adjust (http://msdn.microsoft.com/en-us/library/bb530716(VS.85).aspx)
        [ValidateSet(
            'SeAssignPrimaryTokenPrivilege', 'SeAuditPrivilege', 'SeBackupPrivilege',
            'SeChangeNotifyPrivilege', 'SeCreateGlobalPrivilege', 'SeCreatePagefilePrivilege',
            'SeCreatePermanentPrivilege', 'SeCreateSymbolicLinkPrivilege', 'SeCreateTokenPrivilege',
            'SeDebugPrivilege', 'SeEnableDelegationPrivilege', 'SeImpersonatePrivilege', 'SeIncreaseBasePriorityPrivilege',
            'SeIncreaseQuotaPrivilege', 'SeIncreaseWorkingSetPrivilege', 'SeLoadDriverPrivilege',
            'SeLockMemoryPrivilege', 'SeMachineAccountPrivilege', 'SeManageVolumePrivilege',
            'SeProfileSingleProcessPrivilege', 'SeRelabelPrivilege', 'SeRemoteShutdownPrivilege',
            'SeRestorePrivilege', 'SeSecurityPrivilege', 'SeShutdownPrivilege', 'SeSyncAgentPrivilege',
            'SeSystemEnvironmentPrivilege', 'SeSystemProfilePrivilege', 'SeSystemtimePrivilege',
            'SeTakeOwnershipPrivilege', 'SeTcbPrivilege', 'SeTimeZonePrivilege', 'SeTrustedCredManAccessPrivilege',
            'SeUndockPrivilege', 'SeUnsolicitedInputPrivilege')]
        $Privilege,
        # The process on which to adjust the privilege. Defaults to the current process
        $ProcessId = $pid,
        # Switch to disable the privilege, rather than enable it
        [switch] $Disable
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    # Taken from P/Invoke.NET with minor adjustments
    $definition = @'
 using System;
 using System.Runtime.InteropServices;
  
 public class AdjPriv
 {
  [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
  internal static extern bool AdjustTokenPrivileges(IntPtr htok, bool disall,
   ref TokPriv1Luid newst, int len, IntPtr prev, IntPtr relen);
  
  [DllImport("advapi32.dll", ExactSpelling = true, SetLastError = true)]
  internal static extern bool OpenProcessToken(IntPtr h, int acc, ref IntPtr phtok);
  [DllImport("advapi32.dll", SetLastError = true)]
  internal static extern bool LookupPrivilegeValue(string host, string name, ref long pluid);
  [StructLayout(LayoutKind.Sequential, Pack = 1)]
  internal struct TokPriv1Luid
  {
   public int Count;
   public long Luid;
   public int Attr;
  }
  
  internal const int SE_PRIVILEGE_ENABLED = 0x00000002;
  internal const int SE_PRIVILEGE_DISABLED = 0x00000000;
  internal const int TOKEN_QUERY = 0x00000008;
  internal const int TOKEN_ADJUST_PRIVILEGES = 0x00000020;
  public static bool EnablePrivilege(long processHandle, string privilege, bool disable)
  {
   bool retVal;
   TokPriv1Luid tp;
   IntPtr hproc = new IntPtr(processHandle);
   IntPtr htok = IntPtr.Zero;
   retVal = OpenProcessToken(hproc, TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, ref htok);
   tp.Count = 1;
   tp.Luid = 0;
   if(disable)
   {
    tp.Attr = SE_PRIVILEGE_DISABLED;
   }
   else
   {
    tp.Attr = SE_PRIVILEGE_ENABLED;
   }
   retVal = LookupPrivilegeValue(null, privilege, ref tp.Luid);
   retVal = AdjustTokenPrivileges(htok, false, ref tp, 0, IntPtr.Zero, IntPtr.Zero);
   return retVal;
  }
 }
'@
    
    $processHandle = (Get-Process -Id $ProcessId).Handle
    $type = Add-Type $definition -PassThru
    $type[0]::EnablePrivilege($processHandle, $Privilege, $Disable)
}

###############################################################
###  Computer
###############################################################

# Add default user accounts
function AddDefaultUser {
    param (
        [string]$userData
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $userData

    [array]$users = ($userData -split ';').Trim()
    foreach ($user in $users) {
        $username, [string]$defaultPw = ($user -split ',').Trim()
        $securePw = ConvertTo-SecureString -String $defaultPw -AsPlainText -Force
        LogMessage 6 $source "Creating user account $username"
        New-LocalUser -Name $username -Password $securePw -PasswordNeverExpires | Out-Null
        Add-LocalGroupMember -Group 'Administrators' -Member $username
    }
}

# Copy and set the default theme file (GPO)
function SetTheme {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode
    
    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Windows\Personalization' -ValueName 'ThemeFile'
        }
        1 {
            $themePath = "$env:ALLUSERSPROFILE\Microsoft\Windows\Themes"
            $themeFile = "$themePath\DefaultTheme.theme"
            if (!(Test-Path $themePath)) {
                New-Item $themePath -ItemType Directory -Force | Out-Null
            }
            Copy-Item -Path "$DeploymentAssets\DefaultTheme.theme" -Destination $themePath
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Windows\Personalization' -ValueName 'ThemeFile' -Data $themeFile
            Invoke-Item $themeFile # For built-in administrator
        }
        '?' {
            if ($null -eq (Get-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Windows\Personalization' -ValueName 'ThemeFile')) {
                $script:SetTheme = 0
            }
            else {
                $script:SetTheme = 1
            }
            LogMessage 6 $source $SetTheme
            return $SetTheme
        }
    }
}

# Set the computer label as seen in the Windows shell ("This PC")
function SetThisPCLabel {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        '?' {
            $script:SetThisPCLabel = (Get-Item 'Registry::HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}').GetValue('LocalizedString',$null,'DoNotExpandEnvironmentNames')
            
            if ($SetThisPCLabel -eq '@%SystemRoot%\system32\windows.storage.dll,-9216') {  
                $script:SetThisPCLabel = 'This PC'
            }
            LogMessage 6 $source $SetThisPCLabel
            return $SetThisPCLabel
        }
        default {
            $newLabel = $mode

            if ($newLabel -eq 'This PC') {
                $newLabel -eq '@%SystemRoot%\system32\windows.storage.dll,-9216'
            }

            EnablePrivilege SeTakeOwnershipPrivilege | Out-Null
            # Change owner to the local Administrators group
            $regKey = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey('CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}',[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::TakeOwnership)
            $regACL = $regKey.GetAccessControl()
            $regACL.SetOwner([System.Security.Principal.NTAccount]'Administrators')
            $regKey.SetAccessControl($regACL)

            # Change permissions for the local Administrators group
            $regKey = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey('CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}',[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::ChangePermissions)
            $regACL = $regKey.GetAccessControl()
            $regRule = New-Object System.Security.AccessControl.RegistryAccessRule ('Administrators','FullControl','ContainerInherit','None','Allow')
            $regACL.SetAccessRule($regRule)
            $regKey.SetAccessControl($regACL)

            Set-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Name 'LocalizedString' -Value $newLabel
        }
    }
}

# Disable automatic shortcut creation for Edge
function DisableEdgeShortcut {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'DisableEdgeDesktopShortcutCreation' -ErrorAction SilentlyContinue
        }
        1 {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'DisableEdgeDesktopShortcutCreation' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'DisableEdgeDesktopShortcutCreation') {
                1 {
                    $script:DisableEdgeShortcut = 1
                }
                default {
                    $script:DisableEdgeShortcut = 0
                }
            }
            LogMessage 6 $source $DisableEdgeShortcut
            return $DisableEdgeShortcut
        }
    }
}


# Disable Cortana (GPO)
function DisableCortana {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy' -ErrorAction SilentlyContinue
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization' -Name 'RestrictImplicitTextCollection' -Type DWord -Value 0
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization' -Name 'RestrictImplicitInkCollection' -Type DWord -Value 0
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' -Name 'HarvestContacts' -ErrorAction SilentlyContinue
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana' -Name 'Value' -Type DWord -Value 1
            Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization' -Name 'AllowInputPersonalization' -ErrorAction SilentlyContinue
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Windows Search' -ValueName 'AllowCortana' -Type DWord -Data 0
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\InputPersonalization' -ValueName 'AllowInputPersonalization' -Type DWord -Data 0
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana' -Name 'Value' -Type DWord -Value 0
            if (!(Test-Path 'HKCU:\Software\Microsoft\Personalization\Settings')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Personalization\Settings' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy' -Type DWord -Value 0
            if (!(Test-Path 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore')) {
                New-Item -Path 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization' -Name 'RestrictImplicitTextCollection' -Type DWord -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization' -Name 'RestrictImplicitInkCollection' -Type DWord -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' -Name 'HarvestContacts' -Type DWord -Value 0
        }
        '?' {
            switch (Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Windows Search' -ValueName 'AllowCortana') {
                0 {
                    $script:DisableCortana = 1
                }
                default {
                    $script:DisableCortana = 0
                }
            }
            LogMessage 6 $source $DisableCortana
            return $DisableCortana
        }
    }
}

# Disable web search functionality
function DisableWebSearch {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Windows Search' -ValueName 'DisableWebSearch'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Windows Search' -ValueName 'DisableWebSearch' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Windows Search' -ValueName 'DisableWebSearch').Data) {
                1 {
                    $script:DisableWebSearch = 1
                }
                default {
                    $script:DisableWebSearch = 0
                }
            }
            LogMessage 6 $source $DisableWebSearch
            return $DisableWebSearch
        }
    }
}

# Show all system tray icons
function ShowAllSysTrayIcons {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray') {
                1 {
                    $script:ShowAllSysTrayIcons = 1
                }
                default {
                    $script:ShowAllSysTrayIcons = 0
                }
            }
            LogMessage 6 $source $ShowAllSysTrayIcons
            return $ShowAllSysTrayIcons
        }
    }
}

# Disable Action Center (GPO)
function DisableActionCenter {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Windows\Explorer' -ValueName 'DisableNotificationCenter'
        }
        1 {
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Windows\Explorer' -ValueName 'DisableNotificationCenter' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Windows\Explorer' -ValueName 'DisableNotificationCenter').Data) {
                1 {
                    $script:DisableActionCenter = 1
                }
                default {
                    $script:DisableActionCenter = 0
                }
            }
            LogMessage 6 $source $DisableActionCenter
            return $DisableActionCenter
        }
    }
}

# Hide 3D Objects folder
function Hide3DObjectsFolder {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}')) {
                New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}' | Out-Null
            }
        }
        1 {
            Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}' -Force
        }
        '?' {
            switch (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}') {
                $false {
                    $script:Hide3DObjectsFolder = 1
                }
                $true {
                    $script:Hide3DObjectsFolder = 0
                }
            }
            LogMessage 6 $source $Hide3DObjectsFolder
            return $Hide3DObjectsFolder
        }
    }
}

# Hide PerfLogs folder
function HidePerfLogsFolder {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            (Get-Item -Path 'C:\PerfLogs' -Force -ErrorAction SilentlyContinue).Attributes -= 'Hidden'
        }
        1 {
            (Get-Item -Path 'C:\PerfLogs' -Force -ErrorAction SilentlyContinue).Attributes += 'Hidden'
        }
        '?' {
            switch ((Get-Item -Path 'C:\PerfLogs').Attributes -like '*Hidden*') {
                1 {
                    $script:HidePerfLogsFolder = 1
                }
                default {
                    $script:HidePerfLogsFolder = 0
                }
            }
            LogMessage 6 $source $HidePerfLogsFolder
            return $HidePerfLogsFolder
        }
    }        
}

# Set default file type associations (Internet Explorer .URL, Adobe Reader .PDF) (GPO)
function SetAppAssociations {
    Write-Information "($($MyInvocation.MyCommand)) Setting default application associations..."
    Start-Process Dism.exe -ArgumentList "/Online /Import-DefaultAppAssociations:`"$DeploymentAssets\DefaultAppAssociations.xml`"" -NoNewWindow -Wait

    # Disable "Keep using this app?" popup due to the above
    Set-PolicyFileEntry -Path $ComputerPolicy -Key "SOFTWARE\Policies\Microsoft\Windows\Explorer" -ValueName "NoNewAppAlert" -Data 1 -Type DWord
}

# Disable fast startup (prevents shutdown from hibernating system state and not refresh devices)
function DisableFastStartup {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled') {
                0 {
                    $script:DisableFastStartup = 1
                }
                default {
                    $script:DisableFastStartup = 0
                }
            }
            LogMessage 6 $source $DisableFastStartup
            return $DisableFastStartup
        }
    }
}

# Set system power sleep settings (GPO)
function SetSleepSettings {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"

    # Hard disk sleep (defaults 1200/20m, 600/10m)
    Start-Process powercfg.exe -ArgumentList "/setacvalueindex SCHEME_CURRENT SUB_DISK DISKIDLE 0" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setdcvalueindex SCHEME_CURRENT SUB_DISK DISKIDLE 1800" -NoNewWindow -Wait
    # System sleep timeout (defaults 1800/30m, 900/15m)
    Start-Process powercfg.exe -ArgumentList "/setacvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setdcvalueindex SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 2700" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setactive SCHEME_CURRENT" -NoNewWindow -Wait
}

# Set display power settings
function SetDisplayTimeout {
    param (
        [string]$acTimeout
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]" $acTimeout

    # Screen off idle timeout (defaults 600/10m, 300/5m)
    Start-Process powercfg.exe -ArgumentList "/setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE $acTimeout" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setdcvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 1800" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK $acTimeout" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setdcvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 1800" -NoNewWindow -Wait
    Start-Process powercfg.exe -ArgumentList "/setactive SCHEME_CURRENT" -NoNewWindow -Wait
    
    # Show the video console lock setting in powercfg.cpl
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\7516b95f-f776-4464-8c53-06167f40cc99\8EC4B3A5-6868-48c2-BE75-4F3044BE88A7" -Name "Attributes" -Value 2 -Type DWord
}

# Disable lock screen (not the login screen) (GPO)
function DisableLockScreen {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Personalization' -ValueName 'NoLockScreen'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Personalization' -ValueName 'NoLockScreen' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\Personalization' -ValueName 'NoLockScreen').Data) {
                1 {
                    $script:DisableLockScreen = 1
                }
                default {
                    $script:DisableLockScreen = 0
                }
            }
            LogMessage 6 $source $DisableLockScreen
            return $DisableLockScreen
        }
    }
}

# Disable private firewall profile
function DisablePrivateFirewall {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-NetFirewallProfile -Profile Private -Enabled True
        }
        1 {
            Set-NetFirewallProfile -Profile Private -Enabled False
        }
        '?' {
            $privateFirewall = Get-NetFirewallProfile | Where-Object { $_.Name -eq 'Private' }
            switch ($privateFirewall.Enabled) {
                $false {
                    $script:DisablePrivateFirewall = 1
                }
                default {
                    $script:DisablePrivateFirewall = 0
                }
            }
            LogMessage 6 $source $DisablePrivateFirewall
            return $DisablePrivateFirewall
        }
    }
}

# Disable Link-Local Multicast Name Resolution (LLMNR) protocol
function DisableLLMNR {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -ValueName 'EnableMulticast'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -ValueName 'EnableMulticast' -Type DWord -Data 0
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -ValueName 'EnableMulticast').Data) {
                1 {
                    $script:DisableLLMNR = 1
                }
                default {
                    $script:DisableLLMNR = 0
                }
            }
            LogMessage 6 $source $DisableLLMNR
            return $DisableLLMNR
        }
    }
}

# Disable Windows Defender (GPO)
function DisableDefender {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows Defender' -ValueName 'DisableAntiSpyware'
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'SecurityHealth' -Type ExpandString -Value '%windir%\system32\SecurityHealthSystray.exe'
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows Defender' -ValueName 'DisableAntiSpyware' -Type DWord -Data 1
            Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'SecurityHealth' -Force -ErrorAction SilentlyContinue
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows Defender' -ValueName 'DisableAntiSpyware').Data) {
                1 {
                    $script:DisableDefender = 1
                }
                default {
                    $script:DisableDefender = 0
                }
            }
            LogMessage 6 $source $DisableDefender
            return $DisableDefender
        }
    }
}

# Disable SmartScreen (GPO)
function DisableSmartScreen {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            # Explorer
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\System' -ValueName 'EnableSmartScreen'
            # Microsoft Edge
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -ValueName 'EnabledV9'
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\System' -ValueName 'EnableSmartScreen' -Type DWord -Data 0
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -ValueName 'EnabledV9' -Type DWord -Data 0
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\System' -ValueName 'EnableSmartScreen').Data) {
                0 {
                    $script:DisableSmartScreen = 1
                }
                default {
                    $script:DisableSmartScreen = 0
                }
            }
            LogMessage 6 $source $DisableSmartScreen
            return $DisableSmartScreen
        }
    }
}

# Disable UAC (GPO)
function DisableUAC {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 5
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 0
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin') {
                0 {
                    $script:DisableUAC = 1
                }
                default {
                    $script:DisableUAC = 0
                }
            }
            LogMessage 6 $source $DisableUAC
            return $DisableUAC
        }
    }
}

# Disable security notifications
function DisableSecurityNotifications {
    Write-Output "($($MyInvocation.MyCommand)) Disabling security notifications..."
    if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" -Force | Out-Null
    }
    Set-PolicyFileEntry -Path $ComputerPolicy -Key "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" -ValueName "DisableNotifications" -Data 1 -Type DWord
}

# Disable location feature (GPO)
function DisableLocation {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' -ValueName 'DisableLocation'
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' -ValueName 'DisablLocationScripting'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' -ValueName 'DisableLocation' -Type DWord -Data 1
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' -ValueName 'DisablLocationScripting' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors' -ValueName 'DisableLocation').Data) {
                1 {
                    $script:DisableLocation = 1
                }
                default {
                    $script:DisableLocation = 0
                }
            }
            LogMessage 6 $source $DisableLocation
            return $DisableLocation
        }
    }
}

# Disable Xbox DVR recording feature (GPO)
function DisableXboxDVR {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\GameDVR' -ValueName 'AllowGameDVR'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\GameDVR' -ValueName 'AllowGameDVR' -Type DWord -Data 0
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\GameDVR' -ValueName 'AllowGameDVR').Data) {
                1 {
                    $script:DisableXboxDVR = 1
                }
                default {
                    $script:DisableXboxDVR = 0
                }
            }
            LogMessage 6 $source $DisableXboxDVR
            return $DisableXboxDVR
        }
    }
}

# Disable automatic updates (GPO)
function DisableAutoUpdate {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -ValueName 'NoAutoUpdate'
            #Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -ValueName 'AUOptions'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU')) {
                New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -ValueName 'NoAutoUpdate' -Type DWord -Data 1
            #Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -ValueName 'NoAutoUpdate' -Type DWord -Data 2
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -ValueName 'NoAutoUpdate').Data) {
                1 {
                    $script:DisableAutoUpdate = 1
                }
                default {
                    $script:DisableAutoUpdate = 0
                }
            }
            LogMessage 6 $source $DisableAutoUpdate
            return $DisableAutoUpdate
        }
    }
}

# Disable "Check for updates" button (GPO)
function DisableCheckForUpdates {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -ValueName 'SetDisableUXWUAccess' -ErrorAction SilentlyContinue
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -ValueName 'SetDisableUXWUAccess' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -ValueName 'SetDisableUXWUAccess').Data) {
                1 {
                    $script:DisableCheckForUpdates = 1
                }
                default {
                    $script:DisableCheckForUpdates = 0
                }
            }
            LogMessage 6 $source $DisableCheckForUpdates
            return $DisableCheckForUpdates
        }
    }
}

# Hide the missing updates system tray icon
function HideMissingUpdatesIcon {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotifyIcon.exe' -Name 'Debugger' -Value 'C:\Windows\System32\systray.exe'
            Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe' -Name 'Debugger' -Value 'C:\Windows\System32\systray.exe'
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotifyIcon.exe')) {
                New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotifyIcon.exe' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotifyIcon.exe' -Name 'Debugger' -Value 'C:\Windows\System32\systray.exe'
            if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe')) {
                New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe' -Name 'Debugger' -Value 'C:\Windows\System32\systray.exe'
        }
        '?' {
            switch (Get-ItemPropertyValue -Path '' -Name '') {
                1 {
                    $script:HideMissingUpdatesIcon = 1
                }
                default {
                    $script:HideMissingUpdatesIcon = 0
                }
            }
            LogMessage 6 $source $HideMissingUpdatesIcon
            return $HideMissingUpdatesIcon
        }
    }
}

# Install HP PCL6 universal printer driver
function InstallHPPCL6UPD {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        1 {
            if (!(Get-PrinterDriver -Name 'HP Universal Printing PCL 6' -ErrorAction SilentlyContinue)) {
                Start-Process pnputil.exe -ArgumentList "/add-driver $CompanyRoot\Drivers\HP Universal Printing PCL 6\*.inf /install"
                #Add-PrinterDriver -Name 'HP Universal Printing PCL 6'
            }
        }
        '?' {
            try {
                Get-PrinterDriver -Name 'HP Universal Printing PCL 6' -ErrorAction Stop
                $InstallHPPCL6UPD = 1
            }
            catch {
                $InstallHPPCL6UPD = 0
            }
            LogMessage 6 $source $InstallHPPCL6UPD
            return $InstallHPPCL6UPD
        }
    }
}

# Disable Windows default printer management (GPO)
function DisableAutoDefaultPrinter {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Microsoft\Windows NT\CurrentVersion\Windows' -ValueName 'LegacyDefaultPrinterMode' -Type DWord -Data 1
        }
        1 {
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Microsoft\Windows NT\CurrentVersion\Windows' -ValueName 'LegacyDefaultPrinterMode' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $UserPolicy -Key 'Software\Microsoft\Windows NT\CurrentVersion\Windows' -ValueName 'LegacyDefaultPrinterMode').Data) {
                1 {
                    $script:DisableAutoDefaultPrinter = 1
                }
                default {
                    $script:DisableAutoDefaultPrinter = 0
                }
            }
            LogMessage 6 $source $DisableAutoDefaultPrinter
            return $DisableAutoDefaultPrinter
        }
    }
}

# Disable automatic setup of network-connected devices
function DisableNCDAutoSetup {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private')) {
                New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Name 'AutoSetup' -Type DWord -Value 1
        }
        1 {
            if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private')) {
                New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Name 'AutoSetup' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Name 'AutoSetup') {
                0 {
                    $script:DisableNcdAutoSetup = 1
                }
                default {
                    $script:DisableNcdAutoSetup = 0
                }
            }
            LogMessage 6 $source $DisableNcdAutoSetup
            return $DisableNcdAutoSetup
        }
    }
}

# Remove Fax printer
function RemoveFaxPrinter {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Add-Printer -Name 'Fax' -DriverName 'Microsoft Shared Fax Driver' -PortName 'SHRFAX'
        }
        1 {
            Remove-Printer -Name 'Fax'
        }
        '?' {
            switch ($null -eq (Get-Printer -Name 'Fax' -ErrorAction SilentlyContinue)) {
                $true {
                    $script:RemoveFaxPrinter = 1
                }
                $false {
                    $script:RemoveFaxPrinter = 0
                }
            }
            LogMessage 6 $source $RemoveFaxPrinter
            return $RemoveFaxPrinter
        }
    }
}

# Remove Microsoft XPS Document Writer
function RemoveXPSPrinter {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Add-Printer -Name 'Microsoft XPS Document Writer' -DriverName 'Microsoft XPS Document Writer v4' -PortName 'PORTPROMPT:'
        }
        1 {
            Remove-Printer -Name 'Microsoft XPS Document Writer'
        }
        '?' {
            switch (Get-Printer -Name 'Microsoft XPS Document Writer') {
                $true {
                    $script:RemoveXPSPrinter = 0
                }
                $false {
                    $script:RemoveXPSPrinter = 1
                }
            }
            LogMessage 6 $source $RemoveXPSPrinter
            return $RemoveXPSPrinter
        }
    }
}

# Enable NumLock after startup
function EnableNumLock {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKU:')) {
                New-PSDrive -Name 'HKU' -PSProvider 'Registry' -Root 'HKEY_USERS' | Out-Null
            }
            Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 0
        }
        1 {
            if (!(Test-Path 'HKU:')) {
                New-PSDrive -Name 'HKU' -PSProvider 'Registry' -Root 'HKEY_USERS' | Out-Null
            }
            Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2
        }
        '?' {
            switch (Get-ItemPropertyValue 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators') {
                2 {
                    $script:EnableNumLock = 1
                }
                default {
                    $script:EnableNumLock = 0
                }
            }
            LogMessage 6 $source $EnableNumLock
            return $EnableNumLock
        }
    }
}

# Disable first run wizard in Internet Explorer (GPO)
function DisableIEFirstRunWizard {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -ValueName 'DisableFirstRunCustomize'
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -ValueName 'DisableFirstRunCustomize' -Data 1 -Type DWord
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -ValueName 'DisableFirstRunCustomize').Data) {
                1 {
                    $script:DisableIEFirstRunWizard = 1
                }
                default {
                    $script:DisableIEFirstRunWizard = 0
                }
            }
            LogMessage 6 $source $DisableIEFirstRunWizard
            return $DisableIEFirstRunWizard
        }
    }
}

# Disable popup management in Internet Explorer (GPO)
function DisableIEPopupMgmt {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions' -ValueName 'NoPopupManagement'
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions' -ValueName 'NoPopupManagement' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Restrictions' -ValueName 'NoPopupManagement').Data) {
                1 {
                    $script:DisableIEPopupMgmt = 1
                }
                default {
                    $script:DisableIEPopupMgmt = 0
                }
            }
            LogMessage 6 $source $DisableIEPopupMgmt
            return $DisableIEPopupMgmt
        }
    }
}

# Disable autocomplete for usernames and passwords in Internet Explorer (GPO)
function DisableIEPasswordAutoComplete {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Main' -ValueName 'FormSuggest PW Ask'
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Main' -ValueName 'FormSuggest Passwords'
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Control Panel' -ValueName 'FormSuggest Passwords'
        }
        1 {
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Main' -ValueName 'FormSuggest PW Ask' -Data 'no'
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Main' -ValueName 'FormSuggest Passwords' -Data 'no'
            if (!(Test-Path 'HKCU:\Software\Policies\Microsoft\Internet Explorer\Control Panel')) {
                New-Item -Path 'HKCU:\Software\Policies\Microsoft\Internet Explorer\Control Panel' -Force | Out-Null
            }
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Control Panel' -ValueName 'FormSuggest Passwords' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Main' -ValueName 'FormSuggest PW Ask').Data) {
                'no' {
                    $script:DisableIEPasswordAutoComplete = 1
                }
                default {
                    $script:DisableIEPasswordAutoComplete = 0
                }
            }
            LogMessage 6 $source $DisableIEPasswordAutoComplete
            return $DisableIEPasswordAutoComplete
        }
    }
}

# Disable suggested sites in Internet Explorer (GPO)
function DisableIESuggestedSites {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites' -ValueName 'Enabled'
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites' -ValueName 'Enabled' -Type DWord -Data 0
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Suggested Sites' -ValueName 'Enabled').Data) {
                0 {
                    $script:DisableIESuggestedSites = 1
                }
                default {
                    $script:DisableIESuggestedSites = 0
                }
            }
            LogMessage 6 $source $DisableIESuggestedSites
            return $DisableIESuggestedSites
        }
    }
}

# Disable smiley feedback button in Internet Explorer (GPO)
function DisableIESmileyButton {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Restrictions' -ValueName 'NoHelpItemSendFeedback' 
        }
        1 {
            Set-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Restrictions' -ValueName 'NoHelpItemSendFeedback' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $UserPolicy -Key 'Software\Policies\Microsoft\Internet Explorer\Restrictions' -ValueName 'NoHelpItemSendFeedback').Data) {
                1 {
                    $script:DisableIESmileyButton = 1
                }
                default {
                    $script:DisableIESmileyButton = 0
                }
            }
            LogMessage 6 $source $DisableIESmileyButton
            return $DisableIESmileyButton
        }
    }
}

# Set search engine to Google in Internet Explorer
function SetIESearchEngine {
    Write-Information "($($MyInvocation.MyCommand)) Setting search engine to Google in Internet Explorer..."
    $guid = "{$((New-Guid).ToString()).ToUpper())}"
    Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\*" -Force -ErrorAction SilentlyContinue
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Name "DisplayName" -Value "Google"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Name "FaviconURL" -Value "https://www.google.com/favicon.ico"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Name "OSDFileURL" -Value "https://www.microsoft.com/cms/api/am/binary/RWilsM"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Name "ShowSearchSuggestions" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Name "SuggestionsURL" -Value "https://www.google.com/complete/search?q={searchTerms}&client=ie8&mw={ie:maxWidth}&sh={ie:sectionHeight}&rh={ie:rowHeight}&inputencoding={inputEncoding}&outputencoding={outputEncoding}"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes\$guid" -Name "URL" -Value "https://www.google.com/search?q={searchTerms}&sourceid=ie7&rls=com.microsoft:{language}:{referrer:source}&ie={inputEncoding?}&oe={outputEncoding?}"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\SearchScopes" -Name "DefaultScope" -Value $guid
    
    # Disable warning about changing the search engine
    if (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_EUPP_GLOBAL_FORCE_DISABLE")) {
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_EUPP_GLOBAL_FORCE_DISABLE" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_EUPP_GLOBAL_FORCE_DISABLE" -Name "iexplore.exe" -Value 1 -Type DWord
}

# Set new tab page to about:blank in Internet Explorer (GPO)
function SetIENewTab {
    Write-Information "($($MyInvocation.MyCommand)) Setting new tab page to about:blank in Internet Explorer..."
    Set-PolicyFileEntry -Path $UserPolicy -Key "Software\Policies\Microsoft\Internet Explorer\TabbedBrowsing" -ValueName "NewTabPageShow" -Data 0 -Type DWord
}

################################################################
###  User
################################################################

# Close apps if they're open
function CloseApps {
    param (
        $apps
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $apps

    foreach ($app in $apps) {
        if (Get-Process -Name $app -ErrorAction SilentlyContinue) {
            LogMessage 6 $source "Closing $app"
            Stop-Process -Name $app -Force
        }
    }
}

# Set Control Panel view
function ControlPanelView {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'StartupPage' -Type DWord -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView' -Type DWord -Value 1
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'StartupPage' -Type DWord -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView' -Type DWord -Value 0
        }
        2 {
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'StartupPage' -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView' -ErrorAction SilentlyContinue
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView') {
                0 {
                    $script:ControlPanelView = 0
                }
                1 {
                    $script:ControlPanelView = 1
                }
            }
            LogMessage 6 $source $ControlPanelView
            return $ControlPanelView
        }
    }
}

# Enable title bar color
function EnableTitleBarColor {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'ColorPrevalence' -Type DWord -Value 0
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'ColorPrevalence' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'ColorPrevalence') {
                1 {
                    $script:EnableTitleBarColor = 1
                }
                default {
                    $script:EnableTitleBarColor = 0
                }
            }
            LogMessage 6 $source $EnableTitleBarColor
            return $EnableTitleBarColor
        }
    }
}

# Show This PC on the desktop
function ShowThisPCOnDesktop {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue) {
                0 {
                    $script:ShowThisPCOnDesktop = 1
                }
                default {
                    $script:ShowThisPCOnDesktop = 0
                }
            }
            LogMessage 6 $source $ShowThisPCOnDesktop
            return $ShowThisPCOnDesktop
        }
    }
}

# Show User folder on the desktop
function ShowUserFolderOnDesktop {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' - er) {
                0 {
                    $script:AddUserFolderDesktop = 1
                }
                default {
                    $script:AddUserFolderDesktop = 0
                }
            }
            LogMessage 6 $source $AddUserFolderDesktop
            return $AddUserFolderDesktop
        }
    }
}

# Show Recycle Bin on the desktop
function ShowRecycleBinOnDesktop {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -ErrorAction SilentlyContinue
            Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -ErrorAction SilentlyContinue
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 0
            if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -ErrorAction SilentlyContinue) {
                0 {
                    $script:AddUserFolderDesktop = 1
                }
                default {
                    $script:AddUserFolderDesktop = 0
                }
            }
            LogMessage 6 $source $AddUserFolderDesktop
            return $AddUserFolderDesktop
        }
    }
}

# Show Lock Computer on the desktop
function ShowLockComputerOnDesktop {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-Item -Path "$Shortcuts\Lock Computer.lnk" -Force -ErrorAction SilentlyContinue
        }
        1 {
            Copy-Item -Path "$Shortcuts\Lock Computer.lnk" -Destination "$env:USERPROFILE\Desktop" -Force
        }
        '?' {
            switch (Test-Path "$env:USERPROFILE\Desktop\Lock Computer.lnk") {
                $true {
                    $script:ShowLockComputerOnDesktop = 1
                }
                $false {
                    $script:ShowLockComputerOnDesktop = 0
                }
            }
            LogMessage 6 $source $ShowLockComputerOnDesktop
            return $ShowLockComputerOnDesktop
        }
    }
}

# Add custom shortcuts
function AddCustomDesktopShortcuts {
    Write-Information "($($MyInvocation.MyCommand)) Adding custom shortcuts..."
    # Desktop
    Copy-Item -Path "$Shortcuts\Partners Email.lnk" -Destination "$env:USERPROFILE\Desktop"
    Copy-Item -Path "$Shortcuts\Epic.lnk" -Destination "$env:USERPROFILE\Desktop"
}

# Remove default items from the Start menu
function CleanStartMenu {
    Write-Information "($($MyInvocation.MyCommand)) Cleaning Start menu..."
    $startMenuAll = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs"
    $startMenuUser = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    Remove-Item -Path "$startMenuAll\Maintenance" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$startMenuUser\Maintenance" -Recurse -Force
    Remove-Item -Path "$startMenuUser\OneDrive.lnk" -Force
}

function AddCustomStartMenu {
    Start-Process cmd.exe -ArgumentList "/c mklink /d `"$env:APPDATA\Microsoft\Windows\Start Menu\Partners Websites`" `"$Shortcuts\Bookmarks\Partners Websites`" >nul" -NoNewWindow -Wait
    Copy-Item -Path "$Shortcuts\NWPHO Remote Support.lnk" -Destination "$env:APPDATA\Microsoft\Windows\Start Menu"
    Copy-Item -Path "$Shortcuts\OneDrive.lnk" -Destination "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
}

# Set taskbar buttons to combine when taskbar is full
function SetTaskbarGrouping {
    Write-Information "($($MyInvocation.MyCommand)) Setting taskbar buttons to combine when taskbar is full..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarGlomLevel" -Value 1 -Type DWord
}

# Hide taskbar search feature
function SearchboxTaskbarMode {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode') {
                1 {
                    $script:SearchboxTaskbarMode = 1
                }
                default {
                    $script:SearchboxTaskbarMode = 0
                }
            }
            LogMessage 6 $source $SearchboxTaskbarMode
            return $SearchboxTaskbarMode
        }
    }
}

# Clears pinned applications from taskbar
function ClearTaskbarPins {
    Write-Information "($($MyInvocation.MyCommand)) Clearing pinned applications from taskbar..."
    Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Recurse -Force
}

# Pin applications to taskbar 
function PinTaskbarApps {
    param (
        [string]$targetData
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]" $targetData

    $targets = ($targetData -split ',').Trim()
    $shell = New-Object -ComObject Shell.Application
    $handler = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Windows.taskbarpin').ExplorerCommandHandler
    $key = 'Registry::HKEY_CURRENT_USER\Software\Classes\*\shell\taskbarpin'

    New-Item -Path $key -Force | Out-Null
    Set-ItemProperty -Path $key -Name 'ExplorerCommandHandler' -Value $handler

    foreach ($target in $targets) {
        $folder = $shell.NameSpace((Get-Item $target).DirectoryName)
        $file = $folder.ParseName((Get-Item $target).Name)
        $file.InvokeVerb('taskbarpin')
    }
    Remove-Item -Path $key -Force
}

# Hide People button on the taskbar
function HidePeople {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand') {
                0 {
                    $script:HidePeople = 1
                }
                1 {
                    $script:HidePeople = 0
                }
            }
            LogMessage 6 $source $HidePeople
            return $HidePeople
        }
    }
}

# Hide Task View button on the taskbar
function HideTaskView {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton') {
                0 {
                    $script:HideTaskView = 1
                }
                1 {
                    $script:HideTaskView = 0
                }
            }
            LogMessage 6 $source $HideTaskView
            return $HideTaskView
        }
    }
}

# Disable system notifications
function DisableNotifications {
    Write-Information "($($MyInvocation.MyCommand)) Disabling system notifications..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value 0 -Type DWord
    # Disable Windows Welcome Experience notifications
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value 0 -Type DWord
    # Disable Tips, Tricks, and Suggestions notifications
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 -Type DWord
    # Disable Security and Maintenance notifications (firewall warning)
    if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance")) {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Force | Out-Null
    }
    if (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" -Name "Enabled" -Value 0 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" -Name "DisableNotifications" -Value 1 -Type DWord
    # Disable app suggestion notifications
    if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Suggested")) {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Suggested" -Force | Out-Null
    }
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Suggested" -Name "Enabled" -Value 0 -Type DWord
}

# Set opening view for File Explorer to This PC
function SetFileExplorerOpen {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Type DWord -Value 2
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo') {
                1 {
                    $script:SetFileExplorerOpen = 1
                }
                default {
                    $script:SetFileExplorerOpen = 0
                }
            }
            LogMessage 6 $source $SetFileExplorerOpen
            return $SetFileExplorerOpen
        }
    }
}

# Hide sync provider notifications (OneDrive banner in File Explorer)
function HideOneDriveBanner {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 0
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications') {
                0 {
                    $script:HideOneDriveBanner = 1
                }
                default {
                    $script:HideOneDriveBanner = 0
                }
            }
            LogMessage 6 $source $HideOneDriveBanner
            return $HideOneDriveBanner
        }
    }
}

# Disable automatic adding of recent and frequent locations to Quick Access in File Explorer navigation pane (Does not disallow pinning favorites to Quick Access)
function DisableNavPaneRecent {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Type DWord -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 1
        }
        1 {
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Type DWord -Value 0
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 0
        }
        '?' {
            $showRecent = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent'
            $showFrequent = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent'
            if ($showRecent -eq 0 -and $showFrequent -eq 0) {
                $script:DisableNavPaneRecent = 1
            }
            else {
                $script:DisableNavPaneRecent = 0
            }
            LogMessage 6 $source $DisableNavPaneRecent
            return $DisableNavPaneRecent
        }
    }
}

# Add the Recycle Bin to File Explorer navigation pane
function AddNavPaneRecycleBin {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-ItemProperty -Path 'HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}'
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}')) {
                New-Item -Path 'HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}' -Name 'System.IsPinnedToNameSpaceTree' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}' -Name 'System.IsPinnedToNameSpaceTree' -ErrorAction SilentlyContinue) {
                1 {
                    $script:AddNavPaneRecycleBin = 1
                }
                default {
                    $script:AddNavPaneRecycleBin = 0
                }
            }
            LogMessage 6 $source $AddNavPaneRecycleBin
            return $AddNavPaneRecycleBin
        }
    }
}

# Set screen saver timeout
function SetScreenSaverTimeout {
    param (
        [string]$lockTimeout
    )
    if ($lockTimeout -eq 0) {
        Write-Information "($($MyInvocation.MyCommand)) Disabling screen saver..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Value "0"
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaverIsSecure" -Value "0"
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Value "0"
        Remove-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "SCRNSAVE.EXE" -ErrorAction SilentlyContinue
    }
    else {
        Write-Information "($($MyInvocation.MyCommand)) Setting screen saver timeout ($lockTimeout)..."
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Value "1"
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaverIsSecure" -Value "1"
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Value $lockTimeout
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "SCRNSAVE.EXE" -Value "C:\windows\system32\scrnsave.scr"
    }
}

# Set network connection profile to private
function SetNetworkPrivate {
    Write-Information "($($MyInvocation.MyCommand)) Setting network profile to private..."
    Set-NetConnectionProfile -NetworkCategory Private
}

# Add trusted sites to Internet Explorer
function AddIETrustedSites {
    param (
        [string]$siteData
    )
    Write-Information "($($MyInvocation.MyCommand)) Adding trusted sites to Internet Explorer..."
    [array]$trustedSites = ($siteData -split ",").Trim()
    foreach ($site in $trustedSites) {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\$site" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\$site" -Name "*" -Value 2 -Type DWord
    }
}

# Set the home page for Internet Explorer
function SetIEHomepage {
    param (
        [string]$ieHomepage
    )
    Write-Information "($($MyInvocation.MyCommand)) Setting homepage for Internet Explorer..."
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main" -Name "Start Page" -Value $ieHomepage
}

# Set standard favorites for Internet Explorer
function SetIEStandardFavorites {
    Write-Information "($($MyInvocation.MyCommand)) Setting favorites for Internet Explorer..."
    Remove-Item -Path "$env:USERPROFILE\Favorites\Bing.url" -Force -ErrorAction SilentlyContinue
    Copy-Item -Path "$Shortcuts\Bookmarks\Google.url" -Destination "$env:USERPROFILE\Favorites"
    Copy-Item -Path "$Shortcuts\Bookmarks\Google.url" -Destination "$env:USERPROFILE\Favorites\Links"    
}

# Set custom favorites for Internet Explorer
function SetIECustomFavorites{
    Copy-Item -Path "$Shortcuts\Bookmarks\Partners Websites\*" -Destination "$env:USERPROFILE\Favorites"
    Copy-Item -Path "$Shortcuts\Bookmarks\Partners Websites\Epic.url" -Destination "$env:USERPROFILE\Favorites\Links"
    Copy-Item -Path "$Shortcuts\Bookmarks\Partners Websites\Partners Email.url" -Destination "$env:USERPROFILE\Favorites\Links"
}

# Show the menu bar in Internet Explorer
function ShowIEMenuBar {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'AlwaysShowMenus' -Type DWord -Value 0
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'AlwaysShowMenus' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'AlwaysShowMenus') {
                1 {
                    $script:ShowIEMenuBar = 1
                }
                default {
                    $script:ShowIEMenuBar = 0
                }
            }
            LogMessage 6 $source $ShowIEMenuBar
            return $ShowIEMenuBar
        }
    }
}

# Show the favorites bar in Internet Explorer
function ShowIEFavoritesBar {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'LinksBandEnabled' -Type DWord -Value 0
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'LinksBandEnabled' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'LinksBandEnabled') {
                1 {
                    $script:ShowIEFavoritesBar = 1
                }
                default {
                    $script:ShowIEFavoritesBar = 0
                }
            }
            LogMessage 6 $source $ShowIEFavoritesBar
            return $ShowIEFavoritesBar
        }
    }
}

# Show the status bar in Internet Explorer
function ShowIEStatusBar {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'ShowStatusBar' -Type DWord -Value 0
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'ShowStatusBar' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Internet Explorer\MINIE' -Name 'ShowStatusBar') {
                1 {
                    $script:ShowIEStatusBar = 1
                }
                default {
                    $script:ShowIEStatusBar = 0
                }
            }
            LogMessage 6 $source $ShowIEStatusBar
            return $ShowIEStatusBar
        }
    }
}

# Lock toolbars in Internet Explorer
function LockIEToolbars {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar' -Name 'Locked' -Type DWord -Value 0
        }
        1 {
            if (!(Test-Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar')) {
                New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar' -Force | Out-Null
            }
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar' -Name 'Locked' -Type DWord -Value 1
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar' -Name 'Locked') {
                1 {
                    $script:LockIEToolbars = 1
                }
                default {
                    $script:LockIEToolbars = 0
                }
            }
            LogMessage 6 $source $LockIEToolbars
            return $LockIEToolbars
        }
    }
}

# Disable new tab top open Edge in Internet Explorer
function DisableIENewEdgeTab {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {
            Remove-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -ValueName 'HideNewEdgeButton'
        }
        1 {
            Set-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -ValueName 'HideNewEdgeButton' -Type DWord -Data 1
        }
        '?' {
            switch ((Get-PolicyFileEntry -Path $ComputerPolicy -Key 'SOFTWARE\Policies\Microsoft\Internet Explorer\Main' -ValueName 'HideNewEdgeButton').Data) {
                1 {
                    $script:DisableIENewEdgeTab = 1
                }
                default {
                    $script:DisableIENewEdgeTab = 0
                }
            }
            LogMessage 6 $source $DisableIENewEdgeTab
            return $DisableIENewEdgeTab
        }
    }
}

# Disable Protected View in Office applications
function DisableOfficeProtectedView {
    param (
        $mode
    )
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    $officeApps = @('Word','Excel','PowerPoint')

    switch ($mode) {
        0 {
            foreach ($app in $officeApps) {
                Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableAttachmentsInPV'
                Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableInternetFilesInPV'
                Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableIntranetCheck'
                Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableUnsafeLocationsInPV'
            }
        }
        1 {
            foreach ($app in $officeApps) {
                if (!(Test-Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView")) {
                    New-Item -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Force | Out-Null
                }
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableAttachmentsInPV' -Type DWord -Value 1
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableInternetFilesInPV' -Type DWord -Value 1
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableIntranetCheck' -Type DWord -Value 1
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\$app\Security\ProtectedView" -Name 'DisableUnsafeLocationsInPV' -Type DWord -Value 1
            }
        }
        '?' {
            switch (Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Office\16.0\Word\Security\ProtectedView' -Name 'DisableAttachmentsInPV') {
                1 {
                    $script:DisableOfficeProtectedView = 1
                }
                default {
                    $script:DisableOfficeProtectedView = 0
                }
            }
            LogMessage 6 $source $DisableOfficeProtectedView
            return $DisableOfficeProtectedView
        }
    }

}

# Load Open Shell settings
function LoadOpenShellSettings {
    param (
        $mode
    )
    LogMessage 6 "[$($MyInvocation.MyCommand)]" $mode

    if (Test-Path "$env:ProgramFiles\Open-Shell" -and $mode -eq 1) {
        Start-Process "$env:ProgramFiles\Open-Shell\StartMenu.exe" -ArgumentList "-xml `"$env:ALLUSERSPROFILE\OpenShell\Menu Settings.xml`"" -Wait
        Start-Process "$env:ProgramFiles\Open-Shell\StartMenu.exe" -ArgumentList "-exit" -Wait
        Start-Process "$env:ProgramFiles\Open-Shell\StartMenu.exe" -Wait
    }
}

################################################################
###  FinalizeSetup
################################################################

# Install Citrix Receiver
function InstallCitrix {
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$DeploymentAssets\Citrix\Citrix Receiver\Install.ps1`"" -NoNewWindow -Wait
}

# Begin interactive section of FinalizeSetup
function BeginFinalizeSetup {
    $script:YesNo = '[Y]es or Enter to skip'
    Clear-Host
    Write-Information 'Finalize setup by completing the following steps...'
}

# Activate Windows
function ActivateWindows {
    Write-Information "`nActivate Windows..." -ForegroundColor Yellow
    
    $biosKey = (Get-CimInstance -Query "SELECT * FROM SoftwareLicensingService").OA3xOriginalProductKey
    if ($biosKey -eq "" -or $null -eq $biosKey) {
        Write-Information "`nNo BIOS OEM product key found. Enter manually?" -ForegroundColor Red
        if ((Read-Host $YesNo).ToLower() -match "y") {
            Start-Process slui.exe
        }
    }
    else {
        Write-Information "`nBIOS OEM product key $biosKey found. Attempting to activate..." -ForegroundColor Green
        Start-Process cmd.exe -ArgumentList "/c slmgr.vbs /ipk $biosKey" -NoNewWindow -Wait
    }
}

# Set password for current user
function SetUserPassword {
    Write-Information "`nUpdate password for $env:USERNAME`?" -ForegroundColor Yellow
    if ((Read-Host $YesNo).ToLower() -match "y") {
        $newPw = Read-Host 'New password'
        $securePw = ConvertTo-SecureString $newPw -AsPlainText -Force
        Set-LocalUser -Name $env:USERNAME -Password $securePw
    }
}

# Open Continuum website
function OpenContinuum {
    Write-Information "`nOpen Continuum website?" -ForegroundColor Yellow
    if ((Read-Host $YesNo).ToLower() -match "y") {
        Start-Process "${env:ProgramFiles(x86)}\Internet Explorer\iexplore.exe" -ArgumentList "-private https://control.itsupport247.net"
        Add-Type -Assembly 'Microsoft.VisualBasic'
        [Microsoft.VisualBasic.Interaction]::AppActivate($pid)
    }
}

# Install Webroot
function InstallWebroot {
    Write-Information "`nInstall Webroot?" -ForegroundColor Yellow
    if ((Read-Host $YesNo).ToLower() -match "y") {
        Start-Process "$DeploymentAssets\Webroot\wsasme.exe"
        Start-Process notepad.exe -ArgumentList "$DeploymentAssets\Webroot\wsadat"
    }
}

# Configure Epic Warp Drive
function ConfigWarpDrive {
    $wdPath = "$env:SystemRoot\Temp\EpicWarpDrive"
    if (Test-Path $wdPath) {
        $wdCheck = 1
        $wdTarget = $env:COMPUTERNAME
        $wdData = Get-Content "$wdPath\wddat"

        do {
            $wdMatch = $wdData -match $wdTarget
            
            if ($wdMatch) {
                $wdDepartment, $wdHostname, $wdNetwork, $wdUser = $wdMatch -split ","

                Write-Information "`nEpic Warp Drive data found for $wdHostname. Apply the following configuration?" -ForegroundColor Yellow
                Write-Information 'Department:' -NoNewline -ForegroundColor Yellow
                Write-Information " $wdDepartment "-NoNewline
                Write-Information 'Account:' -NoNewline -ForegroundColor Yellow
                Write-Information " $wdUser " -NoNewline
                Write-Information 'Location:' -NoNewline -ForegroundColor Yellow
                Write-Information " $wdNetwork Network"

                if ((Read-Host $YesNo).ToLower() -match 'y') {
                    $wdCheck = 0
                    $regOnNetwork = Get-Content "$wdPath\WDOnNetwork64.reg"
                    $regOffNetwork = Get-Content "$wdPath\WDOffNetwork64.reg"

                    if (($wdNetwork).ToLower() -match 'on') {
                        $regOnNetwork[8] = "`"WinUser`"=`"$wdUser`""
                        Out-File -FilePath "$wdPath\WDConfig.reg" -InputObject $regOnNetwork
                    }
                    else {
                        $regOffNetwork[8] = "`"WinUser`"=`"$wdUser`""
                        Out-File -FilePath "$wdPath\WDConfig.reg" -InputObject $regOffNetwork
                    }

                    Start-Process reg.exe -ArgumentList "import `"$wdPath\WDConfig.reg`"" -NoNewWindow -Wait
                    # Move Epic desktop shortcut into Start menu, move Warp Drive shortcut to startup folder and remove its folder
                    Move-Item -Path "$env:USERPROFILE\Desktop\Epic.lnk" "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs" -ErrorAction SilentlyContinue
                    Move-Item -Path "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Epic 2015\Epic Warp Drive.lnk" "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Startup" -ErrorAction SilentlyContinue
                    Remove-Item -Path "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Epic 2015" -Recurse -Force -ErrorAction SilentlyContinue
                }
                else {
                    $wdCheck = 0
                }
            }
            else {
                Write-Information "`nEpic Warp Drive detected but no data found for $wdTarget. Use another computer name?" -ForegroundColor Yellow
                if ((Read-Host $YesNo).ToLower() -match 'y') {
                    $wdTarget = Read-Host 'Computer name'
                }
                else {
                    $wdCheck = 0
                }
            }
        } while ($wdCheck -ne 0)
        Remove-Item -Path $wdPath -Recurse -Force
    }
}

# Launch Word to activate Office 365
function ActivateOffice {
    if (Test-Path "${env:ProgramFiles(x86)}\Microsoft Office\root\Office16") {
        Write-Information "`nLaunch Word to activate Office 365?" -ForegroundColor Yellow
        if ((Read-Host $YesNo).ToLower() -match "y") {
            Start-Process "${env:ProgramFiles(x86)}\Microsoft Office\root\Office16\WINWORD.EXE"
        }
    }
}

# Launch BitLocker Control Panel window
function EnableBitlocker {
    Write-Information "`nEnable BitLocker?" -ForegroundColor Yellow
    if ((Read-Host $YesNo).ToLower() -match "y") {
        Start-Process control.exe -ArgumentList "/name Microsoft.BitLockerDriveEncryption"
    }
}

# Clean up temp files ands folders
function EndFinalizeSetup {
    Write-Information "`nCleaning up..." -ForegroundColor Yellow
    Remove-Item -Path "C:\MININT" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PUBLIC\Desktop\Finalize Setup.lnk" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $DeploymentAssets -Recurse -Force -ErrorAction SilentlyContinue
}
