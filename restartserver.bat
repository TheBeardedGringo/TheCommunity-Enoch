:: RestartServer.bat
:: Written by DirtySanchez 
:: For ^The Community^ presented by DonkeyPunch Community Gaming
:: Discord: https://discord.me/eXpoch
:: Free to use this file and modify it for your needs

@echo off
setlocal EnableDelayedExpansion
SET MYPATH=%~dp0


:: *********************** General Settings *************************
SET DEBUG=2
:: ^The Community^ uses D:\DayZServers\TheCommunity_Enoch so DRIVE=D and PARENTFOLDER=DayZServers
SET DRIVE=D
SET PARENTFOLDER=DayZServers
SET MAP=enoch
SET COMMUNITYNAME=TheCommunity
:: Delay BEC from loading(in seconds) to allow for the server to fully start before BEC RCON login
SET BECSTARTUPDELAY=40


:: ********************* LIVE Server Settings ***********************
:: ^The Community^ uses D:\DayZServers\TheCommunity_Enoch so LIVESERVERFOLDER is TheCommunity_Enoch
SET LIVESERVERFOLDER=%COMMUNITYNAME%_%MAP%
SET LIVESERVEREXENAME=EnochServer_x64
SET LIVEGAMEPORT=2402
SET LIVEPROFILE=TheEnochServer
SET LIVECONFIG=%COMMUNITYNAME%DZ.cfg
SET LIVEBECEXE=bec3.exe
SET LIVEFIREWALLNAME=dayzsaenoch
SET LIVEBRANCH=live-instance
SET LIVESTORAGEINSTANCE=2
SET LIVEPRIORITY=HIGH
SET LIVECPUAFFINITY=54

:: ********************* TEST Server Settings ***********************
:: The TEST Server Folder is TheCommunity_ChernoTest
SET TESTSERVERFOLDER=%COMMUNITYNAME%_%MAP%Test
SET TESTSERVEREXENAME=EnochTestServer_x64
SET TESTGAMEPORT=2442
SET TESTPROFILE=TheEnochTestServer
SET TESTCONFIG=%COMMUNITYNAME%DZTest.cfg
SET TESTBECEXE=bec3test.exe
SET TESTFIREWALLNAME=dayzsaenochtest
SET TESTBRANCH=test-instance
SET TESTSTORAGEINSTANCE=666
SET TESTPRIORITY=NORMAL
SET TESTCPUAFFINITY=40

:: ****************************** MODS ******************************
:: MODID look in meta.cpp. Use comma to add but no comma at the end
SET MODIDS=1559212036,1564026768,1574054508,1576057168,1590841260,1710977250,1724005476,1623711988,1819514788,1928939749,1585487785,1927567004,1782854982,1870524790,1934466732,1836257061,1560819773
:: Add the Mod Name WITH the @ symbol close it with the ; as usual
SET MODNAMES=@CF;@Community-Online-Tools;@BuildAnywhere;@BaseBuildingLogs;@Trader;@BaseBuildingPlus;@Durable_Suppressors;@VanillaPlusPlusMap;@Ear-Plugs;@Catch_Rain;@DayZ-Expansion-Notifications;@DayZ-Expansion-Chat;@No_Shoe_Damage;@Airdrop-Upgraded;@Ammo_Making;@Banking;@Unlimited_Stamina;
:: Add the ModID in the [] and Mod Name WITHOUT the @ symbol
SET MOD[1559212036]=CF
SET MOD[1564026768]=Community-Online-Tools
SET MOD[1574054508]=BuildAnywhere
SET MOD[1576057168]=BaseBuildingLogs
SET MOD[1590841260]=Trader
SET MOD[1710977250]=BaseBuildingPlus
SET MOD[1724005476]=Durable_Suppressors
SET MOD[1623711988]=VanillaPlusPlusMap
SET MOD[1819514788]=Ear-Plugs
SET MOD[1928939749]=Catch_Rain
SET MOD[1585487785]=DayZ-Expansion-Notifications
SET MOD[1927567004]=DayZ-Expansion-Chat
SET MOD[1782854982]=No_Shoe_Damage
SET MOD[1870524790]=Airdrop-Upgraded
SET MOD[1934466732]=Ammo_Making
SET MOD[1836257061]=Banking
SET MOD[1560819773]=Unlimited_Stamina
:: ********************************************************************************
:: **Do not change anything below this comment unless you know what you are doing**
:: ********************************************************************************


:: **************************** SteamCMD ****************************
SET USERNAME=anonymous
SET PASSWORD=

:: You have gone too far and you really don't need to touch anything under this comment
:: WARNING! you are still reading, stop here and just test your settings changes ;) Good Luck!


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


:: ************************** Workshop Update *************************
FOR %%G IN (%MODIDS%) DO (
	%STEAMCMD%\steamcmd.exe +login %USERNAME% %PASSWORD% +workshop_download_item 221100 %%G +quit
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