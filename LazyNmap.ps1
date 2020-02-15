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

$ScanName = Read-Host -Prompt '[+] Welcome Boomer! Please enter the Scan Name (USE UNIQUE NAME OR CRY ALL DAY):'

$Nmaparg = Read-Host -Prompt '[+] Now provide your Nmap Arguments (such as: -v -A -T4 192.168.1.1 -oX out.xml):'

$timing = Read-Host -Prompt '[+] Enter your Timing (Format: 2/13/2020 4:06:00 PM ):'

$yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes'
$no = New-Object System.Management.Automation.Host.ChoiceDescription '&No'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
$result = $host.ui.PromptForChoice('Do you want to use default Nmap Directory?', '(Default: C:\Program Files (x86)\Nmap\nmap.exe)', $options, 0)

switch($result)
{
    0 { $haha = 'C:\Program Files (x86)\Nmap\nmap.exe' }
    1 { $haha = Read-Host -Prompt '[+] Please provide your custom Nmap directory:' } 
}
Write-Host '[!] Scheduling Scan for you, MAKE SURE SYSTEM WILL NOT GET SHUTDOWN DURING THE SCHEDULE. BYE' -ForegroundColor Green

$arg1 = New-ScheduledTaskAction -Execute $haha -Argument $Nmaparg 

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -WakeToRun

$arg2 = New-ScheduledTaskTrigger -Once -At $timing

$boomer = whoami

Register-ScheduledTask -TaskName $ScanName -User $boomer -Action $arg1 -Trigger $arg2 -Settings $settings