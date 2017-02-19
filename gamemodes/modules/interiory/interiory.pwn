//interiory.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Modu³: interiory.pwn ]-------------------------------------------//
//Opis:
/*

	SYSTEM INTERIORÓW
		3 klasy:
			budynek - g³ówna instancja, nazwê, w³aœciciela oraz typ budynku (Systemowy, Publiczny, Organizacja, Frakcja), vw
			pomieszczenie - nazwa, zawiera interior, oswietlenie, pogode, muzyke
			drzwi - zawieraja x,y,z in i out, lock oraz id pomieszczenia in i out, id budynku in, id budynku out, [3dtext in, 3dtext out, pickup in, pickup out, pickup type], winda
			winda - zawiera id drzwi które nale¿¹ do wiêkszej instancji
			
		Przyk³ad:
		Komisariat, LSPD, Frakcja, VW:1
		Sala g³ówna - interior 1, oœwietlenie - jasne, pogoda - ³adna, muzyka grozy
		Drzwi - x,y,z przed komi, x,y,z sali g³ównej, otwarte, in Sali g³ównej, out San Andreas
		
	SYSTEM DOMÓW/BIZNESÓW
		3 klasy:
		Instancja - nazwê, zawiera x,y,z, x2, y2, z2, uzywaj2wejscia, VW, w³aœciciela, typ instancji, zamkniête, oœwietlenie, pogode, muzykê, id Interioru
		Interior - zawiera x,y,z, x2,y2,z2 interior

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

//-----------------<[ Callbacki: ]>-------------------
public OnPlayerEnterDoor(playerid, doorid)
{
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
stock interiory_Init()
{
	MruMySQL_LoadBudynki();
	MruMySQL_LoadPomieszczenia();
	MruMySQL_LoadDrzwi();
	//MruMySQL_LoadWindy();
	StworzRelacje();
	return 1;
}

stock interiory_Exit()
{
	return 1;
}

//-----[ Dialogi ]-----
stock PanelBudynkow(playerid, domy)
{
	/*
	Zarz¹dzanie interiorami:
	Lista budynków
		1. Edytuj
			Lista pól do edytowania + edytuj wszystko
		2. Powi¹zane pomieszczenia
			Lista powi¹zanych pomieszczeñ
				1. Edytuj
					Lista pól do edytowania + edytuj wszystko
				2. Powi¹zane drzwi
					Lista drzwi
						1. Tryb edycji
						2. Usuñ
				3. Usuñ
		3. Usuñ
	*/
	
	new drzwiID, pomieszczenieID, budynekID;
	inline iDialog0(pid, dialogid, response, listitem, string:inputtext[])
	{
		#pragma unused pid, dialogid, inputtext
		inline iDialog1(pid1, dialogid1, response1, listitem1, string:inputtext1[])
		{
			new bool:changedB=false;
			#pragma unused pid1, dialogid1, inputtext1
			inline iDialog2(pid2, dialogid2, response2, listitem2, string:inputtext2[])
			{
				new bool:changedP=false;
				#pragma unused pid2, dialogid2, inputtext2
				inline iDialog3(pid3, dialogid3, response3, listitem3, string:inputtext3[])
				{
					new bool:changedD=false;
					#pragma unused pid3, dialogid3
					inline iDialog4(pid4, dialogid4, response4, listitem4, string:inputtext4[])
					{
						#pragma unused pid4, dialogid4, inputtext4
						inline iDialog5(pid5, dialogid5, response5, listitem5, string:inputtext5[])
						{
							#pragma unused pid5, dialogid5
							inline iDialog6(pid6, dialogid6, response6, listitem6, string:inputtext6[])
							{
								#pragma unused pid6, dialogid6, listitem6
								//Dialog 6
								if(response6)
								{
									switch(listitem5)
									{
										case 0://Nazwa
										{
											if(!isnull(inputtext6))
												format(Drzwi[drzwiID][Nazwa], MAX_POMIESZCZENIE_NAME, "%s", inputtext6);
											else
												ServerFail(playerid, "Nazwa musi zawieraæ przynajmniej 1 znak");
										}
										case 1://X,Y,Z,A
										{
											if(sscanf(inputtext6, "ffff", Drzwi[drzwiID][inX], Drzwi[drzwiID][inY], Drzwi[drzwiID][inZ], Drzwi[drzwiID][inA]))
											{
												ServerFail(playerid, "Niepoprawny format");
											}
										}
										case 2://3DText
										{
											if(!isnull(inputtext6))
												format(Drzwi[drzwiID][in3DTextString], MAX_POMIESZCZENIE_NAME, "%s", inputtext6);
											else
												ServerFail(playerid, "3DText musi zawieraæ przynajmniej 1 znak");
										}
										case 3://Pickup
										{
											Drzwi[drzwiID][inPickupModel] = strval(inputtext6);
										}
										case 4://Pomieszczenie
										{
											Drzwi[drzwiID][inPomieszczenie] = strval(inputtext6);
										}
										case 5://X,Y,Z,A
										{
											if(sscanf(inputtext6, "ffff", Drzwi[drzwiID][outX], Drzwi[drzwiID][outY], Drzwi[drzwiID][outZ], Drzwi[drzwiID][outA]))
											{
												ServerFail(playerid, "Niepoprawny format");
											}
										}
										case 6://3DText
										{
											if(!isnull(inputtext6))
												format(Drzwi[drzwiID][out3DTextString], MAX_POMIESZCZENIE_NAME, "%s", inputtext6);
											else
												ServerFail(playerid, "3DText musi zawieraæ przynajmniej 1 znak");
										}
										case 7://Pickup
										{
											Drzwi[drzwiID][outPickupModel] = strval(inputtext6);
										}
										case 8://Pomieszczenie
										{
											Drzwi[drzwiID][outPomieszczenie] = strval(inputtext6);
										}
										case 9://Lock
										{
											Drzwi[drzwiID][lock] = strval(inputtext6);
										}
										case 10://Usuñ drzwi
										{
											MruMySQL_DeleteDrzwi(drzwiID);
											ServerInfoF(playerid, "Drzwi %d usuniête", drzwiID);
										}
									}
									if(listitem5 == 10)
										Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> powiazane drzwi"), ListaDrzwi(pomieszczenieID), "Wybierz", "Wróæ");
									else
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_LIST, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> edycja"), DrzwiEdycjaDialog(drzwiID), "Wybierz", "Wróæ");
										changedD=true;
									}
								}
								else//nie response dialog 6
								{
									Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_LIST, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> edycja"), DrzwiEdycjaDialog(drzwiID), "Wybierz", "Wróæ");
								}
							}
							//Dialog 5
							if(response5)
							{
								if(listitem3 == 0)
								{
									switch(listitem4)
									{
										case 0://Nazwa - wybrano
										{
											if(!isnull(inputtext5))
												format(Pomieszczenia[pomieszczenieID][Nazwa], MAX_POMIESZCZENIE_NAME, "%s", inputtext5);
											else
												ServerFail(playerid, "Nazwa musi zawieraæ przynajmniej 1 znak");
										}
										case 1://Budynek - wybrano
										{
											Pomieszczenia[pomieszczenieID][Budynek] = strval(inputtext5);
										}
										case 2://Interior - wybrano
										{
											Pomieszczenia[pomieszczenieID][Interior] = strval(inputtext5);
										} 
										case 3://Oswietlenie - wybrano
										{
											Pomieszczenia[pomieszczenieID][Oswietlenie] = strval(inputtext5);
										}
										case 4://Pogoda - wybrano
										{
											Pomieszczenia[pomieszczenieID][Pogoda] = strval(inputtext5);
										}
										case 5://Muzyka - wybrano
										{
											format(Pomieszczenia[pomieszczenieID][Muzyka], MAX_POMIESZCZENIE_NAME, "%s", inputtext5);
										}
									}
									changedP=true;
									Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj"), PomieszczeniaEdycjaDialog(pomieszczenieID), "Wybierz", "Wróæ");
								}
								else//listitem3=1 edycja usuwanie drzwi
								{
									switch(listitem5)
									{
										case 0://Nazwa
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Nazwa"), "Wpisz now¹ nazwê: (max "#MAX_DRZWI_NAME" znaków)", "Zmieñ", "Anuluj");
										}
										case 1://X,Y,Z,A
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Pozycja"), "Wpisz now¹ pozycjê (oddzielana spacjami):", "Zmieñ", "Anuluj");
										}
										case 2://3DText
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> 3DText"), "Wpisz nowy tekst w 3DTekœcie: (max "#MAX_DRZWI3D_LENGTH" znaków)", "Zmieñ", "Anuluj");
										}
										case 3://Pickup
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Pickup"), "Wpisz nowy model pickupa (tylko liczby)", "Zmieñ", "Anuluj");
										}
										case 4://Pomieszczenie
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Pomieszczenie"), "Wpisz nowe ID pomieszczenia", "Zmieñ", "Anuluj");
										}
										case 5://X,Y,Z,A
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Pozycja"), "Wpisz now¹ pozycjê (oddzielana spacjami):", "Zmieñ", "Anuluj");
										}
										case 6://3DText
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> 3DText"), "Wpisz nowy tekst w 3DTekœcie: (max "#MAX_DRZWI3D_LENGTH" znaków)", "Zmieñ", "Anuluj");
										}
										case 7://Pickup
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Pickup"), "Wpisz nowy model pickupa (tylko liczby)", "Zmieñ", "Anuluj");
										}
										case 8://Pomieszczenie
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Pomieszczenie"), "Wpisz nowe ID pomieszczenia", "Zmieñ", "Anuluj");
										}
										case 9://Lock
										{
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_INPUT, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> Lock"), "Wpisz now¹ wartoœæ zamkniêcia", "Zmieñ", "Anuluj");
										}
										case 10://Usuñ drzwi
										{
											new string[256];
											format(string, sizeof(string), "Czy na pewno chcesz usun¹æ drzwi %s?", Drzwi[drzwiID][Nazwa]);
											Dialog_ShowCallback(playerid, using inline iDialog6, DIALOG_STYLE_MSGBOX, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> usuwanie"), string, "Usuñ", "Anuluj");
										}
									}
								}
							}
							else//nie response dialog 5
							{
								switch(listitem3)
								{
									case 0://edycja pomieszczen
									{
										Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj"), PomieszczeniaEdycjaDialog(pomieszczenieID), "Wybierz", "Wróæ");
									}
									case 1://lista drzwi
									{
										Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> powiazane drzwi"), ListaDrzwi(pomieszczenieID), "Wybierz", "Wróæ");
										if(changedD==true)
										{
											MruMySQL_SaveDrzwi(changedD);
											changedD=false;
										}
									}
								}
							}
						}
						//Dialog 4
						if(response4 && inputtext4[0] != '@')
						{
							//Zsota³y tylko pomieszczenia i drzwi
							if(listitem3 == 0)
							{
								switch(listitem4)
								{
									case 0://Nazwa
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_INPUT, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj nazwe"), "Wpisz now¹ nazwê pomieszczenia (max "#MAX_POMIESZCZENIE_NAME" znaków)", "Zmieñ", "Anuluj");
									}
									case 1://Budynek
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_INPUT, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj budynek"), "Wpisz nowe ID powi¹zanego budynku (tylko liczby)", "Zmieñ", "Anuluj");
									}
									case 2://Interior
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_INPUT, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj interior"), "Wpisz nowe ID interioru (tylko liczby)", "Zmieñ", "Anuluj");
									}
									case 3://Oswietlenie
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_INPUT, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj oœwietlenie"), "Wpisz nowe oœwietlenie-czas (tylko liczby)", "Zmieñ", "Anuluj");
									}
									case 4://Pogoda
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_INPUT, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj pogodê"), "Wpisz now¹ pogodê (tylko liczby)", "Zmieñ", "Anuluj");
									}
									case 5://Muzyka
									{
										Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_INPUT, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj muzykê"), "Wpisz nowy adres stream'a (max "#MAX_STREAM_LENGTH" znaków)", "Zmieñ", "Anuluj");
									}
								}
							}
							else if(listitem3 == 1)//Lista drzwi - wybrano drzwi
							{
								drzwiID = PowiazaneDrzwi(pomieszczenieID, listitem4);
								Dialog_ShowCallback(playerid, using inline iDialog5, DIALOG_STYLE_LIST, ListaDrzwiNaglowek(budynekID, pomieszczenieID, drzwiID, " -> edycja"), DrzwiEdycjaDialog(drzwiID), "Wybierz", "Wróæ");
							}
							else if(listitem3 == 2)//Usuñ pomieszczenie - zatwierdzone
							{
								MruMySQL_DeletePomieszczenie(pomieszczenieID);
								Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, " -> powi¹zane pomieszczenia"), ListaPomieszczen(budynekID), "Wybierz", "Wróæ");
							}
							
						}
						else//nie response dialog 4
						{
							Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, "."), "Edytuj\nPowi¹zane drzwi\nUsuñ", "Wybierz", "Wróæ");
						}
					}
					
					//Dialog 3
					if(response3)
					{
						switch(listitem1)
						{
							case 0://Lista edytowana
							{
								if(!isnull(inputtext3))
								{
									switch(listitem2)
									{
										case 0: //Wybrano Nazwa
										{
											if(!isnull(inputtext3))
												format(Budynki[budynekID][Nazwa], MAX_BUDYNEK_NAME, "%s", inputtext3);
											else
												ServerFail(playerid, "Nazwa musi zawieraæ przynajmniej 1 znak");
										}
										case 1: //Wybrano Typ
										{
											new typ = strval(inputtext3);
											if(typ >= 0 && typ <= 4)
												Budynki[budynekID][Typ] = typ;
											else
											{
												ServerFail(playerid, "Wpisano niepoprawny typ!");
												Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, ListaBudynkowNaglowek(budynekID, " -> edytuj typ"), "Wpisz nowy typ budynku\nPUBLICZNY-0 | SYSTEM-1 | FRAKCJA-2 | ORGANIZACJA-3 | GRACZ-4", "Zmieñ", "Anuluj");
											}
										}
										case 2: //Wybrano Wlasciciel
										{
											Budynki[budynekID][Wlasciciel] = strval(inputtext3);
										}
										case 3: //Wybrano Virtual Wrold
										{
											Budynki[budynekID][VW] = strval(inputtext3);
										}
									}
									changedB=true;
								}
								Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, " -> edytuj"), BudynkiEdycjaDialog(budynekID), "Wybierz", "Wróæ");
							}
							case 1://Lista pomieszczeñ - wybrano opcje edytowania
							{
								switch(listitem3)
								{
									case 0://Edytowanie pomieszczenia
									{
										Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> edytuj"), PomieszczeniaEdycjaDialog(pomieszczenieID), "Wybierz", "Wróæ");
									}
									case 1://Powiazane drzwi
									{
										Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, " -> powiazane drzwi"), ListaDrzwi(pomieszczenieID), "Wybierz", "Wróæ");
									}
									case 2://Usuñ pomieszczenie
									{
										new string[256];
										format(string, sizeof(string), "Czy na pewno chcesz usun¹æ pomieszczenie %s?\n"INCOLOR_PANICRED"Ostrze¿enie: wszystkie powiazane drzwi zostan¹ usuniête razem z nim!", Pomieszczenia[pomieszczenieID][Nazwa]);
										Dialog_ShowCallback(playerid, using inline iDialog4, DIALOG_STYLE_MSGBOX, ListaBudynkowNaglowek(budynekID, " -> usuñ"), string, "Usuñ", "Anuluj");
									}
								}
							}
						}
					}
					else//nie response dialog 3
					{
						//Z dialogu 1
						switch(listitem1)
						{
							case 0://Edytowanie budynku
							{
								Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, " -> edytuj"), BudynkiEdycjaDialog(budynekID), "Wybierz", "Wróæ");
							}
							case 1://Powiazane pomieszczenia
							{
								Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, " -> powi¹zane pomieszczenia"), ListaPomieszczen(budynekID), "Wybierz", "Wróæ");
								if(changedP==true)
								{
									MruMySQL_SavePomieszczenie(pomieszczenieID);
									changedP=false;
								}
							}
						}
					}
				}
				
				//Dialog 2
				if(response2 && inputtext2[0] != '@')
				{
					switch(listitem1)
					{
						case 0://Lista edytowana - wybrano opcje
						{
							switch(listitem2)
							{
								case 0: //Nazwa
								{
									Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, ListaBudynkowNaglowek(budynekID, " -> edytuj nazwe"), "Wpisz now¹ nazwê budynku (max "#MAX_BIZNES_NAME" znaków)", "Zmieñ", "Anuluj");
								}
								case 1: //Typ
								{
									Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, ListaBudynkowNaglowek(budynekID, " -> edytuj typ"), "Wpisz nowy typ budynku\nPUBLICZNY-0 | SYSTEM-1 | FRAKCJA-2 | ORGANIZACJA-3 | GRACZ-4", "Zmieñ", "Anuluj");
								}
								case 2: //Wlasciciel
								{
									Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, ListaBudynkowNaglowek(budynekID, " -> edytuj wlasciciela"), "Wpisz nowego wlasciciela budynku (tylko liczby)", "Zmieñ", "Anuluj");
								}
								case 3: //Virtual Wrold
								{
									Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_INPUT, ListaBudynkowNaglowek(budynekID, " -> edytuj virtualworld"), "Wpisz nowy virtual world budynku (tylko liczby)", "Zmieñ", "Anuluj");
								}
							}
						}
						case 1://Lista pomieszczeñ - wybrano pomieszczenie
						{
							pomieszczenieID = PowiazanePomieszczenie(listitem, listitem2);
							Dialog_ShowCallback(playerid, using inline iDialog3, DIALOG_STYLE_LIST, ListaPomieszczenNaglowek(budynekID, pomieszczenieID, "-> edytuj"), "Edytuj\nPowi¹zane drzwi\nUsuñ", "Wybierz", "Wróæ");
						}
						case 2://Potwierdzenie usuniêcia
						{
							MruMySQL_DeleteBudynek(budynekID);
							Dialog_ShowCallback(playerid, using inline iDialog0, DIALOG_STYLE_LIST, "Zarz¹dzanie budynkami", ListaBudynkow(domy), "Wybierz", "WyjdŸ");
						}
					}
				}
				else//nie response dialog 2
				{
					Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, "."), "Edytuj\nPowi¹zane pomieszczenia\nUsuñ", "Wybierz", "Wróæ");
					if(changedB==true)
					{
						MruMySQL_SaveBudynek(budynekID);
						changedB=false;
					}
				}
			}
			
			//Dialog 1
			if(response1)
			{
				switch(listitem1)
				{
					case 0://Edytowanie budynku
					{
						Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, " -> edytuj"), BudynkiEdycjaDialog(budynekID), "Wybierz", "Wróæ");
					}
					case 1://Powiazane pomieszczenia
					{
						Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, " -> powi¹zane pomieszczenia"), ListaPomieszczen(budynekID), "Wybierz", "Wróæ");
					}
					case 2://Usuwanie budynku
					{
						new string[256];
						format(string, sizeof(string), "Czy na pewno chcesz usun¹æ budynek %s?\n"INCOLOR_PANICRED"Ostrze¿enie: wszystkie powiazane pomieszczenia i drzwi zostan¹ usuniête razem z nim!", Budynki[budynekID][Nazwa]);
						Dialog_ShowCallback(playerid, using inline iDialog2, DIALOG_STYLE_MSGBOX, ListaBudynkowNaglowek(budynekID, " -> usuñ"), string, "Usuñ", "Anuluj");
					}
				}
			}
			else//nie response
			{
				Dialog_ShowCallback(playerid, using inline iDialog0, DIALOG_STYLE_LIST, "Zarz¹dzanie budynkami", ListaBudynkow(domy), "Wybierz", "WyjdŸ");
			}
		}
	
		//Dialog 0
		if(inputtext[0] == '@' && response)
		{
			Dialog_ShowCallback(playerid, using inline iDialog0, DIALOG_STYLE_LIST, "Zarz¹dzanie budynkami", ListaBudynkow(domy), "Wybierz", "WyjdŸ");
		}
		else if(response)
		{
			budynekID = BudynkiListitem(listitem, false); //true - domy | false - budynki
			Dialog_ShowCallback(playerid, using inline iDialog1, DIALOG_STYLE_LIST, ListaBudynkowNaglowek(budynekID, "."), "Edytuj\nPowi¹zane pomieszczenia\nUsuñ", "Wybierz", "Wróæ");
		}
	}
	Dialog_ShowCallback(playerid, using inline iDialog0, DIALOG_STYLE_LIST, "Zarz¹dzanie budynkami", ListaBudynkow(domy), "Wybierz", "WyjdŸ");
	
	return 1;
}

stock ListaBudynkow(domy)
{
	new string[1024];
	for(new i; i<MAX_BUDYNKOW; i++)
	{
		if(domy)
		{
			if(Budynki[i][Typ] == OWNER_TYPE_DOM)
				strcat(string, Budynki[i][Nazwa], sizeof(string));
		}
		else
		{
			if(Budynki[i][Typ] != OWNER_TYPE_DOM)
				strcat(string, Budynki[i][Nazwa], sizeof(string));
		}
		if(isnull(Budynki[i+1][Nazwa]))
			break;
		else
			strcat(string, "\n", sizeof(string));
	}
	if(isnull(string))
	{
		strcat(string, "@"INCOLOR_PANICRED"Brak budynków!");
	}
	safe_return string;
}

stock ListaPomieszczen(budynek)
{
	new string[1024];
	for(new i; i<MAX_POMIESZCZEN; i++)
	{
		if(Pomieszczenia[i][Budynek] == Budynki[budynek][ID])
		{
			strcat(string, Pomieszczenia[i][Nazwa], sizeof(string));
			if(isnull(Pomieszczenia[i+1][Nazwa]))
				break;
			else
				strcat(string, "\n", sizeof(string));
		}
	}
	if(isnull(string))
	{
		strcat(string, "@"INCOLOR_PANICRED"Brak powi¹zanych pomieszczeñ!");
	}
	safe_return string;
}

stock ListaDrzwi(pomieszczenie)
{
	new string[1024];
	for(new i; i<MAX_DRZWI; i++)
	{
		if(Drzwi[i][inPomieszczenie] == Pomieszczenia[pomieszczenie][ID])
		{
			strcat(string, INCOLOR_LIGHTGREEN, sizeof(string));
			strcat(string, Drzwi[i][Nazwa], sizeof(string));
			if(isnull(Drzwi[i+1][Nazwa]) && Drzwi[i][outPomieszczenie] != Pomieszczenia[pomieszczenie][ID])
				break;
			else
				strcat(string, "\n", sizeof(string));
		}
		if(Drzwi[i][outPomieszczenie] == Pomieszczenia[pomieszczenie][ID])
		{
			strcat(string, INCOLOR_LIGHTRED, sizeof(string));
			strcat(string, Drzwi[i][Nazwa], sizeof(string));
			if(isnull(Drzwi[i+1][Nazwa]))
				break;
			else
				strcat(string, "\n", sizeof(string));
		}
	}
	if(isnull(string))
	{
		strcat(string, "@"INCOLOR_PANICRED"Brak powi¹zanych drzwi!");
	}
	safe_return string;
}

stock BudynkiListitem(zkolei, domy)
{
	new i, r;
	while (i<MAX_BUDYNKOW)
	{
		if(domy)
		{
			if(Budynki[i][Typ] == OWNER_TYPE_DOM)
			{
				if(r==zkolei)
					break;
				r++;
			}
		}
		else
		{
			if(Budynki[i][Typ] != OWNER_TYPE_DOM)
			{
				if(r==zkolei)
					break;
				r++;
			}
		}
		i++;
	}
	
	return i;
}

stock PowiazanePomieszczenie(budynek, zkolei)
{
	new i, r;
	while (i<MAX_POMIESZCZEN)
	{
		if(Pomieszczenia[i][Budynek] == Budynki[budynek][ID])
		{
			if(r==zkolei)
				break;
			r++;
		}
		i++;
	}
	
	return i;
}

stock PowiazaneDrzwi(pomieszczenie, zkolei)
{
	new i, r;
	while (i<MAX_DRZWI)
	{
		if(Drzwi[i][inPomieszczenie] == Pomieszczenia[pomieszczenie][ID])
		{
			if(r==zkolei)
				break;
			r++;
		}
		if(Drzwi[i][outPomieszczenie] == Pomieszczenia[pomieszczenie][ID])
		{
			if(r==zkolei)
				break;
			r++;
		}
		i++;
	}
	
	return i;
}

stock ListaBudynkowNaglowek(budynek, dodatkowy[])
{
	new string[64];
	format(string, sizeof(string), "Budynek %d%s", Budynki[budynek][ID], dodatkowy);
	safe_return string;
}

stock ListaPomieszczenNaglowek(budynek, pomieszczenie, dodatkowy[])
{
	new string[100];
	format(string, sizeof(string), "Budynek %d -> Pomieszczenie %d%s", Budynki[budynek][ID], Pomieszczenia[pomieszczenie][ID], dodatkowy);
	safe_return string;
}

stock ListaDrzwiNaglowek(budynek, pomieszczenie, drzwi, dodatkowy[])
{
	new string[128];
	format(string, sizeof(string), "Budynek %d -> Pom. %d -> Drzwi %d%s", Budynki[budynek][ID], Pomieszczenia[pomieszczenie][ID], Drzwi[drzwi][ID], dodatkowy);
	safe_return string;
}

stock BudynkiEdycjaDialog(budynek)
{
	new string[512];
	new typstring[16];
	switch(Budynki[budynek][Typ])
	{
		case 0:
		{
			strcat(typstring, "Publiczny");
		}
		case 1:
		{
			strcat(typstring, "System");
		}
		case 2:
		{
			strcat(typstring, "Frakcja");
		}
		case 3:
		{
			strcat(typstring, "Organizacja");
		}
		case 4:
		{
			strcat(typstring, "Gracz");
		}
	}
	format(string, sizeof(string), INDIALOG_COLOR"Nazwa: "INCOLOR_WHITE"%s\n"INDIALOG_COLOR"Typ: "INCOLOR_WHITE"%s\n"INDIALOG_COLOR"Wlasciciel: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"VirtualWorld: "INCOLOR_WHITE"%d", Budynki[budynek][Nazwa], typstring, Budynki[budynek][Wlasciciel], Budynki[budynek][VW]);
	safe_return string;
}

stock PomieszczeniaEdycjaDialog(p)
{
	new string[512];
	format(string, sizeof(string), INDIALOG_COLOR"Nazwa: "INCOLOR_WHITE"%s\n"INDIALOG_COLOR"Budynek: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"Interior: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"Oswietlenie: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"Pogoda: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"Muzyka: "INCOLOR_WHITE"%s", 
		Pomieszczenia[p][Nazwa], Pomieszczenia[p][Budynek], Pomieszczenia[p][Interior], Pomieszczenia[p][Oswietlenie], Pomieszczenia[p][Pogoda], Pomieszczenia[p][Muzyka]);
	safe_return string;
}

stock DrzwiEdycjaDialog(d)
{
	new string[1024];
	format(string, sizeof(string), INDIALOG_COLOR"Nazwa: "INCOLOR_WHITE"%s\n"INDIALOG_COLOR"In - Pozycja X, Y, Z, A: "INCOLOR_WHITE"%.1f, %.1f, %.1f, %.1f\n"INDIALOG_COLOR"In - 3DText: "INCOLOR_WHITE"%s\n"INDIALOG_COLOR"In - Model pickupu: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"In - Pomieszczenie: "INCOLOR_WHITE"%d\n", 
		Drzwi[d][Nazwa], Drzwi[d][inX], Drzwi[d][inY], Drzwi[d][inZ], Drzwi[d][inA], Drzwi[d][in3DTextString], Drzwi[d][inPickupModel], Drzwi[d][inPomieszczenie]);
		
	format(string, sizeof(string), "%s"INDIALOG_COLOR"Out - Pozycja X, Y, Z, A: "INCOLOR_WHITE"%.1f, %.1f, %.1f, %.1f\n"INDIALOG_COLOR"Out - 3DText: "INCOLOR_WHITE"%s\n"INDIALOG_COLOR"Out - Model pickupu: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"Out - Pomieszczenie: "INCOLOR_WHITE"%d\n"INDIALOG_COLOR"Zamkniête: "INCOLOR_WHITE"%d\n"INCOLOR_PANICRED"Usuñ", 
		string, Drzwi[d][outX], Drzwi[d][outY], Drzwi[d][outZ], Drzwi[d][outA], Drzwi[d][out3DTextString], Drzwi[d][outPickupModel], Drzwi[d][outPomieszczenie], Drzwi[d][lock]);
	safe_return string;
}
//-----[ Tworzenie/usuwanie/edytowanie interiorów ]-----
stock StworzBudynek(id, nazwa[], typ, wlasciciel, vw, playerid=-1)
{
	format(Budynki[id][Nazwa], MAX_BUDYNEK_NAME, nazwa);
	Budynki[id][Typ] = typ;
	Budynki[id][Wlasciciel] = wlasciciel;
	Budynki[id][VW] = vw;
	
	budynki_ORM(id);
	MruMySQL_CreateBudynek(id, playerid);
	return id;
}

stock StworzPomieszczenie(id, nazwa[], budynek, interior, czas, pogoda, muzyka[]="", playerid=-1)
{
	format(Pomieszczenia[id][Nazwa], MAX_POMIESZCZENIE_NAME, nazwa);
	Pomieszczenia[id][Budynek] = budynek;
	Pomieszczenia[id][Interior] = interior;
	Pomieszczenia[id][Oswietlenie] = czas;
	Pomieszczenia[id][Pogoda] = pogoda;
	format(Pomieszczenia[id][Muzyka], MAX_STREAM_LENGTH, muzyka);
	
	pomieszczenia_ORM(id);
	MruMySQL_CreatePomieszczenie(id, playerid);
	return id;
}

stock StworzDrzwi(id, nazwa[], Float:ix, Float:iy, Float:iz, Float:ia, itext3d[], ipickup, ipomieszczenie, Float:ox, Float:oy, Float:oz, Float:oa, otext3d[], opickup, opomieszczenie, bool:lockvalue=false, playerid=-1)
{
	format(Drzwi[id][Nazwa], MAX_DRZWI_NAME, nazwa);
	Drzwi[id][inX] = ix;
	Drzwi[id][inY] = iy;
	Drzwi[id][inZ] = iz;
	Drzwi[id][inA] = ia;
	format(Drzwi[id][in3DTextString], MAX_DRZWI3D_LENGTH, itext3d);
	Drzwi[id][inPickupModel] = ipickup;
	Drzwi[id][inPomieszczenie] = ipomieszczenie;
	Drzwi[id][outX] = ox;
	Drzwi[id][outY] = oy;
	Drzwi[id][outZ] = oz;
	Drzwi[id][outA] = oa;
	format(Drzwi[id][out3DTextString], MAX_DRZWI3D_LENGTH, otext3d);
	Drzwi[id][outPickupModel] = opickup;
	Drzwi[id][outPomieszczenie] = opomieszczenie;
	Drzwi[id][lock] = lockvalue;
	
	
	drzwi_ORM(id);
	drzwi_Create(id);
	MruMySQL_CreateDrzwi(id, playerid);
	return id;
}

stock drzwi_Create(id)
{
	//in
	if(!isnull(Drzwi[id][in3DTextString])) Drzwi[id][in3DText] = CreateDynamic3DTextLabel(Drzwi[id][in3DTextString], TEXT3D_INTERIOR_COLOR, Drzwi[id][inX], Drzwi[id][inY], Drzwi[id][inZ]+TEXT3D_UP_Z, TEXT3D_DRZWI_DRAWDISTANCE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Budynki[Pomieszczenia[Drzwi[id][inPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][inPomieszczenieID]][Interior]);
	if(Drzwi[id][inPickupModel]) Drzwi[id][inPickup] = CreateDynamicPickup(Drzwi[id][inPickupModel], DOOR_PICKUP_TYPE, Drzwi[id][inX], Drzwi[id][inY], Drzwi[id][inZ], Budynki[Pomieszczenia[Drzwi[id][inPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][inPomieszczenieID]][Interior]);
	//out
	if(!isnull(Drzwi[id][out3DTextString])) Drzwi[id][out3DText] = CreateDynamic3DTextLabel(Drzwi[id][out3DTextString], TEXT3D_INTERIOR_COLOR, Drzwi[id][outX], Drzwi[id][outY], Drzwi[id][outZ]+TEXT3D_UP_Z, TEXT3D_DRZWI_DRAWDISTANCE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Budynki[Pomieszczenia[Drzwi[id][outPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][outPomieszczenieID]][Interior]);
	if(Drzwi[id][outPickupModel]) Drzwi[id][outPickup] = CreateDynamicPickup(Drzwi[id][outPickupModel], DOOR_PICKUP_TYPE, Drzwi[id][outX], Drzwi[id][outY], Drzwi[id][outZ], Budynki[Pomieszczenia[Drzwi[id][outPomieszczenieID]][BudynekID]][VW], Pomieszczenia[Drzwi[id][outPomieszczenieID]][Interior]);		
}

//------------------<[ Obsluga drzwi: ]>--------------------
stock SprawdzDrzwi(playerid)
{
	for(new i; i<IloscDrzwi; i++)
	{
		if(Drzwi[i][inPomieszczenieID] == gPlayerPomieszczenie[playerid])
		{
			if(IsPlayerInRangeOfPoint(playerid, DOORS_RANGE, Drzwi[i][inX], Drzwi[i][inY], Drzwi[i][inZ]))
			{
				EnterDoor(playerid, i, 0);
				return i;
			}
		}
		else if(Drzwi[i][outPomieszczenieID] == gPlayerPomieszczenie[playerid])
		{
			if(IsPlayerInRangeOfPoint(playerid, DOORS_RANGE, Drzwi[i][outX], Drzwi[i][outY], Drzwi[i][outZ]))
			{
				EnterDoor(playerid, i, 1);
				return i;
			}
		}
	}
	return -1;
}

stock interiory_SprawdzDrzwiPickup(playerid, pickup)
{
	for(new i; i<IloscDrzwi; i++)
	{
		if(Drzwi[i][inPickup] == pickup)
		{
			EnterDoor(playerid, i, 0);
			return i;
		}
		else if(Drzwi[i][outPickup] == pickup)
		{
			EnterDoor(playerid, i, 1);
			return i;
		}
	}
	return -1;
}

stock EnterDoor(playerid, doorid, inout)
{
	if(!Drzwi[doorid][lock])
	{
		if(inout == 0)//in
		{
			EnterPomieszczenie(playerid, Drzwi[doorid][outPomieszczenieID]);
			SetPlayerPos(playerid, Drzwi[doorid][outX], Drzwi[doorid][outY], Drzwi[doorid][outZ]);
		}
		else//out
		{
			EnterPomieszczenie(playerid, Drzwi[doorid][inPomieszczenieID]);
			SetPlayerPos(playerid, Drzwi[doorid][inX], Drzwi[doorid][inY], Drzwi[doorid][inZ]);
		}
		//Callback
		OnPlayerEnterDoor(playerid, doorid);
	}
	else
	{
		GameTextForPlayer(playerid, "~r~Drzwi zamkniete", 4000, 4);
	}
	return 1;
}

stock EnterPomieszczenie(playerid, pid)
{
	new b = Pomieszczenia[pid][BudynekID];
	SetPlayerVirtualWorld(playerid, Budynki[b][VW]);
	SetPlayerInterior(playerid, Pomieszczenia[pid][Interior]);
	SetPlayerTime(playerid, Pomieszczenia[pid][Oswietlenie], 0);
	SetPlayerWeather(playerid, Pomieszczenia[pid][Pogoda]);
	if(!isnull(Pomieszczenia[pid][Muzyka]))
		PlayAudioStreamForPlayer(playerid, Pomieszczenia[pid][Muzyka]);
	else
		StopAudioStreamForPlayer(playerid);
	gPlayerPomieszczenie[playerid] = pid;
	return 1;
}

//------------------<[ Skróty: ]>--------------------
/*stock GetBudynekID(doorid, inout)
{
	if(inout)
		return ;
	else
		return Pomieszczenie[Drzwi[doorid][outPomieszczenieID]][BudynekID];
}*/

//------------------<[ MySQL: ]>--------------------
stock budynki_ORM(id)
{
	new ORM:oid = Budynki[id][ORM] = orm_create(TABLE_BUDYNKI);
	
	orm_addvar_int(oid, Budynki[id][ID], "ID");
	orm_addvar_string(oid, Budynki[id][Nazwa], MAX_BUDYNEK_NAME, "Nazwa");
	orm_addvar_int(oid, Budynki[id][Typ], "Typ");
	orm_addvar_int(oid, Budynki[id][Wlasciciel], "Wlasciciel");
	orm_addvar_int(oid, Budynki[id][VW], "VirtualWorld");
	
	orm_setkey(oid, "ID");
}

stock pomieszczenia_ORM(id)
{
	new ORM:oid = Pomieszczenia[id][ORM] = orm_create(TABLE_POMIESZCZENIA);
	
	orm_addvar_int(oid, Pomieszczenia[id][ID], "ID");
	orm_addvar_int(oid, Pomieszczenia[id][Budynek], "Budynek");
	orm_addvar_string(oid, Pomieszczenia[id][Nazwa], MAX_POMIESZCZENIE_NAME, "Nazwa");
	orm_addvar_int(oid, Pomieszczenia[id][Interior], "Interior");
	orm_addvar_int(oid, Pomieszczenia[id][Oswietlenie], "Oswietlenie");
	orm_addvar_int(oid, Pomieszczenia[id][Pogoda], "Pogoda");
	orm_addvar_string(oid, Pomieszczenia[id][Muzyka], MAX_STREAM_LENGTH, "Muzyka");
	
	orm_setkey(oid, "ID");
}

stock drzwi_ORM(id)
{
	new ORM:oid = Drzwi[id][ORM] = orm_create(TABLE_DRZWI);
	
	//in
	orm_addvar_int(oid, Drzwi[id][ID], "ID");
	orm_addvar_string(oid, Drzwi[id][Nazwa], MAX_DRZWI_NAME, "Nazwa");
	orm_addvar_float(oid, Drzwi[id][inX], "inX");
	orm_addvar_float(oid, Drzwi[id][inY], "inY");
	orm_addvar_float(oid, Drzwi[id][inZ], "inZ");
	orm_addvar_float(oid, Drzwi[id][inA], "inA");
	orm_addvar_string(oid, Drzwi[id][in3DTextString], MAX_DRZWI3D_LENGTH, "in3DText");
	orm_addvar_int(oid, Drzwi[id][inPickupModel], "inPickup");
	orm_addvar_int(oid, Drzwi[id][inPomieszczenie], "inPomieszczenie");
	//out
	orm_addvar_float(oid, Drzwi[id][outX], "outX");
	orm_addvar_float(oid, Drzwi[id][outY], "outY");
	orm_addvar_float(oid, Drzwi[id][outZ], "outZ");
	orm_addvar_float(oid, Drzwi[id][outA], "outA");
	orm_addvar_string(oid, Drzwi[id][out3DTextString], MAX_DRZWI3D_LENGTH, "out3DText");
	orm_addvar_int(oid, Drzwi[id][outPickupModel], "outPickup");
	orm_addvar_int(oid, Drzwi[id][outPomieszczenie], "outPomieszczenie");
	orm_addvar_int(oid, Drzwi[id][lock], "Lock");
	
	orm_setkey(oid, "ID");
}

stock StworzRelacje(type=0, id=0)
{
	switch(type)
	{
		case 0:
		{
			for(new i; i<MAX_BUDYNKOW; i++)
			{
				for(new j; j<MAX_POMIESZCZEN; j++)
				{
					if(Pomieszczenia[j][Budynek] == Budynki[i][ID])
					{
						Pomieszczenia[j][BudynekID] = i;
					}
				}
			}
			for(new i; i<MAX_POMIESZCZEN; i++)
			{
				for(new j; j<MAX_DRZWI; j++)
				{
					if(Drzwi[j][inPomieszczenie] == Pomieszczenia[i][ID])
					{
						Drzwi[j][inPomieszczenieID] = i;
					}
					if(Drzwi[j][outPomieszczenie] == Pomieszczenia[i][ID])
					{
						Drzwi[j][outPomieszczenieID] = i;
					}
				}
			}
		}
		case 1:
		{
			for(new i; i<MAX_BUDYNKOW; i++)
			{
				if(Pomieszczenia[id][Budynek] == Budynki[i][ID])
				{
					Pomieszczenia[id][BudynekID] = i;
				}
			}
		}
		case 2:
		{
			for(new i; i<MAX_POMIESZCZEN; i++)
			{
				if(Drzwi[id][inPomieszczenie] == Pomieszczenia[i][ID])
				{
					Drzwi[id][inPomieszczenieID] = i;
				}
				if(Drzwi[id][outPomieszczenie] == Pomieszczenia[i][ID])
				{
					Drzwi[id][outPomieszczenieID] = i;
				}
			}
		}
	}
	return 1;
}

stock MruMySQL_LoadBudynki()
{
	inline iQuery()
	{
		new rows = IloscBudynkow = cache_get_row_count(gMySQL);
		if(rows <= MAX_BUDYNKOW)
		{
			for(new i; i<rows; i++)
			{
				budynki_ORM(i);
				orm_apply_cache(Budynki[i][ORM], i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o budynkach z tabeli "TABLE_BUDYNKI, rows);
		}
		else
		{
			Error("interiory", "MruMySQL_LoadBudynki()", "Ilosc zaladowanych budynkow wieksza niz maksymalna liczba budynkow.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_BUDYNKI"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}

stock MruMySQL_LoadPomieszczenia()
{
	inline iQuery()
	{
		new rows = IloscPomieszczen = cache_get_row_count(gMySQL);
		if(rows <= MAX_POMIESZCZEN)
		{
			for(new i; i<rows; i++)
			{
				pomieszczenia_ORM(i);
				orm_apply_cache(Pomieszczenia[i][ORM], i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o pomieszczeniach z tabeli "TABLE_POMIESZCZENIA, rows);
		}
		else
		{
			Error("interiory", "MruMySQL_LoadPomieszczenia()", "Ilosc zaladowanych pomieszczen wieksza niz maksymalna liczba pomieszczen.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_POMIESZCZENIA"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}

stock MruMySQL_LoadDrzwi()
{
	inline iQuery()
	{
		new rows = IloscDrzwi = cache_get_row_count(gMySQL);
		if(rows <= MAX_DRZWI)
		{
			for(new i; i<rows; i++)
			{
				drzwi_ORM(i);
				orm_apply_cache(Drzwi[i][ORM], i);
				drzwi_Create(i);
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o drzwiach z tabeli "TABLE_DRZWI, rows);
		}
		else
		{
			Error("interiory", "MruMySQL_LoadDrzwi()", "Ilosc zaladowanych drzwi wieksza niz maksymalna liczba drzwi.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_DRZWI"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}

/*stock MruMySQL_LoadWindy()
{
	inline iQuery()
	{
		new rows = cache_get_row_count(gMySQL);
		if(rows <= MAX_WIND)
		{
			for(new i; i<rows; i++)
			{
				
			}
			printf("MySQL: Poprawnie zaladowano %d rekordow informacji o windy z tabeli "TABLE_WINDY, rows);
		}
		else
		{
			Error("interiory", "MruMySQL_LoadWindy()", "Ilosc zaladowanych wind wieksza niz maksymalna liczba wind.");
			return 1;
		}
	}
	mysql_pquery_inline(gMySQL, "SELECT * FROM `"TABLE_WINDY"` ORDER BY `ID` ASC", using inline iQuery, "");
	return 1;
}*/

stock MruMySQL_SaveBudynek(id)
{
	orm_update(Budynki[id][ORM]); 
}

stock MruMySQL_SavePomieszczenie(id)
{
	orm_update(Pomieszczenia[id][ORM]); 
}

stock MruMySQL_SaveDrzwi(id)
{
	orm_update(Drzwi[id][ORM]); 
}

stock MruMySQL_CreateBudynek(id, playerid=-1)
{
	inline Query()
	{
		Budynki[id][ID] = cache_insert_id();
		if(playerid!=-1)
			ServerInfoF(playerid, "Stworzono budynek o ID: %d", Budynki[id][ID]);
	}
	orm_insert_inline(Budynki[id][ORM], using inline Query, ""); 
}

stock MruMySQL_CreatePomieszczenie(id, playerid=-1)
{
	inline Query()
	{
		Pomieszczenia[id][ID] = cache_insert_id();
		if(playerid!=-1)
			ServerInfoF(playerid, "Stworzono pomieszczenie o ID: %d", Pomieszczenia[id][ID]);
		StworzRelacje(1, id);
	}
	orm_insert_inline(Pomieszczenia[id][ORM], using inline Query, ""); 
}

stock MruMySQL_CreateDrzwi(id, playerid=-1)
{
	inline Query()
	{
		Drzwi[id][ID] = cache_insert_id();
		if(playerid!=-1)
			ServerInfoF(playerid, "Stworzono drzwi o ID: %d", Drzwi[id][ID]);
		StworzRelacje(2, id);
	}
	orm_insert_inline(Drzwi[id][ORM], using inline Query, ""); 
}

stock MruMySQL_DeleteBudynek(id)
{
	/*new query[1024];
	format(query, sizeof(query), "DELETE FROM `"TABLE_DRZWI"` WHERE `inPomieszczenie` IN (SELECT `ID` FROM `"TABLE_POMIESZCZENIA"` WHERE `Budynek`='%d';", Budynki[id][ID]);
	mysql_pquery(gMySQL, query);
	format(query, sizeof(query), "%s DELETE FROM `"TABLE_DRZWI"` WHERE `outPomieszczenie` IN (SELECT `ID` FROM `"TABLE_POMIESZCZENIA"` WHERE `Budynek`='%d';", Budynki[id][ID]);
	mysql_pquery(gMySQL, query);
	format(query, sizeof(query), "%s DELETE FROM `"TABLE_POMIESZCZENIA"` WHERE `Budynek` = %d;", Budynki[id][ID]);
	mysql_pquery(gMySQL, query);
	format(query, sizeof(query), "%s DELETE FROM `"TABLE_BUDYNKI"` WHERE `ID` = %d;", Budynki[id][ID]);
	mysql_pquery(gMySQL, query);
	
	for(new eBudynki:i; i<eBudynki; i++)
	{
		Budynki[id][i] = 0;
	}*/
	printf("%d, usuwanie nie zrobione - interiory.pwn", id);
	return 1;
}

stock MruMySQL_DeletePomieszczenie(id)
{
	/*new query[128];
	format(query, sizeof(query), "DELETE FROM `"TABLE_POMIESZCZENIA"` WHERE `ID` = %d", Pomieszczenia[id][ID]);
	mysql_pquery(gMySQL, query);*/
	printf("%d, usuwanie nie zrobione - interiory.pwn", id);
	return 1;
}

stock MruMySQL_DeleteDrzwi(id)
{
	/*new query[128];
	format(query, sizeof(query), "DELETE FROM `"TABLE_DRZWI"` WHERE `ID` = %d", Drzwi[id][ID]);
	mysql_pquery(gMySQL, query);*/
	printf("%d, usuwanie nie zrobione - interiory.pwn", id);
	return 1;
}

//-----------------<[ Komendy: ]>-------------------
YCMD:interiory(playerid, params[], help)
{
	if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	PanelBudynkow(playerid, false); // true - domy | false - budynki 
	return 1;
}

YCMD:stworzbudynek(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Lista parametrów:
	new typ, wlasciciel, vw, nazwa[MAX_BUDYNEK_NAME];
	
	if(sscanf(params, "ddds["#MAX_BUDYNEK_NAME"]", typ, wlasciciel, vw, nazwa)) 
	{
		CMDInfo(playerid, "U¿ycie: /stworzbudynek [typ] [wlasciciel] [virtualworld] [nazwa]");
		CMDInfo(playerid, "Dostêpne typy: PUBLICZNY-0 | SYSTEM-1 | FRAKCJA-2 | ORGANIZACJA-3 | GRACZ-4");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		StworzBudynek(IloscBudynkow++, nazwa, typ, wlasciciel, vw, playerid);
		return 1;
	}
}

YCMD:stworzpomieszczenie(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Lista parametrów:
	new budynek, interior, czas, pogoda, nazwa[MAX_BUDYNEK_NAME];
	
	if(sscanf(params, "dddds["#MAX_POMIESZCZENIE_NAME"]", budynek, interior, czas, pogoda, nazwa)) 
	{
		CMDInfo(playerid, "U¿ycie: /stworzpomieszczenie [budynek] [interior] [oswieltenie-czas] [pogoda] [nazwa]");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		StworzPomieszczenie(IloscPomieszczen++, nazwa, budynek, interior, czas, pogoda, "", playerid);
		return 1;
	}
}

YCMD:stworzdrzwi(playerid, params[], help)
{
    if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Lista parametrów:
	new Float:x, Float:y, Float:z, Float:a, p, nazwa[MAX_BUDYNEK_NAME];
	
	if(sscanf(params, "dffffs["#MAX_POMIESZCZENIE_NAME"]", p, x, y, z, a, nazwa)) 
	{
		CMDInfo(playerid, "U¿ycie: /stworzdrzwi [pomieszczenie] [x] [y] [z] [a] [nazwa]");
		return 1;
	}
	else
	{
		//Cia³o komendy:
		new Float:gx, Float:gy, Float:gz, Float:ga;
		GetPlayerPos(playerid, gx, gy, gz);
		GetPlayerFacingAngle(playerid, ga);
		StworzDrzwi(IloscDrzwi++, nazwa, gx, gy, gz, ga, "Wejscie", 1239, 1, x, y, z, a, "Wyjscie", 1239, p, false, playerid);
		return 1;
	}
}

YCMD:wejdz(playerid, params[], help)
{
	if(help)
	{
		//Pomoc
		return 1;
	}
	
	//Cia³o komendy:
	if(SprawdzDrzwi(playerid) == -1)
		ServerFail(playerid, "Brak w okolicy drzwi do których móg³byœ wejœæ");
	return 1;
}

//end