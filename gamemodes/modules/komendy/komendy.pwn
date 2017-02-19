//komendy.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: komendy.pwn ]--------------------------------------------//
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

//----------------<[ Callback: ]>------------------
//-----------------<[ Funkcje: ]>-------------------
stock komendy_Init()
{
	//Command_AddAltNamed("k1", "1");
	return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
YCMD:czas(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "Pokazuje obecny czas.");
	
	new string[256];
	new year, month,day;
	new hour,minute,second;
	getdate(year, month, day);
	gettime(hour,minute,second);
	
	format(string, sizeof(string), (minute>10) ? ("~y~%d %s~n~~g~|~w~%d:%d~g~|") : ("~y~%d %s~n~~g~|~w~%d:0%d~g~|"), day, gMonths[month-1], hour, minute);
	GameTextForPlayer(playerid, string, 10000, 1);
	return 1;
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
		if(IsPlayerConnected(giveplayerid))
		{
			if(hajs <= 5000 && hajs > 0)
			{
				if(IsPlayerInRangeToPlayer(playerid, giveplayerid))
				{
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
					PayLogF(playerid, "dal %s kwote %d$", giveplayer, hajs);
				}
				else
				{
					ServerFail(playerid, "Ten gracz jest za daleko, podejdŸ bli¿ej.");
				}
			}
			else
			{
				ServerFail(playerid, "T¹ komend¹ nie mo¿esz p³aciæ wiêcej ni¿ 5000$. U¿yj /teczka!");
			}
		}
		else
		{
			ServerFailF(playerid, "Na serwerze nie ma gracza o podanym Nicku/ID (%d).", giveplayerid);
		}
		return 1;
	}
}

//end