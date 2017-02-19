//MODULE_NAME.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: MODULE_NAME.pwn ]------------------------------------------//
//Opis:
/*
	Antyczit podzielony na sekcje/modu³y. Zarz¹dzaniem nim poprzez funkcje, nie odwo³ujemy siê raczej do zmiennych zadeklarowanych w module.
	Ka¿d¹ sekcjê mo¿na wy³¹czyæ czasowo lub okreœliæ dla niej wyj¹tek. 
	Je¿eli sekcja jest wy³¹czona antycheat przez okreslony czas nie bêdzie reagowa³ na wykryte niezgodnoœci z danej sekcji.
	Je¿eli sekcja posiada wyj¹tek/wyj¹tki, jedna wykryta niezgodnoœæ usunie/odejmie jeden wyj¹tek.
	
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

antycheat_Init()
{
	return 1;
}

//-----[ AC na ¿ycie ]------
stock AC_Health(playerid, Float:oldhealth, Float:newhealth)
{
	if( newhealth-oldhealth > 0) //wyj¹tki dla niezgodnoœci
	{
		if(AC_Check(playerid, AC_HP))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	else
		return 0;
}

//-----[ AC na pancerz ]------
stock AC_Armor(playerid, Float:oldarmor, Float:newarmor)
{
	if( newarmor-oldarmor > 0) //wyj¹tki dla niezgodnoœci
	{
		if(AC_Check(playerid, AC_ARMOR))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	else
		return 0;
}

//-----[ AC na hajs ]------
stock AC_Money(playerid)
{
	if(AC_Check(playerid, AC_MONEY))
	{
		if(PlayerInfo[playerid][pHajs] != GetPlayerMoney(playerid))
		{
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, PlayerInfo[playerid][pHajs]);
			return 1;
		}
		else
			return 0;
	}
	else
		return 0;
}

//-----[ AC na broñ ]------
stock AC_Weapon(playerid)
{
	if(AC_Check(playerid, AC_WEAPON))
	{
		if( true ) //warunki na czita
		{
			//dzia³ania
			return 1;
		}
		else
		{
			return 0;
		}
	}
	else
		return 0;
}

//---------------------------------------------------
//---------------[ SILNIK ANTYCZITA ]----------------
//---------------------------------------------------
//-----[ Sprawdzanie stanu sekcji ]------
stock AC_Check(playerid, AC_MODULES:module)
{
	if(IsACDisabled(playerid, module))
	{
		ServerInfo(playerid, "AC Disabled");
		return 0;
	}
	else
	{
		if(IsACExpected(playerid, module))
		{
			ACExpectationDetected(playerid, module);
			ServerInfo(playerid, "AC Expectation");
			return 0;
		}
		else
		{
			return 1;
		}
	}
}

//-----[ Funkcje w³¹czania sekcji antycheata ]------
stock AC_Disable(playerid, AC_MODULES:module=AC_ALL, time=-1 )
{
	if(module==AC_ALL)
	{
		for(new AC_MODULES:i; i<AC_MODULES; i++)
		{
			ACstate[playerid][i] = true;
			if(time>0)
			{
				SetTimerEx("timer_ACDisableTime", time, 0, "dd", playerid, _:i);
			}
			else if (time==-1)
			{
				SetTimerEx("timer_ACDisableTime", AC_DISABLE_TIMES[AC_ALL], 0, "dd", playerid, _:i);
			}
		}
	}
	else
	{
		ACstate[playerid][module] = true;
		if(time>0)
		{
			SetTimerEx("timer_ACDisableTime", time, 0, "dd", playerid, _:module);
		}
		else if (time==-1)
		{
			SetTimerEx("timer_ACDisableTime", AC_DISABLE_TIMES[module], 0, "dd", playerid, _:module);
		}
	}
	return 1;
}

stock AC_Enable(playerid, AC_MODULES:module)
{
	ACstate[playerid][module] = false;
	return 1;
}

stock IsACDisabled(playerid, AC_MODULES:module)
{
	return ACstate[playerid][module];
}

//-----[ Funkcje oczekiwañ antycheata ]------
stock ACExpect(playerid, AC_MODULES:module, times=1, expirationtime=AC_ExpirationTime)
{
	ACexpect[playerid][module] += times;
	if(expirationtime>0) SetTimerEx("timer_ACExpirationOfExpectation", expirationtime, 0, "ddd", playerid, _:module, ACexpect[playerid][module]);
	return 1;
}

stock IsACExpected(playerid, AC_MODULES:module)
{
	if(ACexpect[playerid][module] > 0)
		return 1;
	else 
		return 0;
}

stock ACExpectationDetected(playerid, AC_MODULES:module)
{
	ACexpect[playerid][module]--;
	return 1;
}

//-----[ Funkcje warningów antycheata ]------
/*stock ACWarning(playerid, AC_MODULES:module)
{
	ACWarning[playerid][module]++;
	if(ACWarning[playerid][module] > AC_MAX_WARNINGS[module])
	{
		ACReport(playerid, module);
	}
}

ACReport(playerid, AC_MODULES:module)
{
	
}*/

//-----------------<[ Timery: ]>--------------------
public timer_ACDisableTime(playerid, AC_MODULES:module)
{
	AC_Enable(playerid, AC_MODULES:module);
}

public timer_ACExpirationOfExpectation(playerid, AC_MODULES:module, value) //czas wygaœniêcia oczekiwania
{
	if(ACexpect[playerid][module] == value && value > 0)
	{
		ACExpectationDetected(playerid, AC_MODULES:module);
	}
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end