# Disable antivirus
Write-Log "Disable realtime monitoring"
Set-MpPreference -DisableRealtimeMonitoring $true

# install choco
Write-Log "install choco"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# install rsat for server
Write-Log "install RSAT for server"
Get-WindowsFeature | Where-Object {$_.name -like "*RSAT*"}| Install-WindowsFeature -IncludeAllSubFeature

# install rsat for pro
#Write-Log "install RSAT"
#Get-WindowsCapability -Name RSAT* -Online | where State -EQ NotPresent | Add-WindowsCapability -Online

# importing root certificate
Import-Certificate -FilePath "$($env:SystemDrive)\UnattendResources\CustomResources\Virtio_Win_Red_Hat_CA.cer" -CertStoreLocation 'Cert:\LocalMachine\Root'
Import-Certificate -FilePath "$($env:SystemDrive)\UnattendResources\CustomResources\redhat.0.1.185.cer" -CertStoreLocation 'Cert:\LocalMachine\TrustedPublisher'
