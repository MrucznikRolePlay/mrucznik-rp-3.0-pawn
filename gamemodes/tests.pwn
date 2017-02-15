//-------------------------------------[Mapa Testowa Mrucznik Role Play]-------------------------------------//
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
	print("P | ---     Testowanie     --- | P");
	print("----------------------------------\n");
	print("\n");
}

public OnGameModeInit()
{
	return 1;
}

//------------------------------------------<[ Testing ]>----------------------------------------------------//
//-                                                                                                         -//
stock ChatTesting()
{
	
}