Deployment Changelog
================================================================

Process
----------------------------------------------------------------

1. Reference OS media is sourced using the `HeiDoc.net Windows ISO Downloader`, an easy-to-use frontend to retrieve OEM ISOs once supplied to the *Media Creation Tool* each feature update which remain on Microsoft's CDN but are near impossible to access directly.

2. The OS is serviced offline using the `OSDBuilder` PowerShell module, greatly simplifying DISM to apply necessary updates and .NET 3.5 support, precluding need for manual sysprep/capture. This also prevents the reference image from ever being network-connected or otherwise "tainted".

3. The updated reference OS is imported into `MDT` and associated with a Standard Client task sequence. The task sequence will install the operating system, added drivers, applications, and run  `ConfigHost.ps1` passes.

4. Based on the `Disassembler0 Win10-Initial-Setup-Script` PowerShell module (and the reduced `reclaimWindows10.ps1`), the script `ConfigHost.ps1` is specifically designed for use with MDT and uses a single "pass-complete" human-readable settings file called `ConfigSettings.ini` which contains calls to complimentary Powershell functions. The functions are grouped in sections, or passes, based on when they're needed: (1) once during setup, (2) once for the entire computer, (3) once per user, and (4) once for the final interactive customization. The functions run one at a time, in order top-to-bottom within its respective section, and can individually be commented out. Some functions allow for arguments to be passed (e.g. `AddDefaultUser=User,password`).

5. The `[FinalizeSetup]` pass is initiated after logging into any local account and using the *Finalize Setup* desktop shortcut. The USB no longer is required at this point.

Configuration
----------------------------------------------------------------

### [Setup] > [Computer] > [User] *Administrator* > *restart* > [User] *User* > [FinalizeSetup]

### [Setup]
**Any company folder content interaction (excluding DeploymentAssets) references the USB drive source.*

1. `DisableNetworkAdapters` - Disables any network adapters to prevent background processes such as driver updates, hopefully neutering Defender, etc.
2. `CopyDeploymentAssets` - Copies the *DeploymentAssets* folder from the company folder on the USB drive to *%windir%\Temp*
3. `ImportModule=PolicyFileEditor` - Loads the *PolicyFileEditor* PowerShell module, installed at *C:\Program Files\WindowsPowershell\Modules\PolicyFileEditor*
4. `ResetDelayedDesktop` - Removes answer file addition of DelayedDesktopSwitchTimeout=0 bug fix
5. `ResetDefaultWebCaches` - Attempts to resolve delayed n+1 user bug
6. `AddDefaultUser=User,password` - Creates new local administrator account with the name *User* and the password *password*

### [Computer]

1.  

### [User]

1. 

### [FinalizeSetup]

1. 

****************************************************************

Unreleased
----------------------------------------------------------------

### Pending

1. INI parsing

powershell.exe -NoProfile -ExecutionPolicy Bypass -File ConfigHost.ps1 -preset mypreset.txt -log myoutput.log
[0] = -preset
[1] = 


* Pare down the drivers
    - Compare hardware IDs in MS C:\Windows\System32\DriverStore\FileRepository\net* drivers vs Intel on outlier machines
* Install Citrix Receiver from local disk post-deployment
* Change desktop This PC label via registry programmatically (`Set-Acl`)
* Revisit Classic Shell menu settings ("PC Settings")
* Revisit theme colors
* Make note of task sequence changes
* Update wsasme.exe needed?
* Determine if Office Publisher should/(could within version) be reintroduced
* Have deploy script refer to USB %DEPLOYROOT% version of resources
* Consider .cmd to set execution policy in NWPHO folder to allow for easy setting of said policy on computers who have not been reimaged with 2.0
* Have cookie set for Workspace login, or devise alternative way (`FinalizeSetup.ps1`)
* Update Chrome
* Setup Chrome defaults
* Update T-LBK462-BSB-R drivers
* (?) Custom wizard page for user creation and, if possible, show what's in the USB config
* (?) Better install console windows
* GUI for UpdateHost, filter functions by pass and can run on demand
* Weekly scheduled task to restart comp func
* Do everything post image with a strong/forced restart?
* (?) Dynamically change? ...
    - HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion, RegisteredOrganization, $Value
    - HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion, RegisteredOwner, $Value
* Review on how to best prevent unwanted Windows Update

----------------------------------------------------------------

### Completed

* Use PowerShell-based controlled function-style approach to modifications using a settings file (`Win10-Initial-Setup-Script`)
* Use INI settings file (`HostSettings.ini`), sections break down as follows:
    - `[General]` - Settings done (first) EVERY section (think company folder)
    - `[Setup]` - Settings needed for the *State Restore* phase of MDT setup (and does not have to do with general computer/user configuration)
    - `[Computer]` - HKLM functions, settings that affect all accounts and DO NOT want re-run every first time a new user logs in
    - `[User]` - HKCU *and* HKCU/HKLM functions, settings you need to have done every first time a new user logs in
    - `[FinalizeSetup]` - Stuff you need to have the tech set (password setting would need work for multi-user setups)
* GPOs now managed with `PolicyFileEditor` for script-based changes that also update the `registry.pol` files (reflects in `gpedit.msc`)
    - Benefits are no external files, faster updating (no need for run/capture), and modifications are in gpedit (if the policy has an ADMX counterpart only?)
    - It can also set Policies that don't have ADMX templates. These changes will not show in gpedit.msc, but will show up when a gpresult report is ran.
* User creation during setup is now specified in settings file
* Secure Webroot keycodes in encrypted PDF (also sortable now via encrypted DOCX)
* Company folder structure updated to be more clear
* All applications now use `Install.ps1`
* Selection profile names now match their task sequence counterparts going forward
* Confirmed need for and added updates to `Unattend.xml` file to bypass long initial restore login
    - At `Components > 4 specialize > amd64_Microsoft-Windows-Deployment_neutral > RunSynchronous`
        - [5] disable logon animation: reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableFirstLogonAnimation /d 0 /t REG_DWORD /f
        - [6] disable delayed desktop: reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v DelayedDesktopSwitchTimeout /d 0 /t REG_DWORD /f
        - `DelayedDesktopSwitchTimeout` is removed during setup but not `EnableFirstLogonAnimation` as this is an improvement
* Simplified CustomSettings.ini and Bootstrap.ini to only use necessary properties
* Internet Explorer opens in InPrivate mode during FinalizeSetup
* Updated Intel I219-LM Ethernet adapter drivers from version 12.17.10.7 to version 12.18.9.2
    - e1c65x64, e1d65x64, e1r65x64, e1s65x64, v1q65x64
* Updated HP PCL6 driver to 6.7.0.23939
* Updated Citrix Receiver LTSR from version 4.9.6000 to 4.9.6001.1
* Added NAPS2 6.1.1 to optional applications for PDF scanning
* Using Robocopy over Copy-Item to exclude DeploymentAssets