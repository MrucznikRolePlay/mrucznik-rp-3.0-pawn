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
#include <fixes>
//-------<[ Pluginy ]>-------
#include <crashdetect>					// By Zeex, v4.18.1				https://github.com/Zeex/samp-plugin-crashdetect/releases
#include <libRegEx>						// By Koala818 v0.2				http://forum.sa-mp.com/showthread.php?t=526725 https://github.com/FF-Koala/Regular-Expressions-Plugin
#include <a_mysql>						// By BlueG, R41-2:				http://forum.sa-mp.com/showthread.php?t=56564 https://github.com/pBlueG/SA-MP-MySQL/releases
//--------<[ YSI ]>----------
#include <YSI\y_master>
#include <YSI\y_iterate>
#include <YSI\y_commands>
#include <YSI\y_dialog>
#include <YSI\y_groups>
#include <YSI\y_ini>
#include <My_YSI\y_safereturn>			// By Bartekdvd & Y_Less: 		http://forum.sa-mp.com/showthread.php?t=456132
//-------<[ Pluginy ]>-------
#include <sscanf2>						// By Y_Less, 2.8.2:			http://forum.sa-mp.com/showthread.php?t=570927
#include <streamer>						// By Incognito, v2.8.2:		http://forum.sa-mp.com/showthread.php?t=102865


//------------------------------------------<[ Ustawienia ]>-------------------------------------------------//
//-                                                                                                         -//
#define MAJOR		2
#define MINOR		6
#define RELEASE		0
#define VERSION "v" #MAJOR "." #MINOR "." #RELEASE
#define COMPILED_IN "15.02.2017"
#define DEBUG_MODE 1
#if DEBUG_MODE==1
	#warning DEBUG_MODE_ON!
#endif

#define STREAM_DISTANCE 300.0

//----------------------------------------<[ Moje Callbacki ]>-----------------------------------------------//
//-                                                                                                         -//
forward OnPlayerRegister(playerid);
forward OnPlayerLogin(playerid);

//--------------------------------<[ Wewnêtrzbe systemy oraz modu³y ]>---------------------------------------//
//-                                                                                                         -//

//----< System - preprocesor, zmienne >----
#include "system\define.pwn"
#include "system\kolory.pwn"
#include "system\zmienne.pwn"

//----< Modu³y - preprocesor >----
#include "modules\mru_mysql\mru_mysql.def"
#include "modules\logi\logi.def"
#include "modules\chaty\chaty.def"
#include "modules\keybindy\keybindy.def"
#include "modules\debug\debug.def"

//----< Modu³y - zmienne >----
#include "modules\mru_mysql\mru_mysql.hwn"
#include "modules\logi\logi.hwn"
#include "modules\chaty\chaty.hwn"
#include "modules\keybindy\keybindy.hwn"
#include "modules\debug\debug.hwn"

//----< Modu³y - funkcje >----
#include "modules\mru_mysql\mru_mysql.pwn"
#include "modules\logi\logi.pwn"
#include "modules\chaty\chaty.pwn"
#include "modules\keybindy\keybindy.pwn"
#include "modules\debug\debug.pwn"

//----< System - funkcje >----
#include "system\funkcje.pwn"
#include "system\timery.pwn"



//--------------------------------------------<[ Main ]>-----------------------------------------------------//
//-                                                                                                         -//
main()
{
	print("\n----------------------------------");
	print("M | --- Mrucznik Role Play --- | M");
	print("R | ---        ****        --- | R");
	print("U | ---        v"#MAJOR"."#MINOR"        --- | U");
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
	
	//Ustawienia gamemodu:
	SetGameModeText("Mrucznik-RP "VERSION);
	SetMapNameText("Los Santos + Miasteczka");
	SendRconCommand("stream_distance "#STREAM_DISTANCE_S);
	regex_syntax(SYNTAX_PERL);
	
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
	
	//£¹czenie z mysql:
	MruMySQL_Connect();
	
	//Uruchamianie timerów:
	timery_Init();
	
	//Inicjowanie iteratorów:
	Iter_Init(StreamedPlayers);
	
	//Tworzenie grup:
	LoggedPlayer = Group_Create("loggedplayers");
	
	
	//-----< £adowanie modu³ów: >------
	print("    <<< Ladowanie modulow...");
	
	print("    >>> Pomyslnie zaladowano wszystkie moduly...");
	
	print(">>> Wykonano. Gamemode pomyslnie uruchomiony.\n");
	return 1;
}

public OnGameModeExit()
{
    print("<<< Wykonywanie OnGameModeExit...");
	
	timery_Delete();
	
	MruMySQL_Exit();
	
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

	//Iteratory:
	Iter_Clear(StreamedPlayers[playerid]); //czyszczenie pêtli streamed players (widocznych graczy dla gracza)
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
	Chat(playerid, ChatICAdditions(playerid, text));
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
	if( IsPlayerLogged(playerid) )
		Iter_Add(StreamedPlayers[forplayerid], playerid);
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	if( IsPlayerLogged(playerid) )
		Iter_Remove(StreamedPlayers[forplayerid], playerid);
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

//-----------------------------------------------------------------------------------------------------------//
//-----------------------------------------[Callback'i z Bibliotek]------------------------------------------//
//----------------------------------------------------|------------------------------------------------------//
//----------------------------------------------------|------------------------------------------------------//
//---------------------------------------------------\ /-----------------------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//-----------------------------------------------------------------------------------------------------------//
/*
        Error & Return type

    COMMAND_ZERO_RET      = 0 , // The command returned 0.
    COMMAND_OK            = 1 , // Called corectly.
    COMMAND_UNDEFINED     = 2 , // Command doesn't exist.
    COMMAND_DENIED        = 3 , // Can't use the command.
    COMMAND_HIDDEN        = 4 , // Can't use the command don't let them know it exists.
    COMMAND_NO_PLAYER     = 6 , // Used by a player who shouldn't exist.
    COMMAND_DISABLED      = 7 , // All commands are disabled for this player.
    COMMAND_BAD_PREFIX    = 8 , // Used "/" instead of "#", or something similar.
    COMMAND_INVALID_INPUT = 10, // Didn't type "/something".
*/ 
public e_COMMAND_ERRORS:OnPlayerCommandPerformed(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
    switch (success)
    {
        case COMMAND_UNDEFINED:
        {
             // Your code here.
        }
    }
    return COMMAND_OK;
}

//-----------------------------------------------------------------------------------------------------------//
//---------------------------------------------[Moje Callbacki]----------------------------------------------//
//----------------------------------------------------|------------------------------------------------------//
//----------------------------------------------------|------------------------------------------------------//
//---------------------------------------------------\ /-----------------------------------------------------//
//----------------------------------------------------*------------------------------------------------------//
//-----------------------------------------------------------------------------------------------------------//
public OnPlayerRegister(playerid)
{
	
	return 1;
}

public OnPlayerLogin(playerid)
{
	Group_SetPlayer(LoggedPlayer, playerid, true);
	return 1;
}