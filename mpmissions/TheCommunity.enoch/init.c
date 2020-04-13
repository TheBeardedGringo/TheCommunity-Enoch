//Spawn helper function
Object SpawnObject( string type, vector position, vector orientation )
{
    Object obj;
	bool debugCreateLandObj = true;
	if(debugCreateLandObj) PrintFormat("[DonkeyDebug]init.c CreateLandObject type:%1", type);
	//auto obj = GetGame().CreateObject( type, position );
	obj = Object.Cast(GetGame().CreateObject(type, "0 0 0"));
    obj.SetPosition( position );
    obj.SetOrientation( orientation );
    obj.SetOrientation( obj.GetOrientation() ); //Collision fix
    obj.Update();
    obj.SetAffectPathgraph( true, false );
    if( obj.CanAffectPathgraph() ) GetGame().GetCallQueue( CALL_CATEGORY_SYSTEM ).CallLater( GetGame().UpdatePathgraphRegionByObject, 100, false, obj );
	return obj;
}
#include "$CurrentDir:\\mpmissions\\TheCommunity.enoch\\custom\\BuildMyMapAdditions.c"
#include "$CurrentDir:\\mpmissions\\TheCommunity.enoch\\custom\\BBPCementMixers.c"

void main()
{
	BuildMyMapAdditions();
	BBPCementMixers();
	//INIT WEATHER BEFORE ECONOMY INIT------------------------
	Weather weather = g_Game.GetWeather();

	weather.MissionWeather(false);    // false = use weather controller from Weather.c

	weather.GetOvercast().Set( Math.RandomFloatInclusive(0.02, 0.1), 1, 0);
	weather.GetRain().Set( 0, 1, 0);
	weather.GetFog().Set( 0, 1, 0);

	//INIT ECONOMY--------------------------------------
	Hive ce = CreateHive();
	if ( ce )
		ce.InitOffline();

	//DATE RESET AFTER ECONOMY INIT-------------------------
	int year, month, day, hour, minute;
	int reset_month = 8, reset_day = 10;
	GetGame().GetWorld().GetDate(year, month, day, hour, minute);

	if ((month == reset_month) && (day < reset_day))
	{
		GetGame().GetWorld().SetDate(year, reset_month, reset_day, hour, minute);
	}
	else
	{
		if ((month == reset_month + 1) && (day > reset_day))
		{
			GetGame().GetWorld().SetDate(year, reset_month, reset_day, hour, minute);
		}
		else
		{
			if ((month < reset_month) || (month > reset_month + 1))
			{
				GetGame().GetWorld().SetDate(year, reset_month, reset_day, hour, minute);
			}
		}
	}
}

class CustomMission: MissionServer
{
	void SetRandomHealth(EntityAI itemEnt)
	{
		if ( itemEnt )
		{
			int rndHlt = Math.RandomInt(55,100);
			itemEnt.SetHealth("","",rndHlt);
		}
	}

	override PlayerBase CreateCharacter(PlayerIdentity identity, vector pos, ParamsReadContext ctx, string characterName)
	{
		Entity playerEnt;
		playerEnt = GetGame().CreatePlayer(identity, characterName, pos, 0, "NONE");//Creates random player
		Class.CastTo(m_player, playerEnt);
		
		GetGame().SelectPlayer(identity, m_player);
		
		return m_player;
	}
	
	override void StartingEquipSetup(PlayerBase player, bool clothesChosen)
	{
/*
		player.RemoveAllItems();

		EntityAI item = player.GetInventory().CreateInInventory(topsMissionArray.GetRandomElement());
		EntityAI item2 = player.GetInventory().CreateInInventory(pantsArray.GetRandomElement());
		EntityAI item3 = player.GetInventory().CreateInInventory(shoesArray.GetRandomElement());
*/


		float energy = player.GetStatEnergy().Get();
		player.GetStatEnergy().Add( energy + 500 );

		float water = player.GetStatWater().Get();
		player.GetStatWater().Add( water + 500 );
		
		EntityAI itemTop;
		EntityAI itemEnt;
		ItemBase itemBs;
		float rand;
		
		itemTop = player.FindAttachmentBySlotName("Body");
		
		if ( itemTop )
		{
			itemEnt = itemTop.GetInventory().CreateInInventory("Rag");
			if ( Class.CastTo(itemBs, itemEnt ) )
		itemBs.SetQuantity(4);

			SetRandomHealth(itemEnt);
			
			itemEnt = itemTop.GetInventory().CreateInInventory("RoadFlare");
			SetRandomHealth(itemEnt);
		
			itemEnt = itemTop.GetInventory().CreateInInventory("StoneKnife");
			SetRandomHealth(itemEnt);
		}

		rand = Math.RandomFloatInclusive(0.0, 1.0);
		if ( rand < 0.25 )
			itemEnt = player.GetInventory().CreateInInventory("SodaCan_Cola");
		else if ( rand > 0.75 )
			itemEnt = player.GetInventory().CreateInInventory("SodaCan_Spite");
		else
			itemEnt = player.GetInventory().CreateInInventory("SodaCan_Pipsi");
		
		SetRandomHealth(itemEnt);

		rand = Math.RandomFloatInclusive(0.0, 1.0);
		if ( rand < 0.35 )
			itemEnt = player.GetInventory().CreateInInventory("Apple");
		else if ( rand > 0.65 )
			itemEnt = player.GetInventory().CreateInInventory("Pear");
		else
			itemEnt = player.GetInventory().CreateInInventory("Plum");
		
		SetRandomHealth(itemEnt);
		
		itemEnt = player.GetInventory().CreateInInventory("CombatKnife");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("ImprovisedBag");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("PersonalRadio");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("BandageDressing");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("Battery9V");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("Battery9V");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("Battery9V");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("Flashlight");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("SpaghettiCan_Opened");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("WaterBottle");
		itemBs = ItemBase.Cast(itemEnt);
		itemEnt = player.GetInventory().CreateInInventory("NewNVG");
		itemBs = ItemBase.Cast(itemEnt);
	}
	
	void SetClothes()
	{
		int Max; //THE NUMBER OF TRADER CREATED ON TRADEROBJECT.TXT
		Max=m_Trader_SpawnedTraderCharacters.Count();
		
		EntityAI item;
		EntityAI item1;
		EntityAI item2;
		EntityAI item3;
		for (int i=0; i< Max; i++)
		{
			if (i==0)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MedicalScrubsHat_White");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("ManSuit_DarkGrey");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("SlacksPants_White");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("DressShoes_Brown");
			}
			if (i==1)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MedicalScrubsHat_Blue");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MedicalScrubsPants_Blue");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("LabCoat");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("AthleticShoes_Black");
			}
			if (i==2)	
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("BaseballCap_Black");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Jeans_Blue");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Shirt_RedCheck");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("WorkingBoots_Yellow");
			}
			if (i==3)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("CowboyHat_darkBrown");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("WorkingBoots_Brown");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Jeans_BlueDark");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("DenimJacket");
			}
			if (i==4)	
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("ConstructionHelmet_Orange");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Jeans_Black");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("WorkingBoots_Yellow");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("ReflexVest");
			}
			if (i==5)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("BoonieHat_Olive");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("M65Jacket_Black");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("BDUPants");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("CombatBoots_Black");
			}
			if (i==6)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("BaseballCap_CMMG_Black");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MilitaryBoots_Black");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MSFCPantsMulticam");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Hoodie_DrJ0nes");
			}
			if (i==7)	
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MiniDress_RedChecker");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Wellies_Black");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("OfficerHat");
			}
			if (i==8)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MFSCJacketMercer");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("TrackSuitPants_Black");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("JoggingShoes_Red");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("DirtBikeHelmet_Police");
			}
			if (i==9)	
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MSFCMich2000HelmetSkull");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Shirt_GreenCheck");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("USMCPants_Woodland");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("MilitaryBoots_Brown");
			}
			if (i==10)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("ManSuit_Black");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("SlacksPants_Black");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("DressShoes_Black");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("FlatCap_Black");
			}
			if (i==11)
			{
				item = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("TrackSuitPants_Green");
				item1 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("TrackSuitJacket_Green");
				item2 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("Sneakers_Black");
				item3 = m_Trader_SpawnedTraderCharacters.Get(i).GetInventory().CreateInInventory("BandanaHead_BlackPattern");
			}
		}
	}
	
	override void OnInit()
	{
		super.OnInit();
		
		//add this setclothes to the OnInit in the custom mission
		SetClothes();
	}
};

Mission CreateCustomMission(string path)
{
	return new CustomMission();
}