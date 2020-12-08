﻿# Scripted Event Example, Uninstall Microsoft Teams
#
# Example Script Repository Settings
# Name: UninstallMicrosoftTeamsWVD
# Include Script File: Use Script File
# Import Script, Select a File: UninstallMicrosoftTeamsWVD.ps1
# Script Usage: Use this script as an argument for an executable.
# Execute With: C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe
# Arguments: -file %scriptname%
#
# Example Activity Settings
# Name: UninstallMicrosoftTeamsWVD
# Script: UninstallMicrosoftTeamsWVD
# Enabled
# Trigger On: Application Uninstall
# Target Settings, Application: Microsoft Teams WVD
# No Desktop Icon.
#


# Make sure Chocolatey is installed.
Function Get-ChocoInstalled {

    $result = $true

    Try {
        $version = choco -v
    } Catch {
        $result = $false
    }
    
    Return $result
}

$ChocoInstalled = Get-ChocoInstalled

if(-not $ChocoInstalled) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
    $ChocoInstalled = Get-ChocoInstalled
}

if($ChocoInstalled) {
    choco install cjawebrtcsvc -y --force
    choco uninstall microsoft-teams.install -y --force
} else {
    Write-Error "Chocolatey could not be detected."
}