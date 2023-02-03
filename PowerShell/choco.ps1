# Ensure we can run everything
Set-ExecutionPolicy Bypass -Scope Process -Force

# Setting up directories for values
New-Item -Path "$env:SystemDrive\choco-setup" -ItemType Directory -Force
New-Item -Path "$env:SystemDrive\choco-setup\files" -ItemType Directory -Force
New-Item -Path "$env:SystemDrive\choco-setup\packages" -ItemType Directory -Force

# Install Chocolatey
# NONADMIN - you'll need this uncommented to redirect to a different location:
# $env:ChocolateyInstall="$env:ProgramData\chocoportable"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) 
#iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Set Configuration
choco config set --name cacheLocation --value $env:ALLUSERSPROFILE\choco-cache
choco config set --name commandExecutionTimeoutSeconds --value 14400
#TODO: Add other items you would configure here
# https://docs.chocolatey.org/en-us/configuration

# Download local install script - need at least PowerShell v3
$installScript = iwr -UseBasicParsing -Uri https://gist.githubusercontent.com/ferventcoder/d0aa1703a7d302fce79e7a4cc13797c0/raw/b1f7bad2441fa6c371b48b8475ef91cecb4d6370/ChocolateyLocalInstall.ps1 -UseDefaultCredentials

$installScript.Content | Out-File -FilePath "$env:SystemDrive\choco-setup\files\ChocolateyLocalInstall.ps1" -Encoding UTF8 -Force
Write-Warning "Check and adjust script at '$env:SystemDrive\choco-setup\files\ChocolateyLocalInstall.ps1' to ensure it points to the right version of Chocolatey in the choco-setup\packages folder."