//
//

#include <a_npc>

//------------------------------------------

main()
{
}

//------------------------------------------

public OnRecordingPlaybackEnd()
{
}

//------------------------------------------

public OnNPCSpawn()
{
	SetMyPos(0,0,0);
}

//------------------------------------------

public OnNPCExitVehicle()
{
}

//------------------------------------------

public OnPlayerText(playerid, text[])
{
	if(text[0] == '#') return 1;
	
	new commanPos = strfind(text, "komenda ");
	if(strfind(text, "aport") != -1)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		SetMyPos(x, y, z);
		SendChat("# Przyj¹³em, ju¿ lecê!");
	}
	else if(strfind(text, "testuj chaty") != -1)
	{
		TestKomend();
	}
	else if(strfind(text, "testuj bubble1") != -1)
	{
		BubbleChatTest();
	}
	else if(strfind(text, "testuj bubble2") != -1)
	{
		BubbleChatTest2();
	}
	else if(commanPos != -1)
	{
		new string[256];
		strmid(string, text, commanPos+8, strlen(text));
		SendCommand(string);
	}
	else
	{
		SendChat("# Jestem tylko botem, nie rozumiem!");
		SendChat("# Dostêpne komendy: aport, testuj [chaty/bubble1/bubble2], komenda [/komenda]");
	}
    return 1;
}

public OnClientMessage(color, text[])
{
	SendChat(text);
}

//------------------------------------------

public OnNPCConnect(myplayerid)
{
    TestKomend();
	return 1;
}

BubbleChatTest2()
{
	SendCommand("/l bubble chat test :) **smieje sie w twarz**");
}

BubbleChatTest()
{
	SendCommand("/l bubble chat test heheszki lol lol trol **smieje sie w twarz**");
}

TestKomend()
{
	SendChat("Bot testowy chatów melduje siê na rozkaz! Rozpoczynam testy komend chatów!");
	SendCommand("/l no witam pana hehe");
	SendCommand("/l no witam pana hehe :)");
	SendCommand("/l no witam ;) pana :) hehe :( lol xD heh");
	SendCommand("/b no witam ;) pana :) hehe :( lol xD heh");
	SendCommand("/b no witam ;) pana :) he **smieje sie w twarz**");
	SendCommand("/l no witam ;) pana :) he **smieje sie w twarz**");
	SendCommand("/b no witam ;) pana :) he **smieje sie w twarz** po czym morduje z zimna krwia");
	SendCommand("/l no witam ;) pana :) he **smieje sie w twarz** po czym morduje z zimna krwia");
	SendCommand("/l :)");
	SendCommand("/k :(");
	SendCommand("/s ;)");
	SendCommand("/s xD");
    SendChat("Testy zakonczone!");
	return 1;
}