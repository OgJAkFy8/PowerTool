﻿<#

    .NAME
        PowerTool

    .VERSION
        0.1

    .DESCRIPTION
        Helpdesk tool for troubleshooting remote workstations

    .LICENSE
        MIT License

#>

# ================================ [Assemblies & Variables]
#region Assemblies & Variables

## Assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

## Form Variables
$backgroundColour = "POWDERBLUE"
$buttonColour = "White"
$font = "Consolas,11"

Set-Location $PSScriptRoot

#endregion Assemblies & Variables

# ================================ [Form GUI]
#region Form GUI

### Main Form
$PowerTool = New-Object system.Windows.Forms.Form
$PowerTool.MinimumSize = New-Object System.Drawing.Size(770, 380)
$PowerTool.Font = $font
$PowerTool.Width = [int]960
$PowerTool.Height = [int]500
$PowerTool.AutoSize = $false
$PowerTool.text = "PowerTool"
$PowerTool.BackColor = $backgroundColour
$PowerTool.StartPosition = "CenterScreen"
$PowerTool.FormBorderStyle = "FixedDialog"
$PowerTool.MaximizeBox = $False
$PowerTool.ControlBox = $True
$PowerTool.MinimizeBox = $true
$PowerTool.mainMenuStrip = $mainMenu
$PowerTool.KeyPreview = $True

# Logging Textbox
$txbLogging = New-Object 'System.Windows.Forms.RichTextBox'
$txbLogging.Font = $font
$txbLogging.Location = '20, 85'
$txbLogging.Size = '900, 325'
$txbLogging.Text = "A live log of actions will be displayed here `r`n-------------------------------------------------------------------------------------------------------------`r`n"
$txbLogging.Multiline = $true
$txbLogging.ReadOnly = $true
$txbLogging.add_TextChanged($txbLogging_textchanged)
$PowerTool.Controls.Add($txbLogging)
# Scroll to bottom of textbox when log updated
$txbLogging_textchanged={

	$txbLogging.SelectionStart=$txbLogging.Text.Length
	$txbLogging.ScrollToCaret()

}

# Connect Button
$btnConnect = New-Object system.Windows.Forms.Button
$btnConnect.text = "Connect"
$btnConnect.width = 200
$btnConnect.height = 30
$btnConnect.location = New-Object System.Drawing.Point(722,42)
$btnConnect.Font = 'Microsoft Sans Serif,10'
$btnConnect.BackColor = $buttonColour
$PowerTool.Controls.Add($btnConnect)

# Hostname Label
$lblHostname = New-Object system.Windows.Forms.Label
$lblHostname.text = "Enter Computer Name:"
$lblHostname.AutoSize = $true
$lblHostname.width = 25
$lblHostname.height = 30
$lblHostname.location = New-Object System.Drawing.Point(20,50)
$lblHostname.Font = 'Microsoft Sans Serif,10'
$PowerTool.Controls.Add($lblHostname)

# Hostname Textbox
$txbHostname = New-Object system.Windows.Forms.TextBox
$txbHostname.multiline = $false
$txbHostname.width = 175
$txbHostname.height = 30
$txbHostname.CharacterCasing = "Upper"
$txbHostname.MaxLength = 8
$txbHostname.location = New-Object System.Drawing.Point(170,46)
$txbHostname.Font = 'Microsoft Sans Serif,10'
$PowerTool.Controls.Add($txbHostname)

# IP Address Label
$lblAddress = New-Object system.Windows.Forms.Label
$lblAddress.text = "Enter IP Address:"
$lblAddress.AutoSize = $true
$lblAddress.width = 25
$lblAddress.height = 30
$lblAddress.location  = New-Object System.Drawing.Point(375,50)
$lblAddress.Font = 'Microsoft Sans Serif,10'
$PowerTool.Controls.Add($lblAddress)

# IP Address Textbox
$txbIPAddress = New-Object system.Windows.Forms.TextBox
$txbIPAddress.multiline  = $false
$txbIPAddress.width = 175
$txbIPAddress.height = 30
$txbIPAddress.CharacterCasing = "Upper"
$txbIPAddress.MaxLength = 15
$txbIPAddress.location = New-Object System.Drawing.Point(495,46)
$txbIPAddress.Font = 'Microsoft Sans Serif,10'
$PowerTool.Controls.Add($txbIPAddress)

# Clear Button
$btnClearLogs = New-Object system.Windows.Forms.Button
$btnClearLogs.text = "Clear Logs"
$btnClearLogs.width = 100
$btnClearLogs.height = 30
$btnClearLogs.location = New-Object System.Drawing.Point(822,420)
$btnClearLogs.Font = 'Microsoft Sans Serif,10'
$btnClearLogs.BackColor = $buttonColour
$PowerTool.Controls.Add($btnClearLogs)

# Copy Button
$btnCopyLogs = New-Object system.Windows.Forms.Button
$btnCopyLogs.text = "Copy Logs"
$btnCopyLogs.width = 100
$btnCopyLogs.height = 30
$btnCopyLogs.location = New-Object System.Drawing.Point(722,420)
$btnCopyLogs.Font = 'Microsoft Sans Serif,10'
$btnCopyLogs.BackColor = $buttonColour
$PowerTool.Controls.Add($btnCopyLogs)

### Main Menu Strip
$mainMenu = New-Object 'System.Windows.Forms.MenuStrip'
$mainMenu.Font = "Trebuchet MS, 9pt"
$mainMenu.Location = '0, 0'
$mainMenu.Size = '1170, 26'
$mainMenu.TabIndex = 1
$mainMenu.Text = "menustrip1"
$PowerTool.Controls.Add($mainMenu)

## Tools Dropdown
$toolsDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$toolsDropdown.Size = '109, 22'
$toolsDropdown.Text = "Admin Tools"
$mainMenu.Items.Add($toolsDropdown)

# File Explorer
$tools_Explorer = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_Explorer.Size = '109, 22'
$tools_Explorer.Text = "File Explorer"
$toolsDropdown.DropDownItems.Add($tools_Explorer)

# Services.msc
$tools_Services = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_Services.Size = '109, 22'
$tools_Services.Text = "Services"
$toolsDropdown.DropDownItems.Add($tools_Services)

# Regedit
$tools_Regedit = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_Regedit.Size = '109, 22'
$tools_Regedit.Text = "Regedit"
$toolsDropdown.DropDownItems.Add($tools_Regedit)

# PowerShell
$tools_PowerShell = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_PowerShell.Size = '109, 22'
$tools_PowerShell.Text = "PowerShell"
$toolsDropdown.DropDownItems.Add($tools_PowerShell)

# CMD
$tools_CMD = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_CMD.Size = '109, 22'
$tools_CMD.Text = "CMD"
$toolsDropdown.DropDownItems.Add($tools_CMD)

# Device Manager
$tools_DeviceManager = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_DeviceManager.Size = '109, 22'
$tools_DeviceManager.Text = "Device Manager"
$toolsDropdown.DropDownItems.Add($tools_DeviceManager)

# Event Viewer
$tools_EventViewer = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_EventViewer.Size = '109, 22'
$tools_EventViewer.Text = "Event Viewer"
$toolsDropdown.DropDownItems.Add($tools_EventViewer)

# Advanced System Settings
$tools_SystemProperties = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_SystemProperties.Size = '109, 22'
$tools_SystemProperties.Text = "Advanced System Settings"
$toolsDropdown.DropDownItems.Add($tools_SystemProperties)

# Seperator
$tools_Seperator = New-Object 'System.Windows.Forms.ToolStripSeparator'
$tools_Seperator.Size = '109, 22'
$toolsDropdown.DropDownItems.Add($tools_Seperator)

# Remote - Explorer
$tools_remote_Explorer = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_remote_Explorer.Size = '109, 22'
$tools_remote_Explorer.Text = "Remote Explorer"
$tools_remote_Explorer.Enabled = $false
$toolsDropdown.DropDownItems.Add($tools_remote_Explorer)

# Remote - PSExec
$tools_remote_PSExec = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_remote_PSExec.Size = '109, 22'
$tools_remote_PSExec.Text = "Remote PSexec"
$tools_remote_PSExec.Enabled = $false
$toolsDropdown.DropDownItems.Add($tools_remote_PSExec)

# Remote - Services
$tools_remote_Services = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_remote_Services.Size = '109, 22'
$tools_remote_Services.Text = "Remote Services"
$tools_remote_Services.Enabled = $false
$toolsDropdown.DropDownItems.Add($tools_remote_Services)

# Remote - Ping
$tools_remote_Ping = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$tools_remote_Ping.Size = '109, 22'
$tools_remote_Ping.Text = "Remote Ping"
$tools_remote_Ping.Enabled = $false
$toolsDropdown.DropDownItems.Add($tools_remote_Ping)

## Account Information
$accountInformationDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$accountInformationDropdown.Size = '109, 22'
$accountInformationDropdown.Text = "User Account Info"
$mainMenu.Items.Add($accountInformationDropdown)

# Locked Account
$account_LockedOut = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$account_LockedOut.Size = '109, 22'
$account_LockedOut.Text = "Check Locked Account"
$accountInformationDropdown.DropDownItems.Add($account_LockedOut)

# Expired Account
$account_Expired = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$account_Expired.Size = '109, 22'
$account_Expired.Text = "Check Expired Account"
$accountInformationDropdown.DropDownItems.Add($account_Expired)

## Computer Information
$computerInformationDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computerInformationDropdown.Visible = $false
$computerInformationDropdown.Size = '109, 22'
$computerInformationDropdown.Text = "Computer Info"
$mainMenu.Items.Add($computerInformationDropdown)

# Asset Tag & Serial
$computer_AssetSerial = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_AssetSerial.Size = '109, 22'
$computer_AssetSerial.Text = "Asset and Serial"
$computerInformationDropdown.DropDownItems.Add($computer_AssetSerial)

# Device Model
$computer_Model = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_Model.Size = '109, 22'
$computer_Model.Text = "Model and Manufacturer"
$computerInformationDropdown.DropDownItems.Add($computer_Model)

# Operating System
$computer_OperatingSystem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_OperatingSystem.Size = '109, 22'
$computer_OperatingSystem.Text = "OS Version"
$computerInformationDropdown.DropDownItems.Add($computer_OperatingSystem)

# Brower Information
$computer_BrowserInformation = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_BrowserInformation.Size = '109, 22'
$computer_BrowserInformation.Text = "Browser Information"
$computerInformationDropdown.DropDownItems.Add($computer_BrowserInformation)

# MS Office Version
$computer_MSOfficeVersion = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_MSOfficeVersion.Size = '109, 22'
$computer_MSOfficeVersion.Text = "MS Office Version"
$computerInformationDropdown.DropDownItems.Add($computer_MSOfficeVersion)

# IP Address
$computer_IPAddress = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_IPAddress.Size = '109, 22'
$computer_IPAddress.Text = "IP Address"
$computerInformationDropdown.DropDownItems.Add($computer_IPAddress)

# Seperator One
$computer_seperator_one = New-Object 'System.Windows.Forms.ToolStripSeparator'
$computer_seperator_one.Size = '109, 22'
$computerInformationDropdown.DropDownItems.Add($computer_seperator_one)

# Machine Uptime
$computer_MachineUptime = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_MachineUptime.Size = '109, 22'
$computer_MachineUptime.Text = "Machine Uptime"
$computerInformationDropdown.DropDownItems.Add($computer_MachineUptime)

# Build Date
$computer_BuildDate = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_BuildDate.Size = '109, 22'
$computer_BuildDate.Text = "Build Date"
$computerInformationDropdown.DropDownItems.Add($computer_BuildDate)

# Seperator Two
$computer_seperator_two = New-Object 'System.Windows.Forms.ToolStripSeparator'
$computer_seperator_two.Size = '109, 22'
$computerInformationDropdown.DropDownItems.Add($computer_seperator_two)

# CPU Usage
$computer_CPU = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_CPU.Size = '109, 22'
$computer_CPU.Text = "Current CPU Usage"
$computerInformationDropdown.DropDownItems.Add($computer_CPU)

# Power Settings
$computer_PowerSettings = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_PowerSettings.Size = '109, 22'
$computer_PowerSettings.Text = "Power settings"
$computerInformationDropdown.DropDownItems.Add($computer_PowerSettings)

# Disk & Memory Information
$computer_DiskInformation = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_DiskInformation.Size = '109, 22'
$computer_DiskInformation.Text = "Disk and Memory Info"
$computerInformationDropdown.DropDownItems.Add($computer_DiskInformation)

# Seperator Three
$computer_seperator_three = New-Object 'System.Windows.Forms.ToolStripSeparator'
$computer_seperator_three.Size = '109, 22'
$computerInformationDropdown.DropDownItems.Add($computer_seperator_three)

# Anti-Virus
$computer_AntiVirus = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_AntiVirus.Size = '109, 22'
$computer_AntiVirus.Text = "Check Anti Virus"
$computerInformationDropdown.DropDownItems.Add($computer_AntiVirus)

# Last Reboot
$computer_LastReboot = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$computer_LastReboot.Size = '109, 22'
$computer_LastReboot.Text = "Last Reboot"
$computerInformationDropdown.DropDownItems.Add($computer_LastReboot)

## Scripts / Fixes
$fixesDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$fixesDropdown.Visible = $false
$fixesDropdown.Size = '109, 22'
$fixesDropdown.Text = "Scripts / Fixes"
$mainMenu.Items.Add($fixesDropdown)

# Blank Dropdown
$fixes_Template = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$fixes_Template.Size = '109, 22'
$fixes_Template.Text = "Blank Dropdown"
$fixesDropdown.DropDownItems.Add($fixes_Template)

## Applications
$applicationsDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$applicationsDropdown.Visible = $false
$applicationsDropdown.Size = '109, 22'
$applicationsDropdown.Text = "Applications"
$mainMenu.Items.Add($applicationsDropdown)

# Blank Dropdown
$applications_Template = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$applications_Template.Size = '109, 22'
$applications_Template.Text = "Blank Dropdown"
$applicationsDropdown.DropDownItems.Add($applications_Template)

## App-V
$appvDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$appvDropdown.Visible = $false
$appvDropdown.Size = '109, 22'
$appvDropdown.Text = "App-V"
$mainMenu.Items.Add($appvDropdown)

# View App-V
$appv_GetPackages = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$appv_GetPackages.Size = '109, 22'
$appv_GetPackages.Text = "View App-V Packages"
$appvDropdown.DropDownItems.Add($appv_GetPackages)

## Service Dropdown
$servicesDropdown = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$servicesDropdown.Visible = $false
$servicesDropdown.Size = '109, 22'
$servicesDropdown.Text = "Services"
$mainMenu.Items.Add($servicesDropdown)

# All Services
$services_AllServices = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$services_AllServices.Size = '109, 22'
$services_AllServices.Text = "View All Services"
$servicesDropdown.DropDownItems.Add($services_AllServices)

#Running Services
$services_RunningServices = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$services_RunningServices.Size = '109, 22'
$services_RunningServices.Text = "View Running Services"
$servicesDropdown.DropDownItems.Add($services_RunningServices)

# Stopped Services
$services_StoppedServices = New-Object 'System.Windows.Forms.ToolStripMenuItem'
$services_StoppedServices.Size = '109, 22'
$services_StoppedServices.Text = "View Stopped Services"
$servicesDropdown.DropDownItems.Add($services_StoppedServices)

### Menu Icons
$toolsDropdown.Image = [System.Convert]::FromBase64String('iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAACXBIWXMAAAsTAAALEwEAmpwYAAAABGdBTUEAALGeYUxB9wAAACBjSFJNAAB6JQAAgIMAAPn/AACA6AAAUggAARVYAAA6lwAAF2/XWh+QAAACQElEQVR42qSTP2sUYRDGf+/uu3t3+e9dJFGvEa2UFFpYCn4HsRAJiOEa8SMopghY+CGSSgvFIthY2KmgGAJ2QczFJCS3IXe5M3u3+/612OKMiBYOTDHM8DDPPM8I7z3/EwH/GfLX4vWb939c58zsOTxgnUE4hxdgjSaK7UkAgPsPvrK1W4epGqjTnJ+r0bhTolaDHCiVII7gw9svNG5FyNXV1Xkp5YrWmrA8zUjswPUhHAWZctiu0OlGnJ0JwAEWMg/WeUIhCIwxK/V6nbW1tYJTyYMYgBuAHNA7TPm8rvm+69lPYGcfmjtw1PMIXwAghGBxcRGAscmAsKJg0AbXBpWwsdGi2Twm2ctobSv2Ni3pkccHILXWANxsVWAdZJgxMRZz1M3wuQMyDlqKzaahWh3B2Ii0L8l6fawrF0cMw5AbL57CRej1cspRQCwNuUkhhCz17GxLlNI4JL3jgEj18W4Kaa09oUKSaHLt8daB8hAC2pLsBRilEKGk8wOmy32c8UMKUhaKtg8NzmmM9ginEc4iAkPa8VitCKOIbtdSqaYoq4Y+EEIA4FzhJRkJCt3SIvMDsnzovmQXrL4wBMjzovvq5fV/2lcpjQwCvLdIYwwA6SCjFPT51tyisXBPADxaWvLvPn5i+tQMB52Ea1euZk8eP6yc+IW/fePMbN1Pjm+JidEJssAyd+ny5u8zYnl5ed4Ys5LnOXEckyr/PJaVBRkHx4M8x2hNpRzTSweMj41ijaWfZfPVyalnjbu3zc8BAEw8K6ZI7Xa0AAAAAElFTkSuQmCC')
$computerInformationDropdown.Image = [System.Convert]::FromBase64String('iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAmxJREFUeNrsWkuLGkEQrnHcnIQN5Jab+Q/5CT5AVAgEcsw9ueWSQyAsLOzmsKdN7rksLAQCKhJfiSAhF08SPMSL4uOik53Z8a0zTrpbZ9LuZnQkAadDf1BT1U5j19evqhIFwzCAZXiAcXACnMBfwosfR8enzwVBOGfB4clk/OLk+OgtMufoAjIIAez8o8dP9ubUu/cJop89jW9tf/xweYbMCyQykpnXDbNqOuq0jXCIZLhGQPR4QJXaWwcz1h87v7/ZZ6mWfQ1Km0Lj3v0H9Nb3WGeAGF4RTk7f/B6E+oI/2U5lsVjcsk2taRrouk70fD639Gw2g/F4jPb7hLRNfP/R+I+vUVZTio0rkEwmidghk8m4l0AikYBYLEYklUpZn6fT6bV+2WzW/ZE4Go1adiQSsexwOEx0LpdjN5UIhUJE5/N59xLYtIUwgsEg0YVCYT+5EBVLLMTjcesA220hGoFAYG0VisWi7aA+n49o8863gqkoEqHjhWMCkqzeeokPsBNgJ2RZBr/fD/1+H1RVxfnVzrOJgxoWO3R/XtsT2BXY0W63C71eDxRF2W867RQ41LdaLWg0GjAajdxTD2zDYDCAer0OnU6HkHBdQbNpxmu1GnHeyYHaK4GbuVC73YZqtQrT6dT9JSUNPNOVSgWazSY7NTF9HZbLZZAkia2ifjnzBpRKJRgOh2ym0xoKIKw5z3/Y4gQ4AU6AE+AEOAFO4F9mo5+/VdgkcK0owa9fPuVYcPj1q5cPkcJVFqltBVyJCYJwgOy7KzlwOQfs/BUSFfmumwSE1WrcQSK6nIC2IqET3/lfDTgBToBt/BJgAADGdGIkrI5JAAAAAElFTkSuQmCC')
$applicationsDropdown.Image = [System.Convert]::FromBase64String('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')
$fixesDropdown.Image = [System.Convert]::FromBase64String('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')
$servicesDropdown.Image = [System.Convert]::FromBase64String('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')
$accountInformationDropdown.Image = [System.Convert]::FromBase64String('iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QAAAAAAAD5Q7t/AAAACXBIWXMAAABIAAAASABGyWs+AAAACXZwQWcAAAAYAAAAGAB4TKWmAAAE90lEQVRIx7WWW2hbdRzHP/9/zjk5OWmTpl1a2252XadmW+nUbWzitMPLg1NRNgd9GCLKEBlsE/XVG+qDVxAUFMHrw3wSBWUqPih4mXY6t3XL1jS1dU2atmkuzUnOybnEF+80MEV/j//fn++H7+/y5w//c4gLuTQyMsKRI0fURCIR1XW9pVKp1E3TnJdSOmNjY/8O0N7ezp49e5iYmOgeGhq6Y2Bg4AZFUdZkMpno8eM/1pPJMx/l8/lHVFUtZLPZpgClWWLr1q0kk8ne4eEdbwzv2HF9a2urGB8fp1g6Q7mQo2YW77Pt+lQoFHqpt7fXmpmZWVYn0AyQSCTwG41d7W2R++uFSXH2xNfMpr6nR8uxc71Dlzov0+XI9is3bUlv27b1xNGjR/+Zg1OnxrBdX8Rlln0HR2jvvgJVOGh+GbcwTl/rEsems0a+uKQpaq5pieRyh+8+eTuTk2lx26aW0sjwynJf/wDR9jjhti5kMIIvgsSjOruHauVL24qL7x7eI14/tOHCm/zhM7cg1ZaOy1aveD/k5682ejahRVeiaAZO8SeqM99SPT+K5avI7mu+OP7lB7eLQLCw+5mJC3OgLh7jrUOHF7Xy2NsBr3rMmT/pu/kzuPkkbjGNV13Ac6peMKh+F7Yn3tr7/PlijOWb3HRMf3pxgL0HJjj86sZ1gVDsA631orVSDeHWitiFSWqL00nLqt46+HAtNf3yevr2n/lnAID519cxVd5Adzi1Xyj6s0Iquu/Wcep2zVxIH4it3vbafPJTNj7RXEM2Twni95xm88EpOTn05ldzyprZucw0c2WflBhcPLXlk5M9e6Ny45MFIN5UZZk9uBv4AcN4vn/71XN3DW7Z+WDw4pX7uwfXrxk//rkoVl1arnkwMprsvD6d7tzeYiQvMpe2zc4vfVh6+ikd+Owvan/bg8ewrIdZtWrjzbt2bXh6+7V9607P14UaUzBjCXovP4RRK+P1X4U2nunv29De71fqu3zf39cZeemhrq7EkVzuOeCB5UskpYKuP3rZ5s09L1x+Rff62ZIjzhUcfrYaSFUlLgLYMwUWTIfzJZeyDHC65AlTUQeFor6Qy02vBa2Zg0fo6GihVrNvjEZDlyQnlljwBIu6xjcZh968R6ei4KkKo+kSX6equLpCKajiawoEtQSOfx1SpPCWBQhcV8OyaqtHRxeIZBuYEZ3WgSh2dp4TaRheWKA6NcU5Y46yZ2PEwwizAaYDZRtsbzWGCsVXgHv/DvApFN4RsDOemighFgWsihClQnddJXVWxfTLLKbSTGl5Al6ArOviGQYYCjKsImtO/NaZO3kv8hq/ufgTwAOuUsFbQcMHx8YQS1ScLipVgT9ukgpWyeZMch2CeryVcjBMuLRAVXjoYZWYYsTfCz+uoPS4y5TIARpBcNrBQzoV2tQGmRpkqkFClsunRQliLXN6DDPWhrfUIC5qWI6NFArdnXrHTDIaxPd/B/xpimzAMcBuAxvhVYmHAsiyjVdyqAQ0PtaH+Ozimyh1RHFLHqJQI64KpGXhmg6aJNYS0g3J7/p/OBDCBxp6o1GvgJUR4HdFQpz+2cL79UGZa+sEQ4WcCXWXgOXS1aNx1nJoU3WJ65pSdfWA6+H7yy4aGSH8OxoNRwoRIGIEkZYNFQnBAAgBdQ8CAhwP4fhEVBXsBnbN5lzO9CoVa/YC/xL/TfwCh4Mvm0H6U3EAAAAldEVYdGNyZWF0ZS1kYXRlADIwMDktMDktMjhUMTE6Mjc6NTctMDQ6MDB7Y6CgAAAAJXRFWHRtb2RpZnktZGF0ZQAyMDA4LTA5LTI1VDE4OjI5OjE2LTA0OjAwgdHPGAAAAABJRU5ErkJggg==')
$appvDropdown.Image = [System.Convert]::FromBase64String('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')

#endregion Form GUI

# ================================ [Functions]
#region Functions

function PT-Connect {

    # Connect to remote workstation

    PT-ClearLog
    PT-DisableRemoteTools

    if (!($txbHostname.text -eq "") ) {

        if (!($txbIPAddress.Text -eq "") ) {

            # Warning as both IP and hostname have been entered
            PT-LogWrite "Please enter ONLY a Hostname or IP Address and try again."
            return 

        } else {

            # Set hostname up as a global variable based on the hostname entry and set its text to uppercase
            $global:hostname = $txbHostname.text.toupper()
        }

    } else {

        # Set hostname up as a global variable based on the IP Address entry and set its text to uppercase
        $global:hostname = $txbIPAddress.text.toupper()
    }

    if ($hostname -eq "") {
    
        PT-LogWrite "No Computer Name entered. Please enter a valid Computer Name / IP Address"
        PT-LineSpacer

    } else {
    
        $TestConnection = Test-Connection -ComputerName $hostname -Count 1 -BufferSize 16 -ErrorAction SilentlyContinue
    
        if (!($TestConnection)) {

            PT-LogWrite "Unable to Connect to $hostname"
            PT-LineSpacer

        } else {

            try {
    
                # Get target hostname
                $MachineName = Get-WmiObject -Class win32_computersystem -ComputerName $hostname
         
                # Compare entered hostname to target hostname to ensure no DNS issue
                if ((!($hostname -like "*.*")) -and ($MachineName.name -ne $hostname)) {

                    # Stop processing as DNS issue occured
                    PT-ClearLog
                    PT-DisableRemoteTools
                    PT-LogWrite "DNS issue encountered connecting to $hostname"    
                    PT-LineSpacer
                                   
                } else {
     
                    PT-ClearLog
                    PT-EnableRemoteTools
                    PT-LogWrite "Successfully connected to $hostname"
                
                }

            } catch {

                PT-ClearLog
                PT-LogWrite "Unable to connect to $hostname"
                PT-LineSpacer

            }

        }

    }

}

function PT-ClearLog {

    # Clear PowerTool Log

    $txbLogging.clear()

}

function PT-LogWrite {

    # Add log to PowerTool log screen

    Param ([string]$logString)
    $now = Get-Date -Format g
    $txbLogging.Appendtext("$now - $logString `r`n")

}

function PT-LineSpacer {

    # Add linespacer to logs - for formatting only

    $txbLogging.Appendtext("-------------------------------------------------------------------------------------------------------------`r`n")

}

function PT-EnableRemoteTools {

    # Enable Remote Tools & Dropdowns

    $computerInformationDropdown.Visible = $True
    $fixesDropdown.Visible = $True
    $appvDropdown.Visible = $True
    $applicationsDropdown.Visible = $True

    $tools_remote_Explorer.Enabled = $True
    $tools_remote_PSExec.Enabled = $True
    $tools_remote_Services.Enabled = $True
    $tools_remote_Ping.Enabled = $True

}

function PT-DisableRemoteTools {

    # Disable Remote Tools & Dropdowns

    $computerInformationDropdown.Visible = $False
    $fixesDropdown.Visible = $False
    $appvDropdown.Visible = $False
    $applicationsDropdown.Visible = $False

    $tools_remote_Explorer.Visible = $False
    $tools_remote_PSExec.Enabled = $False
    $tools_remote_Services.Enabled = $False
    $tools_remote_Ping.Enabled = $False

}

#endregion Functions

# ================================ [Button Events]
#region Button Events
$PowerTool.Add_KeyDown({

    # Emulate key press when entered key pressed

    if ($_.KeyCode -eq "Return") {
    
        PT-Connect
    
    }

})

$btnConnect.Add_Click({

    PT-Connect

})

$btnCopyLogs.Add_Click({

    PT-CopyLogs

})

$btnClearLogs.Add_Click({

    PT-ClearLog

})

#endregion Button Events

### Show Form
[void]$PowerTool.ShowDialog() 