//wanted.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: wanted.pwn ]------------------------------------------//
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
wanted_OnPlayerDeath(playerid, killerid, reason)
{
	#pragma unused reason
	if(killerid != INVALID_PLAYER_ID)
	{
		//----[ Morderstwo: ]----
		if(IsALider(playerid))
		{
			if(IsAFraction(playerid, LSPD))
			{
				Suspect(killerid, "Morderstwo Komendanta", 5);
				CrimeStatistic(playerid, CRIME_PDLIDER_MURDER);
			}
			else if(IsAFraction(playerid, FBI))
			{
				Suspect(killerid, "Morderstwo Dyrektora FBI", 5);
				CrimeStatistic(playerid, CRIME_FBILIDER_MURDER);
			}
			else if(IsAFraction(playerid, SWAT))
			{
				Suspect(killerid, "Morderstwo Dowódcy SWAT", 5);
				CrimeStatistic(playerid, CRIME_SWATLIDER_MURDER);
			}
			else if(IsAFraction(playerid, DMV))
			{
				Suspect(killerid, "Morderstwo Burmistrza", 10);
				CrimeStatistic(playerid, CRIME_BURMISTRZ_MURDER);
			}
		}
		else if(IsACop(playerid))
		{
			Suspect(killerid, "Morderstwo Policjanta", 2);
			CrimeStatistic(playerid, CRIME_COP_MURDER);
		}
		else
		{
			Suspect(killerid, "Morderstwo", 1);
			CrimeStatistic(playerid, CRIME_MURDER);
		}
	}
	else
	{
		if(PlayerInfo[playerid][pWL] >= PRISON_WL_VALUE)
		{
			//Do paki
		}
	}
	return 1;
}

Suspect(playerid, crime[], wl, cop=INVALID_PLAYER_ID)
{
	IncreaseWantedLevel(playerid, wl);
	ShowCrimeMessage(playerid, cop, crime);
	return 1;
}

IncreaseWantedLevel(playerid, ammount)
{
	PlayerInfo[playerid][pWL] += ammount;
	if( PlayerInfo[playerid][pWL] > 10)
		PlayerInfo[playerid][pWL] = 10;
	return 1;
}

ShowCrimeMessage(playerid, cop, crime[])
{
	new string[256];
	if(cop == INVALID_PLAYER_ID)
	{
		if(PlayerInfo[playerid][pWL] > 5)
		{
			format(string, sizeof(string), "Pope³ni³eœ przestêpstwo ( %s ). Zg³osi³: Monitoring LSPD.", crime);
		}
		else
		{
			format(string, sizeof(string), "Pope³ni³eœ przestêpstwo ( %s ). Zg³osi³: Satelita FBI.", crime);
		}
	}
	else
	{
		format(string, sizeof(string), "Pope³ni³eœ przestêpstwo ( %s ). Zg³osi³: %s.", crime, GetNick(cop));
	}
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	format(string, sizeof(string), "Posiadany Wanted Level: %d", PlayerInfo[playerid][pWL]);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
	return 1;
}

CrimeInfo(playerid, string[])
{
	
	return 1;
}

CrimeStatistic(playerid, type=CRIME_OTHER)
{
	return 1;
}



//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end