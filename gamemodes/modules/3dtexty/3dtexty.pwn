//3dtexty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: 3dtexty.pwn ]--------------------------------------------//
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
stock texty3d_Init()
{
	MruMySQL_Laduj3DTexty();
	return 1;
}

stock Stworz3DText(uid, text[], color, Float:x, Float:y, Float:z, Float:drawdistance, testlos = 0, worldid = -1, interiorid = -1, Float:streamdistance = 100.0)
{
	return 1;
}

stock CreateDiconnect3DText(playerid, reason)
{
	new Float:x, Float:y, Float:z, Float:hp, int, vw, text[128];
	GetPlayerHealth(playerid, hp);
	GetPlayerPos(playerid, x, y, z);
	int = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	switch (reason)
	{
		case 0:
		{
			format(text, sizeof(text), "%s dosta³ crasha\nHP: %.1f", GetNick(playerid), hp);
		}
		case 2:
		{
			format(text, sizeof(text), "%s zosta³ wyrzucony z gry\nHP: %.1f", GetNick(playerid), hp);
		}
		default:
		{
			format(text, sizeof(text), "%s wyszed³ z gry\nHP: %.1f", GetNick(playerid), hp);
		}
	}
	if(Disconnect3DText[playerid] != Text3D:INVALID_3DTEXT_ID)
		DestroyDynamic3DTextLabel_Clear(Disconnect3DText[playerid]);
		
	Disconnect3DText[playerid] = CreateDynamic3DTextLabel( text, COLOR_GREY, x, y, z, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, false, vw, int);
	
	defer Destroy3DTextTimer(Disconnect3DText[playerid]);
	return 1;
}

timer Destroy3DTextTimer[30000](playerid)
{
	if(Disconnect3DText[playerid] != Text3D:INVALID_3DTEXT_ID)
		DestroyDynamic3DTextLabel_Clear(Disconnect3DText[playerid]);
}

stock DestroyDynamic3DTextLabel_Clear(&Text3D:id)
{
	if(id != Text3D:INVALID_3DTEXT_ID)
	{
		DestroyDynamic3DTextLabel(id);
		id = Text3D:INVALID_3DTEXT_ID;
		return 1;
	}
	return 0;
}

//------------------<[ MySQL: ]>--------------------
stock MruMySQL_Laduj3DTexty()
{
	/*new query[1024];
	mysql_query("SELECT * FROM `system_3dtexty`");
	mysql_store_result();
	for(new id = 0; id<mysql_num_rows(); id++)
	{
		if (mysql_fetch_row_format(query, "|"))
		{
			new text[256], color, x, y, z, drawdistance, testlos, worldid, interiorid, streamdistance;
			sscanf(query, "p<|>{ds[64]}s[256]dfffflddf", text, color, x, y, z, drawdistance, testlos, worldid, interiorid, streamdistance);
			
			Stworz3DText(id, text, color, x, y, z, drawdistance, testlos, worldid, interiorid, streamdistance);
		}
		else
		{
			Error("mru_mysql", "MruMySQL_Laduj3DTexty()", "Blad pobierania rekordu");
		}
	}
	mysql_free_result();*/
}

//-----------------<[ Komendy: ]>-------------------

//end