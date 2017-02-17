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
		format(string, sizeof(string), "Error! Function: %s | Info: %s | Player: %s", function, info, GetNick(playerid));
	}
	else
	{
		format(string, sizeof(string), "Error! Function: %s | Info: %s", module, function, info);
		
	}
	//
	new logfolder[64];
	format(logfolder, sizeof(logfolder), LOG_FOLDER"/Errors/%s.log", module);
	Log(logfolder,string);
	
	#if defined DEBUG_MODE_RESTRICT
		printf("DEBUG: Napotkano error przy trybie DEBUG_MODE_RESTRICT - wylaczam serwer ("LOG_FOLDER"/Errors/%s.log)", module);
		SendRconCommand("exit");
	#elseif defined DEBUG_MODE_KICK
		if(playerid != -1) 
		{
			printf("DEBUG: Napotkano error przy trybie DEBUG_MODE_KICK - kickuje gracza ("LOG_FOLDER"/Errors/%s.log)", module);
			KickEx(playerid);
		}
	#else
		printf("DEBUG: Napotkano error, wiecej informacji w "LOG_FOLDER"/Errors/%s.log", module);
	#endif
	return 1;
}

stock Debug_LoadNPCs()
{
	ConnectNPC("Tester","testbot");
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end