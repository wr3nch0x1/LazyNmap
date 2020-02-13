<#
    LazyNmap [Windows Version] aims to be a Nmap Automate Tasker because Default Nmap does not provide functionality to automate of schedule the scans.
    It uses the Windows Task Scheduler and Powershell Functions. Tested in Powershell v5.

    Author Handle: @wr3nch0x1
    Author Name: Akshay Jain
    License: BSD 3-Clause
    Required Dependencies: Nmap.exe should be under 'C:\Program Files (x86)\Nmap\nmap.exe'
    Optional Dependencies: None
    Version: 1.0
    Pratform: Microsoft Windows


.SYNOPSIS
Nmap Port Scan Scheduler

.DESCRIPTION
LazyNmap [Windows Version] aims to be a Nmap Automate Tasker

.EXAMPLE
./LazyNmap.ps1

#>

[String]$ScanName = Read-Host -Prompt '[+] Welcome Boomer! Please enter the Scan Name (USE UNIQUE NAME OR CRY ALL DAY):'


$Nmaparg = Read-Host -Prompt '[+] Now provide your Nmap Arguments (such as: -v -A -T4 192.168.1.1 -oX out.txt):'


[String]$timing = Read-Host -Prompt '[+] Last Promise, Enter your Timing (Format: 2/13/2020 4:06:00 PM ):'

Write-Host '[!] Using Defult Nmap Installed Location (C:\Program Files (x86)\Nmap\nmap.exe)'

Write-Host '[!] Scheduling Scan for you, MAKE SURE SYSTEM WILL NOT GET SHUTDOWN DURING THE SCHEDULE. BYE'

$arg1 = New-ScheduledTaskAction -Execute 'C:\Program Files (x86)\Nmap\nmap.exe' -Argument $Nmaparg

$arg2 = New-ScheduledTaskTrigger -Once -At $timing

$boomer = whoami

Register-ScheduledTask -TaskName $ScanName -User $boomer -Action $arg1 -Trigger $arg2