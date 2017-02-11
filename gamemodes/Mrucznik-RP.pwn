//-----------------------------------------[Mapa Mrucznik Role Play]-----------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//---------------------------------(Stworzona na podstawie mapy The Godfather)-------------------------------//
//-------------------------------------------------(v2.6)----------------------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
//	Mrucznik® Role Play ----> stworzy³ Szymon 'Mrucznik' Gajda

//-------------------------------------------<[ Includy ]>---------------------------------------------------//
//-                                                                                                         -//
#include <a_samp>

//------------------------------------------<[ Ustawienia ]>-------------------------------------------------//
//-                                                                                                         -//
#define MAJOR		2
#define MINOR		6
#define RELEASE		0
#define VERSION "v" #MAJOR "." #MINOR "." #RELEASE

//--------------------------------<[ Wewnêtrzbe systemy oraz modu³y ]>---------------------------------------//
//-                                                                                                         -//
main()
{
	print("\n----------------------------------");
	print("M | --- Mrucznik Role Play --- | M");
	print("R | ---        ****        --- | R");
	print("U | ---        v3.0        --- | U");
	print("C | ---        ****        --- | C");
	print("Z | ---    by Mrucznik     --- | Z");
	print("N | ---                    --- | N");
	print("I | ---       /\\_/\\        --- | I");
	print("K | ---   ===( *.* )===    --- | K");
	print("  | ---       \\_^_/        --- |  ");
	print("R | ---         |          --- | R");
	print("P | ---         O          --- | P");
	print("----------------------------------\n");
	print("WERSJA: "#VERSION" SKOMPILOWANO: "#COMPILED_IN);
	#if defined DEBUG_MODE_RESTRICT
		print("DEBUG MODE: RESTRICT");
	#elseif defined DEBUG_MODE_KICK
		print("DEBUG MODE: KICK");
	#else
		print("DEBUG MODE: NORMAL");
	#endif
	print("\n");
	
	WasteDeAMXersTime(); //suprise motherfucker
}

WasteDeAMXersTime() //suprise motherfucker
{
	new whack[][] =
    {
        "lol",
        "traktor"
    };
    #pragma unused whack
	
	//Thanks to Y_Less
    new nyan;
    #emit load.pri nyan
    #emit stor.pri nyan
}


//-----------------------------------------------------------------------------------------------------------//
//---------------------------------------------[SAMP callbacks]----------------------------------------------//
//----------------------------------------------------|------------------------------------------------------//
//----------------------------------------------------|------------------------------------------------------//
//---------------------------------------------------\ /-----------------------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//-----------------------------------------------------------------------------------------------------------//
public OnGameModeInit()
{
	print("<<< Wykonywanie OnGameModeInit...");
	
	SetGameModeText("Mrucznik-RP "VERSION);
	SetMapNameText("Los Santos + Miasteczka");
	SetGameModeText("Mrucznik-RP "VERSION);
	SetMapNameText("Los Santos + Miasteczka");
	
	//Ustawienia rozgrywki:
	AllowInteriorWeapons(1); //broñ w intkach
	ShowPlayerMarkers(0); //wy³¹czenie markerów graczy
	DisableInteriorEnterExits(); //wy³¹czenie wejœæ do intków z GTA
	EnableStuntBonusForAll(0); //brak hajsu za stunty
	ManualVehicleEngineAndLights(); //brak automatycznego w³¹czania silnika i œwiate³
	ShowNameTags(1); //Pokazywanie nicków graczy
	SetNameTagDrawDistance(20.0); //Wyœwietlanie nicków od 20 metrów
	//UsePlayerPedAnims(); // Animacja CJ 
		// - off (broñ trzymana w obu rêkach jest trzymana jedn¹, skiny chodz¹ swoim chodem)
		// - on  (broñ trzymana jest normalnie, wszystkie skiny chodz¹ jak CJ)
	
	//£adowanie modu³ów:
	//Modu³y:
	print("    <<< Ladowanie modulow...");
	
	print("    >>> Pomyslnie zaladowano wszystkie moduly...");
	
	print(">>> Wykonano. Gamemode pomyslnie uruchomiony.\n");
	return 1;
}

public OnGameModeExit()
{
    print("<<< Wykonywanie OnGameModeExit...");
	
    print(">>> Wykonano. Gamemode pomyslnie wylaczony.");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{

	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}