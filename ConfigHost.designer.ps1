[void][System.Reflection.Assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
[void][System.Reflection.Assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
$frmMain = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$btnApply = $null
[System.Windows.Forms.MenuStrip]$menuStrip1 = $null
[System.Windows.Forms.ToolStripMenuItem]$fileToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$reloadComputerToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$importINIFileToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$exportConfigFileToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$scanForMDTUSBToolStripMenuItem = $null
[System.Windows.Forms.ToolStripSeparator]$toolStripSeparator1 = $null
[System.Windows.Forms.ToolStripMenuItem]$exitToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$viewToolStripMenuItem = $null
[System.Windows.Forms.ToolStripSeparator]$toolStripSeparator2 = $null
[System.Windows.Forms.ToolStripMenuItem]$updateGroupPolicyToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$restartExplorerToolStripMenuItem = $null
[System.Windows.Forms.Button]$btnExport = $null
[System.Windows.Forms.ToolStripMenuItem]$openScriptToolStripMenuItem = $null
[System.Windows.Forms.TabPage]$tabWebBrowser = $null
[System.Windows.Forms.TabPage]$tabNetworking = $null
[System.Windows.Forms.TabPage]$tabSecurity = $null
[System.Windows.Forms.TabPage]$tabWindows = $null
[System.Windows.Forms.GroupBox]$groupBox2 = $null
[System.Windows.Forms.ComboBox]$cmbComputerLabel = $null
[System.Windows.Forms.Label]$lblComputerLabel = $null
[System.Windows.Forms.ComboBox]$cmbControlPanelView = $null
[System.Windows.Forms.Label]$lblControlPanelView = $null
[System.Windows.Forms.GroupBox]$groupBox1 = $null
[System.Windows.Forms.CheckBox]$chkDisableDefender = $null
[System.Windows.Forms.CheckBox]$chkDisableUACPrompt = $null
[System.Windows.Forms.CheckBox]$chkLockWindowsUpdate = $null
[System.Windows.Forms.CheckBox]$chkHideTaskView = $null
[System.Windows.Forms.CheckBox]$chkHidePeople = $null
[System.Windows.Forms.CheckBox]$chkDisableSmartScreen = $null
[System.Windows.Forms.TabControl]$tabControl = $null
[System.Windows.Forms.GroupBox]$gbxInternetExplorer = $null
[System.Windows.Forms.GroupBox]$gbxChrome = $null
[System.Windows.Forms.GroupBox]$gbxEdge = $null
[System.Windows.Forms.CheckBox]$chkDisableEdgeShortcut = $null
[System.Windows.Forms.TabPage]$tabComputer = $null
[System.Windows.Forms.Label]$lblWorkgroup = $null
[System.Windows.Forms.TextBox]$textBox1 = $null
[System.Windows.Forms.Label]$lblComputerName = $null
[System.Windows.Forms.TextBox]$tbxComputerName = $null
[System.Windows.Forms.Label]$label1 = $null
[System.Windows.Forms.CheckBox]$checkBox4 = $null
[System.Windows.Forms.CheckBox]$checkBox3 = $null
[System.Windows.Forms.CheckBox]$checkBox2 = $null
[System.Windows.Forms.CheckBox]$checkBox1 = $null
[System.Windows.Forms.Label]$label2 = $null
[System.Windows.Forms.CheckBox]$chkDisableIEPasswordAutoComplete = $null
[System.Windows.Forms.CheckBox]$chkDisableIEFirstRunWizard = $null
[System.Windows.Forms.CheckBox]$chkDisableIEPopupMgmt = $null
[System.Windows.Forms.CheckBox]$chkDisableIESuggestedSites = $null
[System.Windows.Forms.CheckBox]$chkDisableIESmileyButton = $null
[System.Windows.Forms.CheckBox]$chkDisableIENewEdgeTab = $null
[System.Windows.Forms.CheckBox]$chkShowIEMenuBar = $null
[System.Windows.Forms.CheckBox]$chkShowIEStatusBar = $null
[System.Windows.Forms.CheckBox]$chkShowIEFavoritesBar = $null
[System.Windows.Forms.CheckBox]$chkLockIEToolbars = $null
[System.Windows.Forms.GroupBox]$gbxLockWindowsUpdate = $null
[System.Windows.Forms.RadioButton]$rdoUnlockWindowsUpdate = $null
[System.Windows.Forms.RadioButton]$rdoLockWindowsUpdate = $null
[System.Windows.Forms.ToolStripSeparator]$toolStripSeparator3 = $null
function InitializeComponent
{
$btnApply = (New-Object -TypeName System.Windows.Forms.Button)
$menuStrip1 = (New-Object -TypeName System.Windows.Forms.MenuStrip)
$fileToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$scanForMDTUSBToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$toolStripSeparator2 = (New-Object -TypeName System.Windows.Forms.ToolStripSeparator)
$importINIFileToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$exportConfigFileToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$toolStripSeparator1 = (New-Object -TypeName System.Windows.Forms.ToolStripSeparator)
$exitToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$viewToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$reloadComputerToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$updateGroupPolicyToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$restartExplorerToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$toolStripSeparator3 = (New-Object -TypeName System.Windows.Forms.ToolStripSeparator)
$openScriptToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$btnExport = (New-Object -TypeName System.Windows.Forms.Button)
$tabWebBrowser = (New-Object -TypeName System.Windows.Forms.TabPage)
$gbxChrome = (New-Object -TypeName System.Windows.Forms.GroupBox)
$gbxEdge = (New-Object -TypeName System.Windows.Forms.GroupBox)
$chkDisableEdgeShortcut = (New-Object -TypeName System.Windows.Forms.CheckBox)
$gbxInternetExplorer = (New-Object -TypeName System.Windows.Forms.GroupBox)
$label2 = (New-Object -TypeName System.Windows.Forms.Label)
$chkDisableIEFirstRunWizard = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableIESuggestedSites = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableIEPasswordAutoComplete = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableIESmileyButton = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableIENewEdgeTab = (New-Object -TypeName System.Windows.Forms.CheckBox)
$label1 = (New-Object -TypeName System.Windows.Forms.Label)
$chkLockIEToolbars = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkShowIEStatusBar = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkShowIEFavoritesBar = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkShowIEMenuBar = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableIEPopupMgmt = (New-Object -TypeName System.Windows.Forms.CheckBox)
$tabNetworking = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabSecurity = (New-Object -TypeName System.Windows.Forms.TabPage)
$tabWindows = (New-Object -TypeName System.Windows.Forms.TabPage)
$groupBox2 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$cmbComputerLabel = (New-Object -TypeName System.Windows.Forms.ComboBox)
$lblComputerLabel = (New-Object -TypeName System.Windows.Forms.Label)
$chkLockWindowsUpdate = (New-Object -TypeName System.Windows.Forms.CheckBox)
$groupBox1 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$checkBox4 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox3 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox2 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox1 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableDefender = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableUACPrompt = (New-Object -TypeName System.Windows.Forms.CheckBox)
$cmbControlPanelView = (New-Object -TypeName System.Windows.Forms.ComboBox)
$chkHideTaskView = (New-Object -TypeName System.Windows.Forms.CheckBox)
$lblControlPanelView = (New-Object -TypeName System.Windows.Forms.Label)
$chkHidePeople = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableSmartScreen = (New-Object -TypeName System.Windows.Forms.CheckBox)
$tabControl = (New-Object -TypeName System.Windows.Forms.TabControl)
$tabComputer = (New-Object -TypeName System.Windows.Forms.TabPage)
$gbxLockWindowsUpdate = (New-Object -TypeName System.Windows.Forms.GroupBox)
$rdoUnlockWindowsUpdate = (New-Object -TypeName System.Windows.Forms.RadioButton)
$rdoLockWindowsUpdate = (New-Object -TypeName System.Windows.Forms.RadioButton)
$lblWorkgroup = (New-Object -TypeName System.Windows.Forms.Label)
$textBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblComputerName = (New-Object -TypeName System.Windows.Forms.Label)
$tbxComputerName = (New-Object -TypeName System.Windows.Forms.TextBox)
$menuStrip1.SuspendLayout()
$tabWebBrowser.SuspendLayout()
$gbxEdge.SuspendLayout()
$gbxInternetExplorer.SuspendLayout()
$tabWindows.SuspendLayout()
$groupBox2.SuspendLayout()
$groupBox1.SuspendLayout()
$tabControl.SuspendLayout()
$tabComputer.SuspendLayout()
$gbxLockWindowsUpdate.SuspendLayout()
$frmMain.SuspendLayout()
#
#btnApply
#
$btnApply.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]478,[System.Int32]501))
$btnApply.Name = [System.String]'btnApply'
$btnApply.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$btnApply.TabIndex = [System.Int32]1
$btnApply.Text = [System.String]'Apply'
$btnApply.UseCompatibleTextRendering = $true
$btnApply.UseVisualStyleBackColor = $true
$btnApply.add_Click($btnApply_Click)
#
#menuStrip1
#
$menuStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($fileToolStripMenuItem,$viewToolStripMenuItem))
$menuStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
$menuStrip1.Name = [System.String]'menuStrip1'
$menuStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]568,[System.Int32]24))
$menuStrip1.TabIndex = [System.Int32]16
$menuStrip1.Text = [System.String]'menuStrip1'
#
#fileToolStripMenuItem
#
$fileToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($scanForMDTUSBToolStripMenuItem,$toolStripSeparator2,$importINIFileToolStripMenuItem,$exportConfigFileToolStripMenuItem,$toolStripSeparator1,$exitToolStripMenuItem))
$fileToolStripMenuItem.Name = [System.String]'fileToolStripMenuItem'
$fileToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]37,[System.Int32]20))
$fileToolStripMenuItem.Text = [System.String]'File'
#
#scanForMDTUSBToolStripMenuItem
#
$scanForMDTUSBToolStripMenuItem.Name = [System.String]'scanForMDTUSBToolStripMenuItem'
$scanForMDTUSBToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]179,[System.Int32]22))
$scanForMDTUSBToolStripMenuItem.Text = [System.String]'Scan for MDT USB...'
#
#toolStripSeparator2
#
$toolStripSeparator2.Name = [System.String]'toolStripSeparator2'
$toolStripSeparator2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]176,[System.Int32]6))
#
#importINIFileToolStripMenuItem
#
$importINIFileToolStripMenuItem.Name = [System.String]'importINIFileToolStripMenuItem'
$importINIFileToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]179,[System.Int32]22))
$importINIFileToolStripMenuItem.Text = [System.String]'Import Config File...'
$importINIFileToolStripMenuItem.add_Click($importINIFileToolStripMenuItem_Click)
#
#exportConfigFileToolStripMenuItem
#
$exportConfigFileToolStripMenuItem.Name = [System.String]'exportConfigFileToolStripMenuItem'
$exportConfigFileToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]179,[System.Int32]22))
$exportConfigFileToolStripMenuItem.Text = [System.String]'Export Config File...'
$exportConfigFileToolStripMenuItem.add_Click($exportConfigFileToolStripMenuItem_Click)
#
#toolStripSeparator1
#
$toolStripSeparator1.Name = [System.String]'toolStripSeparator1'
$toolStripSeparator1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]176,[System.Int32]6))
#
#exitToolStripMenuItem
#
$exitToolStripMenuItem.Name = [System.String]'exitToolStripMenuItem'
$exitToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]179,[System.Int32]22))
$exitToolStripMenuItem.Text = [System.String]'Exit'
#
#viewToolStripMenuItem
#
$viewToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($reloadComputerToolStripMenuItem,$updateGroupPolicyToolStripMenuItem,$restartExplorerToolStripMenuItem,$toolStripSeparator3,$openScriptToolStripMenuItem))
$viewToolStripMenuItem.Name = [System.String]'viewToolStripMenuItem'
$viewToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]54,[System.Int32]20))
$viewToolStripMenuItem.Text = [System.String]'Action'
#
#reloadComputerToolStripMenuItem
#
$reloadComputerToolStripMenuItem.Name = [System.String]'reloadComputerToolStripMenuItem'
$reloadComputerToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]183,[System.Int32]22))
$reloadComputerToolStripMenuItem.Text = [System.String]'Reload Live State'
$reloadComputerToolStripMenuItem.add_Click($reloadComputerToolStripMenuItem_Click)
#
#updateGroupPolicyToolStripMenuItem
#
$updateGroupPolicyToolStripMenuItem.Name = [System.String]'updateGroupPolicyToolStripMenuItem'
$updateGroupPolicyToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]183,[System.Int32]22))
$updateGroupPolicyToolStripMenuItem.Text = [System.String]'Update Group Policy'
$updateGroupPolicyToolStripMenuItem.add_Click($updateGroupPolicyToolStripMenuItem_Click)
#
#restartExplorerToolStripMenuItem
#
$restartExplorerToolStripMenuItem.Name = [System.String]'restartExplorerToolStripMenuItem'
$restartExplorerToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]183,[System.Int32]22))
$restartExplorerToolStripMenuItem.Text = [System.String]'Restart Explorer'
$restartExplorerToolStripMenuItem.add_Click($restartExplorerToolStripMenuItem_Click)
#
#toolStripSeparator3
#
$toolStripSeparator3.Name = [System.String]'toolStripSeparator3'
$toolStripSeparator3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]180,[System.Int32]6))
#
#openScriptToolStripMenuItem
#
$openScriptToolStripMenuItem.Name = [System.String]'openScriptToolStripMenuItem'
$openScriptToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]183,[System.Int32]22))
$openScriptToolStripMenuItem.Text = [System.String]'Open Script'
$openScriptToolStripMenuItem.add_Click($openScriptToolStripMenuItem_Click)
#
#btnExport
#
$btnExport.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]397,[System.Int32]501))
$btnExport.Name = [System.String]'btnExport'
$btnExport.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$btnExport.TabIndex = [System.Int32]17
$btnExport.Text = [System.String]'Export'
$btnExport.UseCompatibleTextRendering = $true
$btnExport.UseVisualStyleBackColor = $true
$btnExport.add_Click($btnExport_Click)
#
#tabWebBrowser
#
$tabWebBrowser.Controls.Add($gbxChrome)
$tabWebBrowser.Controls.Add($gbxEdge)
$tabWebBrowser.Controls.Add($gbxInternetExplorer)
$tabWebBrowser.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabWebBrowser.Name = [System.String]'tabWebBrowser'
$tabWebBrowser.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]436))
$tabWebBrowser.TabIndex = [System.Int32]4
$tabWebBrowser.Text = [System.String]'Web Browser'
$tabWebBrowser.UseVisualStyleBackColor = $true
#
#gbxChrome
#
$gbxChrome.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]355))
$gbxChrome.Name = [System.String]'gbxChrome'
$gbxChrome.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]531,[System.Int32]78))
$gbxChrome.TabIndex = [System.Int32]3
$gbxChrome.TabStop = $false
$gbxChrome.Text = [System.String]'Google Chrome'
#
#gbxEdge
#
$gbxEdge.Controls.Add($chkDisableEdgeShortcut)
$gbxEdge.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]224))
$gbxEdge.Name = [System.String]'gbxEdge'
$gbxEdge.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]531,[System.Int32]125))
$gbxEdge.TabIndex = [System.Int32]2
$gbxEdge.TabStop = $false
$gbxEdge.Text = [System.String]'Microsoft Edge'
#
#chkDisableEdgeShortcut
#
$chkDisableEdgeShortcut.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]22))
$chkDisableEdgeShortcut.Name = [System.String]'chkDisableEdgeShortcut'
$chkDisableEdgeShortcut.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$chkDisableEdgeShortcut.TabIndex = [System.Int32]1
$chkDisableEdgeShortcut.Text = [System.String]'Disable Edge Shortcut Creation after update'
$chkDisableEdgeShortcut.UseCompatibleTextRendering = $true
$chkDisableEdgeShortcut.UseVisualStyleBackColor = $true
#
#gbxInternetExplorer
#
$gbxInternetExplorer.Controls.Add($label2)
$gbxInternetExplorer.Controls.Add($chkDisableIEFirstRunWizard)
$gbxInternetExplorer.Controls.Add($chkDisableIESuggestedSites)
$gbxInternetExplorer.Controls.Add($chkDisableIEPasswordAutoComplete)
$gbxInternetExplorer.Controls.Add($chkDisableIESmileyButton)
$gbxInternetExplorer.Controls.Add($chkDisableIENewEdgeTab)
$gbxInternetExplorer.Controls.Add($label1)
$gbxInternetExplorer.Controls.Add($chkLockIEToolbars)
$gbxInternetExplorer.Controls.Add($chkShowIEStatusBar)
$gbxInternetExplorer.Controls.Add($chkShowIEFavoritesBar)
$gbxInternetExplorer.Controls.Add($chkShowIEMenuBar)
$gbxInternetExplorer.Controls.Add($chkDisableIEPopupMgmt)
$gbxInternetExplorer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$gbxInternetExplorer.Name = [System.String]'gbxInternetExplorer'
$gbxInternetExplorer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]531,[System.Int32]215))
$gbxInternetExplorer.TabIndex = [System.Int32]0
$gbxInternetExplorer.TabStop = $false
$gbxInternetExplorer.Text = [System.String]'Internet Explorer'
#
#label2
#
$label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]241,[System.Int32]176))
$label2.Name = [System.String]'label2'
$label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]95,[System.Int32]17))
$label2.TabIndex = [System.Int32]17
$label2.Text = [System.String]'Trusted Sites:'
$label2.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#chkDisableIEFirstRunWizard
#
$chkDisableIEFirstRunWizard.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]68))
$chkDisableIEFirstRunWizard.Name = [System.String]'chkDisableIEFirstRunWizard'
$chkDisableIEFirstRunWizard.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]150,[System.Int32]17))
$chkDisableIEFirstRunWizard.TabIndex = [System.Int32]1
$chkDisableIEFirstRunWizard.Text = [System.String]'Disable First Run Wizard'
$chkDisableIEFirstRunWizard.UseCompatibleTextRendering = $true
$chkDisableIEFirstRunWizard.UseVisualStyleBackColor = $true
#
#chkDisableIESuggestedSites
#
$chkDisableIESuggestedSites.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]91))
$chkDisableIESuggestedSites.Name = [System.String]'chkDisableIESuggestedSites'
$chkDisableIESuggestedSites.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkDisableIESuggestedSites.TabIndex = [System.Int32]4
$chkDisableIESuggestedSites.Text = [System.String]'Disable Suggested Sites'
$chkDisableIESuggestedSites.UseCompatibleTextRendering = $true
$chkDisableIESuggestedSites.UseVisualStyleBackColor = $true
#
#chkDisableIEPasswordAutoComplete
#
$chkDisableIEPasswordAutoComplete.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]22))
$chkDisableIEPasswordAutoComplete.Name = [System.String]'chkDisableIEPasswordAutoComplete'
$chkDisableIEPasswordAutoComplete.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]209,[System.Int32]17))
$chkDisableIEPasswordAutoComplete.TabIndex = [System.Int32]3
$chkDisableIEPasswordAutoComplete.Text = [System.String]'Disable Password Auto-Complete'
$chkDisableIEPasswordAutoComplete.UseCompatibleTextRendering = $true
$chkDisableIEPasswordAutoComplete.UseVisualStyleBackColor = $true
#
#chkDisableIESmileyButton
#
$chkDisableIESmileyButton.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]114))
$chkDisableIESmileyButton.Name = [System.String]'chkDisableIESmileyButton'
$chkDisableIESmileyButton.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkDisableIESmileyButton.TabIndex = [System.Int32]5
$chkDisableIESmileyButton.Text = [System.String]'Disable Smiley Button'
$chkDisableIESmileyButton.UseCompatibleTextRendering = $true
$chkDisableIESmileyButton.UseVisualStyleBackColor = $true
#
#chkDisableIENewEdgeTab
#
$chkDisableIENewEdgeTab.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]137))
$chkDisableIENewEdgeTab.Name = [System.String]'chkDisableIENewEdgeTab'
$chkDisableIENewEdgeTab.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkDisableIENewEdgeTab.TabIndex = [System.Int32]16
$chkDisableIENewEdgeTab.Text = [System.String]'Disable Edge Tab'
$chkDisableIENewEdgeTab.UseCompatibleTextRendering = $true
$chkDisableIENewEdgeTab.UseVisualStyleBackColor = $true
#
#label1
#
$label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]241,[System.Int32]159))
$label1.Name = [System.String]'label1'
$label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]95,[System.Int32]17))
$label1.TabIndex = [System.Int32]15
$label1.Text = [System.String]'Homepage:'
$label1.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#chkLockIEToolbars
#
$chkLockIEToolbars.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]244,[System.Int32]91))
$chkLockIEToolbars.Name = [System.String]'chkLockIEToolbars'
$chkLockIEToolbars.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkLockIEToolbars.TabIndex = [System.Int32]9
$chkLockIEToolbars.Text = [System.String]'Lock Toolbars'
$chkLockIEToolbars.UseCompatibleTextRendering = $true
$chkLockIEToolbars.UseVisualStyleBackColor = $true
#
#chkShowIEStatusBar
#
$chkShowIEStatusBar.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]244,[System.Int32]68))
$chkShowIEStatusBar.Name = [System.String]'chkShowIEStatusBar'
$chkShowIEStatusBar.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkShowIEStatusBar.TabIndex = [System.Int32]8
$chkShowIEStatusBar.Text = [System.String]'Show Status Bar'
$chkShowIEStatusBar.UseCompatibleTextRendering = $true
$chkShowIEStatusBar.UseVisualStyleBackColor = $true
#
#chkShowIEFavoritesBar
#
$chkShowIEFavoritesBar.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]244,[System.Int32]45))
$chkShowIEFavoritesBar.Name = [System.String]'chkShowIEFavoritesBar'
$chkShowIEFavoritesBar.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkShowIEFavoritesBar.TabIndex = [System.Int32]7
$chkShowIEFavoritesBar.Text = [System.String]'Show Favorites Bar'
$chkShowIEFavoritesBar.UseCompatibleTextRendering = $true
$chkShowIEFavoritesBar.UseVisualStyleBackColor = $true
#
#chkShowIEMenuBar
#
$chkShowIEMenuBar.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]244,[System.Int32]22))
$chkShowIEMenuBar.Name = [System.String]'chkShowIEMenuBar'
$chkShowIEMenuBar.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]190,[System.Int32]17))
$chkShowIEMenuBar.TabIndex = [System.Int32]6
$chkShowIEMenuBar.Text = [System.String]'Show Menu Bar'
$chkShowIEMenuBar.UseCompatibleTextRendering = $true
$chkShowIEMenuBar.UseVisualStyleBackColor = $true
#
#chkDisableIEPopupMgmt
#
$chkDisableIEPopupMgmt.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]45))
$chkDisableIEPopupMgmt.Name = [System.String]'chkDisableIEPopupMgmt'
$chkDisableIEPopupMgmt.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]178,[System.Int32]17))
$chkDisableIEPopupMgmt.TabIndex = [System.Int32]2
$chkDisableIEPopupMgmt.Text = [System.String]'Disable Popup Management'
$chkDisableIEPopupMgmt.UseCompatibleTextRendering = $true
$chkDisableIEPopupMgmt.UseVisualStyleBackColor = $true
#
#tabNetworking
#
$tabNetworking.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabNetworking.Name = [System.String]'tabNetworking'
$tabNetworking.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]436))
$tabNetworking.TabIndex = [System.Int32]3
$tabNetworking.Text = [System.String]'Networking'
$tabNetworking.UseVisualStyleBackColor = $true
#
#tabSecurity
#
$tabSecurity.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabSecurity.Name = [System.String]'tabSecurity'
$tabSecurity.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]436))
$tabSecurity.TabIndex = [System.Int32]2
$tabSecurity.Text = [System.String]'Security'
$tabSecurity.UseVisualStyleBackColor = $true
#
#tabWindows
#
$tabWindows.Controls.Add($groupBox2)
$tabWindows.Controls.Add($groupBox1)
$tabWindows.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabWindows.Name = [System.String]'tabWindows'
$tabWindows.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$tabWindows.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]436))
$tabWindows.TabIndex = [System.Int32]0
$tabWindows.Text = [System.String]'Windows'
$tabWindows.UseVisualStyleBackColor = $true
#
#groupBox2
#
$groupBox2.Controls.Add($cmbComputerLabel)
$groupBox2.Controls.Add($lblComputerLabel)
$groupBox2.Controls.Add($chkLockWindowsUpdate)
$groupBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]241))
$groupBox2.Name = [System.String]'groupBox2'
$groupBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]525,[System.Int32]189))
$groupBox2.TabIndex = [System.Int32]19
$groupBox2.TabStop = $false
$groupBox2.Text = [System.String]'groupBox2'
#
#cmbComputerLabel
#
$cmbComputerLabel.FormattingEnabled = $true
$cmbComputerLabel.Items.AddRange([System.Object[]]@([System.String]'This PC',[System.String]'Computer %COMPUTERNAME%',[System.String]'%COMPUTERNAME%',[System.String]'%USERNAME% on %COMPUTERNAME%'))
$cmbComputerLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]115,[System.Int32]53))
$cmbComputerLabel.Name = [System.String]'cmbComputerLabel'
$cmbComputerLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]217,[System.Int32]21))
$cmbComputerLabel.TabIndex = [System.Int32]15
#
#lblComputerLabel
#
$lblComputerLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]53))
$lblComputerLabel.Name = [System.String]'lblComputerLabel'
$lblComputerLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]87,[System.Int32]17))
$lblComputerLabel.TabIndex = [System.Int32]13
$lblComputerLabel.Text = [System.String]'Computer label:'
$lblComputerLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#chkLockWindowsUpdate
#
$chkLockWindowsUpdate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]11,[System.Int32]96))
$chkLockWindowsUpdate.Name = [System.String]'chkLockWindowsUpdate'
$chkLockWindowsUpdate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$chkLockWindowsUpdate.TabIndex = [System.Int32]6
$chkLockWindowsUpdate.Text = [System.String]'Lock Windows Update'
$chkLockWindowsUpdate.UseCompatibleTextRendering = $true
$chkLockWindowsUpdate.UseVisualStyleBackColor = $true
#
#groupBox1
#
$groupBox1.Controls.Add($checkBox4)
$groupBox1.Controls.Add($checkBox3)
$groupBox1.Controls.Add($checkBox2)
$groupBox1.Controls.Add($checkBox1)
$groupBox1.Controls.Add($chkDisableDefender)
$groupBox1.Controls.Add($chkDisableUACPrompt)
$groupBox1.Controls.Add($cmbControlPanelView)
$groupBox1.Controls.Add($chkHideTaskView)
$groupBox1.Controls.Add($lblControlPanelView)
$groupBox1.Controls.Add($chkHidePeople)
$groupBox1.Controls.Add($chkDisableSmartScreen)
$groupBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]9))
$groupBox1.Name = [System.String]'groupBox1'
$groupBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]525,[System.Int32]226))
$groupBox1.TabIndex = [System.Int32]18
$groupBox1.TabStop = $false
$groupBox1.Text = [System.String]'groupBox1'
#
#checkBox4
#
$checkBox4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]182,[System.Int32]82))
$checkBox4.Name = [System.String]'checkBox4'
$checkBox4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$checkBox4.TabIndex = [System.Int32]21
$checkBox4.Text = [System.String]'Disable private firewall'
$checkBox4.UseCompatibleTextRendering = $true
$checkBox4.UseVisualStyleBackColor = $true
#
#checkBox3
#
$checkBox3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]182,[System.Int32]151))
$checkBox3.Name = [System.String]'checkBox3'
$checkBox3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]290,[System.Int32]17))
$checkBox3.TabIndex = [System.Int32]20
$checkBox3.Text = [System.String]'Disable automatic network-connected device setup'
$checkBox3.UseCompatibleTextRendering = $true
$checkBox3.UseVisualStyleBackColor = $true
#
#checkBox2
#
$checkBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]182,[System.Int32]128))
$checkBox2.Name = [System.String]'checkBox2'
$checkBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$checkBox2.TabIndex = [System.Int32]19
$checkBox2.Text = [System.String]'Disable Web Search'
$checkBox2.UseCompatibleTextRendering = $true
$checkBox2.UseVisualStyleBackColor = $true
#
#checkBox1
#
$checkBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]182,[System.Int32]105))
$checkBox1.Name = [System.String]'checkBox1'
$checkBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$checkBox1.TabIndex = [System.Int32]18
$checkBox1.Text = [System.String]'Disable Cortana'
$checkBox1.UseCompatibleTextRendering = $true
$checkBox1.UseVisualStyleBackColor = $true
#
#chkDisableDefender
#
$chkDisableDefender.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]111))
$chkDisableDefender.Name = [System.String]'chkDisableDefender'
$chkDisableDefender.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$chkDisableDefender.TabIndex = [System.Int32]7
$chkDisableDefender.Text = [System.String]'Disable Defender'
$chkDisableDefender.UseCompatibleTextRendering = $true
$chkDisableDefender.UseVisualStyleBackColor = $true
#
#chkDisableUACPrompt
#
$chkDisableUACPrompt.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]157))
$chkDisableUACPrompt.Name = [System.String]'chkDisableUACPrompt'
$chkDisableUACPrompt.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$chkDisableUACPrompt.TabIndex = [System.Int32]17
$chkDisableUACPrompt.Text = [System.String]'Disable UAC prompts'
$chkDisableUACPrompt.UseCompatibleTextRendering = $true
$chkDisableUACPrompt.UseVisualStyleBackColor = $true
#
#cmbControlPanelView
#
$cmbControlPanelView.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbControlPanelView.FormattingEnabled = $true
$cmbControlPanelView.Items.AddRange([System.Object[]]@([System.String]'Large icons',[System.String]'Small icons'))
$cmbControlPanelView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]116,[System.Int32]199))
$cmbControlPanelView.Name = [System.String]'cmbControlPanelView'
$cmbControlPanelView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]216,[System.Int32]21))
$cmbControlPanelView.TabIndex = [System.Int32]8
#
#chkHideTaskView
#
$chkHideTaskView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]43))
$chkHideTaskView.Name = [System.String]'chkHideTaskView'
$chkHideTaskView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$chkHideTaskView.TabIndex = [System.Int32]5
$chkHideTaskView.Text = [System.String]'Hide Task View button'
$chkHideTaskView.UseCompatibleTextRendering = $true
$chkHideTaskView.UseVisualStyleBackColor = $true
#
#lblControlPanelView
#
$lblControlPanelView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]199))
$lblControlPanelView.Name = [System.String]'lblControlPanelView'
$lblControlPanelView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]102,[System.Int32]17))
$lblControlPanelView.TabIndex = [System.Int32]12
$lblControlPanelView.Text = [System.String]'Control Panel view:'
$lblControlPanelView.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#chkHidePeople
#
$chkHidePeople.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]20))
$chkHidePeople.Name = [System.String]'chkHidePeople'
$chkHidePeople.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]119,[System.Int32]17))
$chkHidePeople.TabIndex = [System.Int32]0
$chkHidePeople.Text = [System.String]'Hide People button'
$chkHidePeople.UseCompatibleTextRendering = $true
$chkHidePeople.UseVisualStyleBackColor = $true
#
#chkDisableSmartScreen
#
$chkDisableSmartScreen.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]134))
$chkDisableSmartScreen.Name = [System.String]'chkDisableSmartScreen'
$chkDisableSmartScreen.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$chkDisableSmartScreen.TabIndex = [System.Int32]16
$chkDisableSmartScreen.Text = [System.String]'Disable SmartScreen'
$chkDisableSmartScreen.UseCompatibleTextRendering = $true
$chkDisableSmartScreen.UseVisualStyleBackColor = $true
#
#tabControl
#
$tabControl.Controls.Add($tabComputer)
$tabControl.Controls.Add($tabWindows)
$tabControl.Controls.Add($tabSecurity)
$tabControl.Controls.Add($tabNetworking)
$tabControl.Controls.Add($tabWebBrowser)
$tabControl.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]33))
$tabControl.Name = [System.String]'tabControl'
$tabControl.SelectedIndex = [System.Int32]0
$tabControl.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]545,[System.Int32]462))
$tabControl.TabIndex = [System.Int32]15
#
#tabComputer
#
$tabComputer.Controls.Add($gbxLockWindowsUpdate)
$tabComputer.Controls.Add($lblWorkgroup)
$tabComputer.Controls.Add($textBox1)
$tabComputer.Controls.Add($lblComputerName)
$tabComputer.Controls.Add($tbxComputerName)
$tabComputer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]22))
$tabComputer.Name = [System.String]'tabComputer'
$tabComputer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]537,[System.Int32]436))
$tabComputer.TabIndex = [System.Int32]5
$tabComputer.Text = [System.String]'Computer'
$tabComputer.UseVisualStyleBackColor = $true
#
#gbxLockWindowsUpdate
#
$gbxLockWindowsUpdate.Controls.Add($rdoUnlockWindowsUpdate)
$gbxLockWindowsUpdate.Controls.Add($rdoLockWindowsUpdate)
$gbxLockWindowsUpdate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]76))
$gbxLockWindowsUpdate.Name = [System.String]'gbxLockWindowsUpdate'
$gbxLockWindowsUpdate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]210,[System.Int32]80))
$gbxLockWindowsUpdate.TabIndex = [System.Int32]24
$gbxLockWindowsUpdate.TabStop = $false
$gbxLockWindowsUpdate.Text = [System.String]'Windows Update'
#
#rdoUnlockWindowsUpdate
#
$rdoUnlockWindowsUpdate.Appearance = [System.Windows.Forms.Appearance]::Button
$rdoUnlockWindowsUpdate.FlatStyle = [System.Windows.Forms.FlatStyle]::System
$rdoUnlockWindowsUpdate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]103,[System.Int32]28))
$rdoUnlockWindowsUpdate.Name = [System.String]'rdoUnlockWindowsUpdate'
$rdoUnlockWindowsUpdate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]85,[System.Int32]30))
$rdoUnlockWindowsUpdate.TabIndex = [System.Int32]1
$rdoUnlockWindowsUpdate.TabStop = $true
$rdoUnlockWindowsUpdate.Text = [System.String]'Unlock'
$rdoUnlockWindowsUpdate.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$rdoUnlockWindowsUpdate.UseVisualStyleBackColor = $true
$rdoUnlockWindowsUpdate.add_CheckedChanged($rdoUnlockWindowsUpdate_CheckedChanged)
#
#rdoLockWindowsUpdate
#
$rdoLockWindowsUpdate.Appearance = [System.Windows.Forms.Appearance]::Button
$rdoLockWindowsUpdate.FlatStyle = [System.Windows.Forms.FlatStyle]::System
$rdoLockWindowsUpdate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]20,[System.Int32]28))
$rdoLockWindowsUpdate.Name = [System.String]'rdoLockWindowsUpdate'
$rdoLockWindowsUpdate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]85,[System.Int32]30))
$rdoLockWindowsUpdate.TabIndex = [System.Int32]0
$rdoLockWindowsUpdate.TabStop = $true
$rdoLockWindowsUpdate.Text = [System.String]'Lock'
$rdoLockWindowsUpdate.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$rdoLockWindowsUpdate.UseVisualStyleBackColor = $true
$rdoLockWindowsUpdate.add_CheckedChanged($rdoLockWindowsUpdate_CheckedChanged)
#
#lblWorkgroup
#
$lblWorkgroup.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]36))
$lblWorkgroup.Name = [System.String]'lblWorkgroup'
$lblWorkgroup.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]90,[System.Int32]17))
$lblWorkgroup.TabIndex = [System.Int32]15
$lblWorkgroup.Text = [System.String]'Workgroup:'
$lblWorkgroup.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#textBox1
#
$textBox1.BackColor = [System.Drawing.SystemColors]::Window
$textBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]111,[System.Int32]36))
$textBox1.Name = [System.String]'textBox1'
$textBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]217,[System.Int32]20))
$textBox1.TabIndex = [System.Int32]14
#
#lblComputerName
#
$lblComputerName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]4,[System.Int32]10))
$lblComputerName.Name = [System.String]'lblComputerName'
$lblComputerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]90,[System.Int32]17))
$lblComputerName.TabIndex = [System.Int32]13
$lblComputerName.Text = [System.String]'Computer Name:'
$lblComputerName.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#tbxComputerName
#
$tbxComputerName.BackColor = [System.Drawing.SystemColors]::Window
$tbxComputerName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]111,[System.Int32]10))
$tbxComputerName.Name = [System.String]'tbxComputerName'
$tbxComputerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]217,[System.Int32]20))
$tbxComputerName.TabIndex = [System.Int32]12
#
#frmMain
#
$frmMain.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]568,[System.Int32]535))
$frmMain.Controls.Add($btnExport)
$frmMain.Controls.Add($tabControl)
$frmMain.Controls.Add($btnApply)
$frmMain.Controls.Add($menuStrip1)
$frmMain.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$frmMain.MainMenuStrip = $menuStrip1
$frmMain.MaximizeBox = $false
$frmMain.Name = [System.String]'frmMain'
$frmMain.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$frmMain.Text = [System.String]'ConfigHost'
$frmMain.add_Load($frmMain_Load)
$menuStrip1.ResumeLayout($false)
$menuStrip1.PerformLayout()
$tabWebBrowser.ResumeLayout($false)
$gbxEdge.ResumeLayout($false)
$gbxInternetExplorer.ResumeLayout($false)
$tabWindows.ResumeLayout($false)
$groupBox2.ResumeLayout($false)
$groupBox1.ResumeLayout($false)
$tabControl.ResumeLayout($false)
$tabComputer.ResumeLayout($false)
$tabComputer.PerformLayout()
$gbxLockWindowsUpdate.ResumeLayout($false)
$frmMain.ResumeLayout($false)
$frmMain.PerformLayout()
Add-Member -InputObject $frmMain -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnApply -Value $btnApply -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name menuStrip1 -Value $menuStrip1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name fileToolStripMenuItem -Value $fileToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name reloadComputerToolStripMenuItem -Value $reloadComputerToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name importINIFileToolStripMenuItem -Value $importINIFileToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name exportConfigFileToolStripMenuItem -Value $exportConfigFileToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name scanForMDTUSBToolStripMenuItem -Value $scanForMDTUSBToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name toolStripSeparator1 -Value $toolStripSeparator1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name exitToolStripMenuItem -Value $exitToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name viewToolStripMenuItem -Value $viewToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name toolStripSeparator2 -Value $toolStripSeparator2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name updateGroupPolicyToolStripMenuItem -Value $updateGroupPolicyToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name restartExplorerToolStripMenuItem -Value $restartExplorerToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnExport -Value $btnExport -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name openScriptToolStripMenuItem -Value $openScriptToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tabWebBrowser -Value $tabWebBrowser -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tabNetworking -Value $tabNetworking -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tabSecurity -Value $tabSecurity -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tabWindows -Value $tabWindows -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox2 -Value $groupBox2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cmbComputerLabel -Value $cmbComputerLabel -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblComputerLabel -Value $lblComputerLabel -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cmbControlPanelView -Value $cmbControlPanelView -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblControlPanelView -Value $lblControlPanelView -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox1 -Value $groupBox1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableDefender -Value $chkDisableDefender -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableUACPrompt -Value $chkDisableUACPrompt -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkLockWindowsUpdate -Value $chkLockWindowsUpdate -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkHideTaskView -Value $chkHideTaskView -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkHidePeople -Value $chkHidePeople -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableSmartScreen -Value $chkDisableSmartScreen -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tabControl -Value $tabControl -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxInternetExplorer -Value $gbxInternetExplorer -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxChrome -Value $gbxChrome -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxEdge -Value $gbxEdge -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableEdgeShortcut -Value $chkDisableEdgeShortcut -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tabComputer -Value $tabComputer -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblWorkgroup -Value $lblWorkgroup -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name textBox1 -Value $textBox1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblComputerName -Value $lblComputerName -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tbxComputerName -Value $tbxComputerName -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name label1 -Value $label1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox4 -Value $checkBox4 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox3 -Value $checkBox3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox2 -Value $checkBox2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox1 -Value $checkBox1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name label2 -Value $label2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIEPasswordAutoComplete -Value $chkDisableIEPasswordAutoComplete -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIEFirstRunWizard -Value $chkDisableIEFirstRunWizard -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIEPopupMgmt -Value $chkDisableIEPopupMgmt -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIESuggestedSites -Value $chkDisableIESuggestedSites -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIESmileyButton -Value $chkDisableIESmileyButton -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIENewEdgeTab -Value $chkDisableIENewEdgeTab -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowIEMenuBar -Value $chkShowIEMenuBar -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowIEStatusBar -Value $chkShowIEStatusBar -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowIEFavoritesBar -Value $chkShowIEFavoritesBar -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkLockIEToolbars -Value $chkLockIEToolbars -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxLockWindowsUpdate -Value $gbxLockWindowsUpdate -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name rdoUnlockWindowsUpdate -Value $rdoUnlockWindowsUpdate -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name rdoLockWindowsUpdate -Value $rdoLockWindowsUpdate -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name toolStripSeparator3 -Value $toolStripSeparator3 -MemberType NoteProperty
}
. InitializeComponent
