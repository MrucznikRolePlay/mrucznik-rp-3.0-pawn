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
logi_Init()
{
	MainLog = CreateLog(ROOT_LOG_PATH"main", ALL, true);
	ChatLog = CreateLog(PLAYER_LOG_PATH"chat", ALL, false);
	PWLog = CreateLog(PLAYER_LOG_PATH"pw", ALL, false);
	LoginLog = CreateLog(PLAYER_LOG_PATH"login", ALL, false);
	PayLog = CreateLog(PLAYER_LOG_PATH"money", ALL, false);
	AdminChatLog = CreateLog(ADMIN_LOG_PATH"chat", ALL, false);
	AdminCommandLog = CreateLog(ADMIN_LOG_PATH"command", ALL, false);
}

logi_Exit()
{
	DestroyLog(MainLog);
	DestroyLog(ChatLog);
	DestroyLog(PWLog);
	DestroyLog(LoginLog);
	DestroyLog(PayLog);
	DestroyLog(AdminChatLog);
	DestroyLog(AdminCommandLog);
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end