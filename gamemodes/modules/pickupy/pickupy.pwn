//pickupy.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: pickupy.pwn ]--------------------------------------------//
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
stock pickupy_Init()
{
	MruMySQL_LadujPickupy();
	return 1;
}

stock StworzPickup(uid, model, typ, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1, Float:streamdistance = 100.0)
{
	gPickups[gPickupsAmmount][0] = CreateDynamicPickup(model, typ, x, y, z, worldid, interiorid, -1/*playerid*/, streamdistance);
	gPickups[gPickupsAmmount][1] = uid;
	gPickupsAmmount++;
	return 1;
}

//------------------<[ MySQL: ]>--------------------
stock MruMySQL_LadujPickupy()
{
	/*new query[1024];
	mysql_query("SELECT * FROM `system_pickupy`");
	mysql_store_result();
	for(new id = 0; id<mysql_num_rows(); id++)
	{
		if (mysql_fetch_row_format(query, "|"))
		{
			new model, typ, Float:x, Float:y, Float:z, worldid, interiorid, Float:streamdistance;
			sscanf(query, "p<|>{ds[64]}ddfffddf", model, typ, x, y, z, worldid, interiorid, streamdistance);
			
			StworzPickup(id, model, typ, x, y, z, worldid, interiorid, streamdistance);
		}
		else
		{
			Error("mru_mysql", "MruMySQL_LadujPickupy()", "Blad pobierania rekordu");
		}
	}
	mysql_free_result();*/
}

//-----------------<[ Komendy: ]>-------------------

//end