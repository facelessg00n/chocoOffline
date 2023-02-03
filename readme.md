[Chocolatey Software | Chocolatey - The package manager for Windows](https://chocolatey.org/)
Chocolatey is a Windows software management solution which can be utilised to package and distribute software across machines. This can be used to keep software versions up to date without staff manually having to install software. They can simply install it from an "app store" like environment. To perform this the endpoints will be required to connect to a network which can communicate with the Chocolatey server. This server hosts the packaged apps and includes version control.

The simplicity of use makes it ideal for updating software on multiple workstations and packaging software is a relatively simple process.

It is suggested you practice this in a VM platform of your choice to ensure it is suitable for your needs.

---

### Contents

[[Chocolatey setup]]  This document
[[Docker]] - To setup an icon server

[[Packaging apps]]

---

### Initial setup

Instructions as per the Chocolatey website. These instructions can be difficult to follow as they also include instructions for the paid version of Chocolatey which is slightly different.
[Chocolatey Software Docs | Set up Chocolatey for Internal/organizational use](https://docs.chocolatey.org/en-us/guides/organizations/organizational-deployment-guide)

[Chocolatey Software Docs | Manually Recompile Packages, Embedding/Internalizing Remote Resources](https://docs.chocolatey.org/en-us/guides/create/recompile-packages)

### Offline install

---
This guide considers you are using the FOSS version (Free open source) of Chocolatey.

This guide will walk you through setting up the FOSS version of Chocolatey for an offline install. Chocolatey will function on a standalone network however packages will be required to be "internalised" and brought across to the server manually.

### Things you will need

Machine or VM with an internet connection to download files and prepare them for moving to the offline machine. You will be required to have sufficient admin privileges to  install Chocolatey on this machine.

An offline PC or VM setup with a fileshare setup. You will also need a basic network setup either with Static IP's or a DHCP server

Ubuntu can act as a Samba server and DHCP server if required.

A simple web-server for hosting icons if the chocolatey GUI is to be used. This can easily be setup with docker, or Apache.

### Setup installer files

---
The first step of this process is to download and bundle up the required files to install Chocolatey so they can be taken over to your offline device.  This will require internalising and packaging some Windows updates.

Instructions on the Chocolatey website may appear confusing as there is a large amount of other steps inserted for the paid versions however here are the shortened FOSS specific install instructions. A Powershell script will be included below, alternately you may copy and paste from below.

These steps will need to be conducted on an internet connected local machine or VM. about 1.5GB of material is required to be downloaded.

Consider buying the paid version of Chocolatey to support the project if it meets your business needs. This helps to support the project.

---

#### Download and install Chocolatey

Chocolatey and the required resources are required to be downloaded and packaged to make them ready to be moved to a standalone machine or environment.

This step is required to pull down all the required resources and package them together.

1. Open a PowerShell terminal with admin privileges.

Type `cd \` to get to the root directory of the drive and then enter the below commands into the terminal. This will create the required folder structure and run the install script.

`New-Item -Path "$env:SystemDrive\choco-setup" -ItemType Directory -Force`

`cd choco-setup`

`New-Item -Path "$env:SystemDrive\choco-setup\files" -ItemType Directory -Force`

`New-Item -Path "$env:SystemDrive\choco-setup\packages" -ItemType Directory -Force`

`cd packages`

`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`

If you run the command `choco` you should now see the Chocolatey version displayed, this indicates chocolatey has been downloaded and installed succesfully on this machine.

A number of further packages need to be downloaded and internalised to allow them to be transported to a standalone machine.

Typically resources are pulled from their online locations however internalising a package bundles the required files into the .nupkg file. This can also be used to direct the script to an internal file share.

- Chocolatey
- Chocolatey GUI

- Chocolatey Server
- Dotnet4.6
- DotNet4.6.1
- KB2919355
- KB2919442

The below packages are also necessary for the Chocolatey GUI to be installed. It is recommended to install the GUI for ease of use for end users.

Chocolatey (≥ 1.0.0 && < 2.0.0)

chocolatey-core.extension (≥ 1.3.3)
chocolatey-compatibility.extension (≥ 1.0.0)
chocolatey-dotnetfx.extension (≥ 1.0.1)
dotnetfx (≥ 4.8.0.20190930)

---

### Internalise dependencies

[[Configs]]

A number of Powershell scrips have been created to pull down all the required resources and package them from a standalone install. This prevents the tedious task of manually internalising packages.

By way of explanation the first set of commands pulls down all the .nupkg files. These are then unzipped and the patches are pulled down from Microsoft and placed in the `/tools` folder.

chocoOffline.ps1

1. Copy these commands into an admin Powershell
2. Run the commands, this should pull down all the required files, if any fail to download there will be an error message displayed. Until error handling is added you will be to recopy the command i.e `Start-BitsTranfer -Source....`  and copy the downloaded file into the appropriate /tools folder.

### Copy to your standalone machine

1. Copy the now populated `C:\choco-setup` folder and all of its contents to a USB and transport it to your standalone machine.

2. Copy the folder and its contents to `C:\choco-setup` on the destination machine.

3. Open an Admin powershell window

4. You may need to enable the running of scripts with the following command `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

5. Navigate to the Chocolatey install script
    1. `cd \`
    2. `cd c:\choco-setup\files\
6. Run the install script `ChocolateyLocalInstall.ps1`

7. Test to see if the `choco` command works.

8. Remove the default source, which is the online source
        `choco sources remove --name "chocolatey"`

9. Add a local 'setup' source.
    `choco source add --name="'setup'" --source="'$env:SystemDrive\choco-setup\packages'"`

### Install required dependencies on the Standalone machine

These steps will install the required dependencies on a standalone machine.

### Install GUI

The GUI also needs these dependencies which we obtained in a previous step. In an admin Powershell window enter the following commands.
`Set-Location C:\choco-setup\packages`

`choco install .\chocolatey-compatibility.extension.1.0.0.nupkg`

`choco install .\chocolatey-core.extension.1.4.0.nupkg`

`choco install .\DotNet4.6.1.4.6.01055.20170308.nupkg -y`

`choco install .\DotNet4.6.4.6.00081.20150925.nupkg -y`

`choco install .\dotnetfx.4.8.1.0-rtw.nupkg -y`

---

### Reboot machine

Reboot the machine to complete the installation of the previous dependencies.
You will now then be able to setup the GUI

 `Set-Location C:\choco-setup\packages`

`choco install .\ChocolateyGUI.1.1.0.nupkg -y`

----

### Chocolatey Server

The Chocolatey server provides a list of available packages to the client machines. This server will require the following.

Network security is to be considered when setting up this environment, I have only provided basic setup instructions to get you started as there is a large amount of possible configurations.

- Access to a file share to host your installer packages
- A webserver for hosting icon files

A simple web server can be setup via Docker running httpd, instructions to perform this can be found in the Docker secion of these documents

The network will require A DHCP server or static IP addresses setup to allow devices to communicate. This can be performed from within a VM such as Ubuntu.

The server hosts the packages in the `C:\tools\` directory.

---

### Other

### Adding icons to files

[[Icons]]
The chocolatey GUI performs a get request to a webserver to pull down icon files listed in the .nuspec files. These files are stored in their respective repository locations at the following path. `tools/chocolatye.server/App_data/packages`

#### Hosting icons

Docker can be used to host the icons, [[Docker]] . Alternately Python, Apache or a variety of other services can be utilised.

### Problems

Scripts unable to run
You will need to run this command in an admin Powershell window if you get a warning showing scripts are unable to be run
`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
