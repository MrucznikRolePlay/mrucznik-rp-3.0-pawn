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
// Skrypterzy, którzy tak¿e pracowali nad map¹: PECET, niceCzlowiek

//-------------------------------------------<[ Includy ]>---------------------------------------------------//
//-                                                                                                         -//
#include <a_samp>
#include <fixes>
//-------<[ Pluginy ]>-------
#include <crashdetect>					// By Zeex, v4.18.1				https://github.com/Zeex/samp-plugin-crashdetect/releases
#include <sscanf2>						// By Y_Less, 2.8.2:			http://forum.sa-mp.com/showthread.php?t=570927
#include <Pawn.Regex>
//--------<[ YSI ]>----------			// By Y_Less, 4.0				https://github.com/Misiur/YSI-Includes
#include <YSI\y_iterate>
#include <YSI\y_playerarray>		
#include <YSI\y_commands>
#include <YSI\y_dialog>
#include <YSI\y_groups>
#include <YSI\y_ini>
#include <YSI\y_timers>
#include <YSI\y_master>
#include <My_YSI\y_safereturn>			// By Bartekdvd & Y_Less: 		http://forum.sa-mp.com/showthread.php?t=456132
//-------<[ Pluginy ]>-------
#include <streamer>						// By Incognito, v2.8.2:		http://forum.sa-mp.com/showthread.php?t=102865
#include <a_mysql_yinline>				// By maddinat0r, v1.0.1 		https://github.com/maddinat0r/samp-mysql-yinline-include
#include <a_mysql>						// By BlueG, R41-2:				http://forum.sa-mp.com/showthread.php?t=56564 https://github.com/pBlueG/SA-MP-MySQL/releases
#include <log-plugin>					// By maddinat0r v0.3: 			http://forum.sa-mp.com/showthread.php?t=603175 https://github.com/maddinat0r/samp-log
//-------<[ Biblioteki ]>-------
#include <callbacks>					// By _Emmet 					http://forum.sa-mp.com/showthread.php?t=490436 https://github.com/emmet-jones/New-SA-MP-callbacks

//TODO:
// By maddinat0r v1.3: https://github.com/maddinat0r/samp-tsconnector
// Kamera By MP2: http://forum.sa-mp.com/showthread.php?p=2362690

native WP_Hash(buffer[], len, const str[]);

//------------------------------------------<[ Ustawienia ]>-------------------------------------------------//
//-                                                                                                         -//
#define MAJOR		2
#define MINOR		6
#define RELEASE		0
#define VERSION "v" #MAJOR "." #MINOR "." #RELEASE
#define COMPILED_IN "15.02.2017"
#define DEBUG_MODE 1
#if DEBUG_MODE > 0
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
#include "modules\konta\konta.def"
#include "modules\payday\payday.def"
#include "modules\chaty\chaty.def"
#include "modules\logi\logi.def"
#include "modules\admin\admin.def"
#include "modules\antycheat\antycheat.def"
#include "modules\system_aut\system_aut.def"
#include "modules\wanted\wanted.def"
#include "modules\frakcje\frakcje.def"
	#include "modules\frakcje\LSPD\LSPD.def"
	#include "modules\frakcje\FBI\FBI.def"
	#include "modules\frakcje\NG\NG.def"
	#include "modules\frakcje\LSMC\LSMC.def"
	#include "modules\frakcje\DMV\DMV.def"
	#include "modules\frakcje\BOR\BOR.def"
	#include "modules\frakcje\GOV\GOV.def"
	#include "modules\frakcje\SAN\SAN.def"
	#include "modules\frakcje\TAXI\TAXI.def"
	#include "modules\frakcje\HA\HA.def"
#include "modules\organizacje\organizacje.def"
#include "modules\prace\prace.def"
#include "modules\interiory\interiory.def"
#include "modules\domy\domy.def"
#include "modules\ekonomia\ekonomia.def"
#include "modules\biznesy\biznesy.def"
#include "modules\textdrawy\textdrawy.def"
#include "modules\obiekty\obiekty.def"
#include "modules\pickupy\pickupy.def"
#include "modules\3dtexty\3dtexty.def"
#include "modules\komendy\komendy.def"
#include "modules\oferty\oferty.def"
#include "modules\animacje\animacje.def"
#include "modules\pomoc\pomoc.def"
#include "modules\ustawienia\ustawienia.def"
#include "modules\statystyki\statystyki.def"
#include "modules\keybindy\keybindy.def"
#include "modules\bw\bw.def"
#include "modules\spawn\spawn.def"
#include "modules\debug\debug.def"
#include "modules\tests\tests.def"

//----< Modu³y - zmienne >----
#include "modules\mru_mysql\mru_mysql.hwn"
#include "modules\konta\konta.hwn"
#include "modules\payday\payday.hwn"
#include "modules\chaty\chaty.hwn"
#include "modules\logi\logi.hwn"
#include "modules\admin\admin.hwn"
#include "modules\antycheat\antycheat.hwn"
#include "modules\system_aut\system_aut.hwn"
#include "modules\wanted\wanted.hwn"
#include "modules\frakcje\frakcje.hwn"
	#include "modules\frakcje\LSPD\LSPD.hwn"
	#include "modules\frakcje\FBI\FBI.hwn"
	#include "modules\frakcje\NG\NG.hwn"
	#include "modules\frakcje\LSMC\LSMC.hwn"
	#include "modules\frakcje\DMV\DMV.hwn"
	#include "modules\frakcje\BOR\BOR.hwn"
	#include "modules\frakcje\GOV\GOV.hwn"
	#include "modules\frakcje\SAN\SAN.hwn"
	#include "modules\frakcje\TAXI\TAXI.hwn"
	#include "modules\frakcje\HA\HA.hwn"
#include "modules\organizacje\organizacje.hwn"
#include "modules\prace\prace.hwn"
#include "modules\interiory\interiory.hwn"
#include "modules\domy\domy.hwn"
#include "modules\ekonomia\ekonomia.hwn"
#include "modules\biznesy\biznesy.hwn"
#include "modules\textdrawy\textdrawy.hwn"
#include "modules\obiekty\obiekty.hwn"
#include "modules\pickupy\pickupy.hwn"
#include "modules\3dtexty\3dtexty.hwn"
#include "modules\komendy\komendy.hwn"
#include "modules\oferty\oferty.hwn"
#include "modules\animacje\animacje.hwn"
#include "modules\pomoc\pomoc.hwn"
#include "modules\ustawienia\ustawienia.hwn"
#include "modules\statystyki\statystyki.hwn"
#include "modules\keybindy\keybindy.hwn"
#include "modules\bw\bw.hwn"
#include "modules\spawn\spawn.hwn"
#include "modules\debug\debug.hwn"
#include "modules\tests\tests.hwn"

//----< Modu³y - funkcje >----
#include "modules\mru_mysql\mru_mysql.pwn"
#include "modules\konta\konta.pwn"
#include "modules\payday\payday.pwn"
#include "modules\chaty\chaty.pwn"
#include "modules\logi\logi.pwn"
#include "modules\admin\admin.pwn"
#include "modules\antycheat\antycheat.pwn"
#include "modules\system_aut\system_aut.pwn"
#include "modules\wanted\wanted.pwn"
#include "modules\frakcje\frakcje.pwn"
	#include "modules\frakcje\LSPD\LSPD.pwn"
	#include "modules\frakcje\FBI\FBI.pwn"
	#include "modules\frakcje\NG\NG.pwn"
	#include "modules\frakcje\LSMC\LSMC.pwn"
	#include "modules\frakcje\DMV\DMV.pwn"
	#include "modules\frakcje\BOR\BOR.pwn"
	#include "modules\frakcje\GOV\GOV.pwn"
	#include "modules\frakcje\SAN\SAN.pwn"
	#include "modules\frakcje\TAXI\TAXI.pwn"
	#include "modules\frakcje\HA\HA.pwn"
#include "modules\organizacje\organizacje.pwn"
#include "modules\prace\prace.pwn"
#include "modules\interiory\interiory_gui.pwn"
#include "modules\interiory\interiory.pwn"
#include "modules\domy\domy.pwn"
#include "modules\ekonomia\ekonomia.pwn"
#include "modules\biznesy\biznesy.pwn"
#include "modules\textdrawy\textdrawy.pwn"
#include "modules\obiekty\obiekty.pwn"
#include "modules\pickupy\pickupy.pwn"
#include "modules\3dtexty\3dtexty.pwn"
#include "modules\komendy\komendy.pwn"
#include "modules\oferty\oferty.pwn"
#include "modules\animacje\animacje.pwn"
#include "modules\pomoc\pomoc.pwn"
#include "modules\ustawienia\ustawienia.pwn"
#include "modules\statystyki\statystyki.pwn"
#include "modules\keybindy\keybindy.pwn"
#include "modules\bw\bw.pwn"
#include "modules\spawn\spawn.pwn"
#include "modules\debug\debug.pwn"
#include "modules\tests\tests.pwn"

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
	
	#if DEBUG_MODE > 0
		print("    <<< Ladowanie botów...");
		Debug_LoadNPCs();
		print("    <<< Boty za³adowane...");
	#endif
	
	//Ustawienia gamemodu:
	SetGameModeText("Mrucznik-RP "VERSION);
	SetMapNameText("Los Santos + Miasteczka");
	SendRconCommand("stream_distance "#STREAM_DISTANCE_S);
	
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
	if(!MruMySQL_Connect()) return 0;
	
	//Uruchamianie timerów:
	timery_Init();
	
	//Inicjowanie iteratorów:
	Iter_Init(StreamedPlayers);
	
	//Tworzenie grup:
	LoggedPlayers = Group_Create("loggedplayers");
	
	
	//-----< £adowanie modu³ów: >------
	print("    <<< Ladowanie modulow...");
	logi_Init();
	antycheat_Init();
	admin_Init();
	frakcje_Init();
	organizacje_Init();
	textdrawy_Init();
	obiekty_Init();
	interiory_Init();
	texty3d_Init();
	pickupy_Init();
	pojazdy_Init();
	ekonomia_Init();
	keybindy_Init();
	ustawienia_Init();
	chaty_Init();
	print("    >>> Pomyslnie zaladowano wszystkie moduly...");
	
	//Skiny:
	AddPlayerClass(35, -2819.9297,1134.0607,26.0766, 326.0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(37, -2819.9297,1134.0607,26.0766, 326.0, 0, 0, 0, 0, 0, 0);
	
	print(">>> Wykonano. Gamemode pomyslnie uruchomiony.\n");
	return 1;
}

public OnGameModeExit()
{
    print("<<< Wykonywanie OnGameModeExit...");
	
	//Timery:
	timery_Delete();
	
	//Modu³y:
	textdrawy_Exit();
	interiory_Exit();
	pojazdy_Exit();
	
	MruMySQL_Exit();
	logi_Exit();
	
    print(">>> Wykonano. Gamemode pomyslnie wylaczony.");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 3.5, 1, 0, 0, 0, 0, 1);
	return 1;
}

public OnPlayerConnect(playerid)
{
	#if DEBUG_MODE > 0
	OnPlayerLogin(playerid);
	#endif

	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME); //pobieranie nicku
	GetPlayerName(playerid, PlayerInfo[playerid][pNick], MAX_PLAYER_NAME); //pobieranie nicku
	
	//Komunikat powitalny:
	ClearChat(playerid);
	MruMessageF(playerid, COLOR_WHITE, "SERVER: Witaj %s", nick);
	
	if(!IsNickCorrect(nick))
	{
		ServerError(playerid, "Twój nick jest niepoprawny! Nick musi posiadaæ formê: Imiê_Nazwisko lub Imiê_Imiê_Nazwisko!");
		ServerError(playerid, "Wiêcej na temat poprawnoœci nicku mo¿esz przeczytaæ na naszym forum w dziale Regulaminy i Zasady -> Lista Kar i Zasad");
		KickEx(playerid);
		return 1;
	}
	
	//Inicjowanie modu³ów:
	LadujPlayerTextdrawy(playerid); //zmien nazwe
	obiekty_OnPlayerConnect(playerid);
	
	konta_Logowanie(playerid);
	
	defer Kamera(playerid); //Tymczasowa wybiera³ka
	return 1;
}

timer Kamera[1500](playerid)
{
	SetPlayerPos(playerid, 	-2819.9297,1134.0607,26.0766);
	SetPlayerFacingAngle(playerid, 326.0);
	SetPlayerCameraPos(playerid, -2801.6691894531, 1151.7545166016, 31.548196792603);
	SetPlayerCameraLookAt(playerid, -2819.05078125, 1141.4909667969, 23.314708709717);
	PlayerPlaySound(playerid, 1062, -2818.0, 1100.0, 0.0);
	ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 3.5, 1, 0, 0, 0, 0, 1);
	ShowWelcomeScreenTextdraw(playerid);
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerLogged(playerid))
	{
		//Modu³y:
		oferty_OnPlayerDisconnect(playerid);
		frakcje_OnPlayerDisconnect(playerid);
		organizacje_OnPlayerDisconnect(playerid);
		
		CreateDiconnect3DText(playerid, reason);
		
		konta_SaveAccount(playerid);
		konta_DestroyORM(playerid);
	}
	
	//Iteratory:
	Iter_Clear(StreamedPlayers[playerid]); //czyszczenie pêtli streamed players (widocznych graczy dla gracza)
	
	//Modu³y:
	UsunPlayerTextdrawy(playerid); //zmien nazwe
	return 1;
}

public OnPlayerSpawn(playerid)
{
	#if DEBUG_MODE > 0
	if(IsPlayerNPC(playerid))
	{
		SetPlayerSkin(playerid, 281);
	}
	#endif
	
	if(IsPlayerLogged(playerid))
	{
		SetPlayerSpawn(playerid);
		
		SetPlayerPos(playerid, 1173.2563, -1323.3102, 15.3943);
	}
	else
	{
		return 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	wanted_OnPlayerDeath(playerid, killerid, reason);
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
	#if DEBUG_MODE > 0
	if(IsPlayerNPC(playerid))
	{
		if(text[0] == '#')
		{
			return 1;
		}
		printf("[Bot %s:] %s", GetNick(playerid), text);
		return 0;
	}
	else if(text[0] == 'b' && text[1] == 'o' && text[2] == 't')
	{
		return 1;
	}
	#endif

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
	/**************** Obs³uga wchodzenia do interiorów - pickupy ****************/
	if( PlayerInfo[playerid][pDoorSettings] == 1 )
	{
		new time = ((PlayerInfo[playerid][pDoorKey]&0b11111110000000)>>>7);
		if(GetPVarInt(playerid, "PickupTick") < time)
		{
			new string[8];
			if(GetTickCountDifference(GetTickCount(), GetPVarInt(playerid, "PickupTimestamp")) > 2500) //2.5s
				SetPVarInt(playerid, "PickupTick", 0);
			format(string, sizeof(string), "~w~%d", time-GetPVarInt(playerid, "PickupTick"));
			GameTextForPlayer(playerid, string, 2500, 3);
			SetPVarInt(playerid, "PickupTick", GetPVarInt(playerid, "PickupTick")+1);
			SetPVarInt(playerid, "PickupTimestamp", GetTickCount());
		}
		else
		{
			GameTextForPlayer(playerid, "~g~Wejscie", 1000, 3);
			SetPVarInt(playerid, "PickupTick", 0);
			interiory_SprawdzDrzwiPickup(playerid, pickupid);
		}
	}
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
	//Pobieranie klawiszy od gracza
	if(GetPVarInt(playerid, "GettingKeys"))
	{
		SetPVarInt(playerid, "PobraneKlawisze", GetPVarInt(playerid, "PobraneKlawisze") | newkeys);
		if(newkeys == 0)
		{
			new string[64];
			SetPVarInt(playerid, "GettingKeys", 0);
			GetPVarString(playerid, "GettingKeysFunction", string, sizeof(string));
			if(!isnull(string))
				CallRemoteFunction(string, "i", playerid);
			else
				Error("Mrucznik-RP", "OnPlayerKeyStateChange", "Nie podano funkcji - CallRemoteFunction", playerid);
		}
	}
	
	//Obs³uga dynamicznych klawiszy
	if(PlayerInfo[playerid][pDoorKey] != 0 && PlayerInfo[playerid][pDoorSettings] == 0)
	{
		if(PRESSED(PlayerInfo[playerid][pDoorKey]))
		{
			SprawdzDrzwi(playerid);
		}
	}
	
	//Obs³uga klawiszy ustawionych na twardo
	if(PRESSED(KEY_SUBMISSION))
    {
        SelectTextDraw(playerid, COLOR_NEWS);
    }
	if(PRESSED(KEY_JUMP))
	{
		SetPVarInt(playerid, "Jumping", 1);
	}
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
	//Anty BH
	if(GetPVarInt(playerid, "Jumping") == 1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerVelocity(playerid, x, y, z);
		if(z > 0.05)
		{
			SetPlayerVelocity(playerid, x*0.6, y*0.6, z);
			SetPVarInt(playerid, "Jumping", 0);
		}
	}
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
public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
    switch (success)
    {
        case COMMAND_ZERO_RET:
        {
            ServerFail(playerid, "Komenda zwróci³a 0 (b³¹d?)");
        }
        case COMMAND_OK:
        {
        }
        case COMMAND_UNDEFINED:
        {
            ServerFail(playerid, "Taka komenda nie istnieje!");
        }
		case COMMAND_DENIED:
        {
            ServerFail(playerid, "Nie masz uprawnieñ do u¿ywania tej komendy!");
        }
		case COMMAND_HIDDEN:
        {
            ServerFail(playerid, "Taka komenda nie istnieje! (istnieje xD)");
        }
		case COMMAND_NO_PLAYER:
        {
            Error("Mrucznik-RP", "OnPlayerCommandPerformed", "Used by a player who shouldn't exist", playerid);
        }
		case COMMAND_DISABLED:
        {
            ServerFail(playerid, "U¿ywanie przez Ciebie komend zosta³o zablokowane przez administratora.");
        }
		case COMMAND_BAD_PREFIX:
        {
            ServerFail(playerid, "BAD PREFIX!");
        }
		case 9:
        {
            ServerFail(playerid, "9 - nie by³o napisane od czego to!");
        }
		case COMMAND_INVALID_INPUT:
        {
            ServerFail(playerid, "INVAILD INPUT!");
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
	new string[128];
	
	ServerInfo(playerid, "Zarejestrowa³eœ siê");
	Log(LoginLog, INFO, "%s (UID: %d) zarejestrowal sie poprawnie z IP: %s", GetNick(playerid), PlayerInfo[playerid][pUID], GetIp(playerid));
	HideWelcomeScreenTextdraw(playerid);
	
	LoginPlayer(playerid);
	return 1;
}

public OnPlayerLogin(playerid)
{
	new string[128];
	
	ServerInfo(playerid, "Zalogowa³eœ siê!");
	Log(LoginLog, INFO, "%s (UID: %d) zalogowa³ sie poprawnie z IP: %s", GetNick(playerid), PlayerInfo[playerid][pUID], GetIp(playerid));
	HideWelcomeScreenTextdraw(playerid);
	
	//Modules:
	admin_AssignPlayerToGroup(playerid);
	
	LoginPlayer(playerid);
	return 1;
}

LoginPlayer(playerid)
{
	Group_SetPlayer(LoggedPlayers, playerid, true);
	SpawnPlayer(playerid);
}