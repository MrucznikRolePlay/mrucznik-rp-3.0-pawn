//system_aut.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: system_aut.pwn ]-------------------------------------------//
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
stock pojazdy_Init()
{
	
	return 1;
}

stock PanelPojazdow(playerid)
{
	Dialog_ShowCallback(playerid, using callback dialog_PanelPojazdow, DIALOG_STYLE_LIST, INCOLOR_LIGHTGREEN"Panel pojazdow", MruMySQL_PanelPojazdow(playerid), "Wybierz", "Wróæ");
	return 1;
}

stock Salon(playerid)
{
	Dialog_ShowCallback(playerid, using callback dialog_SalonKategorie, DIALOG_STYLE_LIST, INCOLOR_LIGHTGREEN"Salon - kategorie", MruMySQL_Salon(), "Wybierz", "WyjdŸ");
	return 1;
}

stock Stocznia()
{
	return 1;
}

stock HangarLotniczy()
{
	return 1;
}

stock KupPojazd(playerid, model, kolor1, kolor2)
{
	MruMySQL_StworzPojazd(playerid, model, kolor1, kolor2, 2161.2605,-1197.3385,23.5517,89.7108, 2161.2605,-1197.3385,23.5517,89.7108, 1000.0, 0);
	ServerInfo(playerid, "Kupi³eœ pojazd");
	return 1;
}

stock SpawnujPojazd(vehicleid)
{
	return 1;
}

stock UnspawnujPojazd(vehicleid)
{
	return 1;
}

stock StworzPojazd(playerid, slot, uid, owner, model, Float:x, Float:y, Float:z, Float:a, kolor1, kolor2, Float:hp, lock)
{
	new id = CreateVehicle(model, x, y, z, a, kolor1, kolor2, -1);
	PlayerInfo[playerid][pPojazd][slot] = id;
	
	if(id < 2000)
	{
		VehicleInfo[id][vUID] = uid;
		VehicleInfo[id][vOwnerType] = OWNER_TYPE_PLAYER;
		VehicleInfo[id][vOwner] = owner;
		VehicleInfo[id][vX] = x;
		VehicleInfo[id][vY] = y;
		VehicleInfo[id][vZ] = z;
		VehicleInfo[id][vAngle] = a;
		VehicleInfo[id][vPrzebieg] = 0;
		VehicleInfo[id][vHP] = hp;
		VehicleInfo[id][vLock] = lock;
		return 1;
	}
	else
	{
		new string[64];
		format(string, sizeof(string), "Nie udalo sie stworzyc pojazdu/przepe³nienie slotów, uid: %d, id: %d", uid, id);
		Error("system_aut.pwn", "MruMySQL_LadujPojazd", string, playerid);
		DestroyVehicle(id);
		return 0;
	}
}

stock FindFreeSlot(playerid)
{
	for(new i; i<MAX_SPAWNED_VEHICLES; i++)
	{
		if(PlayerInfo[playerid][pPojazd][i] == 0)
		{
			return i;
		}
	}
	return -1;
}

//------------------<[ Dialogi: ]>--------------------
public dialog_PanelPojazdow(playerid, dialogid, response, listitem, string:inputtext[])
{
	#pragma unused dialogid, inputtext
	if(response)
	{
		new slot = FindFreeSlot(playerid);
		if(slot != -1)
		{
			if(MruMySQL_LadujPojazd(playerid, listitem, slot))
			{
				ServerInfo(playerid, "Pojazd zespawnowany!");
			}
			else
			{
				ServerError(playerid, "Nie uda³o siê zrespawnowaæ pojazdu!");
			}
		}
		else
		{
			ServerFail(playerid, "Osi¹gn¹³eœ limit zespawnowanych pojazdów, nie mo¿esz zespawnowaæ nastêpnego!");
		}
	}
}

public dialog_SalonKategorie(playerid, dialogid, response, listitem, string:inputtext[])
{
	#pragma unused dialogid
	if(response)
	{
		new nazwa[64];
		format(nazwa, sizeof(nazwa), INCOLOR_LIGHTGREEN"Salon - %s", inputtext);
		Dialog_ShowCallback(playerid, using callback dialog_SalonPojazdy, DIALOG_STYLE_LIST, nazwa, MruMySQL_SalonKategoria(listitem+1), "Wybierz", "Wróæ");
	}
}

public dialog_SalonPojazdy(playerid, dialogid, response, listitem, string:inputtext[])
{
	if(response)
	{
		KupPojazd(playerid, 411, 1, 1);
	}
}

//------------------<[ MySQL: ]>--------------------
stock MruMySQL_StworzPojazd(playerid, model, kolor1, kolor2, Float:x, Float:y, Float:z, Float:a, Float:px, Float:py, Float:pz, Float:pa, Float:hp, lock)
{
	new query[512];
	format(query, sizeof(query), "INSERT INTO `mru_Konta_pojazdy` (`Wlasciciel`, `Model`, `Kolor1`, `Kolor2`, `X`, `Y`, `Z`, `Rotacja`, `Park_X`, `Park_Y`, `Park_Z`, `Park_Rotacja`, `HP`, `Lock`) \ 
		VALUES (%d, %d, %d, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f, %d)", PlayerInfo[playerid][pUID], model, kolor1, kolor2, x, y, z, a, px, py, pz, pa, hp, lock);
	mysql_query(query);
	if(mysql_errno() == 0)
	{
		return 1;
	}
	else
	{
		Error("system_aut.pwn", "MruMySQL_StworzPojazd", query, playerid);
		return 0;
	}
}

stock MruMySQL_LadujPojazd(playerid, nr, slot)
{
	new query[512]; //4096
	format(query, sizeof(query), "SELECT `*` FROM `mru_Konta_pojazdy` WHERE `Owner`='%d' LIMIT %d, 1", PlayerInfo[playerid][pUID], nr-1);
	mysql_query(query);
	mysql_store_result();
	if(mysql_fetch_row_format(query, "|"))
	{
		new uid, owner, model, kolor1, kolor2, Float:x, Float:y, Float:z, Float:a, Float:hp, lock;
		sscanf(query, "p<|>dddddffff{ffff}fd", 
			uid, owner, model, kolor1, kolor2, x, y, z, a, hp, lock
		);
		
		//Tworzenie pojazdu
		return StworzPojazd(playerid, slot, uid, owner, model, Float:x, Float:y, Float:z, Float:a, kolor1, kolor2, Float:hp, lock);
	}
	else
	{
		Error("system_aut.pwn", "MruMySQL_LadujPojazd", query, playerid);
		return 0;
	}
}

stock MruMySQL_ZapiszPojazd(playerid, id)
{
	new query[512];
	format(query, sizeof(query), "UPDATE `mru_konta_pojazdy` SET \
		`X`=%f, \
		`Y`=%f, \
		`Z`=%f, \
		`Rotacja`=%f, \
		`HP`=%f, \
		`Lock`=%f \
		WHERE `ID` = %d",
		VehicleInfo[id][vX], 
		VehicleInfo[id][vY], 
		VehicleInfo[id][vZ],
		VehicleInfo[id][vAngle],
		VehicleInfo[id][vHP],
		VehicleInfo[id][vLock],
		VehicleInfo[id][vUID]
	);
	mysql_query(query);
}

stock MruMySQL_PanelPojazdow(playerid)
{
	new query[512], string[256]; //4096
	format(query, sizeof(query), "SELECT `Model` FROM `mru_Konta_pojazdy` WHERE `Owner`='%d'", PlayerInfo[playerid][pUID]);
	
	mysql_query(query);
	mysql_store_result();
	while (mysql_fetch_row_format(query, "|"))
	{
		new model;
		sscanf(query, "p<|>d", model);
		strcat(string, gVehicleNames[model-400], sizeof(string));
		strcat(string, "\n", sizeof(string));
	}
	mysql_free_result();
	
	safe_return string;
}

stock MruMySQL_Salon()
{
	new string[512], query[128];
	mysql_query("SELECT `Nazwa` FROM `mru_Pojazdy_kategorie`");
	mysql_store_result();
	while (mysql_fetch_row_format(query, "|"))
	{
		new kategoria[32];
		sscanf(query, "p<|>s[32]", kategoria);
		strcat(string, kategoria, sizeof(string));
		strcat(string, "\n", sizeof(string));
	}
	mysql_free_result();
	
	safe_return string;
}

stock MruMySQL_SalonKategoria(kategoria)
{
	new string[1024], query[128];
	format(query, sizeof(query), "SELECT `Nazwa`, `Cena` FROM `mru_Pojazdy` WHERE `Kategoria` = %d", kategoria);
	mysql_query(query);
	mysql_store_result();
	while (mysql_fetch_row_format(query, "|"))
	{
		new pojazd[32], cena;
		sscanf(query, "p<|>s[32]d", pojazd, cena);
		format(string, sizeof(string), "%s%s - %d$\n", string, pojazd, cena);
	}
	mysql_free_result();
	
	safe_return string;
}

stock MruMySQL_PojazdKategoria(kategoria, nr)
{
	new query[128];
	format(query, sizeof(query), "SELECT `ID` FROM `mru_Pojazdy` WHERE `Kategoria` = %d LIMIT %d,1", kategoria, nr-1);
	mysql_query(query);
	mysql_store_result();
	if(mysql_fetch_row_format(query, "|"))
	{
		new id;
		sscanf(query, "p<|>d", id);
		return id;
	}
	else
	{
		Error("system_aut.pwn", "MruMySQL_PojazdKategoria", query, playerid);
	}
}

//-----------------<[ Komendy: ]>-------------------
YCMD:kupauto(playerid, params[], help)
{
	if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	Salon(playerid);
	return 1;
}

YCMD:auto(playerid, params[], help)
{
	if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	PanelPojazdow(playerid);
	return 1;
}

//end