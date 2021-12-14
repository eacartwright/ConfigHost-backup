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
[System.Windows.Forms.ToolStripMenuItem]$reapplyConfigToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$openConfigScriptToolStripMenuItem = $null
[System.ComponentModel.IContainer]$components = $null
[System.Windows.Forms.DataGridView]$dataGridView1 = $null
[System.Windows.Forms.DataGridViewTextBoxColumn]$SettingGroup = $null
[System.Windows.Forms.Panel]$panel5 = $null
[System.Windows.Forms.TableLayoutPanel]$tableLayoutPanel1 = $null
[System.Windows.Forms.GroupBox]$groupBox4 = $null
[System.Windows.Forms.GroupBox]$groupBox5 = $null
[System.Windows.Forms.CheckBox]$checkBox4 = $null
[System.Windows.Forms.CheckBox]$checkBox3 = $null
[System.Windows.Forms.Panel]$panel4 = $null
[System.Windows.Forms.CheckBox]$chkDisableCheckForUpdates = $null
[System.Windows.Forms.GroupBox]$gbxDisableCheckForUpdates = $null
[System.Windows.Forms.RadioButton]$rdoEnableCheckForUpdates = $null
[System.Windows.Forms.RadioButton]$rdoDisableCheckForUpdates = $null
[System.Windows.Forms.Label]$lblComputerName = $null
[System.Windows.Forms.Label]$lblWorkgroup = $null
[System.Windows.Forms.TextBox]$tbxComputerName = $null
[System.Windows.Forms.TextBox]$textBox1 = $null
[System.Windows.Forms.CheckBox]$chkDisableDefender = $null
[System.Windows.Forms.CheckBox]$chkDisableSmartScreen = $null
[System.Windows.Forms.CheckBox]$chkDisableUAC = $null
[System.Windows.Forms.Panel]$panel3 = $null
[System.Windows.Forms.GroupBox]$gbxInternetExplorer = $null
[System.Windows.Forms.Label]$label2 = $null
[System.Windows.Forms.CheckBox]$chkDisableIEFirstRunWizard = $null
[System.Windows.Forms.CheckBox]$chkDisableIESuggestedSites = $null
[System.Windows.Forms.CheckBox]$chkDisableIEPasswordAutoComplete = $null
[System.Windows.Forms.CheckBox]$chkDisableIESmileyButton = $null
[System.Windows.Forms.CheckBox]$chkDisableIENewEdgeTab = $null
[System.Windows.Forms.Label]$label1 = $null
[System.Windows.Forms.CheckBox]$chkLockIEToolbars = $null
[System.Windows.Forms.CheckBox]$chkShowIEStatusBar = $null
[System.Windows.Forms.CheckBox]$chkShowIEFavoritesBar = $null
[System.Windows.Forms.CheckBox]$chkShowIEMenuBar = $null
[System.Windows.Forms.CheckBox]$chkDisableIEPopupMgmt = $null
[System.Windows.Forms.GroupBox]$groupBox3 = $null
[System.Windows.Forms.GroupBox]$gbxEdge = $null
[System.Windows.Forms.CheckBox]$chkDisableEdgeShortcut = $null
[System.Windows.Forms.Panel]$panel6 = $null
[System.Windows.Forms.CheckBox]$checkBox11 = $null
[System.Windows.Forms.CheckBox]$checkBox12 = $null
[System.Windows.Forms.CheckBox]$checkBox13 = $null
[System.Windows.Forms.CheckBox]$checkBox14 = $null
[System.Windows.Forms.CheckBox]$checkBox15 = $null
[System.Windows.Forms.CheckBox]$checkBox16 = $null
[System.Windows.Forms.CheckBox]$checkBox10 = $null
[System.Windows.Forms.CheckBox]$checkBox9 = $null
[System.Windows.Forms.CheckBox]$checkBox8 = $null
[System.Windows.Forms.CheckBox]$checkBox7 = $null
[System.Windows.Forms.CheckBox]$checkBox6 = $null
[System.Windows.Forms.CheckBox]$checkBox5 = $null
[System.Windows.Forms.GroupBox]$gbxDesktop = $null
[System.Windows.Forms.CheckBox]$chkShowRecycleBinOnDesktop = $null
[System.Windows.Forms.CheckBox]$chkShowUserFolderOnDesktop = $null
[System.Windows.Forms.CheckBox]$chkShowComputerOnDesktop = $null
[System.Windows.Forms.GroupBox]$groupBox2 = $null
[System.Windows.Forms.CheckBox]$checkBox1 = $null
[System.Windows.Forms.GroupBox]$groupBox1 = $null
[System.Windows.Forms.CheckBox]$chkClearTaskbarPins = $null
[System.Windows.Forms.CheckBox]$checkBox2 = $null
[System.Windows.Forms.CheckBox]$chkHideTaskView = $null
[System.Windows.Forms.CheckBox]$chkHidePeople = $null
[System.Windows.Forms.GroupBox]$gbxExplorer = $null
[System.Windows.Forms.ComboBox]$cmbControlPanelView = $null
[System.Windows.Forms.Label]$lblControlPanelView = $null
[System.Windows.Forms.Label]$lblSetThisPCLabel = $null
[System.Windows.Forms.ComboBox]$cmbSetThisPCLabel = $null
[System.Windows.Forms.Panel]$panel2 = $null
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
$reapplyConfigToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$openConfigScriptToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$btnExport = (New-Object -TypeName System.Windows.Forms.Button)
$dataGridView1 = (New-Object -TypeName System.Windows.Forms.DataGridView)
$SettingGroup = (New-Object -TypeName System.Windows.Forms.DataGridViewTextBoxColumn)
$panel5 = (New-Object -TypeName System.Windows.Forms.Panel)
$tableLayoutPanel1 = (New-Object -TypeName System.Windows.Forms.TableLayoutPanel)
$groupBox4 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$groupBox5 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$checkBox4 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox3 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$panel4 = (New-Object -TypeName System.Windows.Forms.Panel)
$chkDisableCheckForUpdates = (New-Object -TypeName System.Windows.Forms.CheckBox)
$gbxDisableCheckForUpdates = (New-Object -TypeName System.Windows.Forms.GroupBox)
$rdoEnableCheckForUpdates = (New-Object -TypeName System.Windows.Forms.RadioButton)
$rdoDisableCheckForUpdates = (New-Object -TypeName System.Windows.Forms.RadioButton)
$lblComputerName = (New-Object -TypeName System.Windows.Forms.Label)
$lblWorkgroup = (New-Object -TypeName System.Windows.Forms.Label)
$tbxComputerName = (New-Object -TypeName System.Windows.Forms.TextBox)
$textBox1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$chkDisableDefender = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableSmartScreen = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkDisableUAC = (New-Object -TypeName System.Windows.Forms.CheckBox)
$panel3 = (New-Object -TypeName System.Windows.Forms.Panel)
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
$groupBox3 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$gbxEdge = (New-Object -TypeName System.Windows.Forms.GroupBox)
$chkDisableEdgeShortcut = (New-Object -TypeName System.Windows.Forms.CheckBox)
$panel6 = (New-Object -TypeName System.Windows.Forms.Panel)
$checkBox11 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox12 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox13 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox14 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox15 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox16 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox10 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox9 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox8 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox7 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox6 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox5 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$gbxDesktop = (New-Object -TypeName System.Windows.Forms.GroupBox)
$chkShowRecycleBinOnDesktop = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkShowUserFolderOnDesktop = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkShowComputerOnDesktop = (New-Object -TypeName System.Windows.Forms.CheckBox)
$groupBox2 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$checkBox1 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$groupBox1 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$chkClearTaskbarPins = (New-Object -TypeName System.Windows.Forms.CheckBox)
$checkBox2 = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkHideTaskView = (New-Object -TypeName System.Windows.Forms.CheckBox)
$chkHidePeople = (New-Object -TypeName System.Windows.Forms.CheckBox)
$gbxExplorer = (New-Object -TypeName System.Windows.Forms.GroupBox)
$cmbControlPanelView = (New-Object -TypeName System.Windows.Forms.ComboBox)
$lblControlPanelView = (New-Object -TypeName System.Windows.Forms.Label)
$lblSetThisPCLabel = (New-Object -TypeName System.Windows.Forms.Label)
$cmbSetThisPCLabel = (New-Object -TypeName System.Windows.Forms.ComboBox)
$panel2 = (New-Object -TypeName System.Windows.Forms.Panel)
$menuStrip1.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$dataGridView1).BeginInit()
$panel5.SuspendLayout()
$tableLayoutPanel1.SuspendLayout()
$panel4.SuspendLayout()
$gbxDisableCheckForUpdates.SuspendLayout()
$panel3.SuspendLayout()
$gbxInternetExplorer.SuspendLayout()
$gbxEdge.SuspendLayout()
$panel6.SuspendLayout()
$gbxDesktop.SuspendLayout()
$groupBox2.SuspendLayout()
$groupBox1.SuspendLayout()
$gbxExplorer.SuspendLayout()
$panel2.SuspendLayout()
$frmMain.SuspendLayout()
#
#btnApply
#
#$btnApply.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnApply.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]9,[System.Int32]400))
$btnApply.Name = [System.String]'btnApply'
$btnApply.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]127,[System.Int32]29))
$btnApply.TabIndex = [System.Int32]33
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
$menuStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]658,[System.Int32]24))
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
$scanForMDTUSBToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]170,[System.Int32]22))
$scanForMDTUSBToolStripMenuItem.Text = [System.String]'Scan for MDT USB'
#
#toolStripSeparator2
#
$toolStripSeparator2.Name = [System.String]'toolStripSeparator2'
$toolStripSeparator2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]167,[System.Int32]6))
#
#importINIFileToolStripMenuItem
#
$importINIFileToolStripMenuItem.Name = [System.String]'importINIFileToolStripMenuItem'
$importINIFileToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]170,[System.Int32]22))
$importINIFileToolStripMenuItem.Text = [System.String]'Import Config File'
$importINIFileToolStripMenuItem.add_Click($importINIFileToolStripMenuItem_Click)
#
#exportConfigFileToolStripMenuItem
#
$exportConfigFileToolStripMenuItem.Name = [System.String]'exportConfigFileToolStripMenuItem'
$exportConfigFileToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]170,[System.Int32]22))
$exportConfigFileToolStripMenuItem.Text = [System.String]'Export Config File'
$exportConfigFileToolStripMenuItem.add_Click($exportConfigFileToolStripMenuItem_Click)
#
#toolStripSeparator1
#
$toolStripSeparator1.Name = [System.String]'toolStripSeparator1'
$toolStripSeparator1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]167,[System.Int32]6))
#
#exitToolStripMenuItem
#
$exitToolStripMenuItem.Name = [System.String]'exitToolStripMenuItem'
$exitToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]170,[System.Int32]22))
$exitToolStripMenuItem.Text = [System.String]'Exit'
#
#viewToolStripMenuItem
#
$viewToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($reloadComputerToolStripMenuItem,$updateGroupPolicyToolStripMenuItem,$restartExplorerToolStripMenuItem,$toolStripSeparator3,$reapplyConfigToolStripMenuItem,$openConfigScriptToolStripMenuItem))
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
#reapplyConfigToolStripMenuItem
#
$reapplyConfigToolStripMenuItem.Name = [System.String]'reapplyConfigToolStripMenuItem'
$reapplyConfigToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]183,[System.Int32]22))
$reapplyConfigToolStripMenuItem.Text = [System.String]'Reapply Config'
#
#openConfigScriptToolStripMenuItem
#
$openConfigScriptToolStripMenuItem.Name = [System.String]'openConfigScriptToolStripMenuItem'
$openConfigScriptToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]183,[System.Int32]22))
$openConfigScriptToolStripMenuItem.Text = [System.String]'Open Config Script'
$openConfigScriptToolStripMenuItem.add_Click($openScriptToolStripMenuItem_Click)
#
#btnExport
#
#$btnExport.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$btnExport.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]9,[System.Int32]365))
$btnExport.Name = [System.String]'btnExport'
$btnExport.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]127,[System.Int32]29))
$btnExport.TabIndex = [System.Int32]17
$btnExport.Text = [System.String]'Export'
$btnExport.UseCompatibleTextRendering = $true
$btnExport.UseVisualStyleBackColor = $true
$btnExport.add_Click($btnExport_Click)
#
#dataGridView1
#
$dataGridView1.AllowUserToAddRows = $false
$dataGridView1.AllowUserToDeleteRows = $false
$dataGridView1.AllowUserToResizeColumns = $false
$dataGridView1.AllowUserToResizeRows = $false
$dataGridView1.BackgroundColor = [System.Drawing.SystemColors]::Window
$dataGridView1.CellBorderStyle = [System.Windows.Forms.DataGridViewCellBorderStyle]::None
$dataGridView1.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$dataGridView1.ColumnHeadersVisible = $false
$dataGridView1.Columns.AddRange($SettingGroup)
$dataGridView1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]9,[System.Int32]27))
$dataGridView1.MultiSelect = $false
$dataGridView1.Name = [System.String]'dataGridView1'
$dataGridView1.ReadOnly = $true
$dataGridView1.RowHeadersVisible = $false
$dataGridView1.RowHeadersWidthSizeMode = [System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode]::DisableResizing
$dataGridView1.ShowCellToolTips = $false
$dataGridView1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]127,[System.Int32]332))
$dataGridView1.TabIndex = [System.Int32]1
$dataGridView1.add_CellContentClick($dataGridView1_CellContentClick)
#
#SettingGroup
#
$SettingGroup.AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::Fill
$SettingGroup.HeaderText = [System.String]'Column1'
$SettingGroup.Name = [System.String]'SettingGroup'
$SettingGroup.ReadOnly = $true
#
#panel5
#
$panel5.AutoScroll = $true
$panel5.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$panel5.Controls.Add($tableLayoutPanel1)
$panel5.Controls.Add($checkBox4)
$panel5.Controls.Add($checkBox3)
$panel5.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]142,[System.Int32]27))
$panel5.Name = [System.String]'panel5'
$panel5.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]506,[System.Int32]402))
$panel5.TabIndex = [System.Int32]29
#
#tableLayoutPanel1
#
$tableLayoutPanel1.ColumnCount = [System.Int32]1
$tableLayoutPanel1.ColumnStyles.Add((New-Object -TypeName System.Windows.Forms.ColumnStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$tableLayoutPanel1.Controls.Add($groupBox4,[System.Int32]0,[System.Int32]0)
$tableLayoutPanel1.Controls.Add($groupBox5,[System.Int32]0,[System.Int32]1)
$tableLayoutPanel1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]29,[System.Int32]98))
$tableLayoutPanel1.Name = [System.String]'tableLayoutPanel1'
$tableLayoutPanel1.RowCount = [System.Int32]2
$tableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$tableLayoutPanel1.RowStyles.Add((New-Object -TypeName System.Windows.Forms.RowStyle -ArgumentList @([System.Windows.Forms.SizeType]::Percent,[System.Single]50)))
$tableLayoutPanel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]325,[System.Int32]212))
$tableLayoutPanel1.TabIndex = [System.Int32]27
$tableLayoutPanel1.add_Paint($tableLayoutPanel1_Paint)
#
#groupBox4
#
$groupBox4.AutoSize = $true
$groupBox4.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
$groupBox4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]3))
$groupBox4.MaximumSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]319,[System.Int32]0))
$groupBox4.MinimumSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]319,[System.Int32]0))
$groupBox4.Name = [System.String]'groupBox4'
$groupBox4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]319,[System.Int32]5))
$groupBox4.TabIndex = [System.Int32]0
$groupBox4.TabStop = $false
$groupBox4.Text = [System.String]'groupBox4'
#
#groupBox5
#
$groupBox5.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]3,[System.Int32]109))
$groupBox5.MaximumSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]319,[System.Int32]0))
$groupBox5.MinimumSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]319,[System.Int32]0))
$groupBox5.Name = [System.String]'groupBox5'
$groupBox5.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]319,[System.Int32]0))
$groupBox5.TabIndex = [System.Int32]1
$groupBox5.TabStop = $false
$groupBox5.Text = [System.String]'groupBox5'
#
#checkBox4
#
$checkBox4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]29))
$checkBox4.Name = [System.String]'checkBox4'
$checkBox4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$checkBox4.TabIndex = [System.Int32]26
$checkBox4.Text = [System.String]'Disable private firewall'
$checkBox4.UseCompatibleTextRendering = $true
$checkBox4.UseVisualStyleBackColor = $true
$checkBox4.add_CheckedChanged($checkBox4_CheckedChanged)
#
#checkBox3
#
$checkBox3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]6))
$checkBox3.Name = [System.String]'checkBox3'
$checkBox3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]290,[System.Int32]17))
$checkBox3.TabIndex = [System.Int32]25
$checkBox3.Text = [System.String]'Disable automatic network-connected device setup'
$checkBox3.UseCompatibleTextRendering = $true
$checkBox3.UseVisualStyleBackColor = $true
$checkBox3.add_CheckedChanged($checkBox3_CheckedChanged)
#
#panel4
#
$panel4.AutoScroll = $true
$panel4.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$panel4.Controls.Add($chkDisableCheckForUpdates)
$panel4.Controls.Add($gbxDisableCheckForUpdates)
$panel4.Controls.Add($lblComputerName)
$panel4.Controls.Add($lblWorkgroup)
$panel4.Controls.Add($tbxComputerName)
$panel4.Controls.Add($textBox1)
$panel4.Controls.Add($chkDisableDefender)
$panel4.Controls.Add($chkDisableSmartScreen)
$panel4.Controls.Add($chkDisableUAC)
$panel4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]142,[System.Int32]27))
$panel4.Name = [System.String]'panel4'
$panel4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]506,[System.Int32]402))
$panel4.TabIndex = [System.Int32]29
#
#chkDisableCheckForUpdates
#
$chkDisableCheckForUpdates.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]95,[System.Int32]288))
$chkDisableCheckForUpdates.Name = [System.String]'chkDisableCheckForUpdates'
$chkDisableCheckForUpdates.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$chkDisableCheckForUpdates.TabIndex = [System.Int32]32
$chkDisableCheckForUpdates.Text = [System.String]'Lock Windows Update'
$chkDisableCheckForUpdates.UseCompatibleTextRendering = $true
$chkDisableCheckForUpdates.UseVisualStyleBackColor = $true
#
#gbxDisableCheckForUpdates
#
$gbxDisableCheckForUpdates.Controls.Add($rdoEnableCheckForUpdates)
$gbxDisableCheckForUpdates.Controls.Add($rdoDisableCheckForUpdates)
$gbxDisableCheckForUpdates.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]95,[System.Int32]202))
$gbxDisableCheckForUpdates.Name = [System.String]'gbxDisableCheckForUpdates'
$gbxDisableCheckForUpdates.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]210,[System.Int32]80))
$gbxDisableCheckForUpdates.TabIndex = [System.Int32]31
$gbxDisableCheckForUpdates.TabStop = $false
$gbxDisableCheckForUpdates.Text = [System.String]'Windows Update'
#
#rdoEnableCheckForUpdates
#
$rdoEnableCheckForUpdates.Appearance = [System.Windows.Forms.Appearance]::Button
$rdoEnableCheckForUpdates.FlatStyle = [System.Windows.Forms.FlatStyle]::System
$rdoEnableCheckForUpdates.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]103,[System.Int32]28))
$rdoEnableCheckForUpdates.Name = [System.String]'rdoEnableCheckForUpdates'
$rdoEnableCheckForUpdates.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]85,[System.Int32]30))
$rdoEnableCheckForUpdates.TabIndex = [System.Int32]1
$rdoEnableCheckForUpdates.TabStop = $true
$rdoEnableCheckForUpdates.Text = [System.String]'Unlock'
$rdoEnableCheckForUpdates.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$rdoEnableCheckForUpdates.UseVisualStyleBackColor = $true
#
#rdoDisableCheckForUpdates
#
$rdoDisableCheckForUpdates.Appearance = [System.Windows.Forms.Appearance]::Button
$rdoDisableCheckForUpdates.FlatStyle = [System.Windows.Forms.FlatStyle]::System
$rdoDisableCheckForUpdates.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]20,[System.Int32]28))
$rdoDisableCheckForUpdates.Name = [System.String]'rdoDisableCheckForUpdates'
$rdoDisableCheckForUpdates.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]85,[System.Int32]30))
$rdoDisableCheckForUpdates.TabIndex = [System.Int32]0
$rdoDisableCheckForUpdates.TabStop = $true
$rdoDisableCheckForUpdates.Text = [System.String]'Lock'
$rdoDisableCheckForUpdates.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$rdoDisableCheckForUpdates.UseVisualStyleBackColor = $true
#
#lblComputerName
#
$lblComputerName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]91,[System.Int32]134))
$lblComputerName.Name = [System.String]'lblComputerName'
$lblComputerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]90,[System.Int32]17))
$lblComputerName.TabIndex = [System.Int32]28
$lblComputerName.Text = [System.String]'Computer Name:'
$lblComputerName.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#lblWorkgroup
#
$lblWorkgroup.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]91,[System.Int32]160))
$lblWorkgroup.Name = [System.String]'lblWorkgroup'
$lblWorkgroup.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]90,[System.Int32]17))
$lblWorkgroup.TabIndex = [System.Int32]30
$lblWorkgroup.Text = [System.String]'Workgroup:'
$lblWorkgroup.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#tbxComputerName
#
$tbxComputerName.BackColor = [System.Drawing.SystemColors]::Window
$tbxComputerName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]198,[System.Int32]134))
$tbxComputerName.Name = [System.String]'tbxComputerName'
$tbxComputerName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]217,[System.Int32]20))
$tbxComputerName.TabIndex = [System.Int32]27
#
#textBox1
#
$textBox1.BackColor = [System.Drawing.SystemColors]::Window
$textBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]198,[System.Int32]160))
$textBox1.Name = [System.String]'textBox1'
$textBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]217,[System.Int32]20))
$textBox1.TabIndex = [System.Int32]29
#
#chkDisableDefender
#
$chkDisableDefender.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]29))
$chkDisableDefender.Name = [System.String]'chkDisableDefender'
$chkDisableDefender.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$chkDisableDefender.TabIndex = [System.Int32]23
$chkDisableDefender.Text = [System.String]'Disable Defender'
$chkDisableDefender.UseCompatibleTextRendering = $true
$chkDisableDefender.UseVisualStyleBackColor = $true
#
#chkDisableSmartScreen
#
$chkDisableSmartScreen.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]52))
$chkDisableSmartScreen.Name = [System.String]'chkDisableSmartScreen'
$chkDisableSmartScreen.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$chkDisableSmartScreen.TabIndex = [System.Int32]24
$chkDisableSmartScreen.Text = [System.String]'Disable SmartScreen'
$chkDisableSmartScreen.UseCompatibleTextRendering = $true
$chkDisableSmartScreen.UseVisualStyleBackColor = $true
#
#chkDisableUAC
#
$chkDisableUAC.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]6))
$chkDisableUAC.Name = [System.String]'chkDisableUAC'
$chkDisableUAC.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]274,[System.Int32]17))
$chkDisableUAC.TabIndex = [System.Int32]22
$chkDisableUAC.Text = [System.String]'Elevate application privileges without UAC prompt '
$chkDisableUAC.UseCompatibleTextRendering = $true
$chkDisableUAC.UseVisualStyleBackColor = $true
#
#panel3
#
$panel3.AutoScroll = $true
$panel3.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$panel3.Controls.Add($gbxInternetExplorer)
$panel3.Controls.Add($groupBox3)
$panel3.Controls.Add($gbxEdge)
$panel3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]142,[System.Int32]27))
$panel3.Name = [System.String]'panel3'
$panel3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]506,[System.Int32]402))
$panel3.TabIndex = [System.Int32]29
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
$gbxInternetExplorer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]265))
$gbxInternetExplorer.Name = [System.String]'gbxInternetExplorer'
$gbxInternetExplorer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]187))
$gbxInternetExplorer.TabIndex = [System.Int32]8
$gbxInternetExplorer.TabStop = $false
$gbxInternetExplorer.Text = [System.String]'Internet Explorer'
#
#label2
#
$label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]241,[System.Int32]153))
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
$label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]241,[System.Int32]136))
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
#groupBox3
#
$groupBox3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]3))
$groupBox3.Name = [System.String]'groupBox3'
$groupBox3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]125))
$groupBox3.TabIndex = [System.Int32]7
$groupBox3.TabStop = $false
$groupBox3.Text = [System.String]'Google Chrome'
#
#gbxEdge
#
$gbxEdge.Controls.Add($chkDisableEdgeShortcut)
$gbxEdge.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]134))
$gbxEdge.Name = [System.String]'gbxEdge'
$gbxEdge.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]125))
$gbxEdge.TabIndex = [System.Int32]6
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
#panel6
#
$panel6.AutoScroll = $true
$panel6.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$panel6.Controls.Add($checkBox11)
$panel6.Controls.Add($checkBox12)
$panel6.Controls.Add($checkBox13)
$panel6.Controls.Add($checkBox14)
$panel6.Controls.Add($checkBox15)
$panel6.Controls.Add($checkBox16)
$panel6.Controls.Add($checkBox10)
$panel6.Controls.Add($checkBox9)
$panel6.Controls.Add($checkBox8)
$panel6.Controls.Add($checkBox7)
$panel6.Controls.Add($checkBox6)
$panel6.Controls.Add($checkBox5)
$panel6.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]142,[System.Int32]27))
$panel6.Name = [System.String]'panel6'
$panel6.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]506,[System.Int32]402))
$panel6.TabIndex = [System.Int32]29
#
#checkBox11
#
$checkBox11.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]143))
$checkBox11.Name = [System.String]'checkBox11'
$checkBox11.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox11.TabIndex = [System.Int32]13
$checkBox11.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox11.UseCompatibleTextRendering = $true
$checkBox11.UseVisualStyleBackColor = $true
#
#checkBox12
#
$checkBox12.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]189))
$checkBox12.Name = [System.String]'checkBox12'
$checkBox12.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox12.TabIndex = [System.Int32]12
$checkBox12.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox12.UseCompatibleTextRendering = $true
$checkBox12.UseVisualStyleBackColor = $true
#
#checkBox13
#
$checkBox13.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]166))
$checkBox13.Name = [System.String]'checkBox13'
$checkBox13.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox13.TabIndex = [System.Int32]11
$checkBox13.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox13.UseCompatibleTextRendering = $true
$checkBox13.UseVisualStyleBackColor = $true
#
#checkBox14
#
$checkBox14.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]211))
$checkBox14.Name = [System.String]'checkBox14'
$checkBox14.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox14.TabIndex = [System.Int32]10
$checkBox14.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox14.UseCompatibleTextRendering = $true
$checkBox14.UseVisualStyleBackColor = $true
#
#checkBox15
#
$checkBox15.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]257))
$checkBox15.Name = [System.String]'checkBox15'
$checkBox15.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox15.TabIndex = [System.Int32]9
$checkBox15.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox15.UseCompatibleTextRendering = $true
$checkBox15.UseVisualStyleBackColor = $true
#
#checkBox16
#
$checkBox16.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]234))
$checkBox16.Name = [System.String]'checkBox16'
$checkBox16.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox16.TabIndex = [System.Int32]8
$checkBox16.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox16.UseCompatibleTextRendering = $true
$checkBox16.UseVisualStyleBackColor = $true
#
#checkBox10
#
$checkBox10.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]6))
$checkBox10.Name = [System.String]'checkBox10'
$checkBox10.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]287,[System.Int32]17))
$checkBox10.TabIndex = [System.Int32]7
$checkBox10.Text = [System.String]'Show the video console lock setting in powercfg.cpl'
$checkBox10.UseCompatibleTextRendering = $true
$checkBox10.UseVisualStyleBackColor = $true
#
#checkBox9
#
$checkBox9.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]52))
$checkBox9.Name = [System.String]'checkBox9'
$checkBox9.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox9.TabIndex = [System.Int32]6
$checkBox9.Text = [System.String]'Remove Fax'
$checkBox9.UseCompatibleTextRendering = $true
$checkBox9.UseVisualStyleBackColor = $true
#
#checkBox8
#
$checkBox8.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]29))
$checkBox8.Name = [System.String]'checkBox8'
$checkBox8.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]369,[System.Int32]17))
$checkBox8.TabIndex = [System.Int32]5
$checkBox8.Text = [System.String]'Disable missing updates system tray icon and fullscreen notification'
$checkBox8.UseCompatibleTextRendering = $true
$checkBox8.UseVisualStyleBackColor = $true
#
#checkBox7
#
$checkBox7.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]74))
$checkBox7.Name = [System.String]'checkBox7'
$checkBox7.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox7.TabIndex = [System.Int32]4
$checkBox7.Text = [System.String]'Remove Microsoft XPS Document Writer'
$checkBox7.UseCompatibleTextRendering = $true
$checkBox7.UseVisualStyleBackColor = $true
#
#checkBox6
#
$checkBox6.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]120))
$checkBox6.Name = [System.String]'checkBox6'
$checkBox6.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox6.TabIndex = [System.Int32]3
$checkBox6.Text = [System.String]'Disable Edge Shortcut Creation after update'
$checkBox6.UseCompatibleTextRendering = $true
$checkBox6.UseVisualStyleBackColor = $true
#
#checkBox5
#
$checkBox5.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]7,[System.Int32]97))
$checkBox5.Name = [System.String]'checkBox5'
$checkBox5.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]262,[System.Int32]17))
$checkBox5.TabIndex = [System.Int32]2
$checkBox5.Text = [System.String]'Disable Protected View in Office applications'
$checkBox5.UseCompatibleTextRendering = $true
$checkBox5.UseVisualStyleBackColor = $true
#
#gbxDesktop
#
$gbxDesktop.Controls.Add($chkShowRecycleBinOnDesktop)
$gbxDesktop.Controls.Add($chkShowUserFolderOnDesktop)
$gbxDesktop.Controls.Add($chkShowComputerOnDesktop)
$gbxDesktop.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]102))
$gbxDesktop.Name = [System.String]'gbxDesktop'
$gbxDesktop.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]95))
$gbxDesktop.TabIndex = [System.Int32]22
$gbxDesktop.TabStop = $false
$gbxDesktop.Text = [System.String]'Desktop'
#
#chkShowRecycleBinOnDesktop
#
$chkShowRecycleBinOnDesktop.ForeColor = [System.Drawing.SystemColors]::ControlText
$chkShowRecycleBinOnDesktop.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]65))
$chkShowRecycleBinOnDesktop.Name = [System.String]'chkShowRecycleBinOnDesktop'
$chkShowRecycleBinOnDesktop.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]175,[System.Int32]17))
$chkShowRecycleBinOnDesktop.TabIndex = [System.Int32]22
$chkShowRecycleBinOnDesktop.Text = [System.String]'Show Recycle Bin on Desktop'
$chkShowRecycleBinOnDesktop.UseCompatibleTextRendering = $true
$chkShowRecycleBinOnDesktop.UseVisualStyleBackColor = $true
#
#chkShowUserFolderOnDesktop
#
$chkShowUserFolderOnDesktop.ForeColor = [System.Drawing.SystemColors]::ControlText
$chkShowUserFolderOnDesktop.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]42))
$chkShowUserFolderOnDesktop.Name = [System.String]'chkShowUserFolderOnDesktop'
$chkShowUserFolderOnDesktop.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]175,[System.Int32]17))
$chkShowUserFolderOnDesktop.TabIndex = [System.Int32]21
$chkShowUserFolderOnDesktop.Text = [System.String]'Show User Folder on Desktop'
$chkShowUserFolderOnDesktop.UseCompatibleTextRendering = $true
$chkShowUserFolderOnDesktop.UseVisualStyleBackColor = $true
#
#chkShowComputerOnDesktop
#
$chkShowComputerOnDesktop.ForeColor = [System.Drawing.SystemColors]::ControlText
$chkShowComputerOnDesktop.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]10,[System.Int32]19))
$chkShowComputerOnDesktop.Name = [System.String]'chkShowComputerOnDesktop'
$chkShowComputerOnDesktop.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]175,[System.Int32]17))
$chkShowComputerOnDesktop.TabIndex = [System.Int32]20
$chkShowComputerOnDesktop.Text = [System.String]'Show Computer on Desktop'
$chkShowComputerOnDesktop.UseCompatibleTextRendering = $true
$chkShowComputerOnDesktop.UseVisualStyleBackColor = $true
#
#groupBox2
#
$groupBox2.Controls.Add($checkBox1)
$groupBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]310))
$groupBox2.Name = [System.String]'groupBox2'
$groupBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]151))
$groupBox2.TabIndex = [System.Int32]23
$groupBox2.TabStop = $false
$groupBox2.Text = [System.String]'Start Menu'
#
#checkBox1
#
$checkBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]114))
$checkBox1.Name = [System.String]'checkBox1'
$checkBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$checkBox1.TabIndex = [System.Int32]23
$checkBox1.Text = [System.String]'Disable Cortana'
$checkBox1.UseCompatibleTextRendering = $true
$checkBox1.UseVisualStyleBackColor = $true
#
#groupBox1
#
$groupBox1.Controls.Add($chkClearTaskbarPins)
$groupBox1.Controls.Add($checkBox2)
$groupBox1.Controls.Add($chkHideTaskView)
$groupBox1.Controls.Add($chkHidePeople)
$groupBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]203))
$groupBox1.Name = [System.String]'groupBox1'
$groupBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]101))
$groupBox1.TabIndex = [System.Int32]24
$groupBox1.TabStop = $false
$groupBox1.Text = [System.String]'Taskbar'
#
#chkClearTaskbarPins
#
$chkClearTaskbarPins.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]197,[System.Int32]19))
$chkClearTaskbarPins.Name = [System.String]'chkClearTaskbarPins'
$chkClearTaskbarPins.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]162,[System.Int32]17))
$chkClearTaskbarPins.TabIndex = [System.Int32]20
$chkClearTaskbarPins.Text = [System.String]'Clear default pinned items'
$chkClearTaskbarPins.UseCompatibleTextRendering = $true
$chkClearTaskbarPins.UseVisualStyleBackColor = $true
#
#checkBox2
#
$checkBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]66))
$checkBox2.Name = [System.String]'checkBox2'
$checkBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]160,[System.Int32]17))
$checkBox2.TabIndex = [System.Int32]19
$checkBox2.Text = [System.String]'Disable Web Search'
$checkBox2.UseCompatibleTextRendering = $true
$checkBox2.UseVisualStyleBackColor = $true
#
#chkHideTaskView
#
$chkHideTaskView.ForeColor = [System.Drawing.SystemColors]::ControlText
$chkHideTaskView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]43))
$chkHideTaskView.Name = [System.String]'chkHideTaskView'
$chkHideTaskView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]136,[System.Int32]17))
$chkHideTaskView.TabIndex = [System.Int32]5
$chkHideTaskView.Text = [System.String]'Hide Task View button'
$chkHideTaskView.UseCompatibleTextRendering = $true
$chkHideTaskView.UseVisualStyleBackColor = $true
#
#chkHidePeople
#
$chkHidePeople.ForeColor = [System.Drawing.SystemColors]::ControlText
$chkHidePeople.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]20))
$chkHidePeople.Name = [System.String]'chkHidePeople'
$chkHidePeople.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]119,[System.Int32]17))
$chkHidePeople.TabIndex = [System.Int32]0
$chkHidePeople.Text = [System.String]'Hide People button'
$chkHidePeople.UseCompatibleTextRendering = $true
$chkHidePeople.UseVisualStyleBackColor = $true
#
#gbxExplorer
#
$gbxExplorer.Controls.Add($cmbControlPanelView)
$gbxExplorer.Controls.Add($lblControlPanelView)
$gbxExplorer.Controls.Add($lblSetThisPCLabel)
$gbxExplorer.Controls.Add($cmbSetThisPCLabel)
$gbxExplorer.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]3))
$gbxExplorer.Name = [System.String]'gbxExplorer'
$gbxExplorer.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]472,[System.Int32]93))
$gbxExplorer.TabIndex = [System.Int32]25
$gbxExplorer.TabStop = $false
$gbxExplorer.Text = [System.String]'Explorer'
#
#cmbControlPanelView
#
$cmbControlPanelView.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cmbControlPanelView.FormattingEnabled = $true
$cmbControlPanelView.Items.AddRange([System.Object[]]@([System.String]'Small icons',[System.String]'Large icons',[System.String]'Categories'))
$cmbControlPanelView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]116,[System.Int32]55))
$cmbControlPanelView.Name = [System.String]'cmbControlPanelView'
$cmbControlPanelView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]216,[System.Int32]21))
$cmbControlPanelView.TabIndex = [System.Int32]16
#
#lblControlPanelView
#
$lblControlPanelView.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]8,[System.Int32]55))
$lblControlPanelView.Name = [System.String]'lblControlPanelView'
$lblControlPanelView.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]102,[System.Int32]17))
$lblControlPanelView.TabIndex = [System.Int32]17
$lblControlPanelView.Text = [System.String]'Control Panel view:'
$lblControlPanelView.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#lblSetThisPCLabel
#
$lblSetThisPCLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]9,[System.Int32]28))
$lblSetThisPCLabel.Name = [System.String]'lblSetThisPCLabel'
$lblSetThisPCLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]87,[System.Int32]17))
$lblSetThisPCLabel.TabIndex = [System.Int32]13
$lblSetThisPCLabel.Text = [System.String]'Computer label:'
$lblSetThisPCLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
#
#cmbSetThisPCLabel
#
$cmbSetThisPCLabel.FormattingEnabled = $true
$cmbSetThisPCLabel.Items.AddRange([System.Object[]]@([System.String]'This PC',[System.String]'Computer %COMPUTERNAME%',[System.String]'%COMPUTERNAME%',[System.String]'%USERNAME% on %COMPUTERNAME%'))
$cmbSetThisPCLabel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]116,[System.Int32]28))
$cmbSetThisPCLabel.Name = [System.String]'cmbSetThisPCLabel'
$cmbSetThisPCLabel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]217,[System.Int32]21))
$cmbSetThisPCLabel.TabIndex = [System.Int32]15
#
#panel2
#
$panel2.AutoScroll = $true
$panel2.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$panel2.Controls.Add($gbxExplorer)
$panel2.Controls.Add($groupBox1)
$panel2.Controls.Add($groupBox2)
$panel2.Controls.Add($gbxDesktop)
$panel2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]142,[System.Int32]27))
$panel2.Name = [System.String]'panel2'
$panel2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]506,[System.Int32]402))
$panel2.TabIndex = [System.Int32]28
#
#frmMain
#
$frmMain.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]658,[System.Int32]439))
$frmMain.Controls.Add($panel2)
$frmMain.Controls.Add($panel6)
$frmMain.Controls.Add($panel5)
$frmMain.Controls.Add($panel4)
$frmMain.Controls.Add($panel3)
$frmMain.Controls.Add($dataGridView1)
$frmMain.Controls.Add($btnApply)
$frmMain.Controls.Add($btnExport)
$frmMain.Controls.Add($menuStrip1)
$frmMain.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$frmMain.MainMenuStrip = $menuStrip1
$frmMain.MaximizeBox = $false
$frmMain.Name = [System.String]'frmMain'
$frmMain.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$frmMain.Text = [System.String]'ConfigHost Editor'
$frmMain.add_Load($frmMain_Load)
$menuStrip1.ResumeLayout($false)
$menuStrip1.PerformLayout()
([System.ComponentModel.ISupportInitialize]$dataGridView1).EndInit()
$panel5.ResumeLayout($false)
$tableLayoutPanel1.ResumeLayout($false)
$tableLayoutPanel1.PerformLayout()
$panel4.ResumeLayout($false)
$panel4.PerformLayout()
$gbxDisableCheckForUpdates.ResumeLayout($false)
$panel3.ResumeLayout($false)
$gbxInternetExplorer.ResumeLayout($false)
$gbxEdge.ResumeLayout($false)
$panel6.ResumeLayout($false)
$gbxDesktop.ResumeLayout($false)
$groupBox2.ResumeLayout($false)
$groupBox1.ResumeLayout($false)
$gbxExplorer.ResumeLayout($false)
$panel2.ResumeLayout($false)
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
Add-Member -InputObject $frmMain -Name reapplyConfigToolStripMenuItem -Value $reapplyConfigToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name openConfigScriptToolStripMenuItem -Value $openConfigScriptToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name components -Value $components -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name dataGridView1 -Value $dataGridView1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name SettingGroup -Value $SettingGroup -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name panel5 -Value $panel5 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tableLayoutPanel1 -Value $tableLayoutPanel1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox4 -Value $groupBox4 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox5 -Value $groupBox5 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox4 -Value $checkBox4 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox3 -Value $checkBox3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name panel4 -Value $panel4 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableCheckForUpdates -Value $chkDisableCheckForUpdates -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxDisableCheckForUpdates -Value $gbxDisableCheckForUpdates -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name rdoEnableCheckForUpdates -Value $rdoEnableCheckForUpdates -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name rdoDisableCheckForUpdates -Value $rdoDisableCheckForUpdates -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblComputerName -Value $lblComputerName -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblWorkgroup -Value $lblWorkgroup -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name tbxComputerName -Value $tbxComputerName -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name textBox1 -Value $textBox1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableDefender -Value $chkDisableDefender -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableSmartScreen -Value $chkDisableSmartScreen -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableUAC -Value $chkDisableUAC -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name panel3 -Value $panel3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxInternetExplorer -Value $gbxInternetExplorer -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name label2 -Value $label2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIEFirstRunWizard -Value $chkDisableIEFirstRunWizard -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIESuggestedSites -Value $chkDisableIESuggestedSites -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIEPasswordAutoComplete -Value $chkDisableIEPasswordAutoComplete -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIESmileyButton -Value $chkDisableIESmileyButton -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIENewEdgeTab -Value $chkDisableIENewEdgeTab -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name label1 -Value $label1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkLockIEToolbars -Value $chkLockIEToolbars -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowIEStatusBar -Value $chkShowIEStatusBar -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowIEFavoritesBar -Value $chkShowIEFavoritesBar -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowIEMenuBar -Value $chkShowIEMenuBar -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableIEPopupMgmt -Value $chkDisableIEPopupMgmt -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox3 -Value $groupBox3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxEdge -Value $gbxEdge -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkDisableEdgeShortcut -Value $chkDisableEdgeShortcut -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name panel6 -Value $panel6 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox11 -Value $checkBox11 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox12 -Value $checkBox12 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox13 -Value $checkBox13 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox14 -Value $checkBox14 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox15 -Value $checkBox15 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox16 -Value $checkBox16 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox10 -Value $checkBox10 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox9 -Value $checkBox9 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox8 -Value $checkBox8 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox7 -Value $checkBox7 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox6 -Value $checkBox6 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox5 -Value $checkBox5 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxDesktop -Value $gbxDesktop -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowRecycleBinOnDesktop -Value $chkShowRecycleBinOnDesktop -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowUserFolderOnDesktop -Value $chkShowUserFolderOnDesktop -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkShowComputerOnDesktop -Value $chkShowComputerOnDesktop -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox2 -Value $groupBox2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox1 -Value $checkBox1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name groupBox1 -Value $groupBox1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkClearTaskbarPins -Value $chkClearTaskbarPins -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name checkBox2 -Value $checkBox2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkHideTaskView -Value $chkHideTaskView -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name chkHidePeople -Value $chkHidePeople -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxExplorer -Value $gbxExplorer -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cmbControlPanelView -Value $cmbControlPanelView -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblControlPanelView -Value $lblControlPanelView -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblSetThisPCLabel -Value $lblSetThisPCLabel -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cmbSetThisPCLabel -Value $cmbSetThisPCLabel -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name panel2 -Value $panel2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name toolStripSeparator3 -Value $toolStripSeparator3 -MemberType NoteProperty
}
. InitializeComponent
