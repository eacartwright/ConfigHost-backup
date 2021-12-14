#Add-Type -AssemblyName System.Drawing
#Add-Type -AssemblyName System.Windows.Forms
#[void][System.Windows.Forms.Application]::EnableVisualStyles()

$frmMain_Load = {
    DisableForm
    HideConsole
    CreateVariables
    GetLiveState
    UpdateForm
    EnableForm
}

$reloadComputerToolStripMenuItem_Click = {
    DisableForm
    GetLiveState
    UpdateForm
    EnableForm
}

$importINIFileToolStripMenuItem_Click = {
    DisableForm
    ImportIniFile
    EnableForm
}

$exportConfigFileToolStripMenuItem_Click = {
    DisableForm
    ExportIniFile
    EnableForm
}

$updateGroupPolicyToolStripMenuItem_Click = {
    DisableForm
    UpdatePolicy
    EnableForm
}

$restartExplorerToolStripMenuItem_Click = {
    RestartShell
}

$openScriptToolStripMenuItem_Click = {
    Start-Process notepad.exe -ArgumentList "$PSCommandPath"
}

$btnApply_Click = {
    DisableForm
    ApplyForm
    UpdatePolicy
    RestartShell
    GetLiveState
    UpdateForm
    EnableForm
}

$btnExport_Click = {
    DisableForm
    ExportIniFile
    EnableForm
}

$rdoDisableCheckForUpdates_CheckedChanged = {
    if ($FormUpdated) {
        DisableForm
        switch ($rdoDisableCheckForUpdates.Checked) {
            $true {
                $rdoDisableCheckForUpdates.Enabled = $false
                DisableCheckForUpdates 1
                UpdatePolicy
            }
            $false {
                $rdoDisableCheckForUpdates.Enabled = $true
            }
        }
        EnableForm
    }
}

$rdoEnableCheckForUpdates_CheckedChanged = {
    if ($FormUpdated) {
        DisableForm
        switch ($rdoEnableCheckForUpdates.Checked) {
            $true {
                $rdoEnableCheckForUpdates.Enabled = $false
                DisableCheckForUpdates 0
                UpdatePolicy
            }
            $false {
                $rdoEnableCheckForUpdates.Enabled = $true
            }
        }
        EnableForm
    }
}

function gridClick {
    $rowIndex = $dataGridView1.CurrentRow.Index

    switch ($dataGridView1.Rows[$rowIndex].Cells[0].value) {
        'General' {
            $panel2.Visible = $true
            $panel3.Visible = $false
            $panel4.Visible = $false
            $panel5.Visible = $false
            $panel6.Visible = $false
        }
        'Shell' {
            $panel2.Visible = $false
            $panel3.Visible = $true
            $panel4.Visible = $false
            $panel5.Visible = $false
            $panel6.Visible = $false
        }
        'Security' {
            $panel2.Visible = $false
            $panel3.Visible = $false
            $panel4.Visible = $true
            $panel5.Visible = $false
            $panel6.Visible = $false
        }
        'Networking' {
            $panel2.Visible = $false
            $panel3.Visible = $false
            $panel4.Visible = $false
            $panel5.Visible = $true
            $panel6.Visible = $false
        }
        'Web Browsers' {
            $panel2.Visible = $false
            $panel3.Visible = $false
            $panel4.Visible = $false
            $panel5.Visible = $false
            $panel6.Visible = $true
        }
    }
}

# Form design
. (Join-Path $PSScriptRoot 'ConfigHost.designer.ps1')
$dataGridView1.Add_CellMouseClick({gridClick})
$settingGroups = @(
    'General'
    'Shell'
    'Security'
    'Networking'
    'Web Browsers'
    'Backup'
)

$settingGroups | foreach {
    $dataGridView1.Rows.Add($_) | Out-Null
}

<#$tableLayoutPanel1.AutoSize = $true
$tableLayoutPanel1.AutoSizeMode = 'GrowAndShrink'
$groupBox4.AutoSize = $true
$groupBox4.AutoSizeMode = 'GrowOnly'
$groupBox5.AutoSize = $true
$groupBox5.AutoSizeMode = 'GrowOnly'

$checkboxA = New-Object System.Windows.Forms.CheckBox
$checkboxA.Text = "Checkbox A"
$checkboxA.Location = New-Object System.Drawing.Size(6,20)
$groupBox4.Controls.Add($checkboxA)

$checkboxB = New-Object System.Windows.Forms.CheckBox
$checkboxB.Text = "Checkbox B"
$checkboxB.Location = New-Object System.Drawing.Size(6,43)
$groupBox4.Controls.Add($checkboxB)

$checkboxC = New-Object System.Windows.Forms.CheckBox
$checkboxC.Text = "Checkbox C"
$checkboxC.Location = New-Object System.Drawing.Size(6,20)
$groupBox5.Controls.Add($checkboxC)#>

# Disable main form while updating
function DisableForm {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    $frmMain.Enabled = $false
}

# Enable main form after updating
function EnableForm {
    LogMessage 6 "[$($MyInvocation.MyCommand)]"
    $frmMain.Enabled = $true
}

# Update GUI form with new globals
function UpdateForm {
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source

    switch ($HidePeople) {
        0 { $chkHidePeople.Checked = $false }
        1 { $chkHidePeople.Checked = $true }
    }

    switch ($HideTaskView) {
        0 { $chkHideTaskView.Checked = $false }
        1 { $chkHideTaskView.Checked = $true }
    }

    switch ($DisableDefender) {
        0 { $chkDisableDefender.Checked = $false }
        1 { $chkDisableDefender.Checked = $true }
    }

    $cmbSetThisPCLabel.Text = $SetThisPCLabel

    switch ($DisableCheckForUpdates) {
        0 {
            $rdoEnableCheckForUpdates.Checked = $true
            $rdoEnableCheckForUpdates.Enabled = $false
        }
        1 {
            $rdoDisableCheckForUpdates.Checked = $true
            $rdoDisableCheckForUpdates.Enabled = $false
        }
    }

    switch ($ControlPanelView) {
        0 { $cmbControlPanelView.SelectedIndex = 0 }
        1 { $cmbControlPanelView.SelectedIndex = 1 }
        2 { $cmbControlPanelView.SelectedIndex = 2 }
    }

    switch ($DisableSmartScreen) {
        0 { $chkDisableSmartScreen.Checked = $false }
        1 { $chkDisableSmartScreen.Checked = $true }
    }
    
    switch ($DisableUAC) {
        0 { $chkDisableUAC.Checked = $false }
        1 { $chkDisableUAC.Checked = $true }
    }

    switch ($DisableIEPasswordAutoComplete) {
        0 { $chkDisableIEPasswordAutoComplete.Checked = $false }
        1 { $chkDisableIEPasswordAutoComplete.Checked = $true }
    }

    switch ($DisableIEPopupMgmt) {
        0 { $chkDisableIEPopupMgmt.Checked = $false }
        1 { $chkDisableIEPopupMgmt.Checked = $true }
    }

    switch ($DisableIEFirstRunWizard) {
        0 { $chkDisableIEFirstRunWizard.Checked = $false }
        1 { $chkDisableIEFirstRunWizard.Checked = $true }
    }

    switch ($DisableIESuggestedSites) {
        0 { $chkDisableIESuggestedSites.Checked = $false }
        1 { $chkDisableIESuggestedSites.Checked = $true }
    }

    switch ($DisableIESmileyButton) {
        0 { $chkDisableIESmileyButton.Checked = $false }
        1 { $chkDisableIESmileyButton.Checked = $true }
    }

    switch ($DisableIENewEdgeTab) {
        0 { $chkDisableIENewEdgeTab.Checked = $false }
        1 { $chkDisableIENewEdgeTab.Checked = $true }
    }

    switch ($ShowIEMenuBar) {
        0 { $chkShowIEMenuBar.Checked = $false }
        1 { $chkShowIEMenuBar.Checked = $true }
    }

    switch ($ShowIEFavoritesBar) {
        0 { $chkShowIEFavoritesBar.Checked = $false }
        1 { $chkShowIEFavoritesBar.Checked = $true }
    }

    switch ($ShowIEStatusBar) {
        0 { $chkShowIEStatusBar.Checked = $false }
        1 { $chkShowIEStatusBar.Checked = $true }
    }

    switch ($LockIEToolbars) {
        0 { $chkLockIEToolbars.Checked = $false }
        1 { $chkLockIEToolbars.Checked = $true }
    }

    $script:FormUpdated = $true
}

# Apply configuration from GUI to computer
function ApplyForm {
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source

    switch ($chkHidePeople.Checked) {
        $false { HidePeople 0 }
        $true { HidePeople 1 }
    }

    switch ($chkHideTaskView.Checked) {
        $false { HideTaskView 0 }
        $true { HideTaskView 1 }
    }

    switch ($chkDisableDefender.Checked) {
        $false { DisableDefender 0 }
        $true { DisableDefender 1 }
    }
    
    switch ($chkDisableCheckForUpdates.Checked) {
        $false { DisableCheckForUpdates 0 }
        $true { DisableCheckForUpdates 1 }
    }

    SetThisPCLabel $cmbSetThisPCLabel.Text

    switch ($cmbControlPanelView.SelectedIndex) {
        0 { ControlPanelView 0 }
        1 { ControlPanelView 1 }
        2 { ControlPanelView 2 }
    }
    
    switch ($chkDisableSmartScreen.Checked) {
        $false { DisableSmartScreen 0 }
        $true { DisableSmartScreen 1 }
    }

    switch ($chkDisableUAC.Checked) {
        $false { DisableUAC 0 }
        $true { DisableUAC 1 }
    }

    switch ($chkDisableIEPasswordAutoComplete.Checked) {
        $false { DisableIEPasswordAutoComplete 0 }
        $true { DisableIEPasswordAutoComplete 1 }
    }
    
    switch ($chkDisableIEPopupMgmt.Checked) {
        $false { DisableIEPasswordAutoComplete 0 }
        $true { DisableIEPasswordAutoComplete 1 }
    }

    switch ($chkDisableIEFirstRunWizard.Checked) {
        $false { DisableIEFirstRunWizard 0 }
        $true { DisableIEFirstRunWizard 1 }
    }

    switch ($chkDisableIESuggestedSites.Checked) {
        $false { DisableIESuggestedSites 0 }
        $true { DisableIESuggestedSites 1 }
    }

    switch ($chkDisableIESmileyButton.Checked) {
        $false { DisableIESmileyButton 0 }
        $true { DisableIESmileyButton 1 }
    }

    switch ($chkDisableIENewEdgeTab.Checked) {
        $false { DisableIENewEdgeTab 0 }
        $true { DisableIENewEdgeTab 1 }
    }

    switch ($chkShowIEMenuBar.Checked) {
        $false { ShowIEMenuBar 0 }
        $true { ShowIEMenuBar 1 }
    }

    switch ($chkShowIEFavoritesBar.Checked) {
        $false { ShowIEFavoritesBar 0 }
        $true { ShowIEFavoritesBar 1 }
    }

    switch ($chkShowIEStatusBar.Checked) {
        $false { ShowIEStatusBar 0 }
        $true { ShowIEStatusBar 1 }
    }

    switch ($chkLockIEToolbars.Checked) {
        $false { LockIEToolbars 0 }
        $true { LockIEToolbars 1 }
    }
}

# Import INI file to read into GUI and display it
function ImportIniFile {
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source

    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory =[Environment]::GetFolderPath('Desktop') }
    $FileBrowser.ShowDialog()
    $iniFile = $FileBrowser.FileName

    if ($iniFile -ne '') {
        LogMessage 6 $source $iniFile

        ParseIniFile $iniFile

        foreach ($section in $Ini.GetEnumerator()) {
            foreach ($setting in $Ini[$section.Name].GetEnumerator()) {
                Set-Variable -Name $setting.Name -Value $setting.Value -Scope global
            }
        }

        UpdateForm
    }
}

# Export INI file
function ExportIniFile {
    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source

    $FileBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{InitialDirectory =[Environment]::GetFolderPath('Desktop')}
    $FileBrowser.Filter = 'Configuration file|*.ini'
    $FileBrowser.ShowDialog()
    $iniFile = $FileBrowser.FileName

    if ($iniFile -ne '') {
        LogMessage 6 $source $iniFile
        
        Out-File -FilePath $iniFile -Force

        switch ($chkHidePeople.Checked) {
            $false { $HidePeople = 0 }
            $true { $HidePeople = 1 }
        }

        switch ($chkHideTaskView.Checked) {
            $false { $HideTaskView = 0 }
            $true { $HideTaskView = 1 }
        }

        switch ($chkDisableDefender.Checked) {
            $false { $DisableDefender = 0 }
            $true { $DisableDefender = 1 }
        }

        switch ($chkDisableCheckForUpdates.Checked) {
            $false { $DisableCheckForUpdates = 0 }
            $true { $DisableCheckForUpdates = 1 }
        }

        $SetThisPCLabel = $cmbSetThisPCLabel.Text

        switch ($cmbControlPanelView.SelectedIndex) {
            0 { $ControlPanelView = 0 }
            1 { $ControlPanelView = 1 }
            2 { $ControlPanelView = 2 }
        }

        switch ($chkDisableSmartScreen.Checked) {
            $false { $DisableSmartScreen = 0 }
            $true { $DisableSmartScreen = 1 }
        }

        switch ($chkDisableUAC.Checked) {
            $false { $DisableUAC = 0 }
            $true { $DisableUAC = 1 }
        }

        switch ($chkDisableIEPasswordAutoComplete.Checked) {
            $false { $DisableIEPasswordAutoComplete = 0 }
            $true { $DisableIEPasswordAutoComplete = 1 }
        }

        switch ($chkDisableIEPopupMgmt.Checked) {
            $false { $DisableIEPopupMgmt = 0 }
            $true { $DisableIEPopupMgmt = 1 }
        }

        switch ($chkDisableIEFirstRunWizard.Checked) {
            $false { $DisableIEFirstRunWizard = 0 }
            $true { $DisableIEFirstRunWizard = 1 }
        }

        switch ($chkDisableIESuggestedSites.Checked) {
            $false { $DisableIESuggestedSites = 0 }
            $true { $DisableIESuggestedSites = 1 }
        }

        switch ($chkDisableIESmileyButton.Checked) {
            $false { $DisableIESmileyButton = 0 }
            $true { $DisableIESmileyButton = 1 }
        }

        switch ($chkDisableIENewEdgeTab.Checked) {
            $false { $DisableIENewEdgeTab = 0 }
            $true { $DisableIENewEdgeTab = 1 }
        }

        switch ($chkShowIEMenuBar.Checked) {
            $false { $ShowIEMenuBar = 0 }
            $true { $ShowIEMenuBar = 1 }
        }

        switch ($chkShowIEFavoritesBar.Checked) {
            $false { $ShowIEFavoritesBar = 0 }
            $true { $ShowIEFavoritesBar = 1 }
        }

        switch ($chkShowIEStatusBar.Checked) {
            $false { $ShowIEStatusBar = 0 }
            $true { $ShowIEStatusBar = 1 }
        }

        switch ($chkLockIEToolbars.Checked) {
            $false { $LockIEToolbars = 0 }
            $true { $LockIEToolbars = 1 }
        }

        foreach ($section in $Settings.GetEnumerator()) {
            Add-Content -Path $iniFile -Value "[$($section.Name)]"
            foreach ($entry in $Settings[$section.Name].GetEnumerator()) {
                $entry.Value = Get-Variable -Name $entry.Name -ValueOnly #-ErrorAction SilentlyContinue
                if ($null -eq $entry.Value) {
                    Add-Content -Path $iniFile -Value "$($entry.Name)"
                }
                else {
                    Add-Content -Path $iniFile -Value "$($entry.Name)=$($entry.Value)"
                }
            }
            Add-Content -Path $iniFile ''
        }
    }
}

$frmMain.ShowDialog()