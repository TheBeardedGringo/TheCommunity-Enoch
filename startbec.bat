:: RestartServer.bat
:: Written by DirtySanchez 
:: For ^The Community^ presented by DonkeyPunch Community Gaming
:: Discord: https://discord.me/eXpoch
:: Free to use this file and modify it for your needs

@echo off
setlocal EnableDelayedExpansion
SET MYPATH=%~dp0
call %MYPATH:~0,-1%\Settings.bat

:: **************************** Servers ****************************
if "%MYPATH:~0,-1%" == "%DRIVE%:\%PARENTFOLDER%\%LIVESERVERFOLDER%" (
	SET SERVERFOLDER=%LIVESERVERFOLDER%
	SET SERVEREXENAME=%LIVESERVEREXENAME%
	SET GAMEPORT=%LIVEGAMEPORT%
	SET PROFILE=%LIVEPROFILE%
	SET CONFIG=%LIVECONFIG%
	SET BECEXE=%LIVEBECEXE%
	SET FIREWALLNAME=%LIVEFIREWALLNAME%
	SET BRANCH=%LIVEBRANCH%
	SET STORAGEINSTANCE=%LIVESTORAGEINSTANCE%
	SET PRIORITY=%LIVEPRIORITY%
	SET CPUAFFINITY=%LIVECPUAFFINITY%
	echo You are using the LIVE Server Settings
)

if "%MYPATH:~0,-1%" == "%DRIVE%:\%PARENTFOLDER%\%TESTSERVERFOLDER%" (
	SET SERVERFOLDER=%TESTSERVERFOLDER%
	SET SERVEREXENAME=%TESTSERVEREXENAME%
	SET GAMEPORT=%TESTGAMEPORT%
	SET PROFILE=%TESTPROFILE%
	SET CONFIG=%TESTCONFIG%
	SET BECEXE=%TESTBECEXE%
	SET FIREWALLNAME=%TESTFIREWALLNAME%
	SET BRANCH=%TESTBRANCH%
	SET STORAGEINSTANCE=%TESTSTORAGEINSTANCE%
	SET PRIORITY=%TESTPRIORITY%
	SET CPUAFFINITY=%TESTCPUAFFINITY%
	echo You are using the Test Server Settings
)


:: ************************ Link Shorteners *************************
SET SERVEREXE=%SERVEREXENAME%.exe
SET STEAMCMD=%DRIVE%:\steamcmd
SET DAYZSA=%DRIVE%:\%PARENTFOLDER%\%SERVERFOLDER%
SET KEYSDIR=%DAYZSA%\keys\
SET PROFILEDIR=%DAYZSA%\%PROFILE%\
SET MISSION=%COMMUNITYNAME%.%MAP%
SET WORKSHOP=%STEAMCMD%\steamapps\workshop\content\221100
SET STEAMCOMMON=%STEAMCMD%\steamapps\common\DayZServer
SET BATTLEYE=%DAYZSA%\battleye


:: *************************** BEC Startup ****************************
echo Start BEC
cd /d %BATTLEYE%\BEC
start "" /min "%BECEXE%" --dsc config.cfg
echo Battleye has started.. 
timeout %DEBUG%


:: Server Monitor
:: ********************** Server Monitor Startup **********************
:: echo Starting Server Monitor Loop
:: cd /d %DAYZSA%
:: start "" "servermonitor.bat"
:: echo Server Monitor has started. Have Fun
:: timeout %DEBUG%

@exit 