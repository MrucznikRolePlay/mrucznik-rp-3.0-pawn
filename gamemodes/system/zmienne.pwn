//zmienne.pwn

//-----------------------------------------------<< System >>------------------------------------------------//
//------------------------------------------[ Modu³: zmienne.pwn ]-------------------------------------------//
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

//------------------<[ Tablice: ]>-------------------
new gZalogowany[MAX_PLAYERS];
new gAntySpam[MAX_PLAYERS];
new gCaptcha[MAX_PLAYERS][128];

//------------------<[ Globalne enumy: ]>-------------------


//------------------<[ Tablice zainicjalizowane: ]>-------------------
new gMonths[12][] = {
	"Styczen",
	"Luty ",
	"Marzec",
	"Kwicien",
	"Maj  ",
	"Czerwiec",
	"Lipiec",
	"Sierpien",
	"Wrzesien",
	"Pazdziernik",
	"Listopad",
	"Grudzien"
};

new gGunNames[47][] = {
	"Brak",//0
	"Kastet",//1
	"Kij golfowy",//2
	"Pa³ka policyjna",//3
	"Nó¿",//4
	"Kij Baseballowy",//5
	"£opata",//6
	"Kij bilardowy",//7
	"Katana",//8
	"Pi³a mechaniczna",//9
	"Purple Dildo",//10
	"Small White Vibrator",//11
	"Large White Vibrator",//12
	"Silver Vibrator",//13
	"Kwiaty",//14
	"Laska",//15
	"Granaty",//16
	"Gaz ³zawi¹cy",//17
	"Koktajl Mo³otova",//18
	"B³¹d",//19
	"B³¹d",//20
	"B³¹d",//21
	"Pistolet 9mm",//22
	"Pistolet z t³umikiem",//23
	"Desert Eagle",//24
	"Shotgun",//25
	"Obrzyny",//26
	"Spas-12",//27
	"UZI",//28
	"MP5",//29
	"AK-47",//30
	"M4",//31
	"TEC-9",//32
	"Gwintówka",//33
	"Snajperka",//34
	"RPG",//35
	"Wyrzutnia rakiet",//36
	"Ogniomiotacz",//37
	"Minigun",//38
	"C4",//39
	"Detonator",//40
	"Sprej",//41
	"Gaœnica",//42
	"Aparat",//43
	"Nightvision Goggle",//44
	"Thermal Goggles",//45
	"Spadochron"//46
};

//------------------<[ Grupy i Iteratory: ]>-------------------
new Group:LoggedPlayer; //gracze online
new Iterator:StreamedPlayers[MAX_PLAYERS]<MAX_PLAYERS>; //gracze zestreamowanie dla gracza

//------------------<[ Zmienne: ]>-------------------

//end