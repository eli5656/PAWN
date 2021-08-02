#include <a_samp>
#include <dini>

#define  Indigo      0x4B00B0AA
#define  Aqua        0x7CFC00FF
#define  White       0xFFFFFFAA
#define  Blue        0x0000BBAA
#define  Orange      0xFFA500FF
#define  Pilot       0x33CCFFAA
#define  Brightred   0xFF000096
#define  Black       0x00000000
#define  Brown  	 0x4B351BFF
#define  Gold        0xFFD720FF
#define  Azure       0x0087FFFF
#define  Grellow     0xADFF2FFF
#define  Redwhite    0xFF4040FF
#define  Slateblue   0x007FFFFF
#define  Darkpurple  0x0066CCFF
#define  Invisible   0xFFFFFF00
#define  Bluesea     0x008080FF
#define  Invisible   0xFFFFFF00


#define  Olive        0x556b2fFF
#define  Whiteorange  0xFFCC33AA
#define  Darkblue 	  0x1874CDFF
#define  Purple       0x800080AA 
#define  Yellow       0xFFFF00AA
#define  Red          0xAA3333AA  
#define  Grey         0xAFAFAFAA 
#define  Pink         0xFF66FFFF 
#define  Green        0x33AA33AA  

#define WeaponName(%1) WeaponNames[%1]
#pragma dynamic 145000

forward CountDown(cd);
forward AutomaticUnjail(playerid);
forward AutomaticMainusJailTime(playerid);
forward AutomaticUnmute(playerid);
forward AutomaticMainusMuteTime(playerid);
forward CdUnFreeze();

new inJail[MAX_PLAYERS];
new JailTimer[MAX_PLAYERS];
new JailTimer1[MAX_PLAYERS];

new inMute[MAX_PLAYERS];
new MuteTimer[MAX_PLAYERS];
new MuteTimer1[MAX_PLAYERS];

new inadminspay[MAX_PLAYERS];
new file[256];
new InAdmin[MAX_PLAYERS];
new CountdownON;
new cdtimer;
new CdTimer1;
new inSpec[MAX_PLAYERS];
new chet;



new BlockedWords[27][] =
{
	"הומו",
	"ה!ומו",
	"בן זו!נה",
	"ק!קסינל",
	"מניאק",
	"בן זונה",
	"קוקסינל",
	"שרמוטה",
	"אמא שלך",
	"בולבול",
	"לסבית",
	"זין",
	"נוב",
	"זונה",
	"212.",
	"212,",
	"212'",
	"212;",
	"213.",
	"213,",
	"213'",
	"213;",
	"240.",
	"240,",
	"240'",
	"240;",
	"/q"
};

new WeaponNames[48][32] =
{
	"Unarmed",
	"Brass Knuckles",
	"Golf Club",
	"Night Stick",
	"Knife",
	"Baseball Bat",
	"Shovel",
	"Pool Cue",
	"Katana",
	"Chainsaw",
	"Purple Dildo",
	"Small White Vibrator",
	"Large White Vibrator",
	"Silver Vibrator",
	"Flowers",
	"Cane",
	"Grenade",
	"Tear Gas",
	"Molotov Cocktail",
	" ",
	" ",
	" ",
	"9mm",
	"Silenced 9mm",
	"Desert Eagle",
	"Shotgun",
	"Sawn-off Shotgun",
	"Combat Shotgun",
	"Micro SMG",
	"MP5",
	"AK-47",
	"M4",
	"Tec9",
	"Country Rifle",
	"Sniper Rifle",
	"Rocket Launcher",
	"HS Rocket Launcher",
	"Flamethrower",
	"Minigun",
	"Satchel Charge",
	"Detonator",
	"Spraycan",
	"Fire Extinguisher",
	"Camera",
	"Nightvision Goggles",
	"Thermal Goggles",
	"Parachute",
	"Fake Pistol"
};

//==============================================================================
new VehicleNames[212][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC-Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC-Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC-Baron", "RC-Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC-Goblin", "Hotring Racer", "Hotring Racer", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratium", "Elegy", "Raindance", "RC-Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC-Cam", "Launch", "Police Car", "Police Car", "Police Car",
    "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tractor Carriage", "Utility Trailer"
};
//==============================================================================
public OnPlayerConnect(playerid)
{
	if(GetBan(playerid) == 1)
	{
	    new string[256];
		format(string,sizeof(string), ":יש לך באן וכעת יוצג בפניך פרטי הבאן");
		SendClientMessage(playerid, Brightred, string);
		format(string,sizeof(string), "%s:סיבת הבאן", dini_Get(BanFile(playerid), "Reson"));
		SendClientMessage(playerid, Yellow, string);
		format(string,sizeof(string), "%s:האדמין שהביא את הבאן", dini_Get(BanFile(playerid), "BanAdmin"));
		SendClientMessage(playerid, Yellow, string);
		format(string,sizeof(string), "%s:האיפי החסום", dini_Get(BanFile(playerid), "IP"));
		SendClientMessage(playerid, Yellow, string);
		Kick(playerid);
	}
	if(!dini_Exists(MuteFile(playerid)))
	{
        dini_Create(MuteFile(playerid));
        dini_IntSet(MuteFile(playerid), "inMute", 0);
		dini_IntSet(MuteFile(playerid), "MuteTime", 0);
	}
	if(!dini_Exists(JailFile(playerid)))
	{
        dini_Create(JailFile(playerid));
		dini_IntSet(JailFile(playerid), "inJail", 0);
		dini_IntSet(JailFile(playerid), "JailTime", 0);
	}
	if(!dini_Exists(BanFile(playerid)))
	{
        dini_Create(BanFile(playerid));
		dini_Set(BanFile(playerid), "Reson", "none");
		dini_Set(BanFile(playerid), "BanAdmin", "none");
		dini_Set(BanFile(playerid), "IP", "none");
		dini_IntSet(BanFile(playerid), "HaveBan", 0);
	}
	if(dini_Int(MuteFile(playerid), "inMute") == 1)
	{
		inMute[playerid] = 1;
		MuteTimer[playerid] = SetTimerEx("AutomaticUnmute", 60*1000*dini_Int(MuteFile(playerid), "MuteTime"), 0, "d", playerid);
		MuteTimer1[playerid] = SetTimerEx("AutomaticMainusMuteTime", 60*1000, 0, "d", playerid);
	}
	if(dini_Int(JailFile(playerid), "inJail") == 1)
	{
		inJail[playerid] = 1;
		JailTimer[playerid] = SetTimerEx("AutomaticUnjail", 60*1000*dini_Int(JailFile(playerid), "JailTime"), 0, "d", playerid);
		JailTimer1[playerid] = SetTimerEx("AutomaticMainusJailTime", 60*1000, 0, "d", playerid);
		SetPlayerVirtualWorld(playerid, 7);
  		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 2141.9980,2325.7153,11.7422);
	}
	return 1;
}
//===========================Public=============================================
public OnPlayerCommandText(playerid, cmdtext[])
{
//===========NewPublic==========================================================
	new cmd[256];
	new v, vid;
	new	tmp[256];
	new tmp1[256];
	new tmp2[256];
	new tmp3[256];
	new weaponid;
	new ammu;
	new color;
	new color1;
	new string[256];
	new level;
	new id;
	new any;
	new id1;
	new vehicleid = GetPlayerVehicleID(playerid);
	new pinterior, pvirtual;
	new	idx;
	new Float:X, Float:Y, Float:Z, Float:A;
	cmd = strtok(cmdtext, idx);
	new Float:Health;
	if(GetBlockCmd(playerid) == 1) return SendClientMessage(playerid, White, "אינך יכול לעשות פקודות כשאתה הפקודות חסומות לך");
//==============================================================================
	if(strcmp(cmd, "/AdminRegister", true) == 0 || strcmp(cmd, "/Ar", true) == 0)
	{
		if(dini_Exists(File(playerid)))
		{
			format(string, sizeof(string),"כבר רשום לשרת %s המשתמש", GetName(playerid));
			SendClientMessage(playerid, White, string);
			return 1;
		}
		if(!dini_Exists(file))
		{
			ShowPlayerDialog(playerid, 2_1, DIALOG_STYLE_INPUT, "Register system", "Please type the password you want to put the user", "Enter", "Cancel");
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/AdminLogin", true) == 0 || strcmp(cmd, "/Al", true) == 0)
	{
		if(InAdmin[playerid] == 1) return SendClientMessage(playerid, White, "אתה כבר מחובר לשרת");
	    if(!dini_Exists(File(playerid)))
		{
			SendClientMessage(playerid, White, "אתה לא רשום לשרת");
			return 1;
		}
	    {
	 		ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password", "Enter", "Cancel");
	 	}
	 	return 1;
 	}
 	
//==============================================================================
	if(strcmp(cmd, "/SetAdmin", true) == 0 || strcmp(cmd, "/Sa", true) == 0)
	{
		if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetAdmin(Sa) [id] [level] :צורת השימוש");
	 	id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetAdmin(Sa) [id] [level] :צורת השימוש");
		level = strval(tmp1);
		if(!dini_Exists(File(id))) return SendClientMessage(playerid, White, "אינך יכול לעלות אדמין שאינו רשום במערכת");
		if(level < 0 || level > 7) return SendClientMessage(playerid, White, "טווח הרמות הוא בין 0 ל7");
		dini_IntSet(File(id), "AdminLevel", level);
		format(string, sizeof(string),"%d העלה אותך לרמת אדמין %s האדמין", level, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d לרמת אדמין %s העלתה את השחקן", level, GetName(id));
		SendClientMessage(playerid, Azure, string);
		dini_IntSet(File(id), "AdminSpay", 0);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetTempAdmin", true) == 0 || strcmp(cmd, "/Sta", true) == 0)
	{
		if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetTempAdmin(Sta) [id] [level] :צורת השימוש");
	 	id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetTempAdmin(Sta) [id] [level] :צורת השימוש");
		level = strval(tmp1);
		if(level < 0 || level > 7) return SendClientMessage(playerid, White, "טווח הרמות הוא בין 0 ל7");
		dini_IntSet(File(id), "TempAdminLevel", level);
		format(string, sizeof(string),"%d העלה אותך לרמת ניהול זמני %s האדמין", level, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d לרמת ניהול זמני %s העלתה את השחקן", level, GetName(id));
		SendClientMessage(playerid, Azure, string);
		dini_IntSet(File(id), "AdminSpay", 0);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Jail", true) == 0 || strcmp(cmd, "/J", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Jail(J) [playerid] [time] [reason] :צורת שימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(inJail[id] == 1) return SendClientMessage(playerid, White, "שחקן זה כבר בכלא");
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Jail(J) [playerid] [time] [reason] :צורת שימוש");
		any = strval(tmp1);
		if(any < 1 || any > 10)  return SendClientMessage(playerid, White, "טווח הכלא בדקות הוא מ1 עד 10");
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Jail(J) [playerid] [time] [reason] :צורת שימוש");
		format(string, sizeof(string),"ל%d דקות %s נכלא על ידי האדמין %s השחקן", any, GetName(playerid), GetName(id));
		SendClientMessageToAll(Azure, string);
	  	format(string, sizeof(string),"(%s)", (result));
	  	SendClientMessageToAll(Azure, string);
	  	SetPlayerVirtualWorld(id, 7);
	  	SetPlayerInterior(id, 0);
		SetPlayerPos(id, 2141.9980,2325.7153,11.7422);
		dini_IntSet(JailFile(id), "Jail", dini_Int(JailFile(id), "Jail")+1);
		dini_IntSet(JailFile(id), "inJail", 1);
		dini_Set(File(id), "AdminJail", GetName(playerid));
		dini_Set(File(id), "ResonJail", (result));
		inJail[id] = 1;
		dini_IntSet(JailFile(id), "JailTime", any);
		JailTimer[id] = SetTimerEx("AutomaticUnjail", 60*1000*any, 0, "d", id);
		JailTimer1[id] = SetTimerEx("AutomaticMainusJailTime", 60*1000, 0, "d", id);
	 	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Kill", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 4 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 4 && GetTempAdminLevel(playerid) < 4) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/kill [id] :צורת שימוש");
	    id = strval(tmp);
	    SetPlayerHealth(id, 0);
		format(string,sizeof(string), "%s הרג את השחקן %s האדמין", GetName(id), GetName(playerid));
		SendClientMessageToAll(Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Report", true) == 0 || strcmp(cmd, "/Rep", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid,White, "/Report(Rep) [id] [text] :צורת השימוש");
		id = strval(tmp);
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Report [id] [text] :צורת השימוש");
		format(string,sizeof(string), "[id:%d]%s על השחקן [id:%d]%sדיווח נשלך מהשחקן",id, GetName(id), playerid, GetName(playerid));
		SendAdminsMessage(Brown, string);
		SendClientMessage(playerid, Brown, "דיווח נשלח הבצלחה");
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "//", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, White, "// [text] :צורת השימוש");
		format(string,sizeof(string), "[AdminsChat]%s[%d#]:%s",GetName(playerid), playerid, (result));
		SendAdminsMessage(Grellow, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Ban", true) == 0 || strcmp(cmd, "/B", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Ban(B) [id] [reson] :צורת השימוש");
		id = strval(tmp);
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Ban(B) [id] [reson] :צורת השימוש");
		format(string, sizeof(string),"%s קיבל באן על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
		SendClientMessageToAll(Azure, string);
		format(string, sizeof(string),"(%s)", (result));
		SendClientMessageToAll(Azure, string);
		dini_Set(BanFile(id), "Reson", (result));
		dini_Set(BanFile(id), "BanAdmin", GetName(playerid));
		dini_Set(BanFile(id), "IP", GetIP(id));
		dini_IntSet(BanFile(id), "HaveBan", 1);
		Kick(id);
		return 1;
	 }
//==============================================================================
	if(strcmp(cmd, "/Kick", true) == 0 || strcmp(cmd, "/K", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Kick(K) [id] [reson] :צורת השימוש");
		id = strval(tmp);
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Kick(K) [id] [reson] :צורת השימוש");
		format(string, sizeof(string),"%s קיבל קיק על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
		SendClientMessageToAll(Azure, string);
		format(string, sizeof(string),"(%s)", (result));
		SendClientMessageToAll(Azure, string);
		Kick(id);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Mute", true) == 0 || strcmp(cmd, "/M", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Mute(M) [playerid] [time] [reason] :צורת שימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(inMute[id] == 1) return SendClientMessage(playerid, White, "שחקן זה כבר מושתק");
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Mute(M) [playerid] [time] [reason] :צורת שימוש");
		any = strval(tmp1);
		if(any < 1 || any > 10)  return SendClientMessage(playerid, White, "טווח המיוט בדקות הוא מ1 עד 10");
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Mute(M) [playerid] [time] [reason] :צורת שימוש");
		format(string, sizeof(string),"ל%d דקות %s הושתק על ידי האדמין %s השחקן", any, GetName(playerid), GetName(id));
		SendClientMessageToAll(Grellow, string);
	  	format(string, sizeof(string),"(%s)", (result));
	  	SendClientMessageToAll(Grellow, string);
		dini_IntSet(MuteFile(id), "Mute", dini_Int(MuteFile(id), "Mute")+1);
		dini_IntSet(MuteFile(id), "inMute", 1);
		dini_Set(File(id), "AdminMute", GetName(playerid));
		dini_Set(File(id), "ResonMute", (result));
		inMute[id] = 1;
		dini_IntSet(MuteFile(id), "MuteTime", any);
		MuteTimer[id] = SetTimerEx("AutomaticUnmute", 60*1000*any, 0, "d", id);
		MuteTimer1[id] = SetTimerEx("AutomaticMainusMuteTime", 60*1000, 0, "d", id);
	 	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Say", true) == 0 || strcmp(cmd, "/S", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Say(S) [Text] :צורת השימוש");
		format(string, sizeof(string),"*Admin(%s):%s", GetName(playerid),(result));
		SendClientMessageToAll(Gold, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/KickAll", true) == 0 || strcmp(cmd, "/KAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 6 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 6 && GetTempAdminLevel(playerid) < 6) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
	        if(!strlen(result)) return SendClientMessage(playerid, White, "/KickAll(KAll) [reson] :צורת השימוש");
			format(string, sizeof(string),"הביא קיק לכל השחקנים בשרת %s האדמין", GetName(playerid));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"%s", (result));
			SendClientMessageToAll(Azure, string);
			Kick(i);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetHp", true) == 0 || strcmp(cmd, "/Shp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetHp(Shp) [ID] [Hp] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetHp(Shp) [ID] [Hp] :צורת השימוש");
		any = strval(tmp1);
		SetPlayerHealth(id, any);
		format(string, sizeof(string),"%dשינה לך את אחוז החיים ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d את אחוז החיים %s שיניתה לשחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CleanChat", true) == 0 || strcmp(cmd, "/Cc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i=0; i<100; i++)
		{
			SendClientMessageToAll(White, "");
		}
		format(string, sizeof(string),"^-^-!ניקה את הצ'אט %s האדמין^-^-^-^-", GetName(playerid));
		SendClientMessageToAll(RandomColor(), string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetAllVehicle", true) == 0 || strcmp(cmd, "/Rav", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		format(string, sizeof(string),"^-^-^-^-.עשה ריסט למכוניות %s האדמין-^-^-^-^-", GetName(playerid));
		SendClientMessageToAll(Blue, string);
		for(new i=0; i<MAX_VEHICLES; i++)
		{
			SetVehicleToRespawn(i);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetVehicle", true) == 0 || strcmp(cmd, "/Rv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, White, "אינך נמצא ברכב");
		format(string, sizeof(string),"שיגרתה את המכונית שהאיתי בתוכה לריספאון שלה");
		SendClientMessage(playerid, Blue, string);
		SetVehicleToRespawn(vehicleid);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Chet", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		if(chet == 0)
		{
		    format(string, sizeof(string),"נעל את הצאט %s האדמין", GetName(playerid));
			SendClientMessageToAll(Azure, string);
			chet = 1;
		}
	 	else if(chet == 1)
		{
			format(string, sizeof(string),"פתח את הצאט %s האדמין", GetName(playerid));
			SendClientMessageToAll(Azure, string);
			chet = 0;
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetArmuor", true) == 0 || strcmp(cmd, "/Sar", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetArmuor(Sar) [ID] [Hp] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetArmuor(Sar) [ID] [Hp] :צורת השימוש");
		any = strval(tmp1);
		SetPlayerArmour(id, any);
		format(string, sizeof(string),"%dשינה לך את אחוז המגן ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d את אחוז המגן %s שיניתה לשחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetSkin", true) == 0 || strcmp(cmd, "/SS", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetSkin(SS) [ID] [idskin] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetSkin(SS) [ID] [idskin] :צורת השימוש");
		any = strval(tmp1);
		SetPlayerSkin(id, any);
		format(string, sizeof(string),"%d שינה לך את הסקין ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d לסקין %s שיניתה לשחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Credit", true) == 0)
	{
		SendClientMessage(playerid, White, "האדמין מוד נבנה על ידי אלי בן חמו");
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetAll", true) == 0 || strcmp(cmd, "/Ga", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 6 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 6 && GetTempAdminLevel(playerid) < 6) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    format(string, sizeof(string),"שיגר את כל השחקנים אליו %s האדמין", GetName(playerid));
		SendClientMessageToAll(Azure, string);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
			GetPlayerPos(playerid, X, Y, Z);
			SetPlayerPos(i, X, Y, Z+2);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Goto", true) == 0 || strcmp(cmd, "/Gt", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Goto(Gt) [playerid] :צורת השימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
	  	id = strval(tmp);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(IsYou(id, playerid)) return SendClientMessage(playerid, White, "אינך יכול לבצע פקודה זו על עצמך");
		GetPlayerPos(id, X, Y, Z);
		pinterior = GetPlayerInterior(id);
		if(IsPlayerInAnyVehicle(playerid))
	  	{
	   		SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z+2);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), pinterior);
	 		format(string, sizeof(string), "השתגר אלייך עם רכבו %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure ,string);
	 		format(string, sizeof(string), "עם רכבך %s השתגרת אל השחקן", GetName(id));
			SendClientMessage(playerid, Azure ,string);
	  	}
	  	else
	  	{
	   		SetPlayerPos(playerid, X, Y, Z+2);
	   		SetPlayerInterior(playerid, pinterior);
	 		format(string, sizeof(string), "השתגר אלייך %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure ,string);
	 		format(string, sizeof(string), "%s השתגרת אל השחקן", GetName(id));
			SendClientMessage(playerid, Azure ,string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Get", true) == 0 || strcmp(cmd, "/G", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Get(G) [playerid] :צורת השימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
	  	id = strval(tmp);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(IsYou(id, playerid)) return SendClientMessage(playerid, White, "אינך יכול לבצע פקודה זו על עצמך");
		GetPlayerPos(playerid, X, Y, Z);
		pinterior = GetPlayerInterior(playerid);
		SetPlayerPos(id, X, Y, Z+2);
		SetPlayerInterior(id, pinterior);
		format(string, sizeof(string), "שיגר אותך אליו %s האדמין", GetName(playerid));
	 	SendClientMessage(id, Azure ,string);
		format(string, sizeof(string), "אליך %s שיגרתה את השחקן", GetName(id));
	 	SendClientMessage(playerid, Azure ,string);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/adminhelp", true) == 0 || strcmp(cmd, "/Ah", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/AdminHelp(Ah) 1-13 :צורת השימוש");
	    if(strcmp(tmp, "1", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 1)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#1 - /AdminRegister(Ar) - רמת אדמין (0) - הרשמה למערכת האדמין");
	        SendClientMessage(playerid, White, "#3 - /AdminLogin(Al) - רמת אדמין (0) - תהחברות למערכת האדמין");
	        SendClientMessage(playerid, White, "#4 - /SetAdmin(Sa) - רמת אדמין (7) - לעלות אדמינים");
	        SendClientMessage(playerid, White, "#5 - /Jail(J) - רמת אדמין (5) - להשים כלא");
	        SendClientMessage(playerid, White, "#6 - /UnJail(UnJ) - רמת אדמין (5) - להוריד כלא");
	        SendClientMessage(playerid, White, "#7 - /Mute(M) - רמת אדמין (5) - להשים מיוט");
	        SendClientMessage(playerid, White, "#8 - /UnMute(UnM) - רמת אדמין (5) - להורדת מיוט");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 1)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "2", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 2)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#9 - /Kill - רמת אדמין (4) - להרוג משהוא");
	        SendClientMessage(playerid, White, "#10 - // - רמת אדמין (2) - צא'ט אדמינים");
	        SendClientMessage(playerid, White, "#11 - /Ban(B) - רמת אדמין (5) - לתת באנים");
	        SendClientMessage(playerid, White, "#12 - /Kick(K) - רמת אדמין (3) - להביא קיק");
	        SendClientMessage(playerid, White, "#13 - /Say(S) - רמת אדמין (3) - לדבר בצורת אדמין");
	        SendClientMessage(playerid, White, "#14 - /KickAll(KAll) - רמת אדמין (6) - לתת קיק לכל השחקנים בשרת");
	        SendClientMessage(playerid, White, "#15 - /SetHp(Shp) - רמת אדמין (2) - עריכת אחוז החיים של שחקן מסויים");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 2)-=-=-=-=-=-=-=");
		}
     	if(strcmp(tmp, "3", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 3)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#16 - /CleanChat(Cc) - רמת אדמין (5) - ניקוי צאט");
	        SendClientMessage(playerid, White, "#17 - /ResetAllVehicle(Rav) - רמת אדמין (5) - סידור כל המכוניות בשרת");
	        SendClientMessage(playerid, White, "#18 - /SetArmuor(Sar) - רמת אדמין (2) - עריכת אחוס המגן של שחקן מסויים");
	        SendClientMessage(playerid, White, "#19 - /SetSkin(Ss) - רמת אדמין (3) - שינוי סקין לשחקן מסויים");
	        SendClientMessage(playerid, White, "#20 - /GetAll(Ga) - רמת אדמין (6) - שיגור כל החשקנים אליך");
	        SendClientMessage(playerid, White, "#21 - /Goto(Gt) - רמת אדמין (3) - להשתגר לשחקן");
	        SendClientMessage(playerid, White, "#22 - /Get(G) - רמת אדמין (3) - לשגר שחקן אליך");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 3)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "4", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 4)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#23 - /GetHp(Ghp) - רמת אדמין (5) - בדיקת אחוז החיים של שחקן");
	        SendClientMessage(playerid, White, "#24 - /GetArmour(Gar) - רמת אדמין (5) - בדיקת אחוז המגו של שחקן");
	        SendClientMessage(playerid, White, "#25 - /SetArmuor(Sar) - רמת אדמין (2) - עריכת אחוס המגן של שחקן מסויים");
	        SendClientMessage(playerid, White, "#26 - /Spector(Spec) - רמת אדמין (5) - צפייה על שחקן מסויים");
	        SendClientMessage(playerid, White, "#27 - /UnSpector(UnSpec) - רמת אדמין (5) - לצאת ממצב צפיה");
	        SendClientMessage(playerid, White, "#28 - /Ann - רמת אדמין (5) - כתיבת טקסט על המסך");
	        SendClientMessage(playerid, White, "#29 - /CountDown(Cd) - רמת אדמין (3) - להפעיל ספירה");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 4)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "5", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 5)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#30 - /CancelCountDown(Ccd) - רמת אדמין (3) - ביטול ספירה");
	        SendClientMessage(playerid, White, "#31 - /Explode(Exp) - רמת אדמין (5) - לפוצץ שחקן מסויים");
	        SendClientMessage(playerid, White, "#32 - /Spawn(Spa) - רמת אדמין (5) - לשגר שחקן לנקודת הספאון");
	        SendClientMessage(playerid, White, "#33 - /GetVehicle(Gv) - רמת אדמין (3) - לשגר שחקן עם מכונית אליך");
	        SendClientMessage(playerid, White, "#34 - /SetVehicleHp(Svh) - רמת אדמין (5) - עריכת אחוז חיים של מכונית");
	        SendClientMessage(playerid, White, "#35 - /GetVehicleHp(Gvh) - רמת אדמין (5) - בדיקת אחוז חיים של מכונית");
	        SendClientMessage(playerid, White, "#36 - /Disarm(D) - רמת אדמין (3) - איפוס נשקים לשחקן מסויים");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 5)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "6", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 6)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#37 - /GiveMoney(Gm) - רמת אדמין (6) - הבאת כסך לשחקן מסויים");
	        SendClientMessage(playerid, White, "#38 - /FixVehicle(Fv) - רמת אדמין (4) - תיקון רכב");
	        SendClientMessage(playerid, White, "#39 - /Radius(Rad) - רמת אדמין (3) - פקודה שפועלת על רדיוס");
	        SendClientMessage(playerid, White, "#40 - /Inv - רמת אדמין (3) - הפיכת שחקן לבלתי ניראה");
	        SendClientMessage(playerid, White, "#41 - /Vis - רמת אדמין (3) - הפיכת שחקן לניראה");
	        SendClientMessage(playerid, White, "#42 - /Freeze(F) - רמת אדמין (3) - הקפאת שחקן");
	        SendClientMessage(playerid, White, "#43 - /UnFreeze(UnF) - רמת אדמין (3) - הפשרת שחקן");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 6)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "7", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 7)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#44 - /GiveWeapon(Gw) - רמת אדמין (3) - הבאתה נשק לשחקן");
	        SendClientMessage(playerid, White, "#45 - /Warning(Warn) - רמת אדמין (5) - לתת אזהרה לשחקן");
	        SendClientMessage(playerid, White, "#46 - /Report(Rep) - רמת אדמין (0) - דיווח על שחקן");
	        SendClientMessage(playerid, White, "#47 - /FixAllCar(Fac) - רמת אדמין (3) - תיקון כל המכוניות בשרת");
	        SendClientMessage(playerid, White, "#48 - /BlockCmd(Bc) - רמת אדמין (4) - חסימת פקודות לשחקן");
	        SendClientMessage(playerid, White, "#49 - /SetInt(Sint) - רמת אדמין (5) - שינוי אינטריור השחקן");
	        SendClientMessage(playerid, White, "#50 - /SetVw(Svw) - רמת אדמין (5) - שינוי העולם הוירטואלי של השחקן");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 7)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "8", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 8)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#51 - /ResetVehicle(Rv) - רמת אדמין (5) - שיגור מכונית לריספאון שלה");
	        SendClientMessage(playerid, White, "#52 - /GetCar(Gc) - רמת אדמין (5) - שיגור רכב");
	        SendClientMessage(playerid, White, "#53 - /SetTime(St) - רמת אדמין (5) - שינוי שעה במשחק");
	        SendClientMessage(playerid, White, "#54 - /GetInt(Gint) - רמת אדמין (5) - בדיקת אינטריור");
	        SendClientMessage(playerid, White, "#55 - /GetVw(Gvw) - רמת אדמין (5) - בדיקת עולם וירטואלי");
	        SendClientMessage(playerid, White, "#56 - /JumpPlayer(Jp) - רמת אדמין (5) - הקפצת השחקן");
	        SendClientMessage(playerid, White, "#56 - /JumpVehicle(Jv) - רמת אדמין (5) - הקפצת שחקן עם הרכב");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 8)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "9", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 9)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#57 - /SetMoney(Sm) - רמת אדמין (5) - אריכת הכסף של שחקן");
	        SendClientMessage(playerid, White, "#58 - /Admins(Ad) - רמת אדמין (0) - בדיקת אדמינים מחוברים");
	        SendClientMessage(playerid, White, "#59 - /ToPlayerToPlayer(TpTp) - רמת אדמין (5) - שיגור שחקן על שחקן");
	        SendClientMessage(playerid, White, "#60 - /Jet - רמת אדמין (3) - להביא לעצמך ג'אט");
	        SendClientMessage(playerid, White, "#61 - /Playerjet(Pjet) - רמת אדמין (3) - להביא לשחקן ג'אט");
	        SendClientMessage(playerid, White, "#62 - /AdminsSpay(ASpay) - רמת אדמין (5) - פקודה לצפיה באדמינים סמויים");
	        SendClientMessage(playerid, White, "#63 - /AdminSpay(As) - רמת אדמין (2) - אדמין סמוי");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 9)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "10", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 10)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#64 - /ChangeColorPlayer(Ccp) - רמת אדמין (3) - שינוי צבע לשחקן");
	        SendClientMessage(playerid, White, "#65 - /SetPos(Spos) - X Y Z רמת אדמין (3) - שיגור שחקן למיקום מסויים לפי");
	        SendClientMessage(playerid, White, "#66 - /ResetGun(Rg) - רמת אדמין (3) - איפוס נשק מסויים");
	        SendClientMessage(playerid, White, "#67 - /CarColor(CarC) - רמת אדמין (3) - שינוי צבע לאוטו");
	        SendClientMessage(playerid, White, "#68 - /JailInfo(Ji) - רמת אדמין (3) - להוציא מידע על כלא של שחקן");
	        SendClientMessage(playerid, White, "#69 - /MuteInfo(Mi) - רמת אדמין (3) - להוציע מידע על מיוט של שחקן");
	        SendClientMessage(playerid, White, "#70 - /Chet - רמת אדמין (5) - פקודה לנעילת ופתיחת הצאט");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 10)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "11", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 11)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#71 - /ChangeColorPlayer(Ccp) - רמת אדמין (3) - לעשות לשחקן צבע רנדומלי");
	        SendClientMessage(playerid, White, "#72 - /SetTempAdmin(Sta) - רמת אדמין (7) - פקודה להלעת אדמין זמני");
	        SendClientMessage(playerid, White, "#73 - /Eject(Eje) - רמת אדמין (5) - להוציא שחקן מרכבו");
	        SendClientMessage(playerid, White, "#74 - /EjectAll(EjeAll) - רמת אדמין (7) - להוציא שחקן מרכבו");
	        SendClientMessage(playerid, White, "#75 - /GiveAllMoney(Gam) - רמת אדמין (7) - להביא לכל השרת כסף");
	        SendClientMessage(playerid, White, "#76 - /FreezeAll(Fall) - רמת אדמין (7) - להקפיא את כל השרת");
	        SendClientMessage(playerid, White, "#77 - /UnFreezeAll(UnFall) - רמת אדמין (7) - להפשיר את כל השרת");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 11)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "12", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 13)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#78 - /RandomColorAll(RcAll) - רמת אדמין (7) - צבע רנדומלי לכל השרת");
	        SendClientMessage(playerid, White, "#79 - /SetHpAll(ShpAll) - רמת אדמין (7) - שינוי אחוז החיים לכל השרת");
	        SendClientMessage(playerid, White, "#80 - /SetArmourAll(SarAll) - רמת אדמין (7) - שינוי אחוז המגן לכל השרת");
	        SendClientMessage(playerid, White, "#81 - /ExplodeAll(ExpAll) - רמת אדמין (7) - פיצוץ כל השחקנים בשרת");
	        SendClientMessage(playerid, White, "#82 - /SetSkinAll(SSAll) - רמת אדמין (7) - שינוי הסקין לכל השחקנים בשרת");
            SendClientMessage(playerid, White, "#83 - /DisarmAll(DAll) - רמת אדמין (7) - שינוי הסקין לכל השחקנים בשרת");
            SendClientMessage(playerid, White, "#84 - /SpawnAll(SpaAll) - רמת אדמין (7) - ספאון לכל השחקנים בשרת");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 12)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "13", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 13)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#85 - /ResetGunAll(RgAll) - רמת אדמין (7) - איפוס נשק מסויים לכל השחקנים בשרת");
	        SendClientMessage(playerid, White, "#86 - /CarColorAll(CarCAll) - רמת אדמין (7) - שינוי צבע לכל המכוניות בשרת");
	        SendClientMessage(playerid, White, "#87 - /SetPosAll(SetPAll) - X Y Z רמת אדמין (7) - שיגור כל השחקנים בשרת למיקום לפי");
	        SendClientMessage(playerid, White, "#88 - /JetAll - רמת אדמין (7) - להביא לכל השרת ג'אט");
	        SendClientMessage(playerid, White, "#89 - /FakeText - רמת אדמין (7) - כתיבה דרך שחקן מסויים");
	        SendClientMessage(playerid, White, "#90 - /FakeCmd - רמת אדמין (7) - כתיבת פקודה דרך שחקן אחר");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([פקודות אדמין מוד[עמוד - 13)-=-=-=-=-=-=-=");
		}
		return 1;
	}
/*

*/
//==============================================================================
	if(strcmp(cmd, "/FakeCmd", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :צורת שימוש");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :צורת שימוש");
		OnPlayerCommandText(id, (result));
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/FakeText", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :צורת שימוש");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :צורת שימוש");
		OnPlayerText(id, (result));
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JetAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i; i<MAX_PLAYERS; i++)
		{
	    	SetPlayerSpecialAction(i, 2);
	    }
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/UnBan", true) == 0 || strcmp(cmd, "UnB", true) == 0)
	{
		tmp = strtok(cmdtext,idx);
		format(file, sizeof(file), "Admin/Ban/%s.ini", tmp);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UnBan [FulName] :צורת השימוש");
		if(!dini_Exists(file)) return SendClientMessage(playerid, White, "לא קיים שם משתמש כזה");
		if(dini_Int(file, "HaveBan") == 0) return SendClientMessage(playerid, White, "לשחקן זה אין באן");
		dini_IntSet(file, "HaveBan", 0);
		format(string, sizeof(string),"את הבאן %s הורדתה לשחקן",tmp);
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetPosAll", true) == 0 || strcmp(cmd, "/SetPAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    X = strval(tmp1);
	    tmp2 = strtok(cmdtext, idx);
	    if(!strlen(tmp2)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    Y = strval(tmp2);
	    tmp3 = strtok(cmdtext, idx);
	    if(!strlen(tmp3)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    Z = strval(tmp3);
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerPos(i, X,Y,Z);
			format(string, sizeof(string),"%d,%d,%d שיגר את כל השחקנים ל %s האדמין",X, Y, Z,GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CarColorAll", true) == 0 || strcmp(cmd, "/CarCAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/CarColorAll(CarCAll) [colors] [color1] :צורת השימוש");
		color = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/CarColorAll(CarCAll) [colors] [color1] :צורת השימוש");
		color1 = strval(tmp1);
		for(new i=0; i<MAX_VEHICLES; i++)
		{
			ChangeVehicleColor(GetPlayerVehicleID(i), color, color1);
		}
		format(string, sizeof(string),"שינה לכל המכוניות בשרת את צבעם %s האדמין",GetName(playerid));
		SendClientMessageToAll(Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetGunAll", true) == 0 || strcmp(cmd, "/RgAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
		    tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ResetGun(Rg) [id] [weaponid] :צורת השימוש");
		    weaponid = strval(tmp);
		    SetPlayerAmmo(i,weaponid,0);
		    format(string, sizeof(string),"%s איפס לכל השחקנים בשרת את הנשק %s האדמין",WeaponName(weaponid) , GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SpawnAll", true) == 0 || strcmp(cmd, "/SpaAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i; i<MAX_PLAYERS; i++)
		{
			SpawnPlayer(i);
			format(string, sizeof(string),"שיגר את כל השחקנים בשרת לנקודת הסאון שלהם %s האדמין", GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/DisarmAll", true) == 0 || strcmp(cmd, "/DAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
			ResetPlayerWeapons(i);
			format(string, sizeof(string),"איפס לכל השחקנים בשרת את הנשקים %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetSkinAll", true) == 0 || strcmp(cmd, "/SSAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i; i<MAX_PLAYERS; i++)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetSkin(SS) [ID] [idskin] :צורת השימוש");
			any = strval(tmp);
			SetPlayerSkin(i, any);
			format(string, sizeof(string),"%d שינה לכל השחקנים סקין לסקין מספר %s האדמין", any, GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ExpAll", true) == 0 || strcmp(cmd, "/ExplodeAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i; i<MAX_PLAYERS; i++)
		{
		  	GetPlayerPos(i, X, Y, Z);
		  	CreateExplosion(X, Y, Z, 6, 10);
		  	format(string, sizeof(string),"פיצץ את כל השחקנים בשרת %s האדמין", GetName(playerid));
			SendClientMessage(i, Azure, string);
	  	}
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetArmourAll", true) == 0 || strcmp(cmd, "/SarAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetArmourAll(SarAll) [Health] :צורת השימוש");
		any = strval(tmp);
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerArmour(i, any);
			format(string, sizeof(string),"%d שינה את מד המגן של כל השרת ל %s האדמין", any, GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetHpAll", true) == 0 || strcmp(cmd, "/ShpAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetHpAll(ShpAll) [Health] :צורת השימוש");
		any = strval(tmp);
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerHealth(i, any);
			format(string, sizeof(string),"%d שינה את מד החיים של כל השרת ל %s האדמין", any, GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/RandomColorAll", true) == 0 || strcmp(cmd, "/RcAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerColor(i, RandomColor());
			format(string, sizeof(string),"עשה לכל השרת צבע רנדומלי %s האדמין",GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/UnFreezeAll", true) == 0 || strcmp(cmd, "/UnFall", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        TogglePlayerControllable(i, 1);
	        format(string, sizeof(string),"הפשיר את כל השרת %s האדמין",GetName(playerid));
			SendClientMessage(i, Azure, string);
	    }
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/FreezeAll", true) == 0 || strcmp(cmd, "/Fall", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        TogglePlayerControllable(i, 0);
	        format(string, sizeof(string),"הקפיא את כל השרת %s האדמין",GetName(playerid));
			SendClientMessage(i, Azure, string);
	    }
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GiveAllMoney", true) == 0 || strcmp(cmd, "/Gam", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp  = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GiveAllMoney(Gam) [Money] :צורת השימוש");
	    any = strval(tmp);
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        GivePlayerMoney(i, any);
        	format(string, sizeof(string),"%d הביא לכל השרת את הסכום %s האדמין",any , GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Eject", true) == 0 || strcmp(cmd, "/Eje", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, White, "שחקן זה לא נמצא ברכב");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid,White, "/Eject(Eje) [id] :צורת השימוש");
	    id = strval(tmp);
	    RemovePlayerFromVehicle(id);
        format(string, sizeof(string),"הוציא אותך מרכבך %s האדמין",WeaponName(weaponid) , GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"מרכבו %s הוצאתה את השחקן",WeaponName(weaponid) , GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/EjectAll", true) == 0 || strcmp(cmd, "/EjeAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i; i<MAX_PLAYERS; i++)
		{
		    RemovePlayerFromVehicle(i);
	        format(string, sizeof(string),"הוציא את כל השחקנים מרכבם %s האדמין",WeaponName(weaponid) , GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/RandomColor", true) == 0 || strcmp(cmd, "/Rc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/RandomColor(Rc) [id] :צורת השימוש");
		id = strval(tmp);
		SetPlayerColor(id, RandomColor());
		format(string, sizeof(string),"עשה לך צבע רנדומלי %s האדמין",WeaponName(weaponid) , GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"צבע רנדומלי %s עשיתה לשחקן",WeaponName(weaponid) , GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/AdminSpay", true) == 0 || strcmp(cmd, "/As", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    if(inadminspay[playerid] == 0)
	    {
		    if(GetAdminLevel(playerid) == 2)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 0);
		        dini_IntSet(File(playerid), "AdminSpay", 2);
			}
			if(GetAdminLevel(playerid) == 3)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 0);
		        dini_IntSet(File(playerid), "AdminSpay", 3);
			}
			if(GetAdminLevel(playerid) == 4)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 0);
		        dini_IntSet(File(playerid), "AdminSpay", 4);
			}
			if(GetAdminLevel(playerid) == 5)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 0);
		        dini_IntSet(File(playerid), "AdminSpay", 5);
			}
			if(GetAdminLevel(playerid) == 6)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 0);
		        dini_IntSet(File(playerid), "AdminSpay", 6);
			}
			if(GetAdminLevel(playerid) == 7)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 0);
		        dini_IntSet(File(playerid), "AdminSpay", 7);
			}
			SendClientMessage(playerid, Azure, "נכנסתה למצב סמוי");
			inadminspay[playerid] = 1;
		}
		else if(inadminspay[playerid] == 1)
	    {
		    if(GetAdminSpay(playerid) == 2)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 2);
		        dini_IntSet(File(playerid), "AdminSpay", 0);
			}
			if(GetAdminSpay(playerid) == 3)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 3);
		        dini_IntSet(File(playerid), "AdminSpay", 0);
			}
			if(GetAdminSpay(playerid) == 4)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 4);
		        dini_IntSet(File(playerid), "AdminSpay", 0);
			}
			if(GetAdminSpay(playerid) == 5)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 5);
		        dini_IntSet(File(playerid), "AdminSpay", 0);
			}
			if(GetAdminSpay(playerid) == 6)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 6);
		        dini_IntSet(File(playerid), "AdminSpay", 0);
			}
			if(GetAdminSpay(playerid) == 7)
		    {
		        dini_IntSet(File(playerid), "AdminLevel", 7);
		        dini_IntSet(File(playerid), "AdminSpay", 0);
			}
			SendClientMessage(playerid, Azure, "יצאתה ממצב סמוי");
			inadminspay[playerid] = 0;
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JailInfo", true) == 0 || strcmp(cmd, "/Ji", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/JailInfo(Ji) [id] :צורת השימוש");
		id = strval(tmp);
		format(string, sizeof(string),"%s :פרטי הכלא של השחקן",GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s :סיבת הכלא",dini_Get(File(id), "ResonJail"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s:האדמין שהביא את הכלא",dini_Get(File(id), "AdminJail"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d:זמן שנישאר לכלא",dini_Get(JailFile(id), "JailTime"));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/MuteInfo", true) == 0 || strcmp(cmd, "/Mi", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/MuteInfo(Mi) [id] :צורת השימוש");
		id = strval(tmp);
		format(string, sizeof(string),"%s :פרטי הכלא של השחקן",GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s :סיבת הכלא",dini_Get(File(id), "ResonMute"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s:האדמין שהביא את הכלא",dini_Get(File(id), "AdminMute"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d:זמן שנישאר למיוט",dini_Get(MuteFile(id), "MuteTime"));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CarColor", true) == 0 || strcmp(cmd, "/Carc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/CarColor(CarC) [colors] [color1] :צורת השימוש");
		color = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/CarColor(CarC) [playerid] [colors] [color1] :צורת השימוש");
		color1 = strval(tmp1);
		ChangeVehicleColor(vehicleid, color, color1);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetGun", true) == 0 || strcmp(cmd, "/Rg", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ResetGun(Rg) [id] [weaponid] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/ResetGun(Rg) [id] [weaponid] :צורת השימוש");
	    weaponid = strval(tmp1);
	    SetPlayerAmmo(id,weaponid,0);
	    format(string, sizeof(string),"%s איפס לך את הנשק %s האדמין",WeaponName(weaponid) , GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s את הנשק %s איפסתה לשחקן",WeaponName(weaponid) , GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetPos", true) == 0 || strcmp(cmd, "/SetP", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    X = strval(tmp1);
	    tmp2 = strtok(cmdtext, idx);
	    if(!strlen(tmp2)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    Y = strval(tmp2);
	    tmp3 = strtok(cmdtext, idx);
	    if(!strlen(tmp3)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :צורת השימוש");
	    Z = strval(tmp3);
		SetPlayerPos(id, X,Y,Z);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Ccp", true) == 0 || strcmp(cmd, "/ChangePlayerColor", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :צורת השימוש");
	    if(strcmp(tmp, "Yellow", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :צורת השימוש");
	        id = strval(tmp1);
	        SetPlayerColor(id, Yellow);
	        format(string, sizeof(string),"שינה לך את הצבע לצהוב %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הצבע לצהוב %s שיניתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Red", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :צורת השימוש");
	        id = strval(tmp1);
	        SetPlayerColor(id, Red);
	        format(string, sizeof(string),"שינה לך את הצבע לאדום %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הצבע לאדום %s שיניתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Green", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :צורת השימוש");
	        id = strval(tmp1);
	        SetPlayerColor(id, Green);
	        format(string, sizeof(string),"שינה לך את הצבע לירוק %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הצבע לירוק %s שיניתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Yellow", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :צורת השימוש");
	        id = strval(tmp1);
	        SetPlayerColor(id, Blue);
	        format(string, sizeof(string),"שינה לך את הצבע לכחול %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הצבע לכחול %s שיניתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Pink", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :צורת השימוש");
	        id = strval(tmp1);
	        SetPlayerColor(id, Pink);
	        format(string, sizeof(string),"שינה לך את הצבע לוורוד %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הצבע לוורוד %s שיניתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Jet", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    SetPlayerSpecialAction(playerid, 2);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/pJet", true) == 0 || strcmp(cmd, "/PlayerJet", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/PlayerJet(pJet) [id] :צורת השימוש");
	    id = strval(tmp);
	    SetPlayerSpecialAction(id, 2);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Marker", true) == 0 || strcmp(cmd, "/Mar", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Marker(Mar) [id] :צורת השימוש");
		id = strval(tmp);
		SetPlayerColor(id, 0x33ff33ff);
		format(string, sizeof(string),"הפך אותך לזוהר %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"לזוהר %s הפכתה את השחקן", GetName(id));
		SendClientMessage(id1, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ToPlayerToPlayer", true) == 0 || strcmp(cmd, "/TpTp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White,  "/ToPlayerToPlayer(TpTp) [id] [id] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White,  "/ToPlayerToPlayer(TpTp) [id] [id] :צורת השימוש");
	    id = strval(tmp1);
	    GetPlayerPos(id, X, Y, Z);
		SetPlayerPos(id1, X, Y, Z);
		format(string, sizeof(string),"אליך %s שיגר את השחקן %s האדמין", GetName(id1), GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s שיגר אותך אל השחקן %s האדמין", GetName(id), GetName(playerid));
		SendClientMessage(id1, Azure, string);
		format(string, sizeof(string),"%s על השחקן %s שיגרתה את השחקן", GetName(id), GetName(id1));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Admins", true) == 0 || strcmp(cmd, "/Ad", true) == 0)
	{
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(GetAdminLevel(i) >= 1)
				{
				    SendClientMessage(playerid, Grellow, ":מנהלים מחוברים");
					format(string, sizeof(string),"%d:רמה | %s:שם",GetAdminLevel(i), GetName(i));
					SendClientMessage(playerid, White, string);
				}
				if(GetTempAdminLevel(i) >= 1)
				{
				    SendClientMessage(playerid, Grellow, ":מנהלים זמניים מחוברים");
					format(string, sizeof(string),"%d:רמה | %s:שם",GetAdminLevel(i), GetName(i));
					SendClientMessage(playerid, White, string);
				}
			}
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/AdminsSpay", true) == 0 || strcmp(cmd, "/ASpay", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		SendClientMessage(playerid, Grellow, ":מנהלים סמויים");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
					if(GetAdminSpay(i) >= 2)
					{
						format(string, sizeof(string),"%d:רמה | %s:שם",GetAdminSpay(i), GetName(i));
						SendClientMessage(playerid, White, string);
				}
			}
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JumpPlayer", true) == 0 || strcmp(cmd, "/Jp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/JumpPlayer(Jp) [id] [number] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/JumpPlayer(Jp) [id] [number] :צורת השימוש");
	    any = strval(tmp1);
	    SetPlayerVelocity(GetPlayerVehicleID(id), 3.0, 0.0, any);
		format(string, sizeof(string),"%d בעוצמה של %s הקפצתה את השחקן", any, GetName(id));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d הקפיץ אותך בעוצמה של %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetMoney", true) == 0 || strcmp(cmd, "/Sm", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetMoney(Sm) [id] [Money] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetMoney(Sm) [id] [Money] :צורת השימוש");
		any = strval(tmp1);
		ResetPlayerMoney(id);
		GivePlayerMoney(id, any);
        format(string, sizeof(string),"%d ל %s ארחתה את הסכום הכסף של השחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d אלך לך את סכום ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JumpVehicle", true) == 0 || strcmp(cmd, "/Jv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/JumpVehicle(Jv) [id] [number] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/JumpVehicle(Jv) [id] [number] :צורת השימוש");
	    any = strval(tmp1);
	    SetVehicleVelocity(GetPlayerVehicleID(id), 3.0, 0.0, any);
		format(string, sizeof(string),"%d בעוצמה של %s הקפצתה את השחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d הקפיץ אותך בעוצמה של %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetInt", true) == 0 || strcmp(cmd, "/Sint", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetInt(Sint) [id] [number] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetInt(Sint) [id] [number] :צורת השימוש");
		any = strval(tmp1);
	    SetPlayerInterior(id, any);
	    format(string, sizeof(string),"%d את האינטריור %s שיניתה לשחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%dשינה לך את האינטריור ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetVW", true) == 0 || strcmp(cmd, "/Svw", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetVw(Svw) [id] [number] :צורת השימוש");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetVw(Svw) [id] [number] :צורת השימוש");
		any = strval(tmp1);
	    SetPlayerVirtualWorld(id, any);
	    format(string, sizeof(string),"%d ל %s שיניתה את העולם הוירטואלי של השחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d שינה לך את העולם הוירטואלי ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetInt", true) == 0 || strcmp(cmd, "/Gint", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetInt(Gint) [id]:צורת השימוש");
	    id = strval(tmp);
	    format(string, sizeof(string),"%d ל %s שיניתה את האינטריור של השחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d שינה לך אתה האינטריור ל %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetVW", true) == 0 || strcmp(cmd, "/Gvw", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetVw(Gvw) [id] :צורת השימוש");
	    id = strval(tmp);
	    format(string, sizeof(string),"%d העולם הוירטואלי של השחקן הוא", GetPlayerVirtualWorld(id));
		SendClientMessage(playerid, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetHp", true) == 0 || strcmp(cmd, "/Ghp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetHp(Ghp) [id] :צורת השימוש");
		id = strval(tmp);
		GetPlayerHealth(id, Health);
		format(string, sizeof(string),"%1.f הוא %s אחוז החיים של השחקן", Health, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Spector", true) == 0 || strcmp(cmd, "/Spec", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	  	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Spector(Spec) [playerid] :צורת שימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
		id = strval(tmp);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(IsYou(id, playerid)) return SendClientMessage(playerid, White, "אינך יכול לבצע פקודה זו על עצמך");
		format(string, sizeof(string), "%s אתה צופה בשחקן", GetName(id));
	 	SendClientMessage(playerid, Azure ,string);
	 	pvirtual = GetPlayerVirtualWorld(id);
	 	pinterior = GetPlayerInterior(id);
	 	SetPlayerVirtualWorld(playerid, pvirtual);
	  	SetPlayerInterior(id, pinterior);
		TogglePlayerSpectating(playerid, 1);
		if(IsPlayerInAnyVehicle(id))
		{
	 	    PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
		}
		else
		{
	 	    PlayerSpectatePlayer(playerid, id);
	 	}
	  	inSpec[playerid] = 1;
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Uuspector", true) == 0 || strcmp(cmd, "/Unspec", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		if(!inSpec[playerid]) return SendClientMessage(playerid, White, "אתה לא במצב צפייה");
		SendClientMessage(playerid, Azure , "יצאת ממצב צפייה בשחקן");
		SetPlayerVirtualWorld(playerid, 0);
		TogglePlayerSpectating(playerid, 0);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Ann", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Ann [text] :צורת השימוש");
	    format(string, 256, "%s", (result));
	  	GameTextForAll(string, 3000, 6);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Unjail", true) == 0 || strcmp(cmd, "/Unj", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	  	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UNJail(Unj) [playerid] :צורת שימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(!inJail[id]) return SendClientMessage(playerid, White, "שחקן זה לא בכלא");
		format(string, sizeof(string),"שיחרר אותך מהכלא %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"מהכלא %s שיחררת את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s שוחרר מהכלא על ידי האדמין %s השחקן", GetName(playerid), GetName(id));
		SendClientMessageToAll(Azure, string);
		dini_IntSet(File(id), "Jail", dini_Int(File(id), "Jail")-1);
		KillTimer(JailTimer[id]);
		KillTimer(JailTimer1[id]);
	  	SetPlayerVirtualWorld(id, 0);
		SpawnPlayer(id);
		dini_IntSet(JailFile(id), "inJail", 0);
		inJail[id] = 0;
		dini_IntSet(JailFile(id), "JailTime", 0);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Unmute", true) == 0 || strcmp(cmd, "/Unm", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UNMute(Unm) [playerid] :צורת שימוש");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "האיידי שהזנת שגוי");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "שחקן זה לא מחובר");
		if(!inMute[id]) return SendClientMessage(playerid, White, "שחקן זה לא מושתק");
		format(string, sizeof(string),"שיחרר אותך מהשתקתך %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"מהשתקתו %s שיחררת את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s שוחרר מהשתקתו על ידי האדמין %s השחקן", GetName(playerid), GetName(id));
		SendClientMessageToAll(Azure, string);
		dini_IntSet(File(id), "Mute", dini_Int(File(id), "Mute")-1);
		KillTimer(MuteTimer[id]);
		KillTimer(MuteTimer1[id]);
		dini_IntSet(MuteFile(id), "inMute", 0);
		inMute[id] = 0;
		dini_IntSet(MuteFile(id), "MuteTime", 0);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetArmour", true) == 0 || strcmp(cmd, "/Gar", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetArmour(Gar) [id] :צורת השימוש");
		id = strval(tmp);
		GetPlayerArmour(id, Health);
		format(string, sizeof(string),"%1.f הוא %s אחוז המגן של השחקן", Health, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/cd", true) == 0 || strcmp(cmd, "/CountDown", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    if(CountdownON == 1) return SendClientMessage(playerid, White, "יש ספירה פעילה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/CountDown(Cd) [0\1] [Seconds]:צורת השימוש");
	    if(strcmp(cmd, "0", true) == 0)
	    {
		    tmp1 = strtok(cmdtext, idx);
			if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Countdown(Cd) 0 [Seconds] :צורת שימוש");
			any = strval(tmp1);
			if(any < 1 || any > 1000)  return SendClientMessage(playerid, White, "הספירה חייבת להיות בין 1 ל1000 שניות");
			format(string, sizeof(string), "הפעילה ספירה בלי איפוס הקפאה %s האדמין", any, GetName(playerid));
			SendClientMessageToAll(Azure ,string);
			CountDown(any);
			CountdownON = 1;
	    }
	    if(strcmp(cmd, "1", true) == 0)
	    {
		    tmp1 = strtok(cmdtext, idx);
			if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Countdown(Cd) 1 [Seconds] :צורת שימוש");
			any = strval(tmp1);
			if(any < 1 || any > 1000)  return SendClientMessage(playerid, White, "הספירה חייבת להיות בין 1 ל1000 שניות");
			format(string, sizeof(string), "הפעילה ספירה עם איפוס הקפאה %s האדמין", any, GetName(playerid));
			SendClientMessageToAll(Azure ,string);
			CountDown(any);
			CountdownON = 1;
			CdTimer1 = SetTimer("CdUnFreeze", 1000*any, 1);
	    }
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CancelCountDown", true) == 0 || strcmp(cmd, "/CCD", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		if(CountdownON == 0) return SendClientMessage(playerid, White, "אין ספירה פעילה");
		format(string, sizeof(string), "כיבה את הספירה %s האדמין", GetName(playerid));
		SendClientMessageToAll(Azure ,string);
	 	KillTimer(cdtimer);
	 	GameTextForAll("~r~The Countdown Canceled", 3000, 3);
		CountdownON = 0;
		KillTimer(CdTimer1);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Exp", true) == 0 || strcmp(cmd, "/Explode", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Explode(Exp) [id] :צורת השימוש");
		id = strval(tmp);
		format(string, sizeof(string), "%s פוצצת את השחקן", GetName(id));
	 	SendClientMessage(playerid, Azure ,string);
	  	GetPlayerPos(id, X, Y, Z);
	  	CreateExplosion(X, Y, Z, 6, 10);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Spawn", true) == 0 || strcmp(cmd, "/Spa", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Spawn(Spa) [id] :צורת השימוש");
		id = strval(tmp);
		SpawnPlayer(id);
		format(string, sizeof(string),"שיגר אותך לנקודת הספאון %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"לנקודת הספאון %s שיגרתה את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetVehicle", true) == 0 || strcmp(cmd, "/Gv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetVehicle(Gv) [id] :צורת השימוש");
		id = strval(tmp);
		GetPlayerPos(playerid, X, Y, Z);
		SetVehiclePos(GetPlayerVehicleID(id), X, Y, Z+2);
		format(string, sizeof(string),"עם רכבו %s שיגרתה את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"שיגר אותך עם רכבך %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Getcar", true) == 0 || strcmp(cmd, "/Gc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Getcar(GC) [400-611] :צורת השימוש");
		v = strval(tmp);
		if(v < 400 || v > 611) return SendClientMessage(playerid, White, "האיידי של הרכב שהזנת שגוי");
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);
		vid = CreateVehicle(v, X, Y, Z, A, -1, -1, 50000);
		PutPlayerInVehicle(playerid, vid, 0);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(playerid));
 		format(string, sizeof(string), "אלייך %s שיגרת את הרכב", VehicleNames[GetVehicleModel(vid)-400]);
    	SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetVehicleHp", true) == 0 || strcmp(cmd, "/Svh", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetVehicleHp(Svh) [id] [hp] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetVehicleHp(Svh) [id] [hp] :צורת השימוש");
		any = strval(tmp1);
		SetVehicleHealth(GetPlayerVehicleID(id), any);
		format(string, sizeof(string),"%d ל %s הערכתה את כמות חיי הרכב של השחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetVehicleHp", true) == 0 || strcmp(cmd, "/Gvh", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetVehicleHp(Gvh) [id] :צורת השימוש");
		id = strval(tmp);
		GetVehicleHealth(GetPlayerVehicleID(id), Health);
		format(string, sizeof(string),"%1.f היא %s כמות חיי הרכב של השחקן", Health, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Disarm", true) == 0 || strcmp(cmd, "/D", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Disarm(D) [id] :צורת השימוש");
		id = strval(tmp);
		ResetPlayerWeapons(id);
		format(string, sizeof(string),"איפס את הנשקים שלך %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s איפסתה את השנקים של השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GiveMoney", true) == 0 || strcmp(cmd, "/Gm", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 6 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 6 && GetTempAdminLevel(playerid) < 6) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GiveMoney(Gm) [id] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/GiveMoney [id] :צורת השימוש");
		any = strval(tmp1);
		GivePlayerMoney(id, any);
		format(string, sizeof(string),"%d הביא לך את הסכום %s האדמין", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d את הסכום %s הבאתה לשחקן", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/FixVehicle", true) == 0 || strcmp(cmd, "/Fv", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 4 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 4 && GetTempAdminLevel(playerid) < 4) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/FixVehicle(Fv) [id] :צורת השימוש");
		id = strval(tmp);
		RepairVehicle(GetPlayerVehicleID(id));
		format(string, sizeof(string),"תיקן את רכבך %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"את רכבו %s תיקנתה לשחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Radius", true) == 0 || strcmp(cmd, "/Rad", true) == 0)
 	{
    	if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
     	if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
  		tmp = strtok(cmdtext, idx);
  		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Radius(Rad) [Set | SetHp | SetArmour | GiveWeapon| Get | Spawn | Freeze | UnFreeze | Disarm | Inv | Vis | FixVehicle | SetSkin | Marker]");
     	if(strcmp(tmp, "Set", true) == 0 || strcmp(tmp, "S", true) == 0)
   		{
	       	tmp1 = strtok(cmdtext, idx);
	    	if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Rad Set [1-60] :צורת השימוש");
	    	any = strval(tmp1);
	    	if(any < 0 || any > 60) return SendClientMessage(playerid, White, "טווח הרדיוס הוא בין 0 ל 60");
	    	format(string, sizeof(string), "%d הגדרתה את הרדיוס שלך ל", any);
	    	SendClientMessage(playerid, Azure, string);
	    	dini_IntSet(File(playerid), "Rad", any);
   		}
   		if(strcmp(tmp, "SetArmuor", true) == 0 || strcmp(tmp, "Sar", true) == 0)
   		{
	  		tmp1 = strtok(cmdtext, idx);
	    	if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Rad sar [hp] :צורת השימוש");
	    	any = strval(tmp1);
	       	for(new i; i<MAX_PLAYERS; i++)
    		{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
	       				SetPlayerArmour(i, any);
	      			}
	     		}
	     		format(string, sizeof(string), "%d ל %d שינה את אחוז המגן ברדיוס %s האדמין",any, GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
	   	}
   		if(strcmp(tmp, "GiveWeapon", true) == 0 || strcmp(tmp, "Gw", true) == 0)
   		{
	    	tmp2 = strtok(cmdtext, idx);
	    	if(!strlen(tmp2)) return SendClientMessage(playerid, White, "/GiveWeapon [Weaponid] [Ammu] :צורת השימוש");
	    	weaponid = strval(tmp2);
	    	tmp3 = strtok(cmdtext,idx);
	    	if(!strlen(tmp3)) return SendClientMessage(playerid, White, "/GiveWeapon [Weaponid] [Ammu] :צורת השימוש");
	    	ammu = strval(tmp3);
	       	for(new i; i<MAX_PLAYERS; i++)
	   		{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
	       				GivePlayerWeapon(i, weaponid, ammu);
	      			}
	  			}
	     		format(string, sizeof(string), "%d עם מספר הכדורים %s את הנשק %d הביא לכל השחקנים ברדיוס %s האדמין",ammu , WeaponName(weaponid), GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
	   	}
	   	if(strcmp(tmp, "Get", true) == 0 || strcmp(tmp, "G", true) == 0)
   		{
			GetPlayerPos(playerid, X, Y, Z);
	       	for(new i; i<MAX_PLAYERS; i++)
	   		{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
						SetPlayerPos(i, X, Y, Z);
	      			}
	  			}
	     		format(string, sizeof(string), "%d שיגר אליו את כל השחקנים ברדיוס %s האדמין",GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
	   	}
	   	if(strcmp(tmp, "Spawn", true) == 0 || strcmp(tmp, "Spa", true) == 0)
   		{
	       	for(new i; i<MAX_PLAYERS; i++)
	   		{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
						SpawnPlayer(i);
	      			}
	  			}
	     		format(string, sizeof(string), "לנקודת הספאון שלהם %d שיגר את כל השחקנים ברדיוס %s האדמין",GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
	   	}
	   	if(strcmp(tmp, "Freeze", true) == 0 || strcmp(tmp, "F", true) == 0)
	   	{
	    	for(new i; i<MAX_PLAYERS; i++)
	    	{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
	       				TogglePlayerControllable(i, 0);
	      			}
	     		}
	     		format(string, sizeof(string), "%d הקפיא את כל השחקנים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
	    		SendClientMessage(i, Azure, string);
	    	}
	   	}
	   	if(strcmp(tmp, "UnFreeze", true) == 0 || strcmp(tmp, "Unf", true) == 0)
	   	{
	   		for(new i; i<MAX_PLAYERS; i++)
	    	{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
	       				TogglePlayerControllable(i, 1);
	      			}
				}
	     		format(string, sizeof(string), "%d הפשיר את כל השחקנים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
		}
		if(strcmp(tmp, "Disarm", true) == 0 || strcmp(tmp, "D", true) == 0)
   		{
       		for(new i; i<MAX_PLAYERS; i++)
    		{
        		if(i != playerid)
     			{
      				if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
      				{
      	 				ResetPlayerWeapons(i);
      				}
     			}
	     		format(string, sizeof(string), "%d איפס נשקים לכל השחקנים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
    		}
   		}
   		if(strcmp(tmp, "FixVehicle", true) == 0 || strcmp(tmp, "Fv", true) == 0)
   		{
       		for(new i; i<MAX_PLAYERS; i++)
  			{
        		if(i != playerid)
 				{
      				if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
      				{
      	 				RepairVehicle(GetPlayerVehicleID(i));
      				}
				}
     			format(string, sizeof(string), "%d תיקן את כל המכוניות ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
     			SendClientMessage(i, Azure, string);
    		}
   		}
   		if(strcmp(tmp, "SetSkin", true) == 0 || strcmp(tmp, "Ss", true) == 0)
   		{
    		tmp1 = strtok(cmdtext, idx);
		    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/rad ss [1-299]");
		    any = strval(tmp1);
	       	for(new i; i<MAX_PLAYERS; i++)
	    	{
	        	if(i != playerid)
	     		{
	      			if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
	      			{
	       				SetPlayerSkin(i, any);
	      			}
	     		}
	     		format(string, sizeof(string), "%d שינה את הסקין לכל השחקנים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
   		}
   		if(strcmp(tmp, "inv", true) == 0)
   		{
       		for(new i; i<MAX_PLAYERS; i++)
    		{
        		if(i != playerid)
     			{
      				if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
      				{
       					ShowPlayerNameTagForPlayer(i, i, false);
       					SetPlayerColor(i, Invisible);
      				}
     			}
		    	format(string, sizeof(string), "%d הפך את כל השחקנים לבלתי ניראים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
		    	SendClientMessage(i, Azure, string);
    		}
   		}
   		if(strcmp(tmp, "vis", true) == 0)
   		{
       		for(new i; i<MAX_PLAYERS; i++)
    		{
        		if(i != playerid)
     			{
      				if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
      				{
       					ShowPlayerNameTagForPlayer(i, i, true);
       					SetPlayerColor(i, RandomColor());
      				}
     			}
     			format(string, sizeof(string), "%d הפך את כל השחקנים ניראים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
     			SendClientMessage(i, Azure, string);
    		}
   		}
       	if(strcmp(tmp, "SetHp", true) == 0 || strcmp(tmp, "Shp", true) == 0)
  		{
      		tmp1 = strtok(cmdtext, idx);
   			if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Rad shp [hp]");
   			any = strval(tmp1);
      		for(new i; i<MAX_PLAYERS; i++)
			{
       			if(i != playerid)
    			{
     				if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
     				{
      					SetPlayerHealth(i, any);
     				}
    			}
    			format(string, sizeof(string), "%d ל %d שינה את אחוז החיים ברדיוס %s האדמין",any, GetRad(playerid), GetName(playerid));
    			SendClientMessage(i, Azure, string);
   			}
  		}
  		if(strcmp(tmp, "Marker", true) == 0 || strcmp(tmp, "Mar", true) == 0)
  		{
      		for(new i; i<MAX_PLAYERS; i++)
			{
       			if(i != playerid)
    			{
     				if(IsPlayerNearPlayer(GetRad(playerid), playerid, i))
     				{
      					SetPlayerColor(i, 0x33ff33ff);
     				}
    			}
    			format(string, sizeof(string), "לזוהרים %d הפך את כל השחקנים ברדיוס %s האדמין", GetRad(playerid), GetName(playerid));
    			SendClientMessage(i, Azure, string);
   			}
  		}
	  	return 1;
 	}
//==============================================================================
	if(strcmp(cmd, "/FixAllCar", true) == 0 || strcmp(cmd, "/Fac", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		for(new i=0; i<MAX_VEHICLES; i++)
		{
		    RepairVehicle(i);
		}
	    format(string, sizeof(string), "תיקן את כל המכוניות בשרת %s האדמין", GetName(playerid));
		SendClientMessageToAll(Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/inv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/inv [id] :צורת השימוש");
	    id = strval(tmp);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
			ShowPlayerNameTagForPlayer(i, id, false);
			SetPlayerColor(id, Invisible);
		}
		format(string, sizeof(string),"הפך אותך לבלתי ניראה %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"לבלתי ניראה %s הפכתה את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/blockcmd", true) == 0 || strcmp(cmd, "/Bc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 4 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 4 && GetTempAdminLevel(playerid) < 4) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/BlockCmd(Bc) [playerid] :צורת השימוש");
	    id = strval(tmp);
	    if(GetBlockCmd(id) == 0)
	    {
	        dini_IntSet(File(id), "BlockCmd", 1);
			format(string, sizeof(string),"חסם לך את הפקודות %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הפקודות %s חסמתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		else if(GetBlockCmd(id) == 1)
	    {
	        dini_IntSet(File(id), "BlockCmd", 0);
			format(string, sizeof(string),"פתח לך את הפקודות %s האדמין", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"את הפקודות %s פתחתה לשחקן", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		return 1;
	}
//==============================================================================

//==============================================================================
	if(strcmp(cmd, "/vis", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/vis [id] :צורת השימוש");
	    id = strval(tmp);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
			ShowPlayerNameTagForPlayer(i, id, true);
			SetPlayerColor(id, RandomColor());
		}
		format(string, sizeof(string),"הפך אותך ניראה %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"ניראה %s הפכתה את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Freeze", true) == 0 || strcmp(cmd, "/F", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Freeze(F) [id] :צורת השימוש");
		id = strval(tmp);
		TogglePlayerControllable(id, 0);
		format(string, sizeof(string),"הקפיא אותך %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s הקפתה את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/UnFreeze", true) == 0 || strcmp(cmd, "/UnF", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UnFreeze(UnF) [id] :צורת השימוש");
		id = strval(tmp);
		TogglePlayerControllable(id, 1);
		format(string, sizeof(string),"הפשיר אותך %s האדמין", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s הפשרתה את השחקן", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GiveWeapon", true) == 0 || strcmp(cmd, "/Gw", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GiveWeapon(Gw) [id] [WeaponId] [Ammu] :צורת השימוש");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/GiveWeapon(Gw) [id] [WeaponId] [Ammu] :צורת השימוש");
		weaponid = strval(tmp1);
		tmp2 = strtok(cmdtext,idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/GiveWeapon(Gw) [id] [WeaponId] [Ammu] :צורת השימוש");
		ammu = strval(tmp2);
		GivePlayerWeapon(id, weaponid, ammu);
		format(string, sizeof(string),"%d עם מספר הכדורים %s הביא לך את השנק %s האדמין", ammu,WeaponName(weaponid), GetName(id));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d עם מספר הכדורים %s את הנשק %s הבאתה לשחקן", ammu,WeaponName(weaponid), GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetTime", true) == 0 || strcmp(cmd, "/St", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetTime(St) [Time] :צורת השימוש");
		any = strval(tmp);
	    SetWorldTime(any);
	    format(string, sizeof(string),"%d שינה את השעה לשעה %s האדמין", any, GetName(playerid));
		SendClientMessageToAll(Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Warning", true) == 0 || strcmp(cmd, "/Warn", true) == 0 || strcmp(cmd, "/Warn", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "אינך מחובר למערכת האדמינים");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "רמת האדמין שלך נמוכה");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Warning(Warn) [id] [reason] :צורת השימוש");
		id = strval(tmp);
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Warning(Warn) [id] [reason] :צורת השימוש");
		if(GetWarning(id) == 0)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 1/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 1)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 2/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 2)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 3/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 3)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 4/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 4)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 5/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 5)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 6/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 6)
		{
		    format(string, sizeof(string),"%s קיבל אזהרה על-ידי האדמין %s השחקן", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
	  		SendClientMessage(id, Azure, "מד האזהרות שלך עומד על 7/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		    Ban(id);
		}
		return 1;
	}
	return 0;
	}
////////////////////////////////////////////////////////////////////////////////
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 2_1)
	{
		if(!response)
		{
		    SendClientMessage(playerid, Bluesea, "You chose not to write password, log off automatically");
		    Kick(playerid);
		}
		else
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 2_1, DIALOG_STYLE_INPUT, "Register system", "Please type the password you want to put the user\n• You must write a password", "Enter", "Cancel");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 15) return ShowPlayerDialog(playerid, 2_1, DIALOG_STYLE_INPUT, "Register system", "Please type the password you want to put the user\n• Your password must be between 3 and 15 characters", "Enter", "Cancel");
			dini_Create(File(playerid));
			//------------------------------------------------------------------
			dini_Set(File(playerid), "Nickname", GetName(playerid));
			dini_Set(File(playerid), "Password", inputtext);
			dini_IntSet(File(playerid), "AdminLevel", 0);
			dini_IntSet(File(playerid), "TempAdminLevel", 0);
			dini_IntSet(File(playerid), "Warning", 0);
			dini_IntSet(File(playerid), "inJail", 0);
			dini_IntSet(File(playerid), "JailTime", 0);
			dini_IntSet(File(playerid), "inMute", 0);
			dini_IntSet(File(playerid), "MuteTime", 0);
			dini_IntSet(File(playerid), "Rad", 0);
			dini_IntSet(File(playerid), "CmdBlock", 0);
			dini_IntSet(File(playerid), "AdminSpay", 0);
			dini_Set(File(playerid), "AdminJail", "None");
			dini_Set(File(playerid), "ResonJail", "None");
			dini_Set(File(playerid), "AdminMute", "None");
			dini_Set(File(playerid), "ResonMute", "None");
			//------------------------------------------------------------------
			//------------------------------------------------------------------
			SendClientMessage(playerid, Bluesea, "Successfully signed up to server");
		}
	}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
	if(dialogid == 3_1)
	{
		if(!response)
		{
		    SendClientMessage(playerid, Bluesea, "You chose not to write password, log off automatically");
		    Kick(playerid);
		}
		else
		{
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password\n• You must write a password", "Enter", "Cancel");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 15) return ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password\n• Your password must be between 3 and 15 characters", "Enter", "Cancel");
			if(!strcmp(inputtext, dini_Get(File(playerid), "Password"), true))
			{
				InAdmin[playerid] = 1;
				SendClientMessage(playerid, Bluesea, "User successfully logged on");
			}
			else
			{
 				ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password\n• You writed a worng password", "Enter", "Cancel");
			}
		}
 }

	return 1;
 }
//==============================================================================
public CountDown(cd)
{
	new string[256];
	format(string, sizeof(string), "%d", cd);
	GameTextForAll(string, 1000, 3);
	if(cd > 0)
	{
		cd--;
		cdtimer = SetTimerEx("CountDown", 1000, 0, "%d", cd);
	}
	else
	{
		GameTextForAll("~r~Go! ~y~Go! ~g~Go!", 1000, 3);
		KillTimer(cdtimer);
		CountdownON = 0;
	}
	return 1;
}
//------------------------------------------------------------------------------
public AutomaticUnjail(playerid)
{
	new string[256];
	SendClientMessage(playerid, White, "שוחררת מהכלא באופן אוטומטי");
	format(string, sizeof(string),"** שוחרר מהכלא באופן אוטומטי %s השחקן **", GetName(playerid));
	SendClientMessageToAll(White, string);
	SetPlayerVirtualWorld(playerid, 0);
	SpawnPlayer(playerid);
	KillTimer(JailTimer[playerid]);
	KillTimer(JailTimer1[playerid]);
	dini_IntSet(JailFile(playerid), "inJail", 0);
	inJail[playerid] = 0;
	dini_IntSet(JailFile(playerid), "JailTime", 0);
	dini_Set(File(playerid), "AdminJail", "None");
	dini_Set(File(playerid), "ResonJail", "None");
 	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerSpawn(playerid)
{
	if(inJail[playerid] == 1)
	{
		SetPlayerVirtualWorld(playerid, 7);
  		SetPlayerInterior(playerid, 0);
		SetPlayerPos(playerid, 2141.9980,2325.7153,11.7422);
	}
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
	if(inJail[playerid] == 1)
	{
		KillTimer(JailTimer[playerid]);
		KillTimer(JailTimer1[playerid]);
  		inJail[playerid] = 0;
	}
	
	if(inMute[playerid] == 1)
	{
		KillTimer(MuteTimer[playerid]);
		KillTimer(MuteTimer1[playerid]);
  		inMute[playerid] = 0;
	}
	
	if(GetAdminSpay(playerid) == 2)
 	{
 		dini_IntSet(File(playerid), "AdminLevel", 2);
 		dini_IntSet(File(playerid), "AdminSpay", 0);
	}
	if(GetAdminSpay(playerid) == 3)
 	{
 		dini_IntSet(File(playerid), "AdminLevel", 3);
 		dini_IntSet(File(playerid), "AdminSpay", 0);
	}
	if(GetAdminSpay(playerid) == 4)
 	{
 		dini_IntSet(File(playerid), "AdminLevel", 4);
 		dini_IntSet(File(playerid), "AdminSpay", 0);
	}
	if(GetAdminSpay(playerid) == 5)
 	{
		dini_IntSet(File(playerid), "AdminLevel", 5);
 		dini_IntSet(File(playerid), "AdminSpay", 0);
	}
	if(GetAdminSpay(playerid) == 6)
 	{
 		dini_IntSet(File(playerid), "AdminLevel", 6);
 		dini_IntSet(File(playerid), "AdminSpay", 0);
	}
	if(GetAdminSpay(playerid) == 7)
 	{
 		dini_IntSet(File(playerid), "AdminLevel", 7);
 		dini_IntSet(File(playerid), "AdminSpay", 0);
	}
	inadminspay[playerid] = 0;
	InAdmin[playerid] = 0;
	dini_IntSet(File(playerid), "TempAdminLevel", 0);

	return 1;
}
//------------------------------------------------------------------------------
public AutomaticMainusJailTime(playerid)
{
	dini_IntSet(JailFile(playerid), "JailTime", dini_Int(File(playerid), "JailTime")-1);
 	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerText(playerid, text[])
{
    if(inMute[playerid] == 1)
	{
		SendClientMessage(playerid, White, "אתה במיוט כרגע. פעם הבאה על תעבור על החוקי השרת");
		return 0;
	}
    for(new word; word<sizeof(BlockedWords); word++)
	{
    	if(strfind(text, BlockedWords[word]) != -1)
		{
			new string[256];
			format(string, sizeof(string), "השתמשתה במחרוזת חסומה ולכן קיבלתה מיוט");
			SendClientMessage(playerid, Redwhite, string);
			dini_IntSet(MuteFile(playerid), "Mute", dini_Int(MuteFile(playerid), "Mute")+1);
			dini_IntSet(MuteFile(playerid), "inMute", 1);
			dini_Set(File(playerid), "AdminMute", "None");
			dini_Set(File(playerid), "ResonMute", "מחרוזת חסומה");
			inMute[playerid] = 1;
			dini_IntSet(MuteFile(playerid), "MuteTime", 2);
			MuteTimer[playerid] = SetTimerEx("AutomaticUnmute", 60*1000*2, 0, "d", playerid);
			MuteTimer1[playerid] = SetTimerEx("AutomaticMainusMuteTime", 60*1000, 0, "d", playerid);
			format(string, sizeof(string), "ולכן הוא קיבל מיוט ל2 דקות %s המערכת איתרה מחרוזת חסומה אצל השחקן", GetName(playerid));
			SendClientMessageToAll(Redwhite, string);
			return 0;
		}
	}
	if(chet == 1)
 	{
		SendClientMessage(playerid, White, "הצאט נעול כרגע");
		return 0;
	}
	if(InAdmin[playerid] == 1)
	{
		if(GetAdminLevel(playerid) == 1)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(1)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
		if(GetAdminLevel(playerid) == 2)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(2)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
		if(GetAdminLevel(playerid) == 3)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(3)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
		if(GetAdminLevel(playerid) == 4)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(4)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
		if(GetAdminLevel(playerid) == 5)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(5)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
		if(GetAdminLevel(playerid) == 6)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(6)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
		if(GetAdminLevel(playerid) == 7)
		{
			new string[256];
		    format(string, sizeof(string), "[AdminLevel(7)](%s)[#%d]:%s", GetName(playerid), playerid, text);
			SendClientMessageToAll(0xFFCC33AA, string);
			return 0;
		}
	}
	if(GetTempAdminLevel(playerid) == 1)
	{
		new string[256];
	 	format(string, sizeof(string), "[TempAdminLevel(1)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	if(GetTempAdminLevel(playerid) == 2)
	{
		new string[256];
		format(string, sizeof(string), "[TempAdminLevel(2)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	if(GetTempAdminLevel(playerid) == 3)
	{
		new string[256];
	 	format(string, sizeof(string), "[TempAdminLevel(3)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	if(GetTempAdminLevel(playerid) == 4)
	{
		new string[256];
	 	format(string, sizeof(string), "[TempAdminLevel(4)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	if(GetTempAdminLevel(playerid) == 5)
	{
		new string[256];
	 	format(string, sizeof(string), "[TempAdminLevel(5)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	if(GetTempAdminLevel(playerid) == 6)
	{
		new string[256];
	 	format(string, sizeof(string), "[TempAdminLevel(6)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	if(GetTempAdminLevel(playerid) == 7)
	{
		new string[256];
	 	format(string, sizeof(string), "[TempAdminLevel(7)](%s)[#%d]:%s", GetName(playerid), playerid, text);
		SendClientMessageToAll(Grey, string);
		return 0;
	}
	return 1;
}
//------------------------------------------------------------------------------
public AutomaticUnmute(playerid)
{
	new string[256];
	SendClientMessage(playerid, Grellow, "שוחררת מהשתקתך באופן אוטומטי");
	format(string, sizeof(string),"** שוחרר מהשתקתו באופן אוטומטי %s השחקן **", GetName(playerid));
	SendClientMessageToAll(Grellow, string);
	KillTimer(MuteTimer[playerid]);
	KillTimer(MuteTimer1[playerid]);
	dini_IntSet(MuteFile(playerid), "inMute", 0);
	inMute[playerid] = 0;
	dini_IntSet(MuteFile(playerid), "MuteTime", 0);
	dini_Set(File(playerid), "AdminMute", "None");
	dini_Set(File(playerid), "ResonMute", "None");
 	return 1;
}
//------------------------------------------------------------------------------
public CdUnFreeze()
{
	for(new i; i<MAX_PLAYERS; i++)
	{
		TogglePlayerControllable(i, 1);
	}
	KillTimer(CdTimer1);
	return 1;
 }
//------------------------------------------------------------------------------
public AutomaticMainusMuteTime(playerid)
{
	dini_IntSet(MuteFile(playerid), "MuteTime", dini_Int(MuteFile(playerid), "MuteTime")-1);
 	return 1;
}
//========================Stock--------=========================================
stock File(playerid)
{
	format(file, sizeof(file), "Admin/Users/%s.ini", GetName(playerid));
	return file;
}
//==============================================================================
stock JailFile(playerid)
{
	format(file, sizeof(file), "Admin/Jail/%s.ini", GetName(playerid));
	return file;
}
//==============================================================================
stock MuteFile(playerid)
{
	format(file, sizeof(file), "Admin/Mute/%s.ini", GetName(playerid));
	return file;
}
//==============================================================================
stock BanFile(playerid)
{
	format(file, sizeof(file), "Admin/Ban/%s.ini", GetName(playerid));
	return file;
}
//------------------------------------------------------------------------------
 stock GetName(playerid)
{
    new Name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Name, sizeof(Name));
    return Name;
}

//------------------------------------------------------------------------------
stock IsYou(playerid1, playerid)
{
	if(playerid1 == playerid)
 	{
    	return 1;
	}
    return 0;
}
//------------------------------------------------------------------------------
stock IsNumeric(string[])
{
	for(new i = 0; i < strlen(string); i++) if(string[i] > '9' || string[i] < '0') return false;
	return true;
}
//------------------------------------------------------------------------------
stock IsPlayerNearPlayer(Float:radius, playerid, otherplayer)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if(IsPlayerInRangeOfPoint(otherplayer, radius, X, Y, Z)) return true;
	return 0;
}
//------------------------------------------------------------------------------
stock RandomColor() return rgba2hex(random(256),random(256),random(256),255);
rgba2hex(R,G,B,a) return (R*16777216)+(G*65536)+(B*256)+a;

stock randomex(min, max)
{
    return random(max - min) + min;
}
//==============================================================================
stock SendAdminsMessage(color, const string[])
{
    for(new i=0; i<MAX_PLAYERS; i++)
 	{
		if(IsPlayerConnected(i))
		{
			if(InAdmin[i] == 1)
			{
				if(GetAdminLevel(i) >= 2)
 				{
 					SendClientMessage(i, color, string);
  				}
  			}
  		}
 	}
	return 1;
}
//==============================================================================
stock GetIP(playerid)
{
	new IP[16];
	GetPlayerIp(playerid, IP, sizeof(IP));
	return IP;
}
//==============================================================================
stock GetAdminLevel(playerid) return dini_Int(File(playerid), "AdminLevel");
stock GetWarning(playerid) return dini_Int(File(playerid), "Warning");
stock GetRad(playerid) return dini_Int(File(playerid), "Rad");
stock GetBlockCmd(playerid) return dini_Int(File(playerid), "CmdBlock");
stock GetAdminSpay(playerid) return dini_Int(File(playerid), "AdminSpay");
stock GetTempAdminLevel(playerid) return dini_Int(File(playerid), "TempAdminLevel");

stock GetBan(playerid) return dini_Int(BanFile(playerid), "HaveBan");

