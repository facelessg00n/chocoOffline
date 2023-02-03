#Invoke-WebRequest -Uri <source> -OutFile 
Set-ExecutionPolicy Bypass -Scope Process -Force

# Setting up directories for downloads
New-Item -Path "$env:SystemDrive\choco-setup\downloads" -ItemType Directory -Force

#$url ='https://community.chocolatey.org/api/v2/package/ChocolateyGUI/1.1.0'
#or https://packages.chocolatey.org/ChocolateyGUI.1.1.0.nupkg
#Invoke-WebRequest -Uri $url -OutFile "$env:SystemDrive\choco-setup\downloads\ChocolateyGUI.1.1.0.nupkg"

#Download Dot Net 4.6
#Rename and unpack .nupkg file, download resource and modify installer powershell so package can be internalised.
Set-Location $env:SystemDrive\choco-setup\downloads
Invoke-WebRequest -Uri "https://community.chocolatey.org/api/v2/package/DotNet4.6" -OutFile "DotNet4.6.4.6.00081.20150925.nupkg"
Rename-Item -Path "DotNet4.6.4.6.00081.20150925.nupkg" -NewName "DotNet4.6.4.6.00081.20150925.zip"
Expand-Archive DotNet4.6.4.6.00081.20150925.zip -DestinationPath DotNet4.6.4.6.00081.20150925
Set-Location C:\choco-setup\downloads\DotNet4.6.4.6.00081.20150925
Remove-Item -Path "_rels" -Recurse
Remove-Item -Path "[Content_Types].xml"

Set-Location C:\choco-setup\downloads\DotNet4.6.4.6.00081.20150925\tools
$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$lineToAdd =('$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";'+"`n")
$filecontent= $lineToAdd+$filecontent | Set-Content ChocolateyInstall.ps1
$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$filecontent -replace 'http://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe' , '$toolsDir/NDP46-KB3045557-x86-x64-AllOS-ENU.exe' | Set-Content ChocolateyInstall.ps1

#Invoke-WebRequest -Uri "http://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe" -OutFile "NDP46-KB3045557-x86-x64-AllOS-ENU.exe"
Start-BitsTransfer -Source "http://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe" -Destination "NDP46-KB3045557-x86-x64-AllOS-ENU.exe"


#------------------------------------------------------------------------------------
#Download DotNet 4.6.1
Set-Location $env:SystemDrive\choco-setup\downloads
Invoke-WebRequest -Uri "https://community.chocolatey.org/api/v2/package/DotNet4.6.1" -OutFile "DotNet4.6.1.4.6.01055.20170308.nupkg"
Rename-Item -Path "DotNet4.6.1.4.6.01055.20170308.nupkg" -NewName "DotNet4.6.1.4.6.01055.20170308.zip"
Expand-Archive DotNet4.6.1.4.6.01055.20170308.zip -DestinationPath DotNet4.6.1.4.6.01055.20170308
Set-Location C:\choco-setup\downloads\DotNet4.6.1.4.6.01055.20170308
Remove-Item -Path "_rels" -Recurse
Remove-Item -Path "[Content_Types].xml"
Set-Location C:\choco-setup\downloads\DotNet4.6.1.4.6.01055.20170308\tools

$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$filecontent -replace 'https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe','$toolsDir/NDP461-KB3102436-x86-x64-AllOS-ENU.exe'| Set-Content ChocolateyInstall.ps1

#Invoke-Webrequest -uri "https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe" -OutFile "NDP461-KB3102436-x86-x64-AllOS-ENU.exe"
Start-BitsTransfer -Source "https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe" -Destination "NDP461-KB3102436-x86-x64-AllOS-ENU.exe"


#------------------------------------------------------------------------
#Download KB2919355
Set-Location $env:SystemDrive\choco-setup\downloads
Invoke-WebRequest -Uri "https://community.chocolatey.org/api/v2/package/KB2919355" -OutFile "KB2919355.1.0.20160915.nupkg"
Rename-Item -Path "KB2919355.1.0.20160915.nupkg" -NewName "KB2919355.1.0.20160915.zip"
Expand-Archive KB2919355.1.0.20160915.zip -DestinationPath KB2919355.1.0.20160915
Set-Location C:\choco-setup\downloads\KB2919355.1.0.20160915
Remove-Item -Path "_rels" -Recurse
Remove-Item -Path "[Content_Types].xml"
Set-Location C:\choco-setup\downloads\KB2919355.1.0.20160915\tools

$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$lineToAdd =('$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";'+"`n")
$filecontent= $lineToAdd+$filecontent | Set-Content ChocolateyInstall.ps1
$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$filecontent -replace "https://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/Windows8.1-KB2919355-x64",'$toolsDir/Windows8.1-KB2919355-x64' -replace "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2919355-x64.msu",'$toolsDir/Windows8.1-KB2919355-x64' -replace 'https://download.microsoft.com/download/4/E/C/4EC66C83-1E15-43FD-B591-63FB7A1A5C04/Windows8.1-KB2919355-x86.msu','$toolsDir/Windows8.1-KB2919355-x86.msu'

Start-BitsTransfer -Source "https://download.microsoft.com/download/4/E/C/4EC66C83-1E15-43FD-B591-63FB7A1A5C04/Windows8.1-KB2919355-x86.msu" -Destination "Windows8.1-KB2919355-x86.msu"
#Invoke-WebRequest -uri "https://download.microsoft.com/download/4/E/C/4EC66C83-1E15-43FD-B591-63FB7A1A5C04/Windows8.1-KB2919355-x86.msu" -Outfile "Windows8.1-KB2919355-x86.msu"
Start-BitsTransfer -Source "https://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/Windows8.1-KB2919355-x64.msu" -Destination "Windows8.1-KB2919355-x64.msu"
#Invoke-WebRequest -uri "https://download.microsoft.com/download/D/B/1/DB1F29FC-316D-481E-B435-1654BA185DCF/Windows8.1-KB2919355-x64.msu" -OutFile "Windows8.1-KB2919355-x64.msu"

#------------------------------------------------------------------------
#Download KB2919442
Set-Location $env:SystemDrive\choco-setup\downloads
Invoke-WebRequest -Uri "https://community.chocolatey.org/api/v2/package/KB2919442"-OutFile "KB2919442.1.0.20160915.nupkg"
Rename-Item -Path "KB2919442.1.0.20160915.nupkg" -NewName "KB2919442.1.0.20160915.zip"
Expand-Archive KB2919442.1.0.20160915.zip -DestinationPath KB2919442.1.0.20160915
Set-Location C:\choco-setup\downloads\KB2919442.1.0.20160915
Remove-Item -Path "_rels" -Recurse
Remove-Item -Path "[Content_Types].xml"
Set-Location C:\choco-setup\downloads\KB2919442.1.0.20160915\tools

$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$lineToAdd =('$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)";'+"`n")
$filecontent= $lineToAdd+$filecontent | Set-Content ChocolateyInstall.ps1
$filecontent = Get-Content -Path ChocolateyInstall.ps1 -Raw
$filecontent 
    -replace "https://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu",'$toolsDir/Windows8.1-KB2919442-x64.msu' 
    -replace "https://download.microsoft.com/download/D/6/0/D60ED3E0-93A5-4505-8F6A-8D0A5DA16C8A/Windows8.1-KB2919442-x64.msu",'$toolsDir/Windows8.1-KB2919442-x64.msu' 
    -replace "https://download.microsoft.com/download/9/D/A/9DA6C939-9E65-4681-BBBE-A8F73A5C116F/Windows8.1-KB2919442-x86.msu",'$toolsDir/Windows8.1-KB2919442-x86.msu'
    | Set-Content ChocolateyInstall.ps1

Start-BitsTransfer -Source "https://download.microsoft.com/download/9/D/A/9DA6C939-9E65-4681-BBBE-A8F73A5C116F/Windows8.1-KB2919442-x86.msu" -Destination "Windows8.1-KB2919442-x86.msu"
#Invoke-WebRequest -uri "https://download.microsoft.com/download/9/D/A/9DA6C939-9E65-4681-BBBE-A8F73A5C116F/Windows8.1-KB2919442-x86.msu" -OutFile "Windows8.1-KB2919442-x86.msu"
Start-BitsTransfer -Source "https://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu" -Destination "Windows8.1-KB2919442-x64.msu"
#Invoke-WebRequest -uri "https://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu" -OutFile "Windows8.1-KB2919442-x64.msu"




