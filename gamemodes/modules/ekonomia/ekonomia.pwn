//ekonomia.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: ekonomia.pwn ]------------------------------------------//
//Opis:
/*
	Modu³ zawiera zdefiniowane ceny wszystkiego oraz w przysz³oœci systemy cen oraz ekonomii które maj¹ na celu
	usuniêcie sytuacji zbyt du¿ej iloœci gotówki wœród graczy i stworzenie rynkowej ekonomii i dynamicznych cen
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

//-----------------<[ Funkcje: ]>-------------------
ekonomia_Init()
{
	ekonomia_LoadCommands();
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
ekonomia_LoadCommands()
{
	Command_AddAlt(YCMD:plac, "zaplac");
	Command_AddAlt(YCMD:plac, "pay");
	Group_SetCommand(LoggedPlayers, YCMD:plac, true);
}

YCMD:plac(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		SendClientMessage(playerid, -1, "P³aci graczowi wpisan¹ kwotê.");
		return 1;
	}
	
	//Lista parametrów:
	new giveplayerid;
	new hajs;
	
	if(sscanf(params, "uk<hajs>", giveplayerid, hajs)) 
	{
		CMDInfo(playerid, "U¿ycie: /plac [Nick/ID] [iloœæ]");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		if(playerid == giveplayerid)
		{
			ServerFail(playerid, "P³acenie samemu sobie nie wydaje siê dobrym pomys³em ;) Czy na pewno taki by³ twój zamiar?");
			return 1;
		}
		if(!IsPlayerLogged(giveplayerid))
		{
			ServerFail(playerid, "Na serwerze nie ma gracza o podanym Nicku/ID");
			return 1;
		}
		if(hajs <= 5000 && hajs > 0)
		{
			ServerFail(playerid, "T¹ komend¹ nie mo¿esz p³aciæ wiêcej ni¿ 5000$. U¿yj /teczka!");
			return 1;
		}
		if(IsPlayerInRangeToPlayer(playerid, giveplayerid))
		{
			ServerFail(playerid, "Ten gracz jest za daleko od tego gracza, podejdŸ bli¿ej.");
			return 1;
		}
		
		new player[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME], string[64];
		GetPlayerName(playerid, player, sizeof(player));
		GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
		GivePlayerMoney(playerid, -hajs);
		GivePlayerMoney(giveplayerid, hajs);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		ServerInfoF(playerid, "Da³eœ %d$ graczowi %s", hajs, giveplayer);
		ServerInfoF(giveplayerid, "Otrzyma³eœ %d$ od gracza %s", hajs, player);
		format(string, sizeof(string), "wyci¹ga pieni¹dze i daje je %s.", giveplayer);
		Me(playerid, string);
		Log(PayLog, INFO, "da³ %s kwotê %d$", giveplayer, hajs);
		
		return 1;
	}
}

//end