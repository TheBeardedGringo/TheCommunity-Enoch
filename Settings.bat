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
SET MODIDS=1559212036,1564026768,1574054508,1576057168,1590841260,1710977250,1724005476,1623711988,1819514788,1928939749,1585487785,1927567004,1782854982,1870524790,1934466732,1836257061,1560819773,1565871491,1677796889,1932611410,1813296260,1646187754,1791033033,1605653648,1832448183,1648967877,1912237302,1567872567,1735947752,1582671564,1962144102,1991570984,1945945241,1827241477,1920610398,1734713776,1957554662,1897838396,1999076953,1862257480,1583941197,1850623448,1617874376,1870357551
:: Add the Mod Name WITH the @ symbol close it with the ; as usual
SET MODNAMES=@CF;@Community-Online-Tools;@BuildAnywhere;@BaseBuildingLogs;@Trader;@BaseBuildingPlus;@Durable_Suppressors;@VanillaPlusPlusMap;@Ear-Plugs;@Catch_Rain;@DayZ-Expansion-Notifications;@DayZ-Expansion-Chat;@No_Shoe_Damage;@Airdrop-Upgraded;@Ammo_Making;@Banking;@Unlimited_Stamina;@BuilderItems;@Camosplus;@CannabisPlus;@CheckIdentity;@Code_Lock;@Dayz_Navigation;@FIDOv_PACK_4;@FlipTransport;@GoreZ;@IRP-Land-Rover-Defender-110;@KillFeed;@NoVehicleDamage;@PartyMe;@Modular_Vest_System;@MuchStuffPack;@Specialist_Weapon_Pack;@BreachingCharge;@BBPBreachCharge;@MunghardsItempack;@NDVPPM;@Next_Days;@Notes;@Repair_My_Car;@SQUAD_MSF-C;@Zeroy-FishingZ;@OP_BaseItems;@Base_Storage;
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
SET MOD[1565871491]=BuilderItems
SET MOD[1677796889]=Camosplus
SET MOD[1932611410]=CannabisPlus
SET MOD[1813296260]=CheckIdentity
SET MOD[1646187754]=Code_Lock
SET MOD[1791033033]=Dayz_Navigation
SET MOD[1605653648]=FIDOv_PACK_4
SET MOD[1832448183]=FlipTransport
SET MOD[1648967877]=GoreZ
SET MOD[1912237302]=IRP-Land-Rover-Defender-110
SET MOD[1567872567]=KillFeed
SET MOD[1735947752]=NoVehicleDamage
SET MOD[1582671564]=PartyMe
SET MOD[1962144102]=Modular_Vest_System
SET MOD[1991570984]=MuchStuffPack
SET MOD[1945945241]=Specialist_Weapon_Pack
SET MOD[1827241477]=BreachingCharge
SET MOD[1920610398]=BBPBreachCharge
SET MOD[1734713776]=MunghardsItempack
SET MOD[1957554662]=NDVPPM
SET MOD[1897838396]=Next_Days
SET MOD[1999076953]=Notes
SET MOD[1862257480]=Repair_My_Car
SET MOD[1583941197]=SQUAD_MSF-C
SET MOD[1850623448]=Zeroy-FishingZ
SET MOD[1617874376]=OP_BaseItems
SET MOD[1870357551]=Base_Storage
:: **************************** GITHUB ******************************
SET GITEMAIL=donkeypunch.info@gmail.com
SET GITNAME=DirtySanchez
SET GITACCTNAME=ravmustang
SET REPONAME=TheCommunity-Enoch
SET TESTLOGSREPONAME=TheCommunity-EnochTestLogs
SET LIVELOGSREPONAME=TheCommunity-EnochLiveLogs

:: *************************** STEAMCMD ******************************
:: STEAMCMD - keep as anonymous all testing downloaded server and mods as it is setup
SET STEAMCMDFOLDER=steamcmd
SET USERNAME=anonymous
SET PASSWORD=
