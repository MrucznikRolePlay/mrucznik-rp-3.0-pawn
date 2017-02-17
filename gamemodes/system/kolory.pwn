//kolory.pwn

//-----------------------------------------------<< System >>------------------------------------------------//
//------------------------------------------[ Modu³: kolory.pwn ]--------------------------------------------//
//Opis:
/*
	Modu³ zawieraj¹cy wszystkie kolory. U¿ywane kolory powinny mieæ nazwy zgodne z prawdziwymi nazwami kolorów.
	Inne definicje kolorów ni¿ nazwy prawdziwych kolorów powinny byæ wskazaniem na nazwê prawdziwego koloru
	lub posiadaæ wyraŸny opis w komentarzu jak wygl¹da ten kolor.
	
	Nazwy kolorów prawdziwych lub opisanych w komenatrzu s¹ zapisane w formacie:
		#define COLOR_[nazwa koloru]     kolor
	Nazwy kolorów odwo³uj¹cych siê s¹ zapisane w formacie:
		#define C_[nazwa]   odwo³anie
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

//---------------------------------------<[ Kolory ]>----------------------------------------
//Podstawowe kolory:
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_BLACK     	0x000000FF

//Odcienie szarosci:
#define COLOR_GREY			0x808080FF
#define COLOR_LIGHTGREY		0xA0A0A0FF
#define COLOR_DARKGREY		0x606060FF
#define COLOR_SILVER		0xC0C0C0FF
#define COLOR_LIGHTSILVER	0xD7D7D7FF
#define COLOR_DARKSILVER	0x4F4F4FFF

#define COLOR_GRAD1 		0xB4B5B7FF	//ciemny szary
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF	//jasny szary

//Czerwone kolory:
#define COLOR_RED			0xAA3333AA
#define COLOR_LIGHTRED		0xFF6347AA
#define COLOR_DARKRED		0xCF2929FF	
#define COLOR_PANICRED      0xFF0000FF

//Pomarañczowe kolory:
#define COLOR_ORANGE        0xFFA500FF
#define COLOR_LIGHTORANGE	0xFFC125FF
#define COLOR_DARKORANGE	0xFF8000FF
#define COLOR_RUDY			0xCD5700FF

//¯ó³te kolory:
#define COLOR_YELLOW        0xFFFF00FF
//#define COLOR_YELLOW2 0xF5DEB3AA - GF
#define COLOR_LIGHTYELLOW	0xFFFF33FF
#define COLOR_DARKYELLOW	0xFFBF00FF
#define COLOR_GOLD			0xFFD700FF

#define COLOR_YELLOW1		0xFFFF33FF
#define COLOR_YELLOW2		0xFFFF15FF
#define COLOR_YELLOW3		0xFFFF00FF
#define COLOR_YELLOW4		0xFFDF00FF
#define COLOR_YELLOW5		0xFFCF00FF
#define COLOR_YELLOW6		0xFFBF00FF

//Br¹zowe kolory:
#define COLOR_BROWN         0xA52A2AFF
#define COLOR_LIGHTBROWN	0xCD7F32FF
#define COLOR_DARKBROWN		0x7B3F00FF

//Zielone kolory:
#define COLOR_GREEN         0x00FF00FF
#define COLOR_GREEN2		0x63FF60AA
#define COLOR_LIGHTGREEN	0x9ACD32AA
#define COLOR_DARKGREEN		0x008000FF
#define COLOR_OLIVE			0x808000FF
#define COLOR_MINT			0x22DD64FF
#define COLOR_LIGHTMINT		0xBCE27FFF

//Niebieskie kolory:
#define COLOR_BLUE          0x0000FFFF
#define COLOR_LIGHTBLUE		0x33CCFFAA
#define COLOR_DARKBLUE		0x082567FF
#define COLOR_CYAN			0x00FFFFFF

//Fioletowe i purpurowe kolory:
#define COLOR_DARKPURPLE	0x800080FF
#define COLOR_PURPLE		0xC2A2DAAA
#define COLOR_VIOLET        0xEE82EEFF

//Ró¿owe kolory:
#define COLOR_PINK          0xFF00FFFF
#define COLOR_LIGHTPINK		0xEE82EEFF
#define COLOR_DARKPINK		0xFF0090FF
#define COLOR_HOT_PINK      0xFF69B4FF

//Inne:

//#define COLOR_

//-------------------------------<[ Kolory dialogów/wiadomoœci ]>-------------------------------

//Podstawowe kolory:
#define INCOLOR_WHITE		"{FFFFFF}"
#define INCOLOR_BLACK		"{000000}"
#define INCOLOR_GREY		"{808080}"
#define INCOLOR_LIGHTGREY	"{A0A0A0}"
#define INCOLOR_DARKGREY	"{606060}"
#define INCOLOR_SILVER		"{C0C0C0}"
#define INCOLOR_LIGHTSILVER	"{D7D7D7}"
#define INCOLOR_DARKSILVER	"{4F4F4F}"

#define INCOLOR_GRAD1 		"{B4B5B7}"	//ciemny szary
#define INCOLOR_GRAD2 		"{BFC0C2}"
#define INCOLOR_GRAD3 		"{CBCCCE}"
#define INCOLOR_GRAD4 		"{D8D8D8}"
#define INCOLOR_GRAD5 		"{E3E3E3}"
#define INCOLOR_GRAD6 		"{F0F0F0}"	//jasny szary

//Czerwone kolory:
#define INCOLOR_RED			"{AA3333}"
#define INCOLOR_LIGHTRED	"{FF6347}"
#define INCOLOR_DARKRED		"{CF2929}"
#define INCOLOR_PANICRED	"{FF0000}"

//Pomarañczowe kolory:
#define INCOLOR_ORANGE		"{FFA500}"
#define INCOLOR_LIGHTORANGE	"{FFC125}"
#define INCOLOR_DARKORANGE	"{FF8000}"
#define INCOLOR_RUDY		"{CD5700}"

//¯ó³te kolory:
#define INCOLOR_YELLOW		"{FFFF00}"
#define INCOLOR_LIGHTYELLOW	"{FFFF33}"
#define INCOLOR_DARKYELLOW	"{FFBF00}"
#define INCOLOR_GOLD		"{FFD700}"

#define INCOLOR_YELLOW1		"{FFFF33}"
#define INCOLOR_YELLOW2		"{FFFF15}"
#define INCOLOR_YELLOW3		"{FFFF00}"
#define INCOLOR_YELLOW4		"{FFDF00}"
#define INCOLOR_YELLOW5		"{FFCF00}"
#define INCOLOR_YELLOW6		"{FFBF00}"

//Br¹zowe kolory:
#define INCOLOR_BROWN		"{A52A2A}"
#define INCOLOR_LIGHTBROWN	"{CD7F32}"
#define INCOLOR_DARKBROWN	"{7B3F00}"

//Zielone kolory:
#define INCOLOR_GREEN		"{00FF00}"
#define INCOLOR_GREEN2		"{63FF60}"
#define INCOLOR_LIGHTGREEN	"{9ACD32}"
#define INCOLOR_DARKGREEN	"{008000}"
#define INCOLOR_OLIVE		"{808000}"
#define INCOLOR_MINT		"{22DD64}"
#define INCOLOR_LIGHTMINT	"{BCE27F}"

//Niebieskie kolory:
#define INCOLOR_BLUE		"{0000FF}"
#define INCOLOR_LIGHTBLUE	"{33CCFF}"
#define INCOLOR_DARKBLUE	"{082567}"
#define INCOLOR_CYAN		"{00FFFF}"

//Fioletowe i purpurowe kolory:
#define INCOLOR_DARKPURPLE	"{800080}"
#define INCOLOR_PURPLE		"{C2A2DA}"
#define INCOLOR_VIOLET		"{EE82EE}"

//Ró¿owe kolory:
#define INCOLOR_PINK		"{FF00FF}"
#define INCOLOR_LIGHTPINK	"{EE82EE}"
#define INCOLOR_DARKPINK	"{FF0090}"
#define INCOLOR_HOT_PINK	"{FF69B4}"

//Inne:
#define INDIALOG_COLOR 		"{A9C4E4}"


//-------------------------------<[ Dodatkowe nazwy kolorów ]>-------------------------------



/*
//Nag³ówki:
#define C_HEADER_1      COLOR_
#define C_HEADER_2      COLOR_
#define C_HEADER_3		COLOR_

//Chaty:
#define C_CHAT_ME		COLOR_PURPLE
#define C_CHAT_ADMIN	COLOR_
#define C_CHAT_OOC		COLOR_WHITE
#define C_CHAT_RADIO	COLOR_
#define C_CHAT_DEPO		COLOR_

//Wiadomoœci
#define wreerw

//U¿ytkowe:
#define ewrwafds
*/
//Kolory z 3.0 stare
#define COLOR_ERROR		0xC00010FF	//Ciemny Czerwony
#define COLOR_FAIL		0xB0B0FFFF	//Lekko Fioletowo-Niebieski (jak dialogi)
#define COLOR_WARN		0xF09040FF	//Pomarañczowy
#define COLOR_INFO		0xB4B5B7FF	//Szary (GRAD1)
#define COLOR_GINFO		0x33CCFFAA	//Jasnoniebieski
#define COLOR_BINFO		0xFF6347AA	//Jasnoczerwony
#define COLOR_OFERTA	0xDDA0DDFF	//Miêtowy
#define COLOR_KARA		0xFF0000FF	//Ostro czerowny
#define COLOR_CMDHELP	0xAFAFAFAA	//Szary

#define FRAKCJA_RADIO_COLOR 0x8D8DFF00 	//Radio frakcji
#define FRAKCJA_DEP_COLOR 0xFF8282AA	//Departament frakcji

//Kolory z GF'a
/*#define COLOR_GRAD1 		0xB4B5B7FF	//ciemny szary
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF	//jasny szary
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xFFFF00AA*/
//#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6FF
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6EFF
//#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0xFFA500AA
#define COLOR_OOC 0xE0FFFFAA
//#define COLOR_PANICRED 0xFF0000FF
//#define COLOR_BLACK 0x000000FF
#define COLOR_FBI 0x0000F4FF
/*#define COLOR_BLUE 0x0080FFFF
#define COLOR_BROWN 0x8F4747FF
#define COLOR_LIGHTBROWN 0xA0522DFF*/
#define COLOR_BROWN2 0x8B4513FF
#define COLOR_P@ 0xDDA0DD

#define OBJECTIVE_COLOR 0x64000064
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_JOB_COLOR 0xFFB6C1AA
#define TEAM_HIT_COLOR 0xFFFFFF00
#define TEAM_BLUE_COLOR 0x8D8DFF00
#define COLOR_ADD 0x63FF60AA
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_CYAN_COLOR 0xFF8282AA
#define TEAM_ORANGE_COLOR 0xFF830000
#define TEAM_COR_COLOR 0x39393900
#define TEAM_BAR_COLOR 0x00D90000
#define TEAM_TAT_COLOR 0xBDCB9200
#define TEAM_CUN_COLOR 0xD900D300
#define TEAM_STR_COLOR 0x01FCFF00
#define TEAM_ADMIN_COLOR 0x00808000
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200
#define COLOR_LFBI 0x483D8B00

//end