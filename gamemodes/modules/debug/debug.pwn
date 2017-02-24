//debug.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: debug.pwn ]---------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*

*/
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

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock Error(const module[], const function[], const info[], playerid=-1)
{
	new string[512];
	if(playerid != -1)
	{
		ServerError(playerid, "Napotkano b³¹d! Przepraszamy za uniedogodnienia.");
		format(string, sizeof(string), "Error! Module: %s Function: %s | Info: %s | Player: %s", module, function, info, GetNick(playerid));
	}
	else
	{
		format(string, sizeof(string), "Error! Module: %s  Function: %s | Info: %s", module, function, info);
		
	}
	//
	Log(MainLog, ERROR, string);
	
	#if defined DEBUG_MODE_RESTRICT
		printf("DEBUG: Napotkano error przy trybie DEBUG_MODE_RESTRICT - wylaczam serwer");
		SendRconCommand("exit");
	#elseif defined DEBUG_MODE_KICK
		if(playerid != -1) 
		{
			printf("DEBUG: Napotkano error przy trybie DEBUG_MODE_KICK - kickuje gracza");
			KickEx(playerid);
		}
		else
		{
			printf("DEBUG: Napotkano error przy trybie DEBUG_MODE_KICK ale brak gracza, pomijam.");
		}
	#else
		printf("DEBUG: Napotkano error, wiecej informacji w logach");
	#endif
	return 1;
}

stock Debug_LoadNPCs()
{
	ConnectNPC("Bot_Tester","testbot");
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end