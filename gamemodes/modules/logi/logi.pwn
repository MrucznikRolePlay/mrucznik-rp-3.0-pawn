//login.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//------------------------------------------[ Modu³: login.pwn ]---------------------------------------------//
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
stock Log(plik[], text[])
{
	new data[2][3], string[512];
	new File:file = fopen(plik, io_append);

	gettime(data[0][0], data[0][1], data[0][2]);
	getdate(data[1][0], data[1][1], data[1][2]);

	format(string, sizeof(string), "[%02i/%02i/%i - %02i:%02i:%02i] %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], text);
	fwrite(file, string);
	return fclose(file);
}

stock PlayerLog(playerid, plik[], text[])
{
	new data[2][3], string[512];
	new File:file = fopen(plik, io_append);

	gettime(data[0][0], data[0][1], data[0][2]);
	getdate(data[1][0], data[1][1], data[1][2]);

	format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s: %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], GetNick(playerid), text);
	fwrite(file, string);
	return fclose(file);
}

stock LogF(plik[], fstring[], {Float, _}:...) //#emit by Y_Less
{
    static const STATIC_ARGS = 2;
    new n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
	new data[2][3], string[512];
	new File:file = fopen(plik, io_append);

	gettime(data[0][0], data[0][1], data[0][2]);
	getdate(data[1][0], data[1][1], data[1][2]);
	
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

		format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], message);
    } 
	else 
	{
		format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], fstring);
    }
	fwrite(file, string);
	return fclose(file);
}

stock PlayerLogF(playerid, plik[], fstring[], {Float, _}:...) //#emit by Y_Less
{
    static const STATIC_ARGS = 3;
    new n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
	new data[2][3], string[512];
	new File:file = fopen(plik, io_append);

	gettime(data[0][0], data[0][1], data[0][2]);
	getdate(data[1][0], data[1][1], data[1][2]);
	
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

		format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s: %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], GetNick(playerid), message);
    } 
	else 
	{
		format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s: %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], GetNick(playerid), fstring);
    }
	fwrite(file, string);
	return fclose(file);
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end