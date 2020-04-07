:: Server and Mod startup file
:: Written by DirtySanchez 
:: For "The Community" Servers presented by DonkeyPunch Community Gaming
:: Discord: https://discord.me/eXpoch
:: 

:: *********************** General Settings *************************
SET DEBUG=2
:: Add your install DRIVE and PARENTFOLDER preferences
SET DRIVE=D
SET PARENTFOLDER=DayZServers
:: Add your MAP based on mission file mapname
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
SET LIVEBERCONPASSWORD=coronavirus
SET LIVEBERCONIP=127.0.0.1
SET LIVEFIREWALLNAME=dayzsaenoch
SET LIVEBRANCH=live-instance
SET LIVESTORAGEINSTANCE=420
SET LIVEPRIORITY=HIGH
SET LIVECPUAFFINITY=54
SET LIVELOGSFOLDER=Logging


:: ********************* TEST Server Settings ***********************
:: The TEST Server Folder is TheCommunity_ChernoTest
SET TESTSERVERFOLDER=%COMMUNITYNAME%_%MAP%Test
SET TESTSERVEREXENAME=EnochTestServer_x64
SET TESTGAMEPORT=2442
SET TESTPROFILE=TheEnochTestServer
SET TESTCONFIG=%COMMUNITYNAME%DZTest.cfg
SET TESTBECEXE=bec3test.exe
SET TESTBERCONPASSWORD=coronavirus
SET TESTBERCONIP=127.0.0.1
SET TESTFIREWALLNAME=dayzsaenochtest
SET TESTBRANCH=test-instance
SET TESTSTORAGEINSTANCE=666
SET TESTPRIORITY=NORMAL
SET TESTCPUAFFINITY=40
SET TESTLOGSFOLDER=LoggingTest



:: ****************************** MODS ******************************
:: DO NOT USE SPACES IN ANY OF THE MOD SETTINGS
:: MODID look in meta.cpp. Use comma to add but no comma at the end
SET MODIDS=1559212036,1564026768
:: Add the Mod Name WITH the @ symbol close it with the ; as usual
SET MODNAMES=@CF;@Community-Online-Tools;
:: Add the ModID in the [] and Mod Name WITHOUT the @ symbol
SET MOD[1559212036]=CF
SET MOD[1564026768]=Community-Online-Tools


:: **************************** GITHUB ******************************
SET GITEMAIL=donkeypunch.info@gmail.com
SET GITNAME=DirtySanchez
SET GITACCTNAME=ravmustang
SET REPONAME=TheCommunity-Enoch
SET TESTLOGSREPONAME=TheCommunity-EnochTestLogs
SET LIVELOGSREPONAME=TheCommunity-EnochLiveLogs

:: *************************** STEAMCMD ******************************
:: STEAMCMD - keep as anonymous all testing downloaded server and mods as it is setup
SET USERNAME=anonymous
SET PASSWORD=
