Packaging an application provides the neccesary details for Chocolatey to be able to install the software. This will be in the form of a .nuspec file and a number of powershell scripts, the one of particular impotance being the .... install script.
This includes the following

- Name of package
- Version of software
  - It is important to develop a appropriate naming scheme when you are packaging your own software
- Link to resources and dependencies
- Install switches
- Information about the software which can be displayed to an end user

### Resources

Documentation from Chocolatey
[Chocolatey Software Docs | Package Creation](https://docs.chocolatey.org/en-us/create/)

Specification for .nuspec files
[.nuspec File Reference for NuGet | Microsoft Learn](https://learn.microsoft.com/en-us/nuget/reference/nuspec)

Sample install script
[chocolatey-packages/chocolateyInstall.ps1 at master · ferventcoder/chocolatey-packages · GitHub](https://github.com/ferventcoder/chocolatey-packages/blob/master/manual/windirstat/tools/chocolateyInstall.ps1)

### Naming

It is important to consider a naming scheme for packages. The package ID field in the .nuspec file is the name given to the package, the subsequent versions will need to have the same package ID but updated version number.

Chocolatey docs suggest these names should be all lowercase and no spaces for consistencey however for an internal repository your own naming scheme can be developed.

### Package generation

Packages can be iternalised which involves pulling resources down from the web and then repackaging them for internal use, or packaging apps for use internally. This consideres the second use case. I.e you have a piece of software which your organisation uses and you want to bundle it up so endpoints can install or update the application. Internalising appication instructions are detailed in the internalising section of these instructions.

What you need

- Notepad ++ or a simlar code editor
- Relevant install files, preferably with their silent switches
  - These files are to be hosted on a file share which will be accessible to the client machines
  - You will need to know the path to the relevant files
- Icon files as per these instructions [[Icons]]
  - You can use it with icons but the Ui/Ux experience is diminished.

Packages can be created from the command line by Chocolatey. This will generate the necessary folder structure and templates. These templates can appear daunting as they contain a large amount of lines of code, however only a few are needed.

---

### Generate a package

This action can be performed on a number of machines, I suggest testing this in a virtualized environment to test your workflow.

- The Chocolatey server itself
- One of the Chocolatey endpoints with the appropriate permissions to push the package to the server
- A dedicated packaging VM or machine

In this example we will package Mobile phone forensic software, Cellebrite Physical Analyzer. A number of updated versions of this software are released during the year.

When you download the software you receive a zip file containing the installer. When an endpoint user choses to install the software Chocolatey will pull this zip file from your file share, unpack the zip and then run the installer with the appropriate switches.
Smaller installers can be packaged within the Chocolatey package but it is suggested this is limited to 1GB.

Take note of the zip file and its location on your file share.
*Cellebrite_Physical_Analyzer_7.58.0.66_xxx.zip*
You will also need the hash of the file as Chocolatey will validate this during the install process.
Command line example as per below. This should also be compared to the hash provided by the vendor.
`certutil -hashfile .\Cellebrite_Physical_Analyzer_7.58.0.66_xxx.zip sha256`

Open the zip file and take note of the name of the installer .exe file contained within. You do not need to unpack the zip file.
*Cellebrite_Physical_Analyzer_7.58.0.66.exe*

Open an admin Powershell widow and navigate to the root directory `cd \`
 Then navigate to the chocolatey directory

I like to also make a packing folder inside this directory to not mess up the packages folder struture.

Navigate to the packages or packing folder

You can now create your package
`choco new package-name-here`

This will generate a folder with the name `package-name-here` in the folder the command is run from. This folder will contain the requisite files and structure to build your Chocolatey package.

The *.nuspec* file is in the root directory of this folder and can be modified.

- Pay attention to the version number and naming conventions
- For a new version of the software the package name needs to remain the same, but the version updated.

The *chocolateyinstall.ps1* is located in the */tools* folder. This script will need to be modified to to include the location ad file hash of the installer .zip

----

### Building your package

This step prepares the package for upload to the Chocolatey server

### Uploading to the Server
