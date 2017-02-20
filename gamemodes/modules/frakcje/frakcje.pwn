//frakcje.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: frakcje.pwn ]--------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*
	TODO: 	Dodaj rangi i baze mysql frakcji i sprawdz jak dzialaja
			Dodaj wydzialy
			Dodaj uprawnienia dla rang
			Dodaj uprawnienia dla wydzia³ów
			Sprawdz uprawnienia
			Stwórz funkcje tworz¹ce autoamtycznie baze danych jeœli nie istnieje
			Dodaj komendy frakcji z poprzedniego game modu i sprawdŸ
			Dodaj przypisywanie aut do frakcji
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
//---<[ G³ówne ]>---
frakcje_Init()
{
	CreateORMs();
	MruMySQL_LadujFrakcje();
	CreateFractionGroups();
	CreateFractionRangGroups();
	return 1;
}

frakcje_OnPlayerLogin(playerid)
{
	AddPlayerToFractionGroup(playerid, PlayerInfo[playerid][pFrakcja]);
	PlayerFractionRankGroupInit(playerid);
	return 1;
}

frakcje_OnPlayerDisconnect(playerid)
{
	return 1;
}
//--

CreateFractionGroups()
{
	for(new i; i<ILOSC_FRAKCJI; i++)
		Frakcja[i][Grupa] = Group_Create(Frakcja[i][Nazwa]);
	return 1;
}

CreateFractionRangGroups()
{
	for(new i; i<ILOSC_FRAKCJI; i++)
		CreateFractionRangGroup(i); 
	return 1;
}

CreateFractionRangGroup(fraction)
{
	for(new i; i<ILOSC_RANG; i++)
	{
		new string[32];
		format(string, sizeof(string), "%s ranga %d", Group_GetName(Frakcja[fraction][Grupa]), i);
		Frakcja[fraction][GrupaRanga][i] = Group_Create(string);
	}
	return 1;
}

AddPlayerToFractionGroup(playerid, fraction)
{
	Group_SetPlayer(Frakcja[fraction][Grupa], playerid, true);
}

RemovePlayerFromFractionGroup(playerid, fraction)
{
	Group_SetPlayer(Frakcja[fraction][Grupa], playerid, false);
}

AddToFractionRankGroup(playerid, fraction, rang)
{
	Group_SetPlayer(Frakcja[fraction][GrupaRanga][rang], playerid, true);
}

RemoveFromFractionRankGroup(playerid, fraction, rang)
{
	Group_SetPlayer(Frakcja[fraction][GrupaRanga][rang], playerid, false);
}

PlayerFractionRankGroupInit(playerid)
{
	for(new i; i<=PlayerInfo[playerid][pRanga]; i++)
	{
		AddToFractionRankGroup(playerid, PlayerInfo[playerid][pFrakcja], i);
	}
}

ClearPlayerFractionRankGroup(playerid)
{
	for(new i; i<=PlayerInfo[playerid][pRanga]; i++)
	{
		RemoveFromFractionRankGroup(playerid, PlayerInfo[playerid][pFrakcja], i);
	}
}

FrakcjaSpawn(playerid)
{
	new frakcja = PlayerInfo[playerid][pFrakcja];
	SetPlayerPos(playerid, Frakcja[frakcja][Spawn][0], Frakcja[frakcja][Spawn][1], Frakcja[frakcja][Spawn][2]);
	SetPlayerFacingAngle(playerid, Frakcja[frakcja][Spawn][3]);
	SetPlayerColor(playerid, Frakcja[frakcja][Kolor]);
	return 1;
}

//---<[ Lider ]>---
stock Przyjmij(playerid, frakcja)
{
	PlayerInfo[playerid][pFrakcja] = frakcja;
	PlayerInfo[playerid][pRanga] = 0;
	AddPlayerToFractionGroup(playerid, frakcja);
	AddToFractionRankGroup(playerid, frakcja, 0);
}

stock Zwolnij(playerid)
{
	RemovePlayerFromFractionGroup(playerid, PlayerInfo[playerid][pFrakcja]);
	PlayerInfo[playerid][pFrakcja] = BRAK_FRAKCJI;
	ClearPlayerFractionRankGroup(playerid);
	PlayerInfo[playerid][pRanga] = -1;
}

stock Awansuj(playerid)
{
	PlayerInfo[playerid][pRanga] += 1;
	AddToFractionRankGroup(playerid, PlayerInfo[playerid][pFrakcja], PlayerInfo[playerid][pRanga]);
}

stock Degraduj(playerid)
{
	RemoveFromFractionRankGroup(playerid, PlayerInfo[playerid][pFrakcja], PlayerInfo[playerid][pRanga]);
	PlayerInfo[playerid][pRanga] -= 1;
	if(PlayerInfo[playerid][pRanga] < 0)
	{
		Zwolnij(playerid);
		return 0;
	}
	return 1;
}

stock UstawRange(playerid, ranga)
{
	PlayerInfo[playerid][pRanga] = ranga;
	PlayerFractionRankGroupInit(playerid);
}

stock LiderPanel(playerid)
{
	if(IsALider(playerid))
	{
		Dialog_ShowCallback(playerid, using fLiderGUI, DIALOG_STYLE_LIST, "Panel lidera", PANEL_LIDERA_KOMUNIKAT, "Wybierz", "WyjdŸ");
	}
	else if(PlayerInfo[playerid][pFRank] == WYDZIAL_RANG)
	{
		Dialog_ShowCallback(playerid, using fWydzialGUI, DIALOG_STYLE_LIST, "Panel wydzia³u", PANEL_WYDZIALU_KOMUNIKAT, "Wybierz", "WyjdŸ");
	}
	else
	{
		ServerFail(playerid, "Brak uprawnieñ");
	}
}

stock LiderGUI(playerid, dialogid, response, listitem, string:inputtext[] ) 
{
	#pragma unused dialogid, inputtext
	new frakcjaid = PlayerInfo[playerid][pFrakcja];
	if(response)
	{
		if(listitem == 0)//Bilans
		{
			
		}
		else if(listitem == 1)//Pracownicy
		{
			
		}
		else if(listitem == 2)//Wydzia³y
		{
			
		}
		else if(listitem == 3)//Pojazdy
		{
			
		}
		else if(listitem == 4)//Wyposa¿enie
		{
			
		}
		else if(listitem == 5)//Zarz¹dzaj nazwami
		{
			
		}
		else if(listitem == 6)//Ustawienia
		{
			FrakcjaInfo[frakcjaid][pChatyOOC] ~~;
			ServerInfo(playerid, "Czaty "(FrakcjaInfo[frakcjaid][pChatyOOC]) ? ("{00FF00}ON") : ("{FF0000}OFF"));
			Dialog_ShowCallback(playerid, using LiderGUI, DIALOG_STYLE_LIST, "Panel lidera", PANEL_LIDERA_KOMUNIKAT, "Wybierz", "WyjdŸ");
		}
	}
}

stock WydzialGUI(playerid, dialogid, response, listitem, string:inputtext[] ) 
{
	
}
//--

//---<[ Chaty ]>---
stock FrakcjaMessage(id, kolor, text[])
{
	foreach(new i : GroupMember(Frakcja[id][Grupa]))
	{
		MruMessage(i, kolor, text);
	}
}

stock FrakcjaRangMessage(id, ranga, kolor, text[])
{
	for(new i=ranga; i<ILOSC_RANG; i++)
	{
		foreach(new j : GroupMember(Frakcja[id][GrupaRanga][i]))
		{
			MruMessage(j, kolor, text);
		}
	}
}

stock Radio(playerid, id, text[])
{
	new string[256];
	format(string, sizeof(string), "** %s [%d] %s: %s, odbiór. **", fRanga[id][PlayerInfo[playerid][pRanga]], PlayerInfo[playerid][pRanga], GetNick(playerid), text);
	FrakcjaMessage(id, FRAKCJA_RADIO_COLOR, string);
}

stock RadioOOC(playerid, id, text[])
{
	new string[256];
	format(string, sizeof(string), "** (( %s [%d] %s: %s, odbiór. )) **", fRanga[id][PlayerInfo[playerid][pRanga]], PlayerInfo[playerid][pRanga], GetNick(playerid), text);
	FrakcjaMessage(id, FRAKCJA_RADIO_COLOR, string);
}

stock Departament(playerid, id, text[])
{
	new string[256];
	format(string, sizeof(string), "** %s [%d] %s: %s, odbiór. **", fRanga[id][PlayerInfo[playerid][pRanga]], PlayerInfo[playerid][pRanga], GetNick(playerid), text);
	FrakcjaMessage(LSPD, FRAKCJA_DEP_COLOR, string);
	FrakcjaMessage(FBI, FRAKCJA_DEP_COLOR, string);
	FrakcjaMessage(SWAT, FRAKCJA_DEP_COLOR, string);
	FrakcjaMessage(LSMC, FRAKCJA_DEP_COLOR, string);
}

stock DepartamentOOC(playerid, id, text[])
{
	new string[256];
	format(string, sizeof(string), "** (( %s [%d] %s: %s, odbiór. )) **", fRanga[id][PlayerInfo[playerid][pRanga]], PlayerInfo[playerid][pRanga], GetNick(playerid), text);
	FrakcjaMessage(LSPD, FRAKCJA_DEP_COLOR, string);
	FrakcjaMessage(FBI, FRAKCJA_DEP_COLOR, string);
	FrakcjaMessage(SWAT, FRAKCJA_DEP_COLOR, string);
	FrakcjaMessage(LSMC, FRAKCJA_DEP_COLOR, string);
}
//--

//---<[ IsA ]>---
stock IsAFraction(playerid, fraction)
{
	if(PlayerInfo[playerid][pFrakcja] == fraction)
		return 1;
	return 0;
}

stock IsACop(playerid)
{
	switch (PlayerInfo[playerid][pFrakcja])
	{
		case LSPD, FBI, SWAT: return 1;
		default: return 0;
	}
	return 0;
}

stock IsALider(playerid)
{
	if(PlayerInfo[playerid][pRanga] == LIDER_RANGA)
		return 1;
	return 0;
}

stock IsABurmistrz(playerid)
{
	if(PlayerInfo[playerid][pRanga] == LIDER_RANGA)
	{
		if(PlayerInfo[playerid][pFrakcja] == DMV)
			return 1;
	}
	return 0;
}
//--

//------------------<[ MySQL: ]>--------------------
stock static CreateORMs()
{
	for(new i; i<ILOSC_FRAKCJI; i++)
	{
		CreateFractionORM(i);
	}
}

stock static CreateFractionORM(fraction)
{
	Frakcja[fraction][ID] = fraction;
	new ORM:id = Frakcja[fraction][ORM] = orm_create(TABLE_FRAKCJE);
	
	orm_addvar_int(id, Frakcja[fraction][ID], "ID");
	orm_addvar_string(id, Frakcja[fraction][Nazwa], MAX_FRACTION_NAME, "Nazwa");
	orm_addvar_string(id, Frakcja[fraction][Skrot], MAX_FRACTION_SKROT, "Skrot");
	orm_addvar_string(id, Frakcja[fraction][Motto], MAX_FRACTION_MOTTO, "Motto");
	orm_addvar_float(id, Frakcja[fraction][Spawn][0], "SpawnX");
	orm_addvar_float(id, Frakcja[fraction][Spawn][1], "SpawnY");
	orm_addvar_float(id, Frakcja[fraction][Spawn][2], "SpawnZ");
	orm_addvar_float(id, Frakcja[fraction][Spawn][3], "SpawnA");
	orm_addvar_int(id, Frakcja[fraction][Kolor], "Kolor");
	
	orm_setkey(id, "ID");
}

stock static CreateRanksORM(fraction, rank)
{
	
}

stock MruMySQL_LadujFrakcje()
{
	for(new i; i<ILOSC_FRAKCJI; i++)
	{
		orm_load(Frakcja[i][ORM]);
	}	
	return 1;
}

stock MruMySQL_ZapiszFrakcje()
{
	for(new i; i<ILOSC_FRAKCJI; i++)
	{
		orm_update(Frakcja[i][ORM]);
	}	
	return 1;
}

//-----------------<[ Komendy: ]>-------------------
YCMD:r(playerid, params[], help) //radio
{
	if(help) return SendClientMessage(playerid, -1, "Radio frakcji");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /r [text]");
		
	Radio(playerid, PlayerInfo[playerid][pFrakcja], ZamienZnalezioneBindy(playerid, params));
	return 1;
}

YCMD:ro(playerid, params[], help) //radio
{
	if(help) return SendClientMessage(playerid, -1, "Radio frakcji");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /ro [text]");
	
	RadioOOC(playerid, PlayerInfo[playerid][pFrakcja], ZamienZnalezioneBindy(playerid, params));
	return 1;
}

YCMD:d(playerid, params[], help) //radio
{
	if(help) return SendClientMessage(playerid, -1, "Departament frakcji");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /d [text]");
		
	Departament(playerid, PlayerInfo[playerid][pFrakcja], ZamienZnalezioneBindy(playerid, params));
	return 1;
}

YCMD:depo(playerid, params[], help) //radio
{
	if(help) return SendClientMessage(playerid, -1, "Departament frakcji");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /depo [text]");
	
	DepartamentOOC(playerid, PlayerInfo[playerid][pFrakcja], ZamienZnalezioneBindy(playerid, params));
	return 1;
}

YCMD:przyjmij(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "S³u¿y do przyjmowania graczy");
	
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, -1, "U¿ycie: /przyjmij [Nick/ID]");
	}
	else
	{
		if(PlayerInfo[giveplayerid][pFrakcja] == BRAK_FRAKCJI)
		{
			Przyjmij(giveplayerid, PlayerInfo[playerid][pFrakcja]);
			ServerInfoF(playerid, "Przyj¹³eœ do frakcji %s", GetNick(playerid));
			ServerInfoF(giveplayerid, "Zosta³eœ przyjêty do frakcji przez %s", GetNick(giveplayerid));
		}
		else
		{
			ServerFail(playerid, "Ten gracz jest ju¿ we frakcji.");
			return 1;
		}
	}
	return 1;
}

YCMD:zwolnij(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "S³u¿y do zwalniania graczy");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /zwolnij [Nick/ID]");
	
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid))
	{
		SendClientMessage(playerid, -1, "U¿ycie: /zwolnij [Nick/ID]");
	}
	else
	{
		if(PlayerInfo[playerid][pFrakcja] == PlayerInfo[giveplayerid][pFrakcja])
		{
			Zwolnij(giveplayerid);
			ServerInfoF(playerid, "Zwolni³eœ z frakcji %s", GetNick(giveplayerid));
			ServerInfoF(giveplayerid, "Zosta³eœ zwolniony z frakcji przez %s", GetNick(playerid));
		}
		else
		{
			ServerFail(playerid, "Ten gracz nie jest w twojej frakcji.");
			return 1;
		}
	}
	return 1;
}

YCMD:awans(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "S³u¿y do awansowania graczy");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /awans [Nick/ID]");
	
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid))
	{
		if(PlayerInfo[playerid][pFrakcja] == PlayerInfo[giveplayerid][pFrakcja])
		{
			Awansuj(giveplayerid);
			ServerGoodInfoF(giveplayerid, "Gratulacje! Dosta³eœ awans na %d rangê od swojego lidera %s.", PlayerInfo[playerid][pRanga], GetNick(playerid));
			ServerInfoF(playerid, "Awansowa³eœ %s na %d rangê.", GetNick(giveplayerid), PlayerInfo[playerid][pRanga]);
		}
		else
		{
			ServerFail(playerid, "Ten gracz nie jest w twojej frakcji.");
			return 1;
		}
	}
	return 1;
}

YCMD:degraduj(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "S³u¿y do degradowania graczy");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /degraduj [Nick/ID]");
	
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid))
	{
		if(PlayerInfo[playerid][pFrakcja] == PlayerInfo[giveplayerid][pFrakcja])
		{
			new zdegradowany = Degraduj(giveplayerid);
			if(zdegradowany)
			{
				ServerBadInfoF(giveplayerid, "WsytdŸ siê! Dosta³eœ degradacjê na %d rangê od swojego lidera %s.", PlayerInfo[playerid][pRanga], GetNick(playerid));
				ServerInfoF(playerid, "Zdegradowa³eœ %s na %d rangê.", GetNick(giveplayerid), PlayerInfo[playerid][pRanga]);
			}
			else
			{
				ServerInfoF(playerid, "Zwolni³eœ z frakcji %s", GetNick(giveplayerid));
				ServerInfoF(giveplayerid, "Zosta³eœ zwolniony z frakcji przez %s", GetNick(playerid));
			}
		}
		else
		{
			ServerFail(playerid, "Ten gracz nie jest w twojej frakcji.");
			return 1;
		}
	}
	return 1;
}

YCMD:dajrange(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "S³u¿y do nadawania rangi pracownikom");
	if(isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /dajrange [Nick/ID] [ranga]");
	
	new giveplayerid, ranga;
	if(sscanf(params, "ud", giveplayerid, ranga))
	{
		if(PlayerInfo[playerid][pFrakcja] == PlayerInfo[giveplayerid][pFrakcja])
		{
			UstawRange(giveplayerid, ranga);
			ServerInfoF(giveplayerid, "Twój lider %s nada³ ci %d rangê.", GetNick(playerid), ranga);
			ServerInfoF(playerid, "Da³eœ %s rangê %d.", GetNick(giveplayerid), ranga);
		}
		else
		{
			ServerFail(playerid, "Ten gracz nie jest w twojej frakcji.");
			return 1;
		}
	}
	return 1;
}

//end