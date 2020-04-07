:: RestartServer.bat
:: Written by DirtySanchez 
:: For ^The Community^ presented by DonkeyPunch Community Gaming
:: Discord: https://discord.me/eXpoch
:: Free to use this file and modify it for your needs

@echo off
setlocal EnableDelayedExpansion
SET MYPATH=%~dp0
call Settings.bat

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


:: ************************ Firewall Rule OFF ************************
echo Disabling firewall rules for this server
netsh advfirewall firewall delete rule name=%FIREWALLNAME% program="%DAYZSA%\%SERVEREXE%"
timeout %DEBUG%


:: ************************ Stop All DayZ SA *************************
echo Making sure all instances of this server have stopped
taskkill /f /fi "status eq not responding" /im %SERVEREXE%
taskkill /f /im %SERVEREXE%
timeout %DEBUG%


:: *********************** DPCG Backup Utility ***********************
C:\Windows\System32\cmd.exe /C start "dayzsabackup" "%DAYZSA%\DayZSADatabaseBackup.cmd"
echo Backup of logs, database and more has completed
timeout %DEBUG%


:: ************************** DayZ SA Update *************************
%STEAMCMD%\steamcmd.exe +login %USERNAME% %PASSWORD% +app_update 223350 +quit
if exist %DAYZSA%\keys\dayz.bikey (
	fc /b %STEAMCOMMON%\keys\dayz.bikey %DAYZSA%\keys\dayz.bikey > nul
	if errorlevel == 1 (
		robocopy %STEAMCOMMON% %DAYZSA% /COPYALL /E
	) else (
		echo NO UPDATES AVAILABLE
	)
) else (
	robocopy %STEAMCOMMON% %DAYZSA% /COPYALL /E
)
echo DayZServer updates completed
timeout %DEBUG%


:: ************************** Mod Update Check *************************
FOR %%G IN (%MODIDS%) DO (
	if exist %DAYZSA%\@!MOD[%%G]!\meta.cpp (
		fc /b %WORKSHOP%\%%G\meta.cpp %DAYZSA%\@!MOD[%%G]!\meta.cpp > nul
		if errorlevel == 1 (
			robocopy %WORKSHOP%\%%G\key %KEYSDIR% /COPYALL /E
			robocopy %WORKSHOP%\%%G\keys %KEYSDIR% /COPYALL /E
			robocopy %WORKSHOP%\%%G %DAYZSA%\@!MOD[%%G]!\ /COPYALL /E
		)
	) else (
		robocopy %WORKSHOP%\%%G\key %KEYSDIR% /COPYALL /E
		robocopy %WORKSHOP%\%%G\keys %KEYSDIR% /COPYALL /E
		robocopy %WORKSHOP%\%%G\ServerProfileFolder %PROFILEDIR% /COPYALL /E
		robocopy %WORKSHOP%\%%G\!MOD[%%G]! %PROFILEDIR% /COPYALL /E
		robocopy %WORKSHOP%\%%G %DAYZSA%\@!MOD[%%G]!\ /COPYALL /E
	)
)
echo All mods have been checked on steamcmd
timeout %DEBUG%


:: ************************* DayZ SA Startup **************************
echo Starting DayZServer
C:\Windows\System32\cmd.exe /C start /AFFINITY %CPUAFFINITY% /%PRIORITY% "%FIREWALLNAME%" "%DAYZSA%\%SERVEREXE%" -port=%GAMEPORT% "-mod=%MODNAMES%" -config=%DAYZSA%\%CONFIG% -profiles=%PROFILE% -BEPath=%BATTLEYE% -filePatching -adminlog -netlog -freezecheck -scrAllowFileWrite
timeout %BECSTARTUPDELAY%


:: *************************** BEC Startup ****************************
echo Start BEC
cd /d %BATTLEYE%\BEC
start "" /min "%BECEXE%" --dsc config.cfg
echo Battleye has started.. 
timeout %DEBUG%

:: ************************* Firewall Rule ON *************************
echo Turning on Firewall Rule to allow server network traffic
netsh advfirewall firewall add rule name="%FIREWALLNAME%" dir=in action=allow program="%DAYZSA%\%SERVEREXE%" enable=yes
echo Firewall is on and players can join
timeout %DEBUG%

:: Server Monitor
:: ********************** Server Monitor Startup **********************
echo Starting Server Monitor Loop
cd /d %DAYZSA%
start "" "servermonitor.bat"
echo Server Monitor has started. Have Fun
timeout %DEBUG%

@exit 