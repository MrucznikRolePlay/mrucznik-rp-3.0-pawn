//keybindy.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: keybindy.pwn ]------------------------------------------//
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
keybindy_Init()
{
	keybindy_LoadCommands();
}

// ----[ Dialogi ]----
PanelKeybindow(playerid)
{
	new opcja=0;
	new numer=0;
	new slot=0;

	// --------------- G³ówne ---------------
	inline iKeybindy(pid, dialogid, response, listitem, string:inputtext[])
	{
		// --------------- Nale¿¹ce do iKeybindy ---------------
		#pragma unused pid, dialogid, inputtext
		inline iNumer(pid1, dialogid1, response1, listitem1, string:inputtext1[])
		{
			// --------------- Nale¿¹ce do iNumer (argumenty) ---------------
			#pragma unused pid1, dialogid1, inputtext1
			inline iWyborARG(pid2, dialogid2, response2, listitem2, string:inputtext2[])
			{
				// --------------- Nale¿¹ce do iWybor ---------------
				#pragma unused pid2, dialogid2, inputtext2
				inline iEdytor(pid3, dialogid3, response3, listitem3, string:inputtext3[])
				{
					#pragma unused pid3, dialogid3, listitem3
					if(response3)
					{
						StworzARGBind(playerid, numer, inputtext3);
						Dialog_ShowCallback(playerid, using inline iNumer, DIALOG_STYLE_LIST, TytulArgumentow(numer), ListaArgumentow(playerid), "Wybierz", "Wróæ");
					}
					else
					{
						Dialog_ShowCallback(playerid, using inline iWyborARG, DIALOG_STYLE_LIST, TytulArgumentow(numer), "Edytuj\nUsun", "Wybierz", "Wróæ");
					}
				}
				
				// --------------- Nale¿y do iWyborARG ---------------
				inline iUsun(pid3, dialogid3, response3, listitem3, string:inputtext3[])
				{
					#pragma unused pid3, dialogid3, inputtext3, listitem3
					if(response3)
					{
						UsunARGBind(playerid, numer);
						Dialog_ShowCallback(playerid, using inline iNumer, DIALOG_STYLE_LIST, TytulArgumentow(numer), ListaArgumentow(playerid), "Wybierz", "Wróæ");
					}
					else
					{
						Dialog_ShowCallback(playerid, using inline iWyborARG, DIALOG_STYLE_LIST, TytulArgumentow(numer), "Edytuj\nUsun", "Wybierz", "Wróæ");
					}
				}
				
				//iWybor
				if(response2)
				{
					switch(listitem2)
					{
						case 0:
						{
							Dialog_ShowCallback(playerid, using inline iEdytor, DIALOG_STYLE_INPUT, TytulArgumentow(numer), "Wpisz tekst, który ma zostaæ podstawiony pod argument (maksymalnie 255 znaków).", "Wybierz", "Wróæ");
						}
						case 1:
						{
							new string[64];
							format(string, sizeof(string), "Czy na pewno chcesz usun¹æ zawartoœæ argumentu #%d ?", numer); 
							Dialog_ShowCallback(playerid, using inline iUsun, DIALOG_STYLE_MSGBOX, TytulArgumentow(numer), string, "Tak", "Nie");
						}
					}
				}
				else
				{
					Dialog_ShowCallback(playerid, using inline iNumer, DIALOG_STYLE_LIST, TytulArgumentow(numer), ListaArgumentow(playerid), "Wybierz", "Wróæ");
				}
			}
			
			// --------------- Nale¿y do iNumer (Komendy) ---------------
			inline iWyborSlota(pid2, dialogid2, response2, listitem2, string:inputtext2[])
			{
				#pragma unused pid2, dialogid2, inputtext2
				// --------------- Nale¿y do iWyborSlota ---------------
				inline iWyborCMD(pid3, dialogid3, response3, listitem3, string:inputtext3[])
				{
					#pragma unused pid3, dialogid3, inputtext3
					// --------------- Nale¿y do iWyborCMD ---------------
					inline iEdytor(pid4, dialogid4, response4, listitem4, string:inputtext4[])
					{
						#pragma unused pid4, dialogid4, listitem4
						if(response4)
						{
							StworzCMDBind(playerid, numer, slot, inputtext4);
							Dialog_ShowCallback(playerid, using inline iWyborSlota, DIALOG_STYLE_LIST, TytulKomend(numer), ListaKomendSlot(playerid, numer), "Dalej", "Wróæ");
						}
						else
						{
							Dialog_ShowCallback(playerid, using inline iWyborCMD, DIALOG_STYLE_LIST, TytulKomend(numer), "Edytuj\nUsun", "Wybierz", "Wróæ");
						}
					}
					
					// --------------- Nale¿y do iWyborCMD ---------------
					inline iUsun(pid4, dialogid4, response4, listitem4, string:inputtext4[])
					{
						#pragma unused pid4, dialogid4, inputtext4, listitem4
						if(response4)
						{
							UsunCMDBind(playerid, numer, slot);
							Dialog_ShowCallback(playerid, using inline iWyborSlota, DIALOG_STYLE_LIST, TytulKomend(numer), ListaKomendSlot(playerid, numer), "Dalej", "Wróæ");
						}
						else
						{
							Dialog_ShowCallback(playerid, using inline iWyborCMD, DIALOG_STYLE_LIST, TytulArgumentow(numer), "Edytuj\nUsun", "Wybierz", "Wróæ");
						}
					}
					
					//iWyborCMD
					if(response3)
					{
						switch(listitem3)
						{
							case 0:
							{
								Dialog_ShowCallback(playerid, using inline iEdytor, DIALOG_STYLE_INPUT, TytulArgumentow(numer), "Wpisz tekst, który ma zostaæ podstawiony pod argument (maksymalnie 255 znaków).", "Wybierz", "Wróæ");
							}
							case 1:
							{
								new string[64];
								format(string, sizeof(string), "Czy na pewno chcesz usun¹æ zawartoœæ slotu %d komendy /%d ?", slot, numer); 
								Dialog_ShowCallback(playerid, using inline iUsun, DIALOG_STYLE_MSGBOX, TytulKomend(numer), string, "Tak", "Nie");
							}
						}
					}
					else
					{
						Dialog_ShowCallback(playerid, using inline iWyborSlota, DIALOG_STYLE_LIST, TytulKomend(numer), ListaKomendSlot(playerid, numer), "Dalej", "Wróæ");
					}
				}
			
				//iWyborSlota
				if(response2)
				{
					slot = listitem2;
					Dialog_ShowCallback(playerid, using inline iWyborCMD, DIALOG_STYLE_LIST, TytulKomend(numer), "Edytuj\nUsun", "Wybierz", "Wróæ");
				}
				else
				{
					Dialog_ShowCallback(playerid, using inline iNumer, DIALOG_STYLE_LIST, TytulKomend(numer), ListaKomend(playerid), "Wybierz", "Wróæ");
				}
			}
		
			//iNumer
			if(response1)
			{
				numer = listitem1;
				if(!opcja)
				{
					Dialog_ShowCallback(playerid, using inline iWyborSlota, DIALOG_STYLE_LIST, TytulKomend(numer), ListaKomendSlot(playerid, numer), "Dalej", "Wróæ");
				}
				else
				{
					Dialog_ShowCallback(playerid, using inline iWyborARG, DIALOG_STYLE_LIST, TytulArgumentow(numer), "Edytuj\nUsun", "Wybierz", "Wróæ");
				}
			}
			else
			{
				Dialog_ShowCallback(playerid, using inline iKeybindy, DIALOG_STYLE_LIST, "Kreator skrótów", "Bindowanie komend (/0-9)\nBindowanie argumentów (#0-9)", "Wybierz", "WyjdŸ");
			}
		}
	
		//iKeybindy
		if(response)
		{
			opcja = listitem;
			switch(listitem)
			{
				case 0:
				{
					Dialog_ShowCallback(playerid, using inline iNumer, DIALOG_STYLE_LIST, "Kreator skrótów - komendy", ListaKomend(playerid), "Wybierz", "Wróæ");
				}
				case 1:
				{
					Dialog_ShowCallback(playerid, using inline iNumer, DIALOG_STYLE_LIST, "Kreator skrótów - argumenty", ListaArgumentow(playerid), "Wybierz", "Wróæ");
				}
			}
		}
	}
	Dialog_ShowCallback(playerid, using inline iKeybindy, DIALOG_STYLE_LIST, "Kreator skrótów", "Bindowanie komend (/0-9)\nBindowanie argumentów (#0-9)", "Wybierz", "WyjdŸ");
	return 1;
}

ListaKomend(playerid)
{
	new string[512];
	for (new i; i<10; i++)
	{
		new tmp=0;
		for (new j; j<5; j++)
		{
			if(!isnull(PlayerCMDBinds[playerid][j*10+i]))
			{
				tmp=1;
				break;
			}
		}
		
		if (!tmp)
		{
			format(string, sizeof(string), "%s"INDIALOG_COLOR"/%d", string, i);
		}
		else
		{
			format(string, sizeof(string), "%s"INCOLOR_ORANGE"/%d", string, i);
		}	
		
		if(i!=9) strcat(string, "\n", sizeof(string));
	}
	safe_return string;
}

ListaArgumentow(playerid)
{
	new string[512];
	for (new i; i<10; i++)
	{
		if(isnull(PlayerARGBinds[playerid][i]))
		{
			format(string, sizeof(string), "%s"INDIALOG_COLOR"#%d", string, i);
		}
		else
		{
			new bufor[32];
			strcat(bufor, PlayerARGBinds[playerid][i], sizeof(bufor));
			format(string, sizeof(string), "%s"INCOLOR_ORANGE"#%d - %s", string, i, bufor);
		}	
		
		if(i!=9) strcat(string, "\n", sizeof(string));
	}
	safe_return string;
}

ListaKomendSlot(playerid, slot)
{
	new string[512];
	for (new i; i<5; i++)
	{
		if(isnull(PlayerCMDBinds[playerid][i*10+slot]))
		{
			format(string, sizeof(string), "%s"INDIALOG_COLOR"Slot %d", string, i);
		}
		else
		{
			new bufor[32];
			strcat(bufor, PlayerCMDBinds[playerid][i*10+slot], sizeof(bufor));
			format(string, sizeof(string), "%s"INCOLOR_ORANGE"Slot %d - %s", string, i, bufor);
		}
		
		if(i!=4) strcat(string, "\n", sizeof(string));
	}
	
	safe_return string;
}

TytulKomend(slot)
{
	new string[32];
	format(string, sizeof(string), "Kreator skrótów - /%d", slot);
	safe_return string;
}

TytulArgumentow(slot)
{
	new string[32];
	format(string, sizeof(string), "Kreator skrótów - #%d", slot);
	safe_return string;
}

// ----[ Operacje listy ]----
StworzCMDBind(playerid, numer, slot, text[])
{
	format(PlayerCMDBinds[playerid][slot*10+numer], 256, "%s", text);
	ServerInfoF(playerid, "Teraz po wpisaniu /%d zostanie wykonana podana przez ciebie komenda.", numer);
	return 1;
}

StworzARGBind(playerid, numer, text[])
{
	format(PlayerARGBinds[playerid][numer], 256, "%s", text);
	ServerInfoF(playerid, "Teraz po wpisaniu #%d w argumencie komendy wyœwietli siê tekst który poda³eœ.", numer);
	return 1;
}

UsunCMDBind(playerid, numer, slot)
{
	PlayerCMDBinds[playerid][slot*10+numer][0] = '\0';
	ServerInfoF(playerid, "Pomyœlnie oczyszczono slot %d z komendy /%d", slot, numer);
	return 1;
}

UsunARGBind(playerid, numer)
{
	PlayerARGBinds[playerid][numer][0] = '\0';
	ServerInfoF(playerid, "Pomyœlnie oczyszczono argument #%d", numer);
	return 1;
}

// ----[ Operacje komend ]----
WykonajCMDBind(playerid, numer)
{
	for(new i; i<5; i++)
	{
		if(!isnull(PlayerCMDBinds[playerid][i*10+numer]))
		{
			new tmp[256];
			strcat(tmp, PlayerCMDBinds[playerid][i*10+numer]);
			Command_ReProcess(playerid, tmp, 0);
		}
	}
}

ZamienZnalezioneBindy(playerid, text[])
{
	new bufor[512], znajdz;
	strcat(bufor, text, sizeof(bufor));
	while (znajdz != -1)
	{
		znajdz = strfind(bufor, "#", false, znajdz);
		if(bufor[znajdz+1] >= '0' && bufor[znajdz+1] <= '9')
		{
			new numer = bufor[znajdz+1]-'0';
			strdel(bufor, znajdz, znajdz+2);
			strins(bufor, PlayerARGBinds[playerid][numer], znajdz);
			
			znajdz = znajdz-2+strlen(PlayerARGBinds[playerid][numer]);
		}
		else if(bufor[znajdz+1]=='G')
		{
			new nick[MAX_PLAYER_NAME];
			new giveplayerid = GetClosestPlayer(playerid);
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				GetPlayerName(giveplayerid, nick, sizeof(nick));
				strdel(bufor, znajdz, znajdz+2);
				strins(bufor, nick, znajdz);
			
				znajdz = znajdz-2+strlen(nick);
			}
			else
			{
				znajdz+=2;
			}
		}
	}
	return bufor;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
keybindy_LoadCommands()
{
	Command_AddAlt(YCMD:keybindy, "keybind");
	Group_SetCommand(LoggedPlayers, YCMD:keybindy, true);
	
	Group_SetCommand(LoggedPlayers, YCMD:0, true);
	Group_SetCommand(LoggedPlayers, YCMD:1, true);
	Group_SetCommand(LoggedPlayers, YCMD:2, true);
	Group_SetCommand(LoggedPlayers, YCMD:3, true);
	Group_SetCommand(LoggedPlayers, YCMD:4, true);
	Group_SetCommand(LoggedPlayers, YCMD:5, true);
	Group_SetCommand(LoggedPlayers, YCMD:6, true);
	Group_SetCommand(LoggedPlayers, YCMD:7, true);
	Group_SetCommand(LoggedPlayers, YCMD:8, true);
	Group_SetCommand(LoggedPlayers, YCMD:9, true);
}

YCMD:keybindy(playerid, params[], help) //keybind, bindy, bind
{
	if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	PanelKeybindow(playerid);
	
	return 1;
}

YCMD:0(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 0);
	
	return 1;
}

YCMD:1(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 1);
	
	return 1;
}

YCMD:2(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 2);
	
	return 1;
}

YCMD:3(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 3);
	
	return 1;
}

YCMD:4(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 4);
	
	return 1;
}

YCMD:5(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 5);
	
	return 1;
}

YCMD:6(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 6);
	
	return 1;
}

YCMD:7(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 7);
	
	return 1;
}

YCMD:8(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 8);
	
	return 1;
}

YCMD:9(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	WykonajCMDBind(playerid, 9);
	
	return 1;
}

//end