//textdrawy.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Modu³: textdrawy.pwn ]-------------------------------------------//
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

//----------------<[ Callbacki: ]>------------------
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == offer_button[0])
	{
		OfferDecision(playerid, true);
		PlayerPlaySound(playerid,1083,0.0,0.0,0.0);
	}
	else if(clickedid == offer_button[1])
	{
		OfferDecision(playerid, false);
		PlayerPlaySound(playerid,1084,0.0,0.0,0.0);
	}
    return 1;
}


//-----------------<[ Funkcje: ]>-------------------

//-------- Tworzenie
stock LoadWelcomeScreenTxD()
{
	textdraw_upbar = Text:TextDrawCreate(320.000000, 0.000000, "~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawUseBox(textdraw_upbar, 1);
	TextDrawBoxColor(textdraw_upbar, 0x000000FF);
	TextDrawTextSize(textdraw_upbar, 640.000000, 640.000000);
	TextDrawAlignment(textdraw_upbar, 2);

	textdraw_downbar = Text:TextDrawCreate(320.000000, 360.000000, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawUseBox(textdraw_downbar, 1);
	TextDrawBoxColor(textdraw_downbar, 0x000000FF);
	TextDrawTextSize(textdraw_downbar, 640.000000, 640.000000);
	TextDrawAlignment(textdraw_downbar, 2);
	return 1;
}

//-------- Niszczenie
stock DestroyWelcomeScreenTxD()
{
	TextDrawDestroy(textdraw_upbar);
	TextDrawDestroy(textdraw_downbar);
}

//-------- Pokazywanie
stock ShowWelcomeScreenTextdraw(playerid)
{
	TextDrawShowForPlayer(playerid,textdraw_upbar);
	TextDrawShowForPlayer(playerid,textdraw_downbar);
	return 1;
}

//-------- Chowanie
stock HideWelcomeScreenTextdraw(playerid)
{
	TextDrawHideForPlayer(playerid, textdraw_upbar);
    TextDrawHideForPlayer(playerid, textdraw_downbar);
	return 1;
}

//-------- £adowanie textdrawów
textdrawy_Init()
{
	LoadWelcomeScreenTxD();
	
	//z innych modu³ów
	oferty_LoadTextDraws(); //Textdrawy ofert
	return 1;
}

textdrawy_Exit()
{
	DestroyWelcomeScreenTxD();
	
	//z innych modu³ów
	oferty_DeleteTextDraws(); //Textdrawy ofert
	return 1;
}

//-[playertext:]-
LadujPlayerTextdrawy(playerid)
{
	//z innych modu³ów
	oferty_LoadPlayerTextDraws(playerid); //Textdrawy ofert
	return 1;
}

UsunPlayerTextdrawy(playerid)
{
	
	//z innych modu³ów
	oferty_DeletePlayerTextDraws(playerid); //Textdrawy ofert
	return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end