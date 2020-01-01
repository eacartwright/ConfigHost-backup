Process
----------------------------------------------------------------

1. Reference OS media is sourced using either Microsoft VL or the `HeiDoc.net Windows ISO Downloader`, an easy-to-use frontend to retrieve OEM ISOs once supplied to the *Media Creation Tool* each feature update which remain on Microsoft's CDN but are near impossible to access directly.

2. The OS is serviced offline using the `OSDBuilder` PowerShell module, greatly simplifying DISM to apply necessary updates and .NET 3.5 support, precluding need for manual sysprep/capture. This also prevents the reference image from ever being network-connected or otherwise "tainted".

3. The updated reference OS is imported into `MDT` and associated with a Standard Client task sequence. The task sequence will install the operating system, added drivers, applications, and run  `ConfigHost.ps1` passes.

4. Based on the `Disassembler0 Win10-Initial-Setup-Script` PowerShell module, the script `ConfigHost.ps1` is specifically designed for use with MDT and uses a single "pass-complete" human-readable settings file called `ConfigSettings.ini` which contains calls to complimentary Powershell functions. The functions are grouped in sections, or passes, based on when they're needed: (1) once during setup, (2) once for the entire computer, (3) once per user, and (4) once for the final interactive customization. The functions run one at a time, in order top-to-bottom within its respective section, and can individually be commented out. Some functions allow for arguments to be passed (e.g. `AddDefaultUser=User,password`).

5. The `[FinalizeSetup]` pass is initiated after logging into any local account and using the *Finalize Setup* desktop shortcut. The USB no longer is required at this point.
