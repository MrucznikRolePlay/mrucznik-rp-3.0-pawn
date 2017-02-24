//mru_mysql.pwn

//----------------------------------------------<< Source >>-------------------------------------------------//
//----------------------------------------[ Modu³: mru_mysql.pwn ]-------------------------------------------//
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

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	switch(errorid)
	{
		case CR_SERVER_GONE_ERROR:
		{
			printf("[MySQL] Lost connection to server, trying reconnect...");
		}
		case ER_SYNTAX_ERROR:
		{
			new string[128];
			format(string, sizeof(string), "Something is wrong in your syntax, query: %s", query);
			print(string);
			Error("mru_mysql", "OnQueryError", string);
		}
		default:
		{
			print("------------[ Something goes wrong with MySQL]------------");
			printf("ErrorID: %d", errorid);
			printf("Error: %s", error);
			printf("Callback: %s", callback);
			printf("Query: %s", query);
			printf("Connection Handle: %d", _:handle);
			print("----------------------------------------------------------");
			Error("mru_mysql", "OnQueryError", error);
		}
	}
	return 1;
}

//-----------------<[ Funkcje: ]>-------------------
INI:mysql_connect[](name[], value[])
{
	INI_String("Host", MYSQL_HOST, sizeof(MYSQL_HOST));
	INI_String("User", MYSQL_USER, sizeof(MYSQL_USER));
	INI_String("DB", MYSQL_DATABASE, sizeof(MYSQL_DATABASE));
	INI_String("Pass", MYSQL_PASS, sizeof(MYSQL_PASS));
	return 0;
}

MruMySQL_Connect() //OnGameModeInit
{
	if(!fexist("MySQL/mysql_connect.ini"))
		return Error("Mru_MySQL", "MruMySQL_Connect", "Brak pliku MySQL/mysql_connect.ini");
	INI_Load("MySQL/mysql_connect.ini");

	//Logi MySQL
	#if DEBUG_MODE==2
		mysql_log(ALL); // debug
	#else
		mysql_log(ERROR | WARNING); // release
	#endif
	// Po³¹czenie MySQL: (const host[], const user[], const password[], const database[], MySQLOpt:option_id = MySQLOpt:0)
    gMySQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DATABASE);
	
	if(mysql_errno() != 0)
	{
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		print("MYSQL: Nieudane polaczenie z baza MySQL!!!!!!!!!!");
		SendRconCommand("exit");
		return 0;
	}
	else
	{
		print("MYSQL: Polaczono sie z baza MySQL");
	}
	
	CreateTablesIfNotExists();
	return 1;
}

MruMySQL_Exit() //OnGameModeExit
{
	mysql_close(gMySQL);
	return 1;
}

stock CreateTablesIfNotExists()
{
	//mysql_query(gMySQL, "CREATE TABLE IF NOT EXISTS `mru_konta`", false);
	return 1;
}

stock MruMySQL_Query()
{
	return 1;
}

//end