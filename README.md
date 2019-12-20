ConfigHost.ps1
================================================================

Process
----------------------------------------------------------------

1. Reference OS media is sourced using either Microsoft VL or the `HeiDoc.net Windows ISO Downloader`, an easy-to-use frontend to retrieve OEM ISOs once supplied to the *Media Creation Tool* each feature update which remain on Microsoft's CDN but are near impossible to access directly.

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
