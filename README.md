# SP2016-Prereq-Downloader
SharePoint Server 2016 Prerequisite Downloader

This script will download all prerequisites that are required for the installation of SharePoint Server 2016 on Windows Server 2012 R2.

For details, see https://www.itunity.com/article/automatically-download-sharepoint-server-2016-prerequisites-powershell-script-3164

It stores prerequisites in three folders:

- A folder for SharePoint Server 2016's prerequisites. 

  These prerequisites can be used for offline installation of prerequisistes by PrerequisiteInstaller.exe.
   
  Use PREREQUISITEINSTALLER.EXE /? for syntax.
  
  See https://technet.microsoft.com/EN-US/library/ff686793(v=office.16).aspx for details

- A folder for the updates to Windows Server 2012 R2 that must be applied
  before you can run PrerequisiteInstaller.exe

  I will be uploading a script that applies these updates in the correct order.
  
  Until then, please note that the Windows Server 2012 R2 updates must be applied in this order:
  
  -  KB2919442 (restart required)
  -  clearcompressionflag.exe
  -  KB2919355
  -  KB2932046
  -  KB2959977
  -  KB2937592
  -  KB2938439
  -  KB2934018
  
  See https://www.microsoft.com/en-us/download/details.aspx?id=42334 and 
  https://support.microsoft.com/en-us/kb/2919355 for details

- A folder for updates that are necessary only in certain scenarios, including Silverlight and Exchange Web Services Managed API. 
 
To modify this script for your environment:

- Create the folders to which updates and prerequisites will be saved
- Modify the values in the CONFIGURATION BLOCK section
- Run the script in a PowerShell console (or ISE) launched with the RUN AS ADMINISTRATOR option

## CHANGE LOG
3/21/2016 - Optional updates (Silverlight 3 and Exchange Web Services Managed API) downloading to a non-existent folder. FIXED.
