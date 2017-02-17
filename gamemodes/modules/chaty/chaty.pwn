//chaty.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: chaty.pwn ]---------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*
	W razie lagów mo¿na to zoptymalizowaæ by ca³e parsowanie textu by³o w 1 funkcji
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
stock ChatICAdditions(playerid, text[])
{
	new string[256];
	strcat(string, ZamienZnalezioneBindy(playerid, text));
	format(string, sizeof(string), "%s", WykonajEmotki(playerid, string));
	format(string, sizeof(string), "%s", KolorujWstawkiMe(string));
	return string;
}

stock ChatOOCAdditions(playerid, text[])
{
	new string[256]; 
	strcat(string, ZamienZnalezioneBindy(playerid, text));
	return string;
}

stock WykonajEmotki(playerid, text[])
{
	new string[256];
	new emotki[7][] = {
		":)",
		";)",
		":(",
		":D",
		";D",
		"xD",
		":P"
	};
	
	strcat(string, text);
	new bool:brakZamian;
	do
	{
		brakZamian = false;
		for(new i=0; i<sizeof(emotki); i++)
		{
			new pozycjaEmotki = strfind(string, emotki[i]);
			if(pozycjaEmotki != -1)
			{
				defer WyswietlMeEmotki(playerid, i);
				strdel(string, pozycjaEmotki, pozycjaEmotki+strlen(emotki[i]));
				brakZamian = true;
			}
		}
	}
	while(brakZamian);
	return string;
}

timer WyswietlMeEmotki[0](playerid, emotka)
{
	new emotki[7][] = {
		"uœmiecha siê.",
		"puszcza oczko.",
		"zasmuci³ siê.",
		"œmieje siê.",
		"puszcza oczko wpadaj¹c w gromki œmiech.",
		"skis³ ze œmiechu.",
		"wystawia jêzyk."
	};
	Me(playerid, emotki[emotka]);
}

stock KolorujWstawkiMe(text[])
{
	new string[256];
	strcat(string, text);
	new stars = strfind(string, "**");
	if(stars != -1)
	{
		new nextStars = strfind(string, "**", true, stars+2);
		if(nextStars != -1)
		{
			strdel(string, nextStars+2, strlen(string));
			strins(string, INCOLOR_PURPLE, stars);
		}
	}
	return string;
}


//----------< Chaty > --------------
stock Chat(playerid, text[])
{
	if(text[0] =='\0') return 1;
	
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Mówi: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Mówi(w pojeŸdzie): %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE5);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Mówi: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Mówi: %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE5);
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4); //animacja mowy
	}
	ChatLog(playerid, text);
	return 1;
}

stock Krzyk(playerid, text[])
{
	if(text[0] =='\0') return 1;

	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy(w pojeŸdzie): %s!!", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_FADE2);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy: %s!!", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_FADE2);
		//ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4);
	}
	ChatLog(playerid, text);
	return 1;
}

stock Szept(playerid, text[])
{
	if(text[0] =='\0') return 1;
	
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeŸdzie)
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze(w pojeŸdzie): %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE5);
	}
	else
	{ //na zewn¹trz
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze: %s", GetNick(playerid), text);
		RangeMessageGradient(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE5);
		//ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4);
	}
	ChatLog(playerid, text);
	return 1;
}

stock ChatOOC(playerid, text[])
{
	new string[256];
	format(string, sizeof(string), "(( %s ))", text);
	SetPlayerChatBubble(playerid,string, COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
	ChatLog(playerid, string);
	format(string, sizeof(string), "%s [%d] Czat OOC: %s", GetNick(playerid), playerid, string);
    RangeMessageGradient(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE5);
	return 1;
}

stock Me(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "* %s *", text);
	SetPlayerChatBubble(playerid,string, COLOR_PURPLE, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s %s", GetNick(playerid), text);
    RangeMessage(playerid, COLOR_PURPLE, string, zasieg);
	format(string, sizeof(string), "--/me:-- %s", text);
	ChatLog(playerid, string);
	return 1;
}

stock Do(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "** %s **", text);
	SetPlayerChatBubble(playerid,string, COLOR_PURPLE, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s ((%s))", text, GetNick(playerid));
    RangeMessage(playerid, COLOR_PURPLE, string, zasieg);
	format(string, sizeof(string), "--/do:-- %s", text);
	ChatLog(playerid, string);
	return 1;
}

stock PW(playerid, giveplayerid, text[])
{
	new string[256];
	format(string, sizeof(string), "Wiadomoœæ do %s(ID: %d): %s", NICK[giveplayerid], giveplayerid, text);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	format(string, sizeof(string), "%s(ID: %d) wiadomoœæ od: %s", GetNick(playerid), playerid, text);
	SendClientMessage(playerid, COLOR_NEWS, string);
	format(string, sizeof(string), "--PW-- od %s do %s: %s", GetNick(playerid), NICK[giveplayerid], text);
	PWLog(string);
	//dŸwiêk
	PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
	PlayerPlaySound(giveplayerid, 1057, 0.0, 0.0, 0.0);
	return 1;
}

//------------------<[ MySQL: ]>--------------------

//---

//-----------------<[ Komendy: ]>-------------------
YCMD:l(playerid, params[], help)
{ //chat
    if ( help ) return SendClientMessage(playerid, -1, "[POMOC] Podstawowy czat IC (mowa postaci).");
	
	if (isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /l [tekst]");
	
	Chat(playerid, ChatICAdditions(playerid, params));
    return 1;
}

YCMD:k(playerid, params[], help)
{ //krzyk
    if ( help ) return SendClientMessage(playerid, -1, "Podstawowy czat IC (krzyk postaci).");
	
	if (isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /k [tekst]");
	
	Krzyk(playerid, ChatICAdditions(playerid, params));
    return 1;
}

YCMD:s(playerid, params[], help)
{ //szept
    if ( help ) return SendClientMessage(playerid, -1, "Podstawowy czat IC (szept postaci).");
	
	if (isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /s [tekst]");
	
	Szept(playerid, ChatICAdditions(playerid, params));
    return 1;
}

YCMD:b(playerid, params[], help)
{ //szept
    if ( help ) return SendClientMessage(playerid, -1, "Podstawowy czat OOC (wiadomoœæ do graczy woko³o).");
	
	if (isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /b [tekst]");
	
	ChatOOC(playerid, ChatOOCAdditions(playerid, params));
    return 1;
}

YCMD:me(playerid, params[], help)
{ //ja
    if ( help ) return SendClientMessage(playerid, -1, "S³u¿y do opisu czynnoœci które wykonuje postaæ.");
	
	if (isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /me [tekst]");
	
	Me(playerid, ChatOOCAdditions(playerid, params));
    return 1;
}

YCMD:do(playerid, params[], help)
{ //do
    if ( help ) return SendClientMessage(playerid, -1, "S³u¿y do opisu otoczenia, wygl¹du czy sytuacji w jakiej znalaz³a siê nasza postaæ.");
	
	if (isnull(params)) return SendClientMessage(playerid, -1, "U¿ycie: /s [tekst]");
	
	Do(playerid, ChatOOCAdditions(playerid, params));
    return 1;
}

//end