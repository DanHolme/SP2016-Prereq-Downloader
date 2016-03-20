# Download SharePoint 2016 Prerequisites
# 1.0
# 16 March 2016
#
# (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
# FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
# Please provide feedback to Dan Holme
# dan.holme@intelliem.com
#
# This script downloads SharePoint 2016 prerequisites that can be
# later installed by the SharePoint 2016 Prerequisite installer and
# by addiitonal prerequisite installation scripts.
#
# TESTED ON: Windows Server 2012 R2 
# Should work on Windows Server 2016
#
# VERSION HISTORY
# 1.0      THIS VERSION
#
# Based on a script by Craig Lussier (http://craiglussier.com) on TechNet
# http://gallery.technet.microsoft.com/office/DownloadInstall-SharePoint-e6df9eb8
# Updated for SharePoint Server 2016
#
# Run PowerShell as Administrator
#

# -------------------
# CONFIGURATION BLOCK

# Configure the folders to which updates and prerequisites are saved.
# These folders must already exist - the script does not create them.

# The top-level folder in the installation folder tree
$RootFolder = "C:\SharePointInstall"

# The folder for prerequisites installed before the Prerequisite Installer
# There are a number of updates to Windows Server 2012 R2 that must be installed
# before SharePoint Server 2016's Prerequisite Installer can be run
$Prereqs1Folder = "$RootFolder\SharePoint_Prerequisites\Windows_Server_2012_R2_Updates"

# The folder for prerequisites used by the Prerequisite Installer
$Prereqs2Folder = "$RootFolder\SharePoint_Prerequisites\PrerequisiteInstaller"

# END CONFIGURATION BLOCK
# -----------------------

# ----------------------------------------------------------------
# Download details
# Do not change unless Microsoft changes the downloads themselves
# ----------------------------------------------------------------

# Specify download url's for SharePoint 2016 prerequisites
$Downloads = @{
            # Microsoft SQL Server 2012 Native Client 64-bit edition – ENU\x64\sqlncli.MSI - http://go.microsoft.com/fwlink/p/?LinkId=239568
            "https://download.microsoft.com/download/F/E/D/FEDB200F-DE2A-46D8-B661-D019DFE9D470/ENU/x64/sqlncli.msi" = "$Prereqs2Folder\sqlncli-2012.msi";
            # Microsoft ODBC Driver 11 for SQL Server http://go.microsoft.com/fwlink/?LinkId=618410
            "https://download.microsoft.com/download/5/7/2/57249A3A-19D6-4901-ACCE-80924ABEB267/1033/amd64/msodbcsql.msi" = "$Prereqs2Folder\msodbcsql.msi";
            # Microsoft Sync Framework Runtime v1.0 SP1 (x64) http://go.microsoft.com/fwlink/?LinkId=618411
            "https://download.microsoft.com/download/E/0/0/E0060D8F-2354-4871-9596-DC78538799CC/Synchronization.msi" = "$Prereqs2Folder\Synchronization.msi"; 
            # Windows Server App Fabric http://go.microsoft.com/fwlink/?LinkId=618412
            "https://download.microsoft.com/download/A/6/7/A678AB47-496B-4907-B3D4-0A2D280A13C0/WindowsServerAppFabricSetup_x64.exe" = "$Prereqs2Folder\WindowsServerAppFabricSetup_x64.exe"; 
            # Windows Identity Foundation (KB974405)
            "http://download.microsoft.com/download/D/7/2/D72FD747-69B6-40B7-875B-C2B40A6B2BDD/Windows6.1-KB974405-x64.msu" = "$Prereqs2Folder\Windows6.1-KB974405-x64.msu"; 
            # Microsoft Identity Extensions
            # http://go.microsoft.com/fwlink/?LinkID=252368
            "http://download.microsoft.com/download/0/1/D/01D06854-CA0C-46F1-ADBA-EBF86010DCC6/rtm/MicrosoftIdentityExtensions-64.msi" = "$Prereqs2Folder\MicrosoftIdentityExtensions-64.msi";
            # Microsoft Information Protection and Control Client http://go.microsoft.com/fwlink/?LinkID=544913
            # MSI version (does not satisfy Prerequisite Installer): 
            #     http://go.microsoft.com/fwlink/?LinkId=320724
            #     https://download.microsoft.com/download/9/1/D/91DA8796-BE1D-46AF-8489-663AB7811517/setup_msipc_x64.msi
            "http://download.microsoft.com/download/3/C/F/3CF781F5-7D29-4035-9265-C34FF2369FA2/setup_msipc_x64.exe" = "$Prereqs2Folder\setup_msipc_x64.exe";
            # Microsoft WCF Data Services 5.6 required for SharePoint 2013 SP1 http://go.microsoft.com/fwlink/?LinkId=320724
            "https://download.microsoft.com/download/1/C/A/1CAA41C7-88B9-42D6-9E11-3C655656DAB1/WcfDataServices.exe" = "$Prereqs2Folder\WcfDataServices56.exe"; 
            # .NET Framework 4.6 Offline Installer http://go.microsoft.com/fwlink/?LinkId=618401
            "https://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe" = "$Prereqs2Folder\NDP46-KB3045557-x86-x64-AllOS-ENU.exe";
            # Cumulative Update Package 7 for AppFabric 1.1 for Windows Server https://support.microsoft.com/en-us/kb/3092423
            "https://download.microsoft.com/download/F/1/0/F1093AF6-E797-4CA8-A9F6-FC50024B385C/AppFabric-KB3092423-x64-ENU.exe" = "$Prereqs2Folder\AppFabric-KB3092423-x64-ENU.exe";
            # Visual C++ Redistributable for Visual Studio 2012 Update 4 http://go.microsoft.com/fwlink/?LinkId=327788
            "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe" = "$Prereqs2Folder\vcredist_x64.exe";
            # Visual C++ Redistributable for Visual Studio 2015 http://go.microsoft.com/fwlink/?LinkId=623013
            "http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe" = "$Prereqs2Folder\vc_redist.x64.exe"
            # Silverlight http://go.microsoft.com/fwlink/p/?LinkId=166506
            "http://silverlight.dlservice.microsoft.com/download/F/8/C/F8C0EACB-92D0-4722-9B18-965DD2A681E9/30514.00/Silverlight_x64.exe" = "$Prereqs3Folder\Silverlight_x64.exe";
            # Exchange Web Services Managed API, version 1.2 http://go.microsoft.com/fwlink/p/?linkid=238668
            "https://download.microsoft.com/download/7/6/1/7614E07E-BDB8-45DD-B598-952979E4DA29/EwsManagedApi.msi" = "$Prereqs3Folder\EwsManagedApi.msi";
            # Update for Windows 8.1 for x64-based Systems (KB2919442) https://www.microsoft.com/en-us/download/details.aspx?id=42162
            # a prerequisite for the Windows Server 2012 R2 Update
            "https://download.microsoft.com/download/C/F/8/CF821C31-38C7-4C5C-89BB-B283059269AF/Windows8.1-KB2919442-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2919442-x64.msu";
            # Windows Server 2012 R2 Update (KB2919355) https://support.microsoft.com/en-us/kb/2919355
            # Windows Server 2012 R2 clearcompressionflag.exe
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/clearcompressionflag.exe" = "$Prereqs1Folder\clearcompressionflag.exe";
            # Windows Server 2012 R2 Windows8.1-KB2919355-x64.msu 
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2919355-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2919355-x64.msu";
            # Windows Server 2012 R2 Windows8.1-KB2932046-x64.msu
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2932046-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2932046-x64.msu";
            # Windows Server 2012 R2 Windows8.1-KB2934018-x64.msu
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2934018-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2934018-x64.msu";
            # Windows Server 2012 R2 Windows8.1-KB2937592-x64.msu
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2937592-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2937592-x64.msu";
            # Windows Server 2012 R2 Windows8.1-KB2938439-x64.msu
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2938439-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2938439-x64.msu";
            # Windows Server 2012 R2 Windows8.1-KB2959977-x64.msu
            "https://download.microsoft.com/download/2/5/6/256CCCFB-5341-4A8D-A277-8A81B21A1E35/Windows8.1-KB2959977-x64.msu" = "$Prereqs1Folder\Windows8.1-KB2959977-x64.msu";
            } 


# Import Required Modules: BITS is used for file transfer
Import-Module BitsTransfer 

function DownloadFiles() 
{ 

    Write-Host ""
    Write-Host "====================================================================="
    Write-Host "             Downloading SharePoint 2016 Prerequisites" 
    Write-Host "====================================================================="
     
    $ReturnCode = 0 
 
    $Downloads.GetEnumerator() | ForEach { 
        $DownloadURL = $_.get_key()
        $Filespec = $_.get_value()
        # Get the file name based on the portion of the file path after the last slash 
        $FilePath = Split-Path $Filespec
        $FileName = Split-Path $Filespec -Leaf
        Write-Host "DOWNLOADING: $FileName"
        Write-Host "       FROM: $DownloadURL"
        Write-Host "         TO: $FilePath"
        
        Try 
        { 
            # Check if file already exists 
            If (!(Test-Path "$Filespec")) 
            { 
                # Begin download 
                Start-BitsTransfer -Source $DownloadURL -Destination "$Filespec" -DisplayName "Downloading `'$FileName`' to $FilePath" -Priority High -Description "From $DownloadURL..." -ErrorVariable err 
                If ($err) {Throw ""} 
                Write-Host "     STATUS: Downloaded"
                Write-Host
            } 
            Else 
            { 
                Write-Host "     STATUS: Already exists. Skipping." 
                Write-Host
            } 
        } 
        Catch 
        { 
            $ReturnCode = -1
            Write-Warning " AN ERROR OCCURRED DOWNLOADING `'$FileName`'" 
            Write-Error   $_
            Break 
        } 

    } 
    return $ReturnCode 
} 

$rc = DownloadFiles 

if($rc -ne -1)
{
    Write-Host ""
    Write-Host "DOWNLOADS ARE COMPLETE."
}
