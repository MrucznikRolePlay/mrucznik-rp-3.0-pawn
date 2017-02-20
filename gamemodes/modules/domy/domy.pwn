//domy.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: domy.pwn ]----------------------------------------------//
//Opis:
/*
	Co zawiera SYSTEM DOMÓW:
		- Kupowanie domu
			- Licytacja domów (mo¿na te¿ offline)
		- Sprzedawanie domu
		- Wymiana domu
		- Zarz¹dzanie dodatkami domu
			- Natê¿enie œwiat³a
			- Brawa œwiat³a (pogoda)
		- Meblowanie domu
			- Stawianie mebli
			- Kupowanie mebli
				- Od systemu
			- Sprzedawanie mebli za pó³ ceny
			- Edytowanie mebli
			- Stawianie specjalnych mebli (dodaj¹cych funkcjonalnoœci do domu)
				- Sejf
				- Zbrojownia
				- Szafa
				- Radio/G³oœniki
		- Stawianie œcian i sufitów i pod³óg
			- Aby edytowaæ dom trzeba wyrobiæ patent budowlany w DMV
			- Stawianie œ/s/p
			- Kupowanie œ/s/p
			- Sprzedawanie œ/s/p
			- Edytowanie œ/s/p
		- Zamykanie drzwi domu
		- Dawanie kluczy do domu
		- Wygasanie domu po miesi¹cu nieaktywnoœci
			- 5 dni przed wygaœniêciem rozpoczyna siê licytacja domu w której gracze mog¹ braæ udzia³ (je¿eli gracz wejdzie licytacja przepada)
		- Limity
			- Limit maksymalnej iloœci pomieszczeñ (/wejdz, /wyjdz)
			- Limit maksymalnej powierzchni jak¹ mo¿na umeblowaæ (powinna byæ taka sama jak gabaryty domu na zewn¹trz)
		- Premium
			- Mo¿liwoœæ zakupienia dodatkowej powierzchni zawartej w innym pomieszczeniu
			- Mo¿liwoœæ zakupienia ró¿nych specjalnych pomieszczeñ w innym pomieszczeniu (takich jak basen, strzelnica, piwnica itd)
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


//------------------<[ MySQL: ]>--------------------
stock domy_ORM(id)
{
	new ORM:oid = Dom[id][ORM] = orm_create(TABLE_DOMY);
	
	orm_addvar_int(oid, Dom[id][ID], "ID");
	orm_addvar_int(oid, Dom[id][Budynek], "Budynek");
	orm_addvar_int(oid, Dom[id][Cena], "Cena");
	orm_addvar_int(oid, Dom[id][Wlasciciel], "Cena");
	//orm_addvar_string(oid, Dom[id][Nazwa], MAX_BUDYNEK_NAME, "Nazwa");
	
	orm_setkey(oid, "ID");
}

//-----------------<[ Komendy: ]>-------------------
/*YCMD:stworzdrzwi(playerid, params[], help)
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
}*/

//end