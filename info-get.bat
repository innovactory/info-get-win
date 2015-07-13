:: =======================================================
:: Windows Server Info-get Script
:: Ver:0.1  
:: Date: 2015.07.13
:: Copyright(c) 2015 INNOVACTORY INC. ALL Rights Reserved.
:: =======================================================

@echo off
echo ########################
echo Info-get Script Start?
echo ########################
pause

echo ########################
echo Info-get Script Execute!
echo ########################

powershell Set-ExecutionPolicy Unrestricted
powershell .\server_info.ps1
powershell Set-ExecutionPolicy Restricted

echo ########################
echo Info-get Script End!
echo ########################
