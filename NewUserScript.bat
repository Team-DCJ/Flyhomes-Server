:: Created by: Devin Iverson

:: Creates new user and provides it with RDP access. 

@echo off
:: set variables for use in operation
set /p firstname="First Name: "
set /p lastname="Last Name: "
set fullname=%firstname%%lastname%
set /p username="Username: "
set /p password="Password: "

:: add new user account on local computer
net user %username% %password% /ADD /DOMAIN

:: add new user to a group
net group "FLYHOMES.com" %username% /ADD /DOMAIN

:: add RDP permissions
net localgroup "Remote Desktop Users" %username% /add

:: add more permissions
net localgroup administrators FLYHOMES.com\%username% /add

echo "Script finished"
Pause