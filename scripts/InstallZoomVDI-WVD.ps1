# Scripted Event Example, Install Zooom VDI-WVD
#
# Example Script Repository Settings
# Name: InstallZoomVDI-WVD
# Include Script File: Use Script File
# Import Script, Select a File: InstallZoomVDI-WVD.ps1
# Script Usage: Use this script as an argument for an executable.
# Execute With: C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe
# Arguments: -file %scriptname%
#
# Example Activity Settings
# Name: InstallZoomVDI-WVD
# Script: InstallZoomVDI-WVD
# Enabled
# Trigger On: Application Install
# Target Settings, Application: Zoom VDI
# Application Icon Path: \\shortcuts\Zoom VDI.lnk

$zoomMsiUrl = 'https://zoom.us/download/vdi/3.3.2/ZoomInstallerVDI.msi'
$zoomPluginUrl = 'https://zoom.us/download/vdi/3.3.2/ZoomWVDMediaPlugin.msi'
$zoomMsi = "$PSScriptRoot\ZoomInstallerVDI.msi"
$zoomPlugin = "$PSScriptRoot\ZoomWVDMediaPlugin.msi"

$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($zoomMsiUrl, $zoomMsi)
$webClient.DownloadFile($zoomPluginUrl, $zoomPlugin)

$msiArguments = @(
    "/i"
    "$zoomMsi"
    "/qn"
    "/norestart"
)

$pluginArguments = @(
    "/i"
    "$zoomPlugin"
    "/qn"
    "/norestart"
)

Start-Process 'msiexec.exe' -ArgumentList $msiArguments -Wait -NoNewWindow

Start-Process 'msiexec.exe' -ArgumentList $pluginArguments -Wait -NoNewWindow

Remove-Item -Path $zoomMsi
Remove-Item -Path $zoomPlugin