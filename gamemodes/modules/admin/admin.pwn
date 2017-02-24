//admin.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: admin.pwn ]---------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------
admin_Init()
{
	admin_LoadCommands();
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
admin_LoadCommands()
{

}

YCMD:messagecolor(playerid, params[], help)
{
	new color, string[512];
    if(!sscanf(params, "xs[512]", color, string))
	MruMessage(playerid, color, string);
	return 1;
}

YCMD:respawn(playerid, params[], help)
{
	SpawnPlayer(playerid);
	return 1;
}

YCMD:sethp(playerid, params[], help)
{	
	new giveplayerid, Float:hp;
	if(sscanf(params, "uf", giveplayerid, hp)) return SendClientMessage(playerid, -1, "U¿ycie: /sethp [id] [hp]"), 1;
	else
	{
		SetPlayerHealth(giveplayerid, hp);
		if(playerid != giveplayerid)ServerInfoF(playerid, "Ustawiono HP graczowi %s na %f", GetNick(giveplayerid), hp);
		ServerInfoF(giveplayerid, "Ustawiono twoje HP na %f", hp);
	}
	return 1;
}

YCMD:setarmor(playerid, params[], help)
{	
	new giveplayerid, Float:hp;
	if(sscanf(params, "uf", giveplayerid, hp)) return SendClientMessage(playerid, -1, "U¿ycie: /setarmor [id] [hp]"), 1;
	else
	{
		SetPlayerArmour(giveplayerid, hp);
		if(playerid != giveplayerid)ServerInfoF(playerid, "Ustawiono pancerz graczowi %s na %f", GetNick(giveplayerid), hp);
		ServerInfoF(giveplayerid, "Ustawiono twój pancerz na %f", hp);
	}
	return 1;
}

YCMD:gotopos(playerid, params[], help)
{
	new Float:x, Float:y, Float:z;
	if(sscanf(params, "fff",x,y,z)) return SendClientMessage(playerid, -1, "U¿ycie: /gotopos [x] [y] [z]"), 1;
	else
	{
		SetPlayerPos(playerid, x, y, z);
		ServerInfoF(playerid, "Pozycja zmieniona na: [%f, %f, %f]", x,y,z);
	}
	return 1;
}

YCMD:givegun(playerid, params[], help)
{
	new giveplayerid, gun, ammo;
	if(sscanf(params, "udd", giveplayerid, gun, ammo)) return SendClientMessage(playerid, -1, "U¿ycie: /givegun [gracz] [id broni] [amunicja]"), 1;
	else
	{
		GivePlayerWeapon(giveplayerid, gun, ammo);
		if(playerid != giveplayerid) ServerInfoF(playerid, "Dano broñ %s [amunicja: %d] graczowi %s", gGunNames[gun], ammo, GetNick(giveplayerid));
		ServerInfoF(giveplayerid, "Otrzyma³eœ %s z %d nabojami",  gGunNames[gun], ammo);
	}
	return 1;
}

YCMD:givemoney(playerid, params[], help)
{
	new giveplayerid, hajs;
	if(sscanf(params, "ud", giveplayerid, hajs)) return SendClientMessage(playerid, -1, "U¿ycie: /givemoney [gracz] [hajs]"), 1;
	else
	{
		GivePlayerMoney(giveplayerid, hajs);
		if(playerid != giveplayerid) ServerInfoF(playerid, "Dano %d$ graczowi %s", hajs, GetNick(giveplayerid));
		ServerInfoF(giveplayerid, "Otrzyma³eœ %d$ nabojami",  hajs);
	}
	return 1;
}

YCMD:dajadmina(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "Nadawanie administratora");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /dajadmina [Nick/ID] [poziom]");
	
	new giveplayerid, level;
	if(sscanf(params, "ud", giveplayerid, level) && IsPlayerAdmin(playerid))
	{
		ServerInfoF(playerid, "Nadano admina %s lvl %d", GetNick(giveplayerid), level);
		ServerInfoF(giveplayerid, "Otrzyma³eœ %d lvl admina od %s", level, GetNick(playerid));
		PlayerInfo[giveplayerid][pAdmin] = level;
	}
	return 1;
}

YCMD:setstat(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "S³u¿y do zmiany statystyk gracza");
	if(!isnull(params))  
	{
		new giveplayerid, nazwa[16], set;
		if(!sscanf(params, "us[16]d", giveplayerid, nazwa, set))
		{
			switch (YHash(nazwa))
			{
				case _H<lvl>: 				PlayerInfo[giveplayerid][pLevel] = set;
				case _H<hajs>:				PlayerInfo[giveplayerid][pHajs] = set;
				case _H<frakcja>:			if(set < 0) FrakcjaZwolnij(giveplayerid); else FrakcjaPrzyjmij(giveplayerid, set);
				case _H<org>:				PlayerInfo[giveplayerid][pOrganizacja] = set;
				case _H<honline>:			PlayerInfo[giveplayerid][pOnline] = set;
				case _H<spawn>:				PlayerInfo[giveplayerid][pSpawn] = set;
				case _H<ranga>:				FrakcjaUstawRange(giveplayerid, set);
				case _H<praca>:				PlayerInfo[giveplayerid][pPraca] = set;
				case _H<wl>:				PlayerInfo[giveplayerid][pWL] = set;
				default: goto goto_setstat;
			}
			
			ServerInfoF(playerid, "Zmieni³eœ graczowi %s na %d", nazwa, set);
			return 1;
		}
	}
	goto_setstat:
	SendClientMessage(playerid, -1, "U¿ycie: /setstat [Nick/ID] [nazwa] [wartoœæ]");
	SendClientMessage(playerid, -1, "---------------[lista nazw]--------------------------------------------------");
	SendClientMessage(playerid, -1, "lvl, admin, hajs, frakcja, org, honline, spawn, ranga, praca, wl");
	SendClientMessage(playerid, -1, "----------------------------------------------------------------------------");
	
	/*	pUID,
		pOnline,
		pLastLogTime[6],
		pLevel,
		pAdmin,
		pHajs,			
		pFrakcja,		//w tabeli mru_konto_frakcja
		pOrganizacja,	//w tabeli mru_konto_organizacja
		pRanga,
		pPraca,			//mo¿liwe, ¿e w tabeli mru_konto_praca
		pSpawn,
		pWL,
		pDom,  */
	
	return 1;
}

//end