//interiory.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Modu³: interiory.pwn ]-------------------------------------------//
//Opis:
/*

	SYSTEM INTERIORÓW
		3 klasy:
			budynek - g³ówna instancja, nazwê, w³aœciciela oraz typ budynku (Systemowy, Publiczny, Organizacja, Frakcja), vw
			pomieszczenie - nazwa, zawiera interior, oswietlenie, pogode, muzyke
			drzwi - zawieraja x,y,z in i out, lock oraz id pomieszczenia in i out, id budynku in, id budynku out, [3dtext in, 3dtext out, pickup in, pickup out, pickup type], winda
			winda - zawiera id drzwi które nale¿¹ do wiêkszej instancji
			
		Przyk³ad:
		Komisariat, LSPD, Frakcja, VW:1
		Sala g³ówna - interior 1, oœwietlenie - jasne, pogoda - ³adna, muzyka grozy
		Drzwi - x,y,z przed komi, x,y,z sali g³ównej, otwarte, in Sali g³ównej, out San Andreas
		
	SYSTEM DOMÓW/BIZNESÓW
		3 klasy:
		Instancja - nazwê, zawiera x,y,z, x2, y2, z2, uzywaj2wejscia, VW, w³aœciciela, typ instancji, zamkniête, oœwietlenie, pogode, muzykê, id Interioru
		Interior - zawiera x,y,z, x2,y2,z2 interior

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
public OnPlayerEnterDoor(playerid, doorid)
{
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
stock interiory_Init()
{
	interiory_LoadBudynki();
	interiory_LoadPomieszczenia();
	interiory_LoadDrzwi();
	//interiory_LoadWindy();
	StworzRelacje();
	
	interiory_LoadCommands();
	return 1;
}

stock interiory_Exit()
{
	return 1;
}

//-----[ Tworzenie/usuwanie/edytowanie interiorów ]-----
stock StworzBudynek(id, nazwa[], typ, wlasciciel, vw, playerid=-1)
{
	format(Budynki[id][Nazwa], MAX_BUDYNEK_NAME, nazwa);
	Budynki[id][Typ] = typ;
	Budynki[id][Wlasciciel] = wlasciciel;
	Budynki[id][VW] = vw;
	
	budynki_ORM(id);
	interiory_CreateBudynek(id, playerid);
	return id;
}

stock StworzPomieszczenie(id, nazwa[], budynek, interior, czas, pogoda, muzyka[]="", playerid=-1)
{
	format(Pomieszczenia[id][Nazwa], MAX_POMIESZCZENIE_NAME, nazwa);
	Pomieszczenia[id][Budynek] = budynek;
	Pomieszczenia[id][Interior] = interior;
	Pomieszczenia[id][Oswietlenie] = czas;
	Pomieszczenia[id][Pogoda] = pogoda;
	format(Pomieszczenia[id][Muzyka], MAX_STREAM_LENGTH, muzyka);
	
	pomieszczenia_ORM(id);
	interiory_CreatePomieszczenie(id, playerid);
	return id;
}

stock StworzDrzwi(id, nazwa[], Float:ix, Float:iy, Float:iz, Float:ia, itext3d[], ipickup, ipomieszczenie, Float:ox, Float:oy, Float:oz, Float:oa, otext3d[], opickup, opomieszczenie, bool:lockvalue=false, playerid=-1)
{
	format(Drzwi[id][Nazwa], MAX_DRZWI_NAME, nazwa);
	Drzwi[id][inX] = ix;
	Drzwi[id][inY] = iy;
	Drzwi[id][inZ] = iz;
	Drzwi[id][inA] = ia;
	format(Drzwi[id][in3DTextString], MAX_DRZWI3D_LENGTH, itext3d);
	Drzwi[id][inPickupModel] = ipickup;
	Drzwi[id][inPomieszczenie] = ipomieszczenie;
	Drzwi[id][outX] = ox;
	Drzwi[id][outY] = oy;
	Drzwi[id][outZ] = oz;
	Drzwi[id][outA] = oa;
	format(Drzwi[id][out3DTextString], MAX_DRZWI3D_LENGTH, otext3d);
	Drzwi[id][outPickupModel] = opickup;
	Drzwi[id][outPomieszczenie] = opomieszczenie;
	Drzwi[id][lock] = lockvalue;
	
	
	drzwi_ORM(id);
	drzwi_Create(id);
	interiory_CreateDrzwi(id, playerid);
	return id;
}

stock drzwi_Create(id)
{
	//in
	if(!isnull(Drzwi[id][in3DTextString])) Drzwi[id][in3DText] = CreateDynamic3DTextLabel(Drzwi[id][in3DTextString], TEXT3D_INTERIOR_COLOR, Drzwi[id][inX], Drzwi[id][inY], Drzwi[id][inZ]+TEXT3D_UP_Z, TEXT3D_DRZWI_DRAWDISTANCE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Budynki[Pomieszczenia[Drzwi[id][inPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][inPomieszczenieID]][Interior]);
	if(Drzwi[id][inPickupModel]) Drzwi[id][inPickup] = CreateDynamicPickup(Drzwi[id][inPickupModel], DOOR_PICKUP_TYPE, Drzwi[id][inX], Drzwi[id][inY], Drzwi[id][inZ], Budynki[Pomieszczenia[Drzwi[id][inPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][inPomieszczenieID]][Interior]);
	//out
	if(!isnull(Drzwi[id][out3DTextString])) Drzwi[id][out3DText] = CreateDynamic3DTextLabel(Drzwi[id][out3DTextString], TEXT3D_INTERIOR_COLOR, Drzwi[id][outX], Drzwi[id][outY], Drzwi[id][outZ]+TEXT3D_UP_Z, TEXT3D_DRZWI_DRAWDISTANCE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Budynki[Pomieszczenia[Drzwi[id][outPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][outPomieszczenieID]][Interior]);
	if(Drzwi[id][outPickupModel]) Drzwi[id][outPickup] = CreateDynamicPickup(Drzwi[id][outPickupModel], DOOR_PICKUP_TYPE, Drzwi[id][outX], Drzwi[id][outY], Drzwi[id][outZ], Budynki[Pomieszczenia[Drzwi[id][outPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][outPomieszczenieID]][Interior]);		
}

//------------------<[ Obsluga drzwi: ]>--------------------
stock SprawdzDrzwi(playerid)
{
	for(new i; i<IloscDrzwi; i++)
	{
		if(Drzwi[i][inPomieszczenieID] == gPlayerPomieszczenie[playerid])
		{
			if(IsPlayerInRangeOfPoint(playerid, DOORS_RANGE, Drzwi[i][inX], Drzwi[i][inY], Drzwi[i][inZ]))
			{
				EnterDoor(playerid, i, 0);
				return i;
			}
		}
		else if(Drzwi[i][outPomieszczenieID] == gPlayerPomieszczenie[playerid])
		{
			if(IsPlayerInRangeOfPoint(playerid, DOORS_RANGE, Drzwi[i][outX], Drzwi[i][outY], Drzwi[i][outZ]))
			{
				EnterDoor(playerid, i, 1);
				return i;
			}
		}
	}
	return -1;
}

stock interiory_SprawdzDrzwiPickup(playerid, pickup)
{
	for(new i; i<IloscDrzwi; i++)
	{
		if(Drzwi[i][inPickup] == pickup)
		{
			EnterDoor(playerid, i, 0);
			return i;
		}
		else if(Drzwi[i][outPickup] == pickup)
		{
			EnterDoor(playerid, i, 1);
			return i;
		}
	}
	return -1;
}

stock EnterDoor(playerid, doorid, inout)
{
	if(!Drzwi[doorid][lock])
	{
		if(inout == 0)//in
		{
			EnterPomieszczenie(playerid, Drzwi[doorid][outPomieszczenieID]);
			SetPlayerPos(playerid, Drzwi[doorid][outX], Drzwi[doorid][outY], Drzwi[doorid][outZ]);
		}
		else//out
		{
			EnterPomieszczenie(playerid, Drzwi[doorid][inPomieszczenieID]);
			SetPlayerPos(playerid, Drzwi[doorid][inX], Drzwi[doorid][inY], Drzwi[doorid][inZ]);
		}
		//Callback
		OnPlayerEnterDoor(playerid, doorid);
	}
	else
	{
		GameTextForPlayer(playerid, "~r~Drzwi zamkniete", 4000, 4);
	}
	return 1;
}

stock EnterPomieszczenie(playerid, pid)
{
	new b = Pomieszczenia[pid][BudynekID];
	SetPlayerVirtualWorld(playerid, Budynki[b][VW]);
	SetPlayerInterior(playerid, Pomieszczenia[pid][Interior]);
	
	if(Pomieszczenia[pid][Oswietlenie] != -1)
	{
		
		SetPlayerTime(playerid, Pomieszczenia[pid][Oswietlenie], 0);
	}
	else
	{
		new hour, minute, seconds;
		gettime(hour, minute, seconds);
		SetPlayerTime(playerid, hour, minute);
	}
	
	if(Pomieszczenia[pid][Pogoda] != -1)
	{
		SetPlayerWeather(playerid, Pomieszczenia[pid][Pogoda]);
	}
	else
	{
		SetPlayerWeather(playerid, gPogoda);
	}
	if(!isnull(Pomieszczenia[pid][Muzyka]))
		PlayAudioStreamForPlayer(playerid, Pomieszczenia[pid][Muzyka]);
	else
		StopAudioStreamForPlayer(playerid);
	gPlayerPomieszczenie[playerid] = pid;
	return 1;
}

//------------------<[ Skróty: ]>--------------------
/*stock GetBudynekID(doorid, inout)
{
	if(inout)
		return ;
	else
		return Pomieszczenie[Drzwi[doorid][outPomieszczenieID]][BudynekID];
}*/

//------------------<[ MySQL: ]>--------------------
stock budynki_ORM(id)
{
	new ORM:oid = Budynki[id][ORM] = orm_create(TABLE_BUDYNKI);
	
	orm_addvar_int(oid, Budynki[id][ID], "ID");
	orm_addvar_string(oid, Budynki[id][Nazwa], MAX_BUDYNEK_NAME, "Nazwa");
	orm_addvar_int(oid, Budynki[id][Typ], "Typ");
	orm_addvar_int(oid, Budynki[id][Wlasciciel], "Wlasciciel");
	orm_addvar_int(oid, Budynki[id][VW], "VirtualWorld");
	
	orm_setkey(oid, "ID");
}

stock pomieszczenia_ORM(id)
{
	new ORM:oid = Pomieszczenia[id][ORM] = orm_create(TABLE_POMIESZCZENIA);
	
	orm_addvar_int(oid, Pomieszczenia[id][ID], "ID");
	orm_addvar_int(oid, Pomieszczenia[id][Budynek], "Budynek");
	orm_addvar_string(oid, Pomieszczenia[id][Nazwa], MAX_POMIESZCZENIE_NAME, "Nazwa");
	orm_addvar_int(oid, Pomieszczenia[id][Interior], "Interior");
	orm_addvar_int(oid, Pomieszczenia[id][Oswietlenie], "Oswietlenie");
	orm_addvar_int(oid, Pomieszczenia[id][Pogoda], "Pogoda");
	orm_addvar_string(oid, Pomieszczenia[id][Muzyka], MAX_STREAM_LENGTH, "Muzyka");
	
	orm_setkey(oid, "ID");
}

stock drzwi_ORM(id)
{
	new ORM:oid = Drzwi[id][ORM] = orm_create(TABLE_DRZWI);
	
	//in
	orm_addvar_int(oid, Drzwi[id][ID], "ID");
	orm_addvar_string(oid, Drzwi[id][Nazwa], MAX_DRZWI_NAME, "Nazwa");
	orm_addvar_float(oid, Drzwi[id][inX], "inX");
	orm_addvar_float(oid, Drzwi[id][inY], "inY");
	orm_addvar_float(oid, Drzwi[id][inZ], "inZ");
	orm_addvar_float(oid, Drzwi[id][inA], "inA");
	orm_addvar_string(oid, Drzwi[id][in3DTextString], MAX_DRZWI3D_LENGTH, "in3DText");
	orm_addvar_int(oid, Drzwi[id][inPickupModel], "inPickupModel");
	orm_addvar_int(oid, Drzwi[id][inPomieszczenie], "inPomieszczenie");
	//out
	orm_addvar_float(oid, Drzwi[id][outX], "outX");
	orm_addvar_float(oid, Drzwi[id][outY], "outY");
	orm_addvar_float(oid, Drzwi[id][outZ], "outZ");
	orm_addvar_float(oid, Drzwi[id][outA], "outA");
	orm_addvar_string(oid, Drzwi[id][out3DTextString], MAX_DRZWI3D_LENGTH, "out3DText");
	orm_addvar_int(oid, Drzwi[id][outPickupModel], "outPickupModel");
	orm_addvar_int(oid, Drzwi[id][outPomieszczenie], "outPomieszczenie");
	orm_addvar_int(oid, Drzwi[id][lock], "Lock");
	
	orm_setkey(oid, "ID");
}

stock StworzRelacje(type=0, id=0)
{
	switch(type)
	{
		case 0:
		{
			for(new i; i<MAX_BUDYNKOW; i++)
			{
				for(new j; j<MAX_POMIESZCZEN; j++)
				{
					if(Pomieszczenia[j][Budynek] == Budynki[i][ID])
					{
						Pomieszczenia[j][BudynekID] = i;
					}
				}
			}
			for(new i; i<MAX_POMIESZCZEN; i++)
			{
				for(new j; j<MAX_DRZWI; j++)
				{
					if(Drzwi[j][inPomieszczenie] == Pomieszczenia[i][ID])
					{
						Drzwi[j][inPomieszczenieID] = i;
					}
					if(Drzwi[j][outPomieszczenie] == Pomieszczenia[i][ID])
					{
						Drzwi[j][outPomieszczenieID] = i;
					}
				}
			}
		}
		case 1:
		{
			for(new i; i<MAX_BUDYNKOW; i++)
			{
				if(Pomieszczenia[id][Budynek] == Budynki[i][ID])
				{
					Pomieszczenia[id][BudynekID] = i;
				}
			}
		}
		case 2:
		{
			for(new i; i<MAX_POMIESZCZEN; i++)
			{
				if(Drzwi[id][inPomieszczenie] == Pomieszczenia[i][ID])
				{
					Drzwi[id][inPomieszczenieID] = i;
				}
				if(Drzwi[id][outPomieszczenie] == Pomieszczenia[i][ID])
				{
					Drzwi[id][outPomieszczenieID] = i;
				}
			}
		}
	}
	return 1;
}

stock interiory_LoadBudynki()
{
	inline iQuery()
	{
		new rows;
		cache_get_row_count(rows);
		if(rows <= MAX_BUDYNKOW)
		{
			for(new i; i<rows; i++)
			{
				budynki_ORM(i);
				orm_apply_cache(Budynki[i][ORM], i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o budynkach z tabeli "TABLE_BUDYNKI, rows);
		}
		else
		{
			Error("interiory", "interiory_LoadBudynki()", "Ilosc zaladowanych budynkow wieksza niz maksymalna liczba budynkow.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_BUDYNKI"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}

stock interiory_LoadPomieszczenia()
{
	inline iQuery()
	{
		new rows;
		cache_get_row_count(rows);
		if(rows <= MAX_POMIESZCZEN)
		{
			for(new i; i<rows; i++)
			{
				pomieszczenia_ORM(i);
				orm_apply_cache(Pomieszczenia[i][ORM], i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o pomieszczeniach z tabeli "TABLE_POMIESZCZENIA, rows);
		}
		else
		{
			Error("interiory", "interiory_LoadPomieszczenia()", "Ilosc zaladowanych pomieszczen wieksza niz maksymalna liczba pomieszczen.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_POMIESZCZENIA"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}

stock interiory_LoadDrzwi()
{
	inline iQuery()
	{
		new rows;
		cache_get_row_count(rows);
		if(rows <= MAX_DRZWI)
		{
			for(new i; i<rows; i++)
			{
				drzwi_ORM(i);
				orm_apply_cache(Drzwi[i][ORM], i);
				drzwi_Create(i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o drzwiach z tabeli "TABLE_DRZWI, rows);
		}
		else
		{
			Error("interiory", "interiory_LoadDrzwi()", "Ilosc zaladowanych drzwi wieksza niz maksymalna liczba drzwi.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_DRZWI"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}

stock interiory_SaveBudynek(id)
{
	orm_update(Budynki[id][ORM]); 
}

stock interiory_SavePomieszczenie(id)
{
	orm_update(Pomieszczenia[id][ORM]); 
}

stock interiory_SaveDrzwi(id)
{
	orm_update(Drzwi[id][ORM]); 
}

stock interiory_CreateBudynek(id, playerid=-1)
{
	inline Query()
	{
		//Budynki[id][ID] = cache_insert_id();
		if(playerid!=-1)
			ServerInfoF(playerid, "Stworzono budynek o ID: %d", Budynki[id][ID]);
	}
	orm_insert_inline(Budynki[id][ORM], using inline Query, ""); 
}

stock interiory_CreatePomieszczenie(id, playerid=-1)
{
	inline Query()
	{
		//Pomieszczenia[id][ID] = cache_insert_id();
		if(playerid!=-1)
			ServerInfoF(playerid, "Stworzono pomieszczenie o ID: %d", Pomieszczenia[id][ID]);
		StworzRelacje(1, id);
	}
	orm_insert_inline(Pomieszczenia[id][ORM], using inline Query, ""); 
}

stock interiory_CreateDrzwi(id, playerid=-1)
{
	inline Query()
	{
		//Drzwi[id][ID] = cache_insert_id();
		if(playerid!=-1)
			ServerInfoF(playerid, "Stworzono drzwi o ID: %d", Drzwi[id][ID]);
		StworzRelacje(2, id);
	}
	orm_insert_inline(Drzwi[id][ORM], using inline Query, ""); 
}

stock interiory_DeleteBudynek(id)
{
	new query[128];
	format(query, sizeof(query), "%s DELETE FROM `"TABLE_BUDYNKI"` WHERE `ID` = %d;", Budynki[id][ID]);
	mysql_pquery(gMySQL, query);
	
	for(new eBudynki:i; i<eBudynki; i++)
	{
		Budynki[id][i] = 0;
	}
	return 1;
}

stock interiory_DeletePomieszczenie(id)
{
	new query[128];
	format(query, sizeof(query), "DELETE FROM `"TABLE_POMIESZCZENIA"` WHERE `ID` = %d", Pomieszczenia[id][ID]);
	mysql_pquery(gMySQL, query);
	return 1;
}

stock interiory_DeleteDrzwi(id)
{
	new query[128];
	format(query, sizeof(query), "DELETE FROM `"TABLE_DRZWI"` WHERE `ID` = %d", Drzwi[id][ID]);
	mysql_pquery(gMySQL, query);
	return 1;
}

//-----------------<[ Komendy: ]>-------------------
interiory_LoadCommands()
{
	Command_AddAlt(YCMD:interiory, "budynki");
	Command_AddAlt(YCMD:interiory, "interiors");
	Group_SetCommand(LoggedPlayers, YCMD:interiory, true);
	
	Command_AddAlt(YCMD:stworzbudynek, "createbuilding");
	Group_SetCommand(LoggedPlayers, YCMD:stworzbudynek, true);
	
	Command_AddAlt(YCMD:stworzpomieszczenie, "createinterior");
	Group_SetCommand(LoggedPlayers, YCMD:stworzpomieszczenie, true);
	
	Command_AddAlt(YCMD:stworzdrzwi, "createdoor");
	Group_SetCommand(LoggedPlayers, YCMD:stworzdrzwi, true);
	
	Command_AddAlt(YCMD:wejdz, "enter");
	Group_SetCommand(LoggedPlayers, YCMD:wejdz, true);
}

YCMD:interiory(playerid, params[], help)
{
	if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	PanelBudynkow(playerid, false); // true - domy | false - budynki 
	return 1;
}

YCMD:stworzbudynek(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Lista parametrów:
	new typ, wlasciciel, vw, nazwa[MAX_BUDYNEK_NAME];
	
	if(sscanf(params, "ddds["#MAX_BUDYNEK_NAME"]", typ, wlasciciel, vw, nazwa)) 
	{
		CMDInfo(playerid, "U¿ycie: /stworzbudynek [typ] [wlasciciel] [virtualworld] [nazwa]");
		CMDInfo(playerid, "Dostêpne typy: PUBLICZNY-1 | FRAKCJA-2 | ORGANIZACJA-3 | GRACZ-4");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		StworzBudynek(IloscBudynkow++, nazwa, typ, wlasciciel, vw, playerid);
		return 1;
	}
}

YCMD:stworzpomieszczenie(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Lista parametrów:
	new budynek, interior, czas, pogoda, nazwa[MAX_BUDYNEK_NAME];
	
	if(sscanf(params, "dddds["#MAX_POMIESZCZENIE_NAME"]", budynek, interior, czas, pogoda, nazwa)) 
	{
		CMDInfo(playerid, "U¿ycie: /stworzpomieszczenie [budynek] [interior] [oswieltenie-czas] [pogoda] [nazwa]");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		StworzPomieszczenie(IloscPomieszczen++, nazwa, budynek, interior, czas, pogoda, "", playerid);
		return 1;
	}
}

YCMD:stworzdrzwi(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Lista parametrów:
	new Float:x, Float:y, Float:z, Float:a, p, nazwa[MAX_BUDYNEK_NAME];
	
	if(sscanf(params, "dffffs["#MAX_POMIESZCZENIE_NAME"]", p, x, y, z, a, nazwa)) 
	{
		CMDInfo(playerid, "U¿ycie: /stworzdrzwi [pomieszczenie] [x] [y] [z] [a] [nazwa]");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		new Float:gx, Float:gy, Float:gz, Float:ga;
		GetPlayerPos(playerid, gx, gy, gz);
		GetPlayerFacingAngle(playerid, ga);
		StworzDrzwi(IloscDrzwi++, nazwa, gx, gy, gz, ga, "Wejscie", 1239, 1, x, y, z, a, "Wyjscie", 1239, p, false, playerid);
		return 1;
	}
}

YCMD:wejdz(playerid, params[], help)
{
	if(help)
	{
		CMDInfo(playerid, "[POMOC] Komenda s³u¿y do wchodzenia/wychodzenia z pomieszczeñ/budynków."); //Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	if(SprawdzDrzwi(playerid) == -1)
		ServerFail(playerid, "Brak w okolicy drzwi do których móg³byœ wejœæ");
	return 1;
}

//end