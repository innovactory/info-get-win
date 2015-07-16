# ======================================================
# Windows Server info-get
# Ver:0.3  
# Date: 2015.07.16
# Copyright(C) 2015 INNOVACTORY INC. ALL Rights Reserved.
# ======================================================

function start_header()
{
    Write-Output "############################################"
    Write-Output "info-get Script for Windows"
    $date = Get-Date
    Write-Output "Start:$date"
    Write-Output "############################################"
}

function header($title)
{
    Write-Output ""
    Write-Output "============================================================"
    Write-Output $title
    Write-Output "============================================================"
}

$log_base = "server-info"
$log_time = Get-Date -Format "yyyyMMdd-HHmmss"
$log_file = "${log_base}_${log_time}.log"

start_header > $log_file

# 0001 System INFO
header "0001 System INFO"  >> $log_file
systeminfo  >> $log_file

# 0002 HostName
header "0002 HostName"  >> $log_file
hostname  >> $log_file

# 0003 OS version
header "0003 OS version"  >> $log_file
[Environment]::OSVersion  >> $log_file

# 0004 Dsiks/Partition
header "0004 Disks/Partitions"  >> $log_file
Get-WmiObject Win32_DiskDrive  >> $log_file
echo "list volume" | diskpart >> $log_file

# 0005 Domain/WORKGROUP
header "0005 Domain/WORKGROUP"  >> $log_file
Get-WmiObject Win32_ComputerSystem  >> $log_file


# 0006 NetWork Settings
header "0006 NetWork Settings"  >> $log_file
ipconfig /all  >> $log_file
route print  >> $log_file
netstat -an  >> $log_file

# 0007 Roles&Features
header "0007 Roles&Features"  >> $log_file
Import-Module ServerManager  >> $log_file
Get-WindowsFeature  >> $log_file

# 0008 Installed HotFix
header "0008 Installef HotFix"  >> $log_file
Get-hotfix | format-table -property Source,description,hotfixid,installedby,installedon -Autosize | out-string -width 4096 >> $log_file 

# 0009 Installed Applications
header "0009 Installed Applications"  >> $log_file
gwmi -Class Win32_product  >> $log_file

# 0010 Windows FireWall
header "0010 Windows FireWall"  >> $log_file
netsh advfirewall show allprofiles  >> $log_file
netsh advfirewall firewall show rule name=all  >> $log_file

# 0011 User & Group
header "0011 User & Group"  >> $log_file
net user  >> $log_file
net localgroup  >> $log_file
#Get-ADUser -Filter * #AD

# 0012 Windows Update Settings
header "0012 Windows Update Settings (0=Disabled,1=OnlyNotificate,3=DownloadOnly,4=FullAuto)"  >> $log_file
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions  >> $log_file 2>&1

# 0013 NTP Settings
header "0013 NTP Settings"  >> $log_file
# NTP
net start w32time >> $log_file 2>&1
w32tm /query /status >> $log_file
w32tm /query /configuration  >> $log_file
w32tm /query /status /verbose  >> $log_file

# 0014 Share Files
header "0014 Share Files"  >> $log_file
net share  >> $log_file

# 0015 Servise
header "0015 Service"  >> $log_file
get-service | format-table -property * -Autosize | Out-string -width 4096 >> $log_file
get-service | Format-List *  >> $log_file
wmic Service  >> $log_file

# 0016 Task Schedule
header "0016 Task Schedule"  >> $log_file
schtasks /query  >> $log_file
schtasks /query /v  >> $log_file

# 0017 Windows Backup Setting
header "0017 Windows Backup Setting" >> $log_file
wbadmin enable backup >> $log_file
wbadmin get versions >> $log_file
wbadmin get disks >> $log_file

# 0018 Remote Desktop Enable
header "0018 Remote Desktop Enable(0x0=Enable,Portdefult=0xd3d(3389))"  >> $log_file
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections  >> $log_file 2>&1
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber  >> $log_file 2>&1

# 0019 All Devices
header "0019 All Devices"  >> $log_file
powercfg /devicequery all_devices  >> $log_file

# 0020 Group Polcy/Local Security Policy
header "0020 Group Polcy/Local Security Policy"  >> $log_file
gpresult /z  >> $log_file
secedit /export /areas SECURITYPOLICY /cfg .\secedit_$log_time.txt  >> $log_file
type .\secedit_$log_time.txt >> $log_file
del .\secedit_$log_time.txt

# 0021 Get env
header "0021 Get env"  >> $log_file
Get-ChildItem env: | format-table -property name,value -Autosize | out-string -width 4096 >> $log_file
Get-ChildItem env: | Format-List *  >> $log_file

# 0022 ODBC
header "0020 ODBC"  >> $log_file
type C:\windows\odbc.ini  >> $log_file 2>&1

# 0023 hosts
header "0023 hosts"  >> $log_file
type c:\Windows\System32\drivers\etc\hosts  >> $log_file

# 0024 Services
header "0024 Services"  >> $log_file
type c:\Windows\System32\drivers\etc\services  >> $log_file

# 0025 Proxy
header "0025 Proxy"  >> $log_file
netsh winhttp show proxy  >> $log_file
