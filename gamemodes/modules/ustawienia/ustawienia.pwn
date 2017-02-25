//ustawienia.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: MODULE_NAME.pwn ]-------------------------------------------//
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
ustawienia_Init()
{
	ustawienia_LoadCommands();
}

stock Ustawienia(playerid)
{
	inline iSettings(pid, dialogid, response, listitem, string:inputtext[])
	{
		new bitlist;
		#pragma unused pid, dialogid, inputtext
		inline iDialog1(pid1, dialogid1, response1, listitem1, string:inputtext1[])
		{
			#pragma unused pid1, dialogid1, inputtext1
			inline iDialog2(pid2, dialogid2, response2, listitem2, string:inputtext2[])
			{
				#pragma unused pid2, dialogid2, inputtext2
				inline iDialog3(pid3, dialogid3, response3, listitem3, string:inputtext3[])
				{
					#pragma unused pid3, dialogid3, listitem3
					if(response3)
					{
						switch(listitem2)
						{
							case 0:
							{
								new liczba = strval(inputtext3);
								if(liczba <= 127)
									PlayerInfo[playerid][pDoorKey] = (liczba<<7)+(PlayerInfo[playerid][pDoorKey]&0b00000001111111);
								else
									ServerFail(playerid, "Liczba max 127 znaków");
							}
							case 1:
							{
								new liczba = strval(inputtext3);
								if(liczba <= 127)
									PlayerInfo[playerid][pDoorKey] = liczba+(PlayerInfo[playerid][pDoorKey]&0b11111110000000);
								else
									ServerFail(playerid, "Liczba max 127 znaków");
							}
						}
					}
					new string[80];
					format(string, sizeof(string), "OpóŸnienie przed wejœciem: %ds\nOpóŸnienie po wejœciu: %ds", (PlayerInfo[playerid][pDoorKey]&0b11111110000000)>>>7, PlayerInfo[playerid][pDoorKey]&0b00000001111111);
					Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, "Ustawienia drzwi -> na pickup", string, "Ustaw", "Wróæ");
				}
				//dialog 2a
				if(response2)
				{
					switch(listitem1)
					{
						case 0:
						{
							PlayerInfo[playerid][pDoorKey] = 0;
							StartGettingKeys(playerid, "ustawienia_DoorKeys");
						}
						case 1:
						{
							switch(listitem2)
							{
								case 0:
								{
									Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, "Ustawienia drzwi -> na pickup", "Wpisz wartoœæ opóŸnienia przed wejœciem w sekundach (max 127):", "Ustaw", "Wróæ");
								}
								case 1:
								{
									Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, "Ustawienia drzwi -> na pickup", "Wpisz wartoœæ opóŸnienia po wejœciu w sekundach (max 127):", "Ustaw", "Wróæ");
								}
							}
						}
					}
				}
				else//nie response dialog 2
				{
					Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, "Ustawienia drzwi", CreateColouredBitsText(0b111, PlayerInfo[playerid][pDoorSettings], "{FFFFFF}", "{00FF00}", "Klawisz", "Pickup", "Komenda"), "Ustaw", "Wróæ");
				}
			}
			//Dialog 1
			if(response1)
			{	
				switch(listitem)
				{
					case 0:
					{
						PlayerInfo[playerid][pSpawn] = CheckBitPos(bitlist, listitem1);
						Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, "Ustawienia spawnu", CreateColouredBitsText(bitlist, PlayerInfo[playerid][pSpawn], "{FFFFFF}", "{00FF00}", "Spawn cywila (hotel)", "Spawn pracy", "Spawn frakcyjny", "Spawn organizacji", "Spawn w domu", "Inny spawn"), "Ustaw", "Wróæ");
					}
					case 1:
					{
						switch(listitem1)
						{
							case 0:
							{
								if(PlayerInfo[playerid][pDoorSettings] != 0)
									PlayerInfo[playerid][pDoorKey] = KEY_CROUCH;
								PlayerInfo[playerid][pDoorSettings] = listitem1;
								new string[1024];
								format(string, sizeof(string), "Mo¿esz ustaliæ, jaki klawisz ma odpowiadaæ za wchodzenie i wychodzenie z interiorów!\nJe¿eli klikniesz \"Ustaw\", przejdziesz do trybu który wykryje naciœniête klawisze.\nMo¿esz ³¹czyæ klawisze w kombinacje 2, 3 a nawet 4 klawiszy.\nGdy system wykryje naciœniête klawisze, zostaniesz spytany o to, czy zosta³y one poprawnie zweryfikowane.\n");
								format(string, sizeof(string), "%sAktualna kombinacja klawiszy: %s", string, GetKeysName(PlayerInfo[playerid][pDoorKey]));
								Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_MSGBOX, "Ustawienia drzwi -> na klawisz", string, "Ustaw", "Wróæ");
							}
							case 1:
							{
								if(PlayerInfo[playerid][pDoorSettings] != 1)
									PlayerInfo[playerid][pDoorKey] = 0b00100001010;
								PlayerInfo[playerid][pDoorSettings] = listitem1;
								new string[80];
								format(string, sizeof(string), "OpóŸnienie przed wejœciem: %ds\nOpóŸnienie po wejœciu: %ds", (PlayerInfo[playerid][pDoorKey]&0b11111110000000)>>>7, PlayerInfo[playerid][pDoorKey]&0b00000001111111);
								Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, "Ustawienia drzwi -> na pickup", string, "Ustaw", "Wróæ");
							}
							case 2:
							{
								PlayerInfo[playerid][pDoorSettings] = listitem1;
								Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, "Ustawienia drzwi", CreateColouredBitsText(0b111, PlayerInfo[playerid][pDoorSettings], "{FFFFFF}", "{00FF00}", "Klawisz", "Pickup", "Komenda (/wejdz i /wyjdz)"), "Ustaw", "Wróæ");
							}
						}
					}
				}
			}
			else
			{
				Dialog_ShowCallback(playerid, using inline iSettings, DIALOG_STYLE_LIST, "Ustawienia", "Spawn\nDrzwi", "Wybierz", "WyjdŸ");
			}
		}
		//iSettings 0
		if(response)
		{
			switch(listitem)
			{
				case 0://Spawn
				{
					bitlist = CreateBits( 1, (PlayerInfo[playerid][pPraca]!=0), (PlayerInfo[playerid][pFrakcja]!=BRAK_FRAKCJI), (PlayerInfo[playerid][pOrganizacja]!=BRAK_FRAKCJI), (PlayerInfo[playerid][pDom]>0), (PlayerInfo[playerid][pSpawn] == 4) );
					Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, "Ustawienia spawnu", CreateColouredBitsText(bitlist, PlayerInfo[playerid][pSpawn], "{FFFFFF}", "{00FF00}", "Spawn cywila (hotel)", "Spawn pracy", "Spawn frakcyjny", "Spawn organizacji", "Spawn w domu", "Inny spawn"), "Ustaw", "Wróæ");
				}
				case 1://Drzwi (wejdŸ/wyjdŸ)
				{
					Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, "Ustawienia drzwi (wejdŸ/wyjdŸ)", CreateColouredBitsText(0b111, PlayerInfo[playerid][pDoorSettings], "{FFFFFF}", "{00FF00}", "Klawisz", "Pickup", "Komenda (/wejdz i /wyjdz)"), "Ustaw", "Wróæ");
				}
			}
		}
	}
	
	Dialog_ShowCallback(playerid, using inline iSettings, DIALOG_STYLE_LIST, "Ustawienia", "Spawn\nDrzwi (wyjdŸ/wejdŸ)", "Wybierz", "WyjdŸ");
}

public ustawienia_DoorKeys(playerid)
{
	inline iDialog(pid, dialogid, response, listitem, string:inputtext[])
	{
		#pragma unused pid, dialogid, inputtext, listitem
		if(response)
		{
			PlayerInfo[playerid][pDoorKey] = GetPVarInt(playerid, "PobraneKlawisze");
			ServerGoodInfoF(playerid, "Pomyœlnie ustawiono klawisze wejœcia na: %s", GetKeysName(PlayerInfo[playerid][pDoorKey]));
			Command_ReProcess(playerid, "ustawienia", false) ;
		}
		else
		{
			ServerBadInfo(playerid, "Wybra³eœ: nie. Ponawiam procedurê");
			SetPVarInt(playerid, "PobraneKlawisze", 0);
			StartGettingKeys(playerid, "ustawienia_DoorKeys");
		}
	}
	new string[128];
	format(string, sizeof(string), "Czy kombinacja klawiszy lub klawisz:\n%s\nzgadza siê z twoim oczekiwaniami?", GetKeysName(GetPVarInt(playerid, "PobraneKlawisze")));
	Dialog_ShowCallback(playerid, using inline iDialog, DIALOG_STYLE_MSGBOX, "Ustawienia drzwi -> na klawisz", string, "Tak", "Nie");
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
ustawienia_LoadCommands()
{
	Command_AddAlt(YCMD:ustawienia, "settings");
	Group_SetCommand(LoggedPlayers, YCMD:ustawienia, true);
}

YCMD:ustawienia(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "Pod t¹ komend¹ mo¿esz modyfikowaæ wszystkie dostêpne ustawienia swojego konta.");
	
	//Cia³o komendy
	Ustawienia(playerid);
	return 1;
}

/*YCMD:spawn(playerid, params[], help)
{
    if ( help ) return SendClientMessage(playerid, -1, "pierdu pierdu.");
	
	new list;
	inline iSpawn(u, u2, responseS, listitemS, string:u3[])
	{
		#pragma unused u, u2, u3
		if(responseS)
		{	
			PlayerInfo[playerid][pSpawn] = CheckBitPos(list, listitemS);
			
			Dialog_ShowCallback(playerid, using inline iSpawn, DIALOG_STYLE_LIST, "Ustawienia spawnu", CreateColouredBitsText(list, PlayerInfo[playerid][pSpawn], "{FFFFFF}", "{00FF00}", "Spawn cywila (hotel)", "Spawn frakcyjny", "Spawn organizacji", "Spawn w domu", "Inny spawn"), "Ustaw", "Wróæ");
		}
	}
	list = CreateBits( 1, (PlayerInfo[playerid][pFrakcja]>BRAK_FRAKCJI), (PlayerInfo[playerid][pOrganizacja]>BRAK_FRAKCJI), (PlayerInfo[playerid][pDom]>0), (PlayerInfo[playerid][pSpawn] == 4) );
	Dialog_ShowCallback(playerid, using inline iSpawn, DIALOG_STYLE_LIST, "Ustawienia spawnu", CreateColouredBitsText(list, PlayerInfo[playerid][pSpawn], "{FFFFFF}", "{00FF00}", "Spawn cywila (hotel)", "Spawn frakcyjny", "Spawn organizacji", "Spawn w domu", "Inny spawn"), "Ustaw", "Wróæ");
    return 1;
}*/


//end