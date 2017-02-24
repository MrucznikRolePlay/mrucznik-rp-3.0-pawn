//3dtexty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: 3dtexty.pwn ]--------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*
	TODO:
	Stworz3DText body
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
	return 1;
}

stock Stworz3DText(uid, text[], color, Float:x, Float:y, Float:z, Float:drawdistance, testlos = 0, worldid = -1, interiorid = -1, Float:streamdistance = 100.0)
{
	return 1;
}

stock CreateDiconnect3DText(playerid, reason)
{
	new Float:x, Float:y, Float:z, Float:hp, int, vw, text[258], reasonText[32];
	new year,month,day,hour,minute,second;
	GetPlayerHealth(playerid, hp);
	GetPlayerPos(playerid, x, y, z);
	int = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	getdate(year, month, day);
	gettime(hour, minute, second);
	switch (reason)
	{
		case 0:
		{
			strcat(reasonText, "dosta³ crash'a");
		}
		case 2:
		{
			strcat(reasonText, "zosta³ wyrzucony z gry");
		}
		default:
		{
			strcat(reasonText, "wyszed³ z gry");
		}
	}
	
	format(text, sizeof(text), "%s %s\nHP: %.1f\nData: %02d/%02d/%d %02d:%02d:%02d", GetNick(playerid), reasonText, hp, day, month, year, hour, minute, second);
	
	if(Disconnect3DText[playerid] != Text3D:INVALID_3DTEXT_ID)
		DestroyDynamic3DTextLabel_Clear(Disconnect3DText[playerid]);
		
	Disconnect3DText[playerid] = CreateDynamic3DTextLabel( text, COLOR_GREY, x, y, z, 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, false, vw, int);
	
	defer Destroy3DTextTimer(playerid);
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

//-----------------<[ Komendy: ]>-------------------

//end