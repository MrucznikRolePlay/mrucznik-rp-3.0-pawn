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
	MruMySQL_LoadVehicleTypes();
	MruMySQL_LoadVehicles();
	return 1;
}

stock pojazdy_Exit()
{
	MruMySQL_SaveVehicles();
	return 1;
}

stock ShowVehicleTypes(playerid, sterownik)
{
	new string[32];
	
	safe_return string;
}

stock ShowVehiclesForType(playerid, typ, sterownik)
{
	new string[256];
	safe_return string;
}

//-----------------------------------------------------STARE-----------------------------------------------------
/*stock PanelPojazdow(playerid)
{
	/Dialog_ShowCallback(playerid, using callback dialog_PanelPojazdow, DIALOG_STYLE_LIST, INCOLOR_LIGHTGREEN"Panel pojazdow", MruMySQL_PanelPojazdow(playerid), "Wybierz", "Wróæ");
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
}*/

//------------------<[ Dialogi: ]>--------------------
/*public dialog_PanelPojazdow(playerid, dialogid, response, listitem, string:inputtext[])
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
		//Dialog_ShowCallback(playerid, using callback dialog_SalonPojazdy, DIALOG_STYLE_LIST, nazwa, MruMySQL_SalonKategoria(listitem+1), "Wybierz", "Wróæ");
	}
}

public dialog_SalonPojazdy(playerid, dialogid, response, listitem, string:inputtext[])
{
	if(response)
	{
		KupPojazd(playerid, 411, 1, 1);
	}
}
*/
//------------------<[ MySQL: ]>--------------------

stock MruMySQL_LoadVehicleTypes()
{	
	/*inline iQuery()
	{
		new rows = cache_get_row_count(gMySQL);
		if(rows <= MAX_CATEGORIES)
		{
			for(new i; i<rows; i++)
			{
				cache_get_row(i, 0, VehCatName[i], gMySQL, MAX_VEHCATEGORY_NAME);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow kategorii pojazdow do tabeli "TABLE_VEHICLES_CATEGORY, rows);
		}
		else
		{
			Error("system_aut", "MruMySQL_LoadVehicleTypes()", "Ilosc zaladowanych kategorii wieksza niz maksymalna liczba kategorii.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT `Nazwa` FROM `"TABLE_VEHICLES_CATEGORY"` ORDER BY `ID` ASC", using inline iQuery, "");*/
	return 1;
}

stock MruMySQL_LoadVehicles()
{
	/*inline iQuery()
	{
		new rows = cache_get_row_count(gMySQL);
		if(rows <= VEHICLE_MODELS)
		{
			//212 pojazdów
			for(new i; i<rows; i++)
			{
				cache_get_row(i, 1, VehicleInfo[i][Nazwa], gMySQL, MAX_VEHICLE_NAME);
				VehicleInfo[i][Kategoria] = cache_get_row_int(i, 2, gMySQL);
				VehicleInfo[i][Cena] = cache_get_row_int(i, 3, gMySQL);
				VehicleInfo[i][Bak] = cache_get_row_int(i, 4, gMySQL);
				VehicleInfo[i][Spalanie] = cache_get_row_float(i, 5, gMySQL);
				Iter_Add(VehCat[VehicleInfo[i][Kategoria]], i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o pojazdach do tabeli "TABLE_VEHICLES, rows);
		}
		else
		{
			Error("system_aut", "MruMySQL_LoadVehicleTypes()", "Ilosc zaladowanych pojazdow wieksza niz maksymalna liczba pojazdow.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_VEHICLES"` ORDER BY `ID` ASC", using inline iQuery, "");*/
	return 1;
}

stock MruMySQL_SaveVehicles()
{
	/*new query[64];
	for(new i; i<VEHICLE_MODELS; i++)
	{
		format(query, sizeof(query), "UPDATE `"TABLE_VEHICLES"` SET `Cena`='%q'", VehicleInfo[i][Cena]);
		mysql_pquery(gMySQL, query);
	}
	printf("MySQL: Poprawnie zapisano informacje o pojazdach w tabeli "TABLE_VEHICLES);*/
}

stock MruMySQL_LoadCarShowrooms()
{
	//Na podstawie danych z tabeli game_pojazdy tworzy liste pojazdow dla danych kategorii (kategorie nazywaja sie numerycznie w mapie) - done
	//Na podstawie danych z tabeli game_pojazdy_salony tworzy salony (wymagany system interiorów/budynków
	//Na podstawie danych z tabeli game_pojazdy_salony_pojazdy tworzy sterownik bitowy które pojazdy w danej kategorii moze sprzedawac salon
}

//-----------------<[ Komendy: ]>-------------------
/*YCMD:kupauto(playerid, params[], help)
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
}*/

//end