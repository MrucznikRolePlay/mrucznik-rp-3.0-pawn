//funkcje.pwn

//-----------------------------------------------<< System >>------------------------------------------------//
//------------------------------------------[ Modu³: funkcje.pwn ]-------------------------------------------//
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

//----------------------------------[SSCANF Operatory:]-----------------------------------
SSCANF:hajs(string[])
{
	return FunkcjaK(string);
}

//----------------------------------[Funkcje:]-----------------------------------
stock FunkcjaK(string[])
{
	new ilosc_k, len=strlen(string);
	if(len > 10)
		return 0;
	
	for(new i; i<len; i++)
	{
		if(string[i] == 'k' || string[i] == 'K')
		{
			ilosc_k++;
			if(ilosc_k > 3) //Za du¿o k
				return 0;
		}
		else if(string[i] >= '0' && string[i] <= '9' || string[i] == ',')
		{	
			if(ilosc_k != 0) //Z³y string
			{
				return 0;
			}
		}
		else //Z³y string
		{
			return 0;
		}
	}
	
	if(ilosc_k != 0)
	{
		strdel(string, strlen(string)-ilosc_k, strlen(string));
		new Float:hajs=floatstr(string);
		return floatround(hajs*floatpower(1000, ilosc_k), floatround_tozero);
	}
	else
		return strval(string);
}

//----------------------------------[Matematyka:]-----------------------------------
stock abs(int)
{
	if(int < 0)
		return -int;
	return int;
}

stock intdiffabs(tick1, tick2)
{
	if(tick1 > tick2)
		return abs(tick1 - tick2);
	else
		return abs(tick2 - tick1);
}

stock linear_interpolate(start, end, steps, count)
{
	new Float:s = start, Float:e = end, Float:final;
	final = s + ((e - s) / steps) * count;
	return floatround(final, floatround_round);
}

stock GenerateGradient(colorMin, colorMax, range, value)
{
	new minR, minG, minB, minA, maxR, maxG, maxB, maxA, resultR, resultG, resultB, resultA;
	minR = (colorMin >> 24) & 0xFF;
	minG = (colorMin >> 16) & 0xFF;
	minB = (colorMin >> 8) & 0xFF;
	minA = colorMin & 0xFF;

	maxR = ((colorMax & 0xFF000000) >> 24);
	maxG = ((colorMax & 0x00FF0000) >> 16);
	maxB = ((colorMax & 0x0000FF00) >> 8);
	maxA = (colorMax & 0x000000FF);

	resultR = linear_interpolate(minR, maxR, range, value);
	resultG = linear_interpolate(minG, maxG, range, value);
	resultB = linear_interpolate(minB, maxB, range, value);
	resultA = linear_interpolate(minA, maxA, range, value);
	
	resultR = resultR << 24;
	resultG = resultG << 16;
	resultB = resultB << 8;
	return resultR | resultG | resultB | resultA;
}

//----------------------------------[Konwertowanie:]-----------------------------------
stock HexToInt(string[])
{
    if(!string[0]) return 0;
    new cur = 1, res = 0;
    for(new i = strlen(string); i > 0; i--)
    {
        res += cur * (string[i - 1] - ((string[i - 1] < 58) ? (48) : (55)));
        cur = cur * 16;
    }
    return res;
}

//----------------------------------[Sprawdzanie:]-----------------------------------
stock IsPlayerLogged(playerid)
{
	return Group_GetPlayer(LoggedPlayers, playerid);
}

stock IsColorHex(color[])
{
	if(strlen(color) == 6)
	{
		for(new i; i<6; i++)
		{
			if(color[i] >= '0' && color[i] <= '9' || color[i] >= 'A' && color[i] <= 'F' || color[i] >= 'a' && color[i] <= 'f')
				continue;
			else 
				return 0;
		}
		return 1;
	}
	return 0;
}

stock IsNickCorrect(nick[])
{
	new regex:nickRegex = regex_new("^[A-Z]{1}[a-z]{1,}(_[A-Z]{1}[a-z]{1,}([A-HJ-Z]{1}[a-z]{1,})?){1,2}$");
	if(regex_check(nick, nickRegex))
	{
		regex_delete(nickRegex); 
		return 1;
	}
	regex_delete(nickRegex); 
	return 0;
}

//----------------------------------[Skróty:]-----------------------------------
stock SetMapNameText(text[])
{
	new string[64];
	format(string, sizeof(string), "mapname %s", text);
	SendRconCommand(string);
}

stock ClearChat(playerid)
{
	for(new i; i<200; i++)
	{
		SendClientMessage(playerid, -1, " ");
	}
	return 1;
}

 // By Southclaw (taken from https://github.com/Southclaw/ScavengeSurvive/blob/master/gamemodes/SS/utils/tickcountfix.pwn)
stock GetTickCountDifference(a, b)
{
	if ((a < 0) && (b > 0))
	{
		new dist;

		dist = intdiffabs(a, b);

		if(dist > 2147483647)
			return intdiffabs(a - 2147483647, b - 2147483647);
		else
			return dist;
	}
 
	return intdiffabs(a, b);
}

//----------------------------------[Bity:]-----------------------------------
stock BitAdd(&bianaryvalue, pozycja, bit=0b1) //dodaje/usuwa bit na danej pozycji
	return (bianaryvalue += bit<<pozycja), 1;
	
stock CheckBit(bits, position) // podaje wartoœæ bitu na danej pozycji
	return (bits & 0b1<<position) ? 1 : 0;
	
stock CreateBits(...) //pakuje bity w jedn¹ w zmienn¹
{
	new bits;
	for(new i; i<numargs(); i++)
	{
		bits += getarg(i, 0)<<i;
	}
	return bits;
}

stock CountBits(bits, max=32) //zlicza wszystkie niezerowe bity
{
	new number;
	for(new i; i<max; i++)
	{
		number+=CheckBit(bits, i);
	}
	return number;
}

stock CheckBitPos(bits, number) //sprawdza jak¹ pozycje ma X niezerowy bit
{
	new pos, ammount;
	while(ammount!=number+1)
	{
		if(CheckBit(bits, pos))
			ammount++;
		pos++;
	}
	return pos-1;
}

stock CreateBitsText(bits, ...)
{	static const args = 1;
    new n = numargs();
	new text[64], string[256];
	
	for(new i=args; i<n; i++)
	{
		if(CheckBit(bits, i-args))
		{
			text[0]='\0';
			for(new j=0; (text[j]=getarg(i, j)) !=0; j++) 
			{ 
				/*if(j==sizeof(text)-1) 
				{
					string[0]='\0';
					printf("Blad funkcji CreateDynamicDialog: za dlugi tekst w argumencie nr %d", i);
					return string;
				}*/
			}
			strcat(string, text);
			if(i+1 < n) strcat(string, "\n");
		}
	}
	safe_return string;
}

stock CreateColouredBitsText(bits, pozycja, defaultcolor[], color[], ...)
{	static const args = 4;
    new n = numargs(), string[256], text[64];
	
	strcat(string, defaultcolor);
	for(new i=args; i<n; i++)
	{
		if(CheckBit(bits, i-args))
		{
			text[0]='\0';
			for(new j=0; (text[j]=getarg(i, j))!=0; j++) 
			{
				/*if(j==sizeof(text)-1) 
				{
					string[0]='\0';
					printf("Blad funkcji CreateDynamicDialog: za dlugi tekst w argumencie nr %d", i);
					return string;
				}*/
			}
			if(pozycja == i-args)
			{
				strcat(string, color);
				strcat(string, text);
				if(i+1 < n) strcat(string, "\n");
				strcat(string, defaultcolor);
				continue;
			}
			strcat(string, text);
			if(i+1 < n) strcat(string, "\n");
		}
	}
	safe_return string;
}

stock CreateColouredBitsTextBitPos(bits, pozycja, defaultcolor[], color[], ...)
{	static const args = 4;
    new n = numargs(), string[256], text[64];
	
	strcat(string, defaultcolor);
	for(new i=args; i<n; i++)
	{
		if(CheckBit(bits, i-args))
		{
			text[0]='\0';
			for(new j=0; (text[j]=getarg(i, j))!=0; j++) 
			{
				/*if(j==sizeof(text)-1) 
				{
					string[0]='\0';
					printf("Blad funkcji CreateDynamicDialog: za dlugi tekst w argumencie nr %d", i);
					return string;
				}*/
			}
			if(CheckBit(pozycja, i-args))
			{
				strcat(string, color);
				strcat(string, text);
				strcat(string, defaultcolor);
			}
			else
				strcat(string, text);
			if(i+1 < n) strcat(string, "\n");
		}
	}
	safe_return string;
}

//--------------------------------[Pobieranie:]---------------------------------
stock GetNick(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	return nick;
}

stock GetIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	safe_return ip;
}

stock GetKeysName(keys)
{
	new string[256];
	
	static const KeyNames[][] = 
	{
		"Klawisz akcji",
		"Klawisz kucniêcia",
		"Klawisz strza³u",
		"Klawisz sprintu",
		"Klawisz wejœcia do pojazdu",
		"Klawisz skoku",
		"Klawisz spogl¹dania w prawo",
		"Klawisz mierzenia",
		"Klawisz spogl¹dania w lewo",
		"Klawisz wolnego chodzenia",
		"Numpad w górê",
		"Numpad w dó³",
		"Numpad w lewo",
		"Numpad w prawo",
		"Klawisz TAK",
		"Klawisz NIE",
		"Klawisz grupy"
	};
	
	new bool:jest;
	for(new i; i<sizeof(KeyNames); i++)
	{
		if(CheckBit(keys, i))
		{
			if(jest)
				strcat(string, " + ", sizeof(string));
			else
				jest=true;
			strcat(string, KeyNames[i], sizeof(string));
		}
	}
	
	safe_return string;
}

stock StartGettingKeys(playerid, function[])
{
	SetPVarInt(playerid, "GettingKeys", 1);
	SetPVarString(playerid, "GettingKeysFunction", function);
	ServerInfo(playerid, "Rozpoczynam pobieranie klawiszy - proszê wprowadziæ klawisze które maj¹ zostaæ zapamiêtane.");
}

//----------------------------------[Pozycja:]----------------------------------

stock IsPlayerInRangeToPlayer(playerid, giveplayerid, Float:range=15.0)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(giveplayerid, x, y, z);
	if (IsPlayerInRangeOfPoint(playerid, range, x, y, z))
	{
		return 1;
	}
	else return 0;
}

stock Float:GetDistanceBetweenPlayers(playerid1, playerid2)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid2, x, y, z);
	return GetPlayerDistanceFromPoint(playerid1, x, y, z);
}

stock GetClosestPlayer(playerid)
{
	new Float:x, Float:y, Float:z, Float:distance=99999.0, Float:compare, playerid2;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : StreamedPlayers[playerid])
	{
		compare = GetDistanceBetweenPlayers(playerid, i);
		if(compare < distance)
		{
			distance = compare;
			playerid2 = i;
		}
	}
	return playerid2;
}

//-----------------------------------[Chat:]------------------------------------

stock MruMessage(playerid, kolor, text[])
{
	new lenght = strlen(text);
	if(lenght > MAX_MESSAGE_LENGHT)
	{
		new bufor[MAX_MESSAGE_LENGHT], spacja;
		for(spacja=MAX_MESSAGE_LENGHT-5; spacja>MAX_MESSAGE_LENGHT*0.75; spacja--)
			if(text[spacja] == ' ') break;
		
		strmid(bufor, text, 0, spacja);
		strcat(bufor, "...");
		SendClientMessage(playerid, kolor, bufor);
		strmid(bufor, text, spacja+1, lenght);
		strins(bufor, "...", 0);
		SendClientMessage(playerid, kolor, bufor);
		return 1;
	}
	else
	{
		return SendClientMessage(playerid, kolor, text);
	}
}

stock MruMessageToAll(kolor, text[])
{
	new lenght = strlen(text);
	if(lenght > MAX_MESSAGE_LENGHT)
	{
		new bufor[MAX_MESSAGE_LENGHT], spacja;
		for(spacja=MAX_MESSAGE_LENGHT-5; spacja>MAX_MESSAGE_LENGHT*0.75; spacja--)
			if(text[spacja] == ' ') break;
		
		strmid(bufor, text, 0, spacja);
		strcat(bufor, "...");
		SendClientMessageToAll(kolor, bufor);
		strmid(bufor, text, spacja+1, lenght);
		strins(bufor, "...", 0);
		SendClientMessageToAll(kolor, bufor);
	}
	else
	{
		return SendClientMessageToAll(kolor, text);
	}
	return 1;
}

stock MruMessageF(playerid, color, fstring[], {Float, _}:...) //by Y_Less edited by Mrucznik
{
    static const STATIC_ARGS = 3;
    new n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
    if(n)
    {
        new message[256],arg_start,arg_end;
        #emit CONST.alt        fstring
        #emit LCTRL          5
        #emit ADD
        #emit STOR.S.pri        arg_start

        #emit LOAD.S.alt        n
        #emit ADD
        #emit STOR.S.pri        arg_end
        do
        {
            #emit LOAD.I
            #emit PUSH.pri
            arg_end -= BYTES_PER_CELL;
            #emit LOAD.S.pri      arg_end
        }
        while(arg_end > arg_start);

        #emit PUSH.S          fstring
        #emit PUSH.C          256
        #emit PUSH.ADR         message

        n += BYTES_PER_CELL * 3;
        #emit PUSH.S          n
        #emit SYSREQ.C         format

        n += BYTES_PER_CELL;
        #emit LCTRL          4
        #emit LOAD.S.alt        n
        #emit ADD
        #emit SCTRL          4

        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return MruMessageToAll(color, message);
        } else {
            return MruMessage(playerid, color, message);
        }
    } else {
        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return MruMessageToAll(color, fstring);
        } else {
            return MruMessage(playerid, color, fstring);
        }
    }
}

stock RangeMessage(playerid, kolor, text[], Float:zasieg=30.0)
{ //wiadomoœæ wyœwietlana w okreœlonym zasiêgu
	new Float: x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	if (zasieg > STREAM_DISTANCE)
	{
		foreach(new i : GroupMember(LoggedPlayers))
		{
			if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				if(IsPlayerInRangeOfPoint(i, zasieg, x, y, z))
				{
					MruMessage(i, kolor, text);
				}
			}
		}
	}
	else
	{
		MruMessage(playerid, kolor, text);
		foreach(new i : StreamedPlayers[playerid])
		{
			if(IsPlayerInRangeOfPoint(i, zasieg, x, y, z))
			{
				MruMessage(i, kolor, text);
			}
		}
	}
	return 1;
}

stock RangeMessageGradient(playerid, text[], Float:zasieg, kolormin, kolormax)
{ //wiadomoœæ wyœwietlana w okreœlonym zasiêgu kolorowana w zale¿noœci od odleg³oœci
	new Float: x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	if (zasieg > STREAM_DISTANCE)
	{
		foreach(new i : GroupMember(LoggedPlayers))
		{
			if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
			{
				new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
				if(distance <= zasieg)
				{
					MruMessage(i, GenerateGradient(kolormin, kolormax, floatround(zasieg), floatround(distance)), text);
				}
			}
		}
	}
	else
	{
		MruMessage(playerid, kolormin, text);
		foreach(new i : StreamedPlayers[playerid])
		{
			new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
			if(distance <= zasieg)
			{
				MruMessage(i, GenerateGradient(kolormin, kolormax, floatround(zasieg), floatround(distance)), text);
			}
		}
	}
	return 1;
}

//#define ANTY_SPAM(%0,%1) if(AntySpam(%0,%1)) return 1
stock AntySpam(playerid, time)
{
	if(gAntySpam[playerid] > SPAM_PROTECTION_VALUE)
	{
		ServerFail(playerid, "Ochrona przed spamem! Anulowano wykonanie rz¹danego dzia³ania. Spróbuj jeszcze raz.");
		SetTimerEx("timer_AntySpam", time, 0, "d", playerid);
		return 1;
	}
	else
	{
		gAntySpam[playerid]++;
		return 0;
	}
}

forward timer_AntySpam(playerid);
public timer_AntySpam(playerid)
{
	gAntySpam[playerid] = 0;
	return 1;
}

//-----------------------------------[Captcha]------------------------------------

stock DoTheCaptcha(playerid, length, letters=true, sized=true, numbers=true)
{
	if(length > 127 || length < 0) length=127;
	new bits = CreateBits(letters, sized, numbers);
	new ilosc=letters+sized+numbers;
	
	for(new i; i<length; i++)
	{
		switch (CheckBitPos(bits, random(ilosc)))
		{
			case 0: //ma³a literka
			{
				gCaptcha[playerid][i] = 'a'+random(26);
			}
			case 1: //duza literka
			{
				gCaptcha[playerid][i] = 'A'+random(26);
			}
			case 2: //cyfra
			{
				gCaptcha[playerid][i] = '0'+random(10);
			}
			default:
			{
				gCaptcha[playerid][i]='#';
			}
		}
	}
	gCaptcha[playerid][length] = '\0';
	safe_return gCaptcha[playerid];
}

stock CheckCaptcha(playerid, text[])
{
	if(strcmp(gCaptcha[playerid], text, false) && !isnull(text))
		return 1;
	else
		return 0;
}

//-----------------------------------[Ex - funkcje zamiast:]------------------------------------
stock KickEx(playerid)
{
	defer KickTimer(playerid);
}

timer KickTimer[500](playerid)
{
	Kick(playerid);
}

//¯ycie i pancerz
/*stock SetPlayerHealthEx(playerid, Float:health)
{
	ACExpect(playerid, AC_HP, 1);
	gHealth[playerid] = health;
	return SetPlayerHealth(playerid, health);
}

stock SetPlayerArmourEx(playerid, Float:armor)
{
	ACExpect(playerid, AC_ARMOR, 1);
	gArmor[playerid] = armor;
	return SetPlayerArmour(playerid, armor);
}

//Hajsy
stock GivePlayerMoneyEx(playerid, hajs)
{
	AC_Money(playerid);
	PlayerInfo[playerid][pHajs] += hajs;
	return GivePlayerMoney(playerid, hajs);
}

stock GetPlayerMoneyEx(playerid)
{
	AC_Money(playerid);
	return PlayerInfo[playerid][pHajs];
}

stock ResetPlayerMoneyEx(playerid)
{
	AC_Money(playerid);
	PlayerInfo[playerid][pHajs] = 0;
	return ResetPlayerMoney(playerid);
}*/

//end