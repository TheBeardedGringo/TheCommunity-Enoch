:: GitHub.bat
:: Written by DirtySanchez 
:: For ^The Community^ presented by DonkeyPunch Community Gaming
:: Discord: https://discord.me/eXpoch
:: Free to use this file and modify it for your needs

@echo off
setlocal EnableDelayedExpansion
SET MYPATH=%~dp0
call %MYPATH:~0,-1%\Settings.bat

:: *************************** GitHub Repo ****************************
call git config --global user.email "%GITEMAIL%"
call git config --global user.name "%GITNAME%"

if "%MYPATH:~0,-1%" == "%DRIVE%:\%PARENTFOLDER%\%LIVESERVERFOLDER%" (
	cd /d %DRIVE%:\%PARENTFOLDER%\%LIVESERVERFOLDER%\%LIVEPROFILE%\%LIVELOGSFOLDER%
	SET INSTANCE=LIVE)
if "%MYPATH:~0,-1%" == "%DRIVE%:\%PARENTFOLDER%\%TESTSERVERFOLDER%" (
	cd /d %DRIVE%:\%PARENTFOLDER%\%TESTSERVERFOLDER%\%TESTPROFILE%\%TESTLOGSFOLDER%
	SET INSTANCE=TEST)

:: Pull Changes
echo Remote Repo is being checked for changes.... please hold tight
call git pull
timeout %DEBUG%

:: Commit Logs
echo Server is being checked for new logs.... please hold tight
call git add .
call git commit -m "%INSTANCE% Logs Commit-%TIME%"
call git push

echo All logs have been sent to repo
timeout %DEBUG%

@exit