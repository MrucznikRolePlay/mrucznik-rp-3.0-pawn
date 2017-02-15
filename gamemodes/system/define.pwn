//define.pwn

//-----------------------------------------------<< System >>------------------------------------------------//
//-------------------------------------------[ Modu³: define.pwn ]-------------------------------------------//
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

//------------------<[ Makra: ]>-------------------
#define SetPlayerArmorEx SetPlayerArmourEx
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define PRESSING(%0,%1) \
	(%0 & (%1))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

//------------------<[ Define: ]>-------------------
#define MAX_MESSAGE_LENGHT 			144 		//maksymalna liczba znaków jaka mo¿e zostaæ wyœwietlona na ekranie
#define MAX_STREAM_LENGTH 			128			//maksymalna d³ugoœæ linku dla PlayAudioStreamForPlayer
#define BYTES_PER_CELL 				4 			//u¿ywane w SendClientMessageF
#define SPAM_PROTECTION_VALUE 		3 			//iloœæ dzia³añ które mo¿na wykonaæ przed w³¹czeniem ochrony antyspamowej 
#define COLOR_STRING_LENGTH			6			//d³ugoœæ ci¹gu znaków odpowiedzialna za kolor
#define NOT_FOUND					-1			//u¿ywane do strfind

//end