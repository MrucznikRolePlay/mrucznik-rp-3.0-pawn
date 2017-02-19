//prace.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: prace.pwn ]---------------------------------------------//
//Opis:
/*

*/
//Adnotacje:
/*
	Prace do stworzenia:
	 Legalne prace:
		-Mechanik							0%
			-Naprawa aut
			-Tankowanie aut
			-Tuning aut
			-Ulepszenia aut
		-Prawnik							0%
			-Zbijanie WL
				-Przy wiêkszym skillu mo¿esz zbijaæ wy¿szy WL
			-Czyszczenie kartotek
			-Uwalnianie z wiêzienia
				-Za zgod¹ od PD'ka
				-Zgoda uprawnia do uwolnienia 1,2 i 3 wiêŸniów przy skilach (odpowiednio) 1,3,5
			-Kupowanie mo¿liwoœci wyjœcia za kaucja (gdy kupisz mo¿esz wyjœæ z paki za kaucj¹)
				-Im wy¿szy skill tym wiêcej wa¿ne wyjœcie
		-£owca Nagród						0%
			-£apanie przestêpców z WL
				-Im wy¿szy skill tym wiêksze WL do z³apania = wiêksze nagrody
			-
		-Busiarz							0%
			-Je¿d¿enie busami
			-Wy¿szy skill - jazda taxówk¹
			-Mistrzowski skill - taxi ka¿dym autem
		-Bokser(instruktor walki)			0%
		-Roznosiciel						0%
		-Trucker							0%
	 Nielegalne prace:
		-Diler broni						0%
			-Zbieranie materia³ów z fabryki (kursy)
			-Sprzeda¿ klamek
				-Im wy¿szy skil tym lepsze klamy
		-Przemytnik							0%
			-Kradzie¿ materia³ów ze statku NG (kursy)
			-Sprzeda¿ ³adunków wybuchowych
			-Sprzeda¿ wytrychów
			-Sprzeda¿ wszystkich innych przedmiotów przestêpczych oprócz broni
		-Diler narkotyków					0%
			-Sprzeda¿ narkotyków (w trakcie wymyœlania)
		-Z³odziej							0%
			-Kradzie¿ kieszonkowa
			-Kradzie¿ aut
			-W³amania do domów
			-W³amania do biznesów
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
stock prace_Init()
{
	return 1;
}

stock prace_Exit()
{
	return 1;
}

stock PracaSpawn(playerid)
{
	new job = PlayerInfo[playerid][pPraca];
	SetPlayerPos(playerid, SpawnPrac[job][0], SpawnPrac[job][1], SpawnPrac[job][2]);
	SetPlayerFacingAngle(playerid, SpawnPrac[job][3]);
	return 1;
}

stock ePrace:ZnajdzPracePozycja(playerid)
{
	for(new ePrace:i; i<ePrace; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, INVITE_RANGE, InvitePlace[i][0], InvitePlace[i][1], InvitePlace[i][2]))
			return i;
	}
	return ePrace:BRAK_PRACY;
}

stock PracaDolacz(playerid)
{
	new ePrace:job=ZnajdzPracePozycja(playerid);
	
	if(job)
	{
		inline iDialog(pid, dialogid, response, listitem, string:inputtext[])
		{
			#pragma unused pid, dialogid, listitem, inputtext
			if(response)
				PracaZatrudnij(playerid, job);
		}
		new tytul[32], text[256];
		format(tytul, sizeof(tytul), "Praca - %s", NazwyPrac[job]);
		format(text, sizeof(text), "Witaj %s! A wiêc chcesz zostaæ %s?\nAby to zrobiæ, musisz podpisaæ 5-cio godzinny kontrakt.\nNa czas trwania kontraktu nie bêdziesz móg³ siê zwolniæ ani zatrudniæ w innej pracy.\nNaciœnij \"Podpisz\" aby podpisaæ kontrakt i dostaæ tê pracê.", GetNick(playerid), NazwyPrac2[job]);
		Dialog_ShowCallback(playerid, using inline iDialog, DIALOG_STYLE_MSGBOX, tytul, text, "Podpisz", "Anuluj");
	}
	else
	{
		ServerFail(playerid, "W pobli¿u nie ma ¿adnej pracy, do której mo¿na by do³¹czyæ.");
	}
	return 1;
}

stock PracaZatrudnij(playerid, ePrace:job)
{
	ServerInfoF(playerid, "Gratulacje, jesteœ teraz %s! Powodzenia w zarabianiu pieniêdzy w twoim nowym fachu.", NazwyPrac2[job]);
	PlayerInfo[playerid][pPraca] = job;
	PracaInfo[playerid][pKontrakt] = 5;
	
	DajUprawnieniaPracy(playerid, job);
	return 1;
}

stock PracaZwolnij(playerid)
{	
	ZabierzUprawnieniaPracy(playerid, PlayerInfo[playerid][pPraca]);
	return 1;
}

stock DajUprawnieniaPracy(playerid, ePrace:job)
{
	#pragma unused playerid
	switch(job)
	{
		case MECHANIK:
		{
			//Daj uprawnieñ mechanika, np. uprawnienia do komend
		}
		case PRAWNIK:
		{
		}
		case BUSIARZ:
		{
		}
		case LOWCA:
		{
		}
		case TRUCKER:
		{
		}
		case DILER_BRONI:
		{
		}
		case DILER_DRAGOW:
		{
		}
		case PRZEMYTNIK:
		{
		}
		case ZLODZIEJ:
		{
		}
	}
}

stock ZabierzUprawnieniaPracy(playerid, ePrace:job)
{
	switch(job)
	{
		case MECHANIK:
		{
			//Zabranie uprawnieñ mechanika, np. uprawnienia do komend
		}
		case PRAWNIK:
		{
		}
		case BUSIARZ:
		{
		}
		case LOWCA:
		{
		}
		case TRUCKER:
		{
		}
		case DILER_BRONI:
		{
		}
		case DILER_DRAGOW:
		{
		}
		case PRZEMYTNIK:
		{
		}
		case ZLODZIEJ:
		{
		}
	}
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
YCMD:dolacz(playerid, params[], help)
{
	if(help) return SendClientMessage(playerid, -1, "Pozwala zatrudniæ siê w pracy.");

	if(PlayerInfo[playerid][pPraca] == 0)
	{
		PracaDolacz(playerid);
	}
	else
	{
		ServerFail(playerid, "Posiadasz ju¿ pracê, najpierw musisz siê zwolniæ, aby zatrudniæ siê w innej.");
	}
	return 1;
}

//end