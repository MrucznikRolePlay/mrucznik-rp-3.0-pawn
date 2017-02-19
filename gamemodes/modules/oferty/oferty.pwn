//oferty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//-----------------------------------------[ Modu³: oferty.pwn ]---------------------------------------------//
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
stock Offer(playerid, giveplayerid, offerid, price)
{
	if(giveplayerid == playerid) 
	{
		ServerFail(playerid, "Nie mo¿esz z³o¿yæ oferty sam sobie!");
		//return 1;
	}
	if(oferta[giveplayerid] == OFERTA_BRAK)
	{
		oferta[giveplayerid] = offerid;
		oferta_gracz[giveplayerid] = playerid;
		oferta_cena[giveplayerid] = price;
		oferta_timer[giveplayerid] = SetTimerEx("timer_Oferta", 60000, 0, "d", playerid);
		switch(offerid)
		{
			case OFERTA_NAPRAWA:
			{
				new string[128];
				format(string, sizeof(string), "~y~Oferta od gracza: ~w~%s ~>~ Naprawa~n~~y~Szczegoly:~w~ Naprawa pojazdu ~r~sultan~n~~y~Koszt: ~w~%d$", GetNick(playerid), price);
				ShowOfferTextDraw(giveplayerid, string);
			}
			case 2:
			{
				
			}
			default:
			{
				new idinfo[32];
				format(idinfo, sizeof(idinfo), "Zle id oferty: %d", oferta[giveplayerid]);
				Error("oferty", "Offer()", idinfo, playerid);
				return 0;
			}
		}
		SelectTextDraw(playerid, COLOR_NEWS);
	}
	else
	{
		ServerFail(playerid, "Ten gracz ma ju¿ z³o¿on¹ ofertê, odczekaj chwilê zanim z³o¿ysz mu nastêpn¹.");
	}
	return 1;
}

stock OfferDecision(playerid, bool:choice)
{
	if(choice)
	{
		new giveplayerid = oferta_gracz[playerid];
		if(IsPlayerConnected(giveplayerid) && IsPlayerLogged(playerid))
		{
			if(IsPlayerInRangeToPlayer(playerid, giveplayerid))
			{
				switch(oferta[playerid])
				{
					case OFERTA_NAPRAWA:
					{
						
					}
					default:
					{
						new idinfo[32];
						format(idinfo,sizeof(idinfo), "Zle id oferty: %d", oferta[playerid]);
						Error("oferty", "OfferDecision()", idinfo, playerid);
						return 0;
					}
				}
				DeleteOffer(playerid);
			}
			else
			{
				ServerFail(playerid, "Jesteœ zbyt daleko od gracza, który z³o¿y³ ci ofertê");
			}
		}
		else
		{
			ServerFail(playerid, "Gracz oferuj¹cy wyszed³ z gry, oferta przepada, nie mo¿na akcepotwa³.");
			DeleteOffer(playerid);
		}
	}
	else
	{
		new giveplayerid = oferta_gracz[playerid];
		DeleteOffer(playerid);
		ServerInfoF(playerid, "Odrzucono ofertê od gracza %s.", GetNick(giveplayerid));
		ServerInfoF(giveplayerid, "Gracz %s odrzuci³ twoj¹ ofertê!", GetNick(playerid));
	}
	return 1;
}

stock DeleteOffer(playerid)
{
	oferta_gracz[playerid] = INVALID_PLAYER_ID;
	oferta[playerid] = OFERTA_BRAK;
	oferta_cena[playerid] = 0;
	if(oferta_timer[playerid] != -1) 
	{
		KillTimer(oferta_timer[playerid]);
		oferta_timer[playerid] = -1;
	}
	if(IsPlayerConnected(playerid))
	{
		CancelSelectTextDraw(playerid);
		PlayerTextDrawHide(playerid, offer_textdraw[playerid]);
		TextDrawHideForPlayer(playerid, offer_button[0]);
		TextDrawHideForPlayer(playerid, offer_button[1]);
	}
}


public timer_Oferta(playerid)
{
	oferta_timer[playerid] = -1;
	DeleteOffer(playerid);
}

stock ShowOfferTextDraw(playerid, text[])
{
	PlayerTextDrawSetString(playerid, offer_textdraw[playerid], text);
	PlayerTextDrawShow(playerid, offer_textdraw[playerid]);
	TextDrawShowForPlayer(playerid, offer_button[0]);
	TextDrawShowForPlayer(playerid, offer_button[1]);
	return 1;
}

stock oferty_LoadPlayerTextDraws(playerid)
{
	/*"~y~Oferta od gracza: ~w~Patrick Rogers ~>~ Pojazd~n~~n~~y~Nazwa: ~w~Admiral~n~~y~Koszt: ~w~4000$"*/
	offer_textdraw[playerid] = CreatePlayerTextDraw(playerid, 183.750000, 310.0, " ");
	PlayerTextDrawLetterSize(playerid, offer_textdraw[playerid], 0.336874, 1.500833);
	PlayerTextDrawTextSize(playerid, offer_textdraw[playerid], 469.375000, -9.916666);
	PlayerTextDrawAlignment(playerid, offer_textdraw[playerid], 1);
	PlayerTextDrawColor(playerid, offer_textdraw[playerid], -1);
	PlayerTextDrawUseBox(playerid, offer_textdraw[playerid], true);
	PlayerTextDrawBoxColor(playerid, offer_textdraw[playerid], 70);
	PlayerTextDrawSetShadow(playerid, offer_textdraw[playerid], 0);
	PlayerTextDrawSetOutline(playerid, offer_textdraw[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, offer_textdraw[playerid], 51);
	PlayerTextDrawFont(playerid, offer_textdraw[playerid], 1);
	PlayerTextDrawSetProportional(playerid, offer_textdraw[playerid], 1);
	return 1;
}

stock oferty_LoadTextDraws()
{
	offer_button[0] = TextDrawCreate(382.500000, 354.0, "~g~Akceptuj");
	TextDrawLetterSize(offer_button[0], 0.296874, 1.244165);
	TextDrawTextSize(offer_button[0], 8.125000, 50.749996);
	TextDrawAlignment(offer_button[0], 2);
	TextDrawColor(offer_button[0], -1);
	TextDrawUseBox(offer_button[0], true);
	TextDrawBoxColor(offer_button[0], 255);
	TextDrawSetShadow(offer_button[0], 0);
	TextDrawSetOutline(offer_button[0], 1);
	TextDrawBackgroundColor(offer_button[0], 51);
	TextDrawFont(offer_button[0], 1);
	TextDrawSetProportional(offer_button[0], 1);
	TextDrawSetSelectable(offer_button[0], 1);  

	offer_button[1] = TextDrawCreate(439.750000, 354.0, "~r~Odrzuc");
	TextDrawLetterSize(offer_button[1], 0.296874, 1.244165);
	TextDrawTextSize(offer_button[1], 8.125000, 50.749996);
	TextDrawAlignment(offer_button[1], 2);
	TextDrawColor(offer_button[1], -1);
	TextDrawUseBox(offer_button[1], true);
	TextDrawBoxColor(offer_button[1], 255);
	TextDrawSetShadow(offer_button[1], 0);
	TextDrawSetOutline(offer_button[1], 1);
	TextDrawBackgroundColor(offer_button[1], 51);
	TextDrawFont(offer_button[1], 1);
	TextDrawSetProportional(offer_button[1], 1);
	TextDrawSetSelectable(offer_button[1], 1);  
	
	return 1;
}

stock oferty_DeletePlayerTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, offer_textdraw[playerid]);
}

stock oferty_DeleteTextDraws()
{
	TextDrawDestroy(offer_button[0]);
	TextDrawDestroy(offer_button[1]);
}

oferty_OnPlayerDisconnect(playerid)
{
	if(oferta_gracz[playerid] != INVALID_PLAYER_ID)
	{
		ServerInfo(oferta_gracz[playerid], "Gracz, któremu z³o¿y³eœ ofertê opuœci³ serwer.");
		DeleteOffer(playerid);
	}
    foreach(new i : GroupMember(LoggedPlayers))
	{
		if(oferta_gracz[i] == playerid)
		{
			DeleteOffer(i);
			ServerInfo(i, "Gracz sk³adaj¹cy ofertê opuœci³ serwer.");
			break;
		}
	}
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
YCMD:oferta(playerid, params[], help)
	return Offer(playerid, playerid, OFERTA_NAPRAWA, 10000);	

//end