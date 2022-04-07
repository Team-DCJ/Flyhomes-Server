# Author: Devin Iverson
# Script Name: custom-config.ps1

# Enable File and Printer Sharing
Function FilePrintSharing
{
    Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any
    
}

# Allow ICMP traffic
Function ICMP_Traffic
{
   netsh advfirewall firewall add rule name="Allow incoming ping requests IPv4" dir=in action=allow protocol=icmpv4
}

# Enable Remote Management
Function Remote_Manage
{
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\'-Name "UserAuthentication" -Value 1
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

}

# Remove bloatware
Function Remove-bloatware
{
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))

}

# Enable Hyper-V
Function Hyper_On
{
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

}

# Enable SMBv1, an insecure protocol
Function Enable-SMBv1
{
    Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart

}

# main function
Function Main
{
    FilePrintSharing
    ICMP_Traffic
    Remote_Manage
    Remove-bloatware
    Hyper_On
    Enable-SMBv1
    # one restart at end to cover all bases
    Restart-Computer
}

Main
