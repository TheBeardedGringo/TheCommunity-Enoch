:: ServerMonitor.bat
:: Written by DirtySanchez 
:: For ^The Community^ presented by DonkeyPunch Community Gaming
:: Discord: https://discord.me/eXpoch
:: Free to use this file and modify it for your needs

@echo off
title serverBECmonitor.bat
setlocal EnableDelayedExpansion
SET MYPATH=%~dp0
call %MYPATH:~0,-1%\Settings.bat

if "%MYPATH:~0,-1%" == "%DRIVE%:\%PARENTFOLDER%\%COMMUNITYNAME%_%MAP%" ( SET SERVERBECEXE=Bec3.exe )
if "%MYPATH:~0,-1%" == "%DRIVE%:\%PARENTFOLDER%\%COMMUNITYNAME%_%MAP%Test" ( SET SERVERBECEXE=bec3test.exe )


:start
C:\Windows\System32\tasklist /FI "IMAGENAME eq %SERVERBECEXE%" 2>NUL | C:\Windows\System32\find /I /N "%SERVERBECEXE%">NUL
if "%ERRORLEVEL%"=="0" goto loop
echo Server is not running, will be started now 
start "" /min /wait "%MYPATH:~0,-1%\startbec.bat" 
timeout 30
echo Server started succesfully
exit
goto started


:loop
cls
echo Server is already running, running monitoring loop
echo %MYPATH:~0,-1%


:started
::THE 150 REFERS TO SECONDS AND HOW OFTEN IT WILL CHECK,YOU CAN SET IT TO WHATEVER YOU WANT. I JUST DONT WANT MY SERVER DOWN FOR MUCH LONGER THAN THAT!
::New error fault kill, will check for err fault and clear it and hopefully restart, a little more promise but no guarantee :)
taskkill /f /im WerFault.exe /fi "WINDOWTITLE eq Bec"
C:\Windows\System32\timeout /t 150
C:\Windows\System32\tasklist /FI "IMAGENAME eq %SERVERBECEXE%" 2>NUL | C:\Windows\System32\find /I /N "%SERVERBECEXE%">NUL
if "%ERRORLEVEL%"=="0" goto loop
goto start