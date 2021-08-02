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
	"����",
	"�!���",
	"�� ��!��",
	"�!�����",
	"�����",
	"�� ����",
	"�������",
	"������",
	"��� ���",
	"������",
	"�����",
	"���",
	"���",
	"����",
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
		format(string,sizeof(string), ":�� �� ��� ���� ���� ����� ���� ����");
		SendClientMessage(playerid, Brightred, string);
		format(string,sizeof(string), "%s:���� ����", dini_Get(BanFile(playerid), "Reson"));
		SendClientMessage(playerid, Yellow, string);
		format(string,sizeof(string), "%s:������ ����� �� ����", dini_Get(BanFile(playerid), "BanAdmin"));
		SendClientMessage(playerid, Yellow, string);
		format(string,sizeof(string), "%s:����� �����", dini_Get(BanFile(playerid), "IP"));
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
	if(GetBlockCmd(playerid) == 1) return SendClientMessage(playerid, White, "���� ���� ����� ������ ����� ������� ������ ��");
//==============================================================================
	if(strcmp(cmd, "/AdminRegister", true) == 0 || strcmp(cmd, "/Ar", true) == 0)
	{
		if(dini_Exists(File(playerid)))
		{
			format(string, sizeof(string),"��� ���� ���� %s ������", GetName(playerid));
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
		if(InAdmin[playerid] == 1) return SendClientMessage(playerid, White, "��� ��� ����� ����");
	    if(!dini_Exists(File(playerid)))
		{
			SendClientMessage(playerid, White, "��� �� ���� ����");
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
		if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetAdmin(Sa) [id] [level] :���� ������");
	 	id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetAdmin(Sa) [id] [level] :���� ������");
		level = strval(tmp1);
		if(!dini_Exists(File(id))) return SendClientMessage(playerid, White, "���� ���� ����� ����� ����� ���� ������");
		if(level < 0 || level > 7) return SendClientMessage(playerid, White, "���� ����� ��� ��� 0 �7");
		dini_IntSet(File(id), "AdminLevel", level);
		format(string, sizeof(string),"%d ���� ���� ���� ����� %s ������", level, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d ���� ����� %s ����� �� �����", level, GetName(id));
		SendClientMessage(playerid, Azure, string);
		dini_IntSet(File(id), "AdminSpay", 0);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetTempAdmin", true) == 0 || strcmp(cmd, "/Sta", true) == 0)
	{
		if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetTempAdmin(Sta) [id] [level] :���� ������");
	 	id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetTempAdmin(Sta) [id] [level] :���� ������");
		level = strval(tmp1);
		if(level < 0 || level > 7) return SendClientMessage(playerid, White, "���� ����� ��� ��� 0 �7");
		dini_IntSet(File(id), "TempAdminLevel", level);
		format(string, sizeof(string),"%d ���� ���� ���� ����� ���� %s ������", level, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d ���� ����� ���� %s ����� �� �����", level, GetName(id));
		SendClientMessage(playerid, Azure, string);
		dini_IntSet(File(id), "AdminSpay", 0);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Jail", true) == 0 || strcmp(cmd, "/J", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Jail(J) [playerid] [time] [reason] :���� �����");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(inJail[id] == 1) return SendClientMessage(playerid, White, "���� �� ��� ����");
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Jail(J) [playerid] [time] [reason] :���� �����");
		any = strval(tmp1);
		if(any < 1 || any > 10)  return SendClientMessage(playerid, White, "���� ���� ����� ��� �1 �� 10");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Jail(J) [playerid] [time] [reason] :���� �����");
		format(string, sizeof(string),"�%d ���� %s ���� �� ��� ������ %s �����", any, GetName(playerid), GetName(id));
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
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 4 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 4 && GetTempAdminLevel(playerid) < 4) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/kill [id] :���� �����");
	    id = strval(tmp);
	    SetPlayerHealth(id, 0);
		format(string,sizeof(string), "%s ��� �� ����� %s ������", GetName(id), GetName(playerid));
		SendClientMessageToAll(Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Report", true) == 0 || strcmp(cmd, "/Rep", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid,White, "/Report(Rep) [id] [text] :���� ������");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Report [id] [text] :���� ������");
		format(string,sizeof(string), "[id:%d]%s �� ����� [id:%d]%s����� ���� ������",id, GetName(id), playerid, GetName(playerid));
		SendAdminsMessage(Brown, string);
		SendClientMessage(playerid, Brown, "����� ���� ������");
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "//", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "��� ������ ��� �����");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "// [text] :���� ������");
		format(string,sizeof(string), "[AdminsChat]%s[%d#]:%s",GetName(playerid), playerid, (result));
		SendAdminsMessage(Grellow, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Ban", true) == 0 || strcmp(cmd, "/B", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Ban(B) [id] [reson] :���� ������");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Ban(B) [id] [reson] :���� ������");
		format(string, sizeof(string),"%s ���� ��� ��-��� ������ %s �����", GetName(playerid), GetName(id));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Kick(K) [id] [reson] :���� ������");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Kick(K) [id] [reson] :���� ������");
		format(string, sizeof(string),"%s ���� ��� ��-��� ������ %s �����", GetName(playerid), GetName(id));
		SendClientMessageToAll(Azure, string);
		format(string, sizeof(string),"(%s)", (result));
		SendClientMessageToAll(Azure, string);
		Kick(id);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Mute", true) == 0 || strcmp(cmd, "/M", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Mute(M) [playerid] [time] [reason] :���� �����");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(inMute[id] == 1) return SendClientMessage(playerid, White, "���� �� ��� �����");
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Mute(M) [playerid] [time] [reason] :���� �����");
		any = strval(tmp1);
		if(any < 1 || any > 10)  return SendClientMessage(playerid, White, "���� ����� ����� ��� �1 �� 10");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Mute(M) [playerid] [time] [reason] :���� �����");
		format(string, sizeof(string),"�%d ���� %s ����� �� ��� ������ %s �����", any, GetName(playerid), GetName(id));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Say(S) [Text] :���� ������");
		format(string, sizeof(string),"*Admin(%s):%s", GetName(playerid),(result));
		SendClientMessageToAll(Gold, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/KickAll", true) == 0 || strcmp(cmd, "/KAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 6 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 6 && GetTempAdminLevel(playerid) < 6) return SendClientMessage(playerid, White, "��� ������ ��� �����");
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
	        if(!strlen(result)) return SendClientMessage(playerid, White, "/KickAll(KAll) [reson] :���� ������");
			format(string, sizeof(string),"���� ��� ��� ������� ���� %s ������", GetName(playerid));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetHp(Shp) [ID] [Hp] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetHp(Shp) [ID] [Hp] :���� ������");
		any = strval(tmp1);
		SetPlayerHealth(id, any);
		format(string, sizeof(string),"%d���� �� �� ���� ����� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d �� ���� ����� %s ������ �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CleanChat", true) == 0 || strcmp(cmd, "/Cc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i=0; i<100; i++)
		{
			SendClientMessageToAll(White, "");
		}
		format(string, sizeof(string),"^-^-!���� �� ��'�� %s ������^-^-^-^-", GetName(playerid));
		SendClientMessageToAll(RandomColor(), string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetAllVehicle", true) == 0 || strcmp(cmd, "/Rav", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		format(string, sizeof(string),"^-^-^-^-.��� ���� �������� %s ������-^-^-^-^-", GetName(playerid));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, White, "���� ���� ����");
		format(string, sizeof(string),"������ �� ������� ������ ����� �������� ���");
		SendClientMessage(playerid, Blue, string);
		SetVehicleToRespawn(vehicleid);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Chet", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		if(chet == 0)
		{
		    format(string, sizeof(string),"��� �� ���� %s ������", GetName(playerid));
			SendClientMessageToAll(Azure, string);
			chet = 1;
		}
	 	else if(chet == 1)
		{
			format(string, sizeof(string),"��� �� ���� %s ������", GetName(playerid));
			SendClientMessageToAll(Azure, string);
			chet = 0;
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetArmuor", true) == 0 || strcmp(cmd, "/Sar", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetArmuor(Sar) [ID] [Hp] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetArmuor(Sar) [ID] [Hp] :���� ������");
		any = strval(tmp1);
		SetPlayerArmour(id, any);
		format(string, sizeof(string),"%d���� �� �� ���� ���� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d �� ���� ���� %s ������ �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetSkin", true) == 0 || strcmp(cmd, "/SS", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetSkin(SS) [ID] [idskin] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetSkin(SS) [ID] [idskin] :���� ������");
		any = strval(tmp1);
		SetPlayerSkin(id, any);
		format(string, sizeof(string),"%d ���� �� �� ����� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d ����� %s ������ �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Credit", true) == 0)
	{
		SendClientMessage(playerid, White, "������ ��� ���� �� ��� ��� �� ���");
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetAll", true) == 0 || strcmp(cmd, "/Ga", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 6 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 6 && GetTempAdminLevel(playerid) < 6) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    format(string, sizeof(string),"���� �� �� ������� ���� %s ������", GetName(playerid));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Goto(Gt) [playerid] :���� ������");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
	  	id = strval(tmp);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(IsYou(id, playerid)) return SendClientMessage(playerid, White, "���� ���� ���� ����� �� �� ����");
		GetPlayerPos(id, X, Y, Z);
		pinterior = GetPlayerInterior(id);
		if(IsPlayerInAnyVehicle(playerid))
	  	{
	   		SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z+2);
			LinkVehicleToInterior(GetPlayerVehicleID(playerid), pinterior);
	 		format(string, sizeof(string), "����� ����� �� ���� %s ������", GetName(playerid));
			SendClientMessage(id, Azure ,string);
	 		format(string, sizeof(string), "�� ���� %s ������ �� �����", GetName(id));
			SendClientMessage(playerid, Azure ,string);
	  	}
	  	else
	  	{
	   		SetPlayerPos(playerid, X, Y, Z+2);
	   		SetPlayerInterior(playerid, pinterior);
	 		format(string, sizeof(string), "����� ����� %s ������", GetName(playerid));
			SendClientMessage(id, Azure ,string);
	 		format(string, sizeof(string), "%s ������ �� �����", GetName(id));
			SendClientMessage(playerid, Azure ,string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Get", true) == 0 || strcmp(cmd, "/G", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Get(G) [playerid] :���� ������");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
	  	id = strval(tmp);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(IsYou(id, playerid)) return SendClientMessage(playerid, White, "���� ���� ���� ����� �� �� ����");
		GetPlayerPos(playerid, X, Y, Z);
		pinterior = GetPlayerInterior(playerid);
		SetPlayerPos(id, X, Y, Z+2);
		SetPlayerInterior(id, pinterior);
		format(string, sizeof(string), "���� ���� ���� %s ������", GetName(playerid));
	 	SendClientMessage(id, Azure ,string);
		format(string, sizeof(string), "���� %s ������ �� �����", GetName(id));
	 	SendClientMessage(playerid, Azure ,string);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/adminhelp", true) == 0 || strcmp(cmd, "/Ah", true) == 0)
	{
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/AdminHelp(Ah) 1-13 :���� ������");
	    if(strcmp(tmp, "1", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 1)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#1 - /AdminRegister(Ar) - ��� ����� (0) - ����� ������ ������");
	        SendClientMessage(playerid, White, "#3 - /AdminLogin(Al) - ��� ����� (0) - ������� ������ ������");
	        SendClientMessage(playerid, White, "#4 - /SetAdmin(Sa) - ��� ����� (7) - ����� �������");
	        SendClientMessage(playerid, White, "#5 - /Jail(J) - ��� ����� (5) - ����� ���");
	        SendClientMessage(playerid, White, "#6 - /UnJail(UnJ) - ��� ����� (5) - ������ ���");
	        SendClientMessage(playerid, White, "#7 - /Mute(M) - ��� ����� (5) - ����� ����");
	        SendClientMessage(playerid, White, "#8 - /UnMute(UnM) - ��� ����� (5) - ������ ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 1)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "2", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 2)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#9 - /Kill - ��� ����� (4) - ����� �����");
	        SendClientMessage(playerid, White, "#10 - // - ��� ����� (2) - ��'� �������");
	        SendClientMessage(playerid, White, "#11 - /Ban(B) - ��� ����� (5) - ��� �����");
	        SendClientMessage(playerid, White, "#12 - /Kick(K) - ��� ����� (3) - ����� ���");
	        SendClientMessage(playerid, White, "#13 - /Say(S) - ��� ����� (3) - ���� ����� �����");
	        SendClientMessage(playerid, White, "#14 - /KickAll(KAll) - ��� ����� (6) - ��� ��� ��� ������� ����");
	        SendClientMessage(playerid, White, "#15 - /SetHp(Shp) - ��� ����� (2) - ����� ���� ����� �� ���� ������");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 2)-=-=-=-=-=-=-=");
		}
     	if(strcmp(tmp, "3", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 3)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#16 - /CleanChat(Cc) - ��� ����� (5) - ����� ���");
	        SendClientMessage(playerid, White, "#17 - /ResetAllVehicle(Rav) - ��� ����� (5) - ����� �� �������� ����");
	        SendClientMessage(playerid, White, "#18 - /SetArmuor(Sar) - ��� ����� (2) - ����� ���� ���� �� ���� ������");
	        SendClientMessage(playerid, White, "#19 - /SetSkin(Ss) - ��� ����� (3) - ����� ���� ����� ������");
	        SendClientMessage(playerid, White, "#20 - /GetAll(Ga) - ��� ����� (6) - ����� �� ������� ����");
	        SendClientMessage(playerid, White, "#21 - /Goto(Gt) - ��� ����� (3) - ������ �����");
	        SendClientMessage(playerid, White, "#22 - /Get(G) - ��� ����� (3) - ���� ���� ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 3)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "4", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 4)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#23 - /GetHp(Ghp) - ��� ����� (5) - ����� ���� ����� �� ����");
	        SendClientMessage(playerid, White, "#24 - /GetArmour(Gar) - ��� ����� (5) - ����� ���� ���� �� ����");
	        SendClientMessage(playerid, White, "#25 - /SetArmuor(Sar) - ��� ����� (2) - ����� ���� ���� �� ���� ������");
	        SendClientMessage(playerid, White, "#26 - /Spector(Spec) - ��� ����� (5) - ����� �� ���� ������");
	        SendClientMessage(playerid, White, "#27 - /UnSpector(UnSpec) - ��� ����� (5) - ���� ���� ����");
	        SendClientMessage(playerid, White, "#28 - /Ann - ��� ����� (5) - ����� ���� �� ����");
	        SendClientMessage(playerid, White, "#29 - /CountDown(Cd) - ��� ����� (3) - ������ �����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 4)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "5", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 5)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#30 - /CancelCountDown(Ccd) - ��� ����� (3) - ����� �����");
	        SendClientMessage(playerid, White, "#31 - /Explode(Exp) - ��� ����� (5) - ����� ���� ������");
	        SendClientMessage(playerid, White, "#32 - /Spawn(Spa) - ��� ����� (5) - ���� ���� ������ ������");
	        SendClientMessage(playerid, White, "#33 - /GetVehicle(Gv) - ��� ����� (3) - ���� ���� �� ������ ����");
	        SendClientMessage(playerid, White, "#34 - /SetVehicleHp(Svh) - ��� ����� (5) - ����� ���� ���� �� ������");
	        SendClientMessage(playerid, White, "#35 - /GetVehicleHp(Gvh) - ��� ����� (5) - ����� ���� ���� �� ������");
	        SendClientMessage(playerid, White, "#36 - /Disarm(D) - ��� ����� (3) - ����� ����� ����� ������");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 5)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "6", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 6)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#37 - /GiveMoney(Gm) - ��� ����� (6) - ���� ��� ����� ������");
	        SendClientMessage(playerid, White, "#38 - /FixVehicle(Fv) - ��� ����� (4) - ����� ���");
	        SendClientMessage(playerid, White, "#39 - /Radius(Rad) - ��� ����� (3) - ����� ������ �� �����");
	        SendClientMessage(playerid, White, "#40 - /Inv - ��� ����� (3) - ����� ���� ����� �����");
	        SendClientMessage(playerid, White, "#41 - /Vis - ��� ����� (3) - ����� ���� ������");
	        SendClientMessage(playerid, White, "#42 - /Freeze(F) - ��� ����� (3) - ����� ����");
	        SendClientMessage(playerid, White, "#43 - /UnFreeze(UnF) - ��� ����� (3) - ����� ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 6)-=-=-=-=-=-=-=");
	    }
	    if(strcmp(tmp, "7", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 7)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#44 - /GiveWeapon(Gw) - ��� ����� (3) - ����� ��� �����");
	        SendClientMessage(playerid, White, "#45 - /Warning(Warn) - ��� ����� (5) - ��� ����� �����");
	        SendClientMessage(playerid, White, "#46 - /Report(Rep) - ��� ����� (0) - ����� �� ����");
	        SendClientMessage(playerid, White, "#47 - /FixAllCar(Fac) - ��� ����� (3) - ����� �� �������� ����");
	        SendClientMessage(playerid, White, "#48 - /BlockCmd(Bc) - ��� ����� (4) - ����� ������ �����");
	        SendClientMessage(playerid, White, "#49 - /SetInt(Sint) - ��� ����� (5) - ����� �������� �����");
	        SendClientMessage(playerid, White, "#50 - /SetVw(Svw) - ��� ����� (5) - ����� ����� ��������� �� �����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 7)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "8", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 8)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#51 - /ResetVehicle(Rv) - ��� ����� (5) - ����� ������ �������� ���");
	        SendClientMessage(playerid, White, "#52 - /GetCar(Gc) - ��� ����� (5) - ����� ���");
	        SendClientMessage(playerid, White, "#53 - /SetTime(St) - ��� ����� (5) - ����� ��� �����");
	        SendClientMessage(playerid, White, "#54 - /GetInt(Gint) - ��� ����� (5) - ����� ��������");
	        SendClientMessage(playerid, White, "#55 - /GetVw(Gvw) - ��� ����� (5) - ����� ���� ��������");
	        SendClientMessage(playerid, White, "#56 - /JumpPlayer(Jp) - ��� ����� (5) - ����� �����");
	        SendClientMessage(playerid, White, "#56 - /JumpVehicle(Jv) - ��� ����� (5) - ����� ���� �� ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 8)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "9", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 9)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#57 - /SetMoney(Sm) - ��� ����� (5) - ����� ���� �� ����");
	        SendClientMessage(playerid, White, "#58 - /Admins(Ad) - ��� ����� (0) - ����� ������� �������");
	        SendClientMessage(playerid, White, "#59 - /ToPlayerToPlayer(TpTp) - ��� ����� (5) - ����� ���� �� ����");
	        SendClientMessage(playerid, White, "#60 - /Jet - ��� ����� (3) - ����� ����� �'��");
	        SendClientMessage(playerid, White, "#61 - /Playerjet(Pjet) - ��� ����� (3) - ����� ����� �'��");
	        SendClientMessage(playerid, White, "#62 - /AdminsSpay(ASpay) - ��� ����� (5) - ����� ����� �������� ������");
	        SendClientMessage(playerid, White, "#63 - /AdminSpay(As) - ��� ����� (2) - ����� ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 9)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "10", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 10)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#64 - /ChangeColorPlayer(Ccp) - ��� ����� (3) - ����� ��� �����");
	        SendClientMessage(playerid, White, "#65 - /SetPos(Spos) - X Y Z ��� ����� (3) - ����� ���� ������ ������ ���");
	        SendClientMessage(playerid, White, "#66 - /ResetGun(Rg) - ��� ����� (3) - ����� ��� ������");
	        SendClientMessage(playerid, White, "#67 - /CarColor(CarC) - ��� ����� (3) - ����� ��� �����");
	        SendClientMessage(playerid, White, "#68 - /JailInfo(Ji) - ��� ����� (3) - ������ ���� �� ��� �� ����");
	        SendClientMessage(playerid, White, "#69 - /MuteInfo(Mi) - ��� ����� (3) - ������ ���� �� ���� �� ����");
	        SendClientMessage(playerid, White, "#70 - /Chet - ��� ����� (5) - ����� ������ ������ ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 10)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "11", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 11)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#71 - /ChangeColorPlayer(Ccp) - ��� ����� (3) - ����� ����� ��� �������");
	        SendClientMessage(playerid, White, "#72 - /SetTempAdmin(Sta) - ��� ����� (7) - ����� ����� ����� ����");
	        SendClientMessage(playerid, White, "#73 - /Eject(Eje) - ��� ����� (5) - ������ ���� �����");
	        SendClientMessage(playerid, White, "#74 - /EjectAll(EjeAll) - ��� ����� (7) - ������ ���� �����");
	        SendClientMessage(playerid, White, "#75 - /GiveAllMoney(Gam) - ��� ����� (7) - ����� ��� ���� ���");
	        SendClientMessage(playerid, White, "#76 - /FreezeAll(Fall) - ��� ����� (7) - ������ �� �� ����");
	        SendClientMessage(playerid, White, "#77 - /UnFreezeAll(UnFall) - ��� ����� (7) - ������ �� �� ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 11)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "12", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 13)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#78 - /RandomColorAll(RcAll) - ��� ����� (7) - ��� ������� ��� ����");
	        SendClientMessage(playerid, White, "#79 - /SetHpAll(ShpAll) - ��� ����� (7) - ����� ���� ����� ��� ����");
	        SendClientMessage(playerid, White, "#80 - /SetArmourAll(SarAll) - ��� ����� (7) - ����� ���� ���� ��� ����");
	        SendClientMessage(playerid, White, "#81 - /ExplodeAll(ExpAll) - ��� ����� (7) - ����� �� ������� ����");
	        SendClientMessage(playerid, White, "#82 - /SetSkinAll(SSAll) - ��� ����� (7) - ����� ����� ��� ������� ����");
            SendClientMessage(playerid, White, "#83 - /DisarmAll(DAll) - ��� ����� (7) - ����� ����� ��� ������� ����");
            SendClientMessage(playerid, White, "#84 - /SpawnAll(SpaAll) - ��� ����� (7) - ����� ��� ������� ����");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 12)-=-=-=-=-=-=-=");
		}
		if(strcmp(tmp, "13", true) == 0)
	    {
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 13)-=-=-=-=-=-=-=");
	        SendClientMessage(playerid, White, "#85 - /ResetGunAll(RgAll) - ��� ����� (7) - ����� ��� ������ ��� ������� ����");
	        SendClientMessage(playerid, White, "#86 - /CarColorAll(CarCAll) - ��� ����� (7) - ����� ��� ��� �������� ����");
	        SendClientMessage(playerid, White, "#87 - /SetPosAll(SetPAll) - X Y Z ��� ����� (7) - ����� �� ������� ���� ������ ���");
	        SendClientMessage(playerid, White, "#88 - /JetAll - ��� ����� (7) - ����� ��� ���� �'��");
	        SendClientMessage(playerid, White, "#89 - /FakeText - ��� ����� (7) - ����� ��� ���� ������");
	        SendClientMessage(playerid, White, "#90 - /FakeCmd - ��� ����� (7) - ����� ����� ��� ���� ���");
	        SendClientMessage(playerid, Brightred, "=-=-=-=-=-=-=-([������ ����� ���[���� - 13)-=-=-=-=-=-=-=");
		}
		return 1;
	}
/*

*/
//==============================================================================
	if(strcmp(cmd, "/FakeCmd", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :���� �����");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :���� �����");
		OnPlayerCommandText(id, (result));
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/FakeText", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :���� �����");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/FakeText [id] [text] :���� �����");
		OnPlayerText(id, (result));
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JetAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
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
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UnBan [FulName] :���� ������");
		if(!dini_Exists(file)) return SendClientMessage(playerid, White, "�� ���� �� ����� ���");
		if(dini_Int(file, "HaveBan") == 0) return SendClientMessage(playerid, White, "����� �� ��� ���");
		dini_IntSet(file, "HaveBan", 0);
		format(string, sizeof(string),"�� ���� %s ������ �����",tmp);
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetPosAll", true) == 0 || strcmp(cmd, "/SetPAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    X = strval(tmp1);
	    tmp2 = strtok(cmdtext, idx);
	    if(!strlen(tmp2)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    Y = strval(tmp2);
	    tmp3 = strtok(cmdtext, idx);
	    if(!strlen(tmp3)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    Z = strval(tmp3);
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerPos(i, X,Y,Z);
			format(string, sizeof(string),"%d,%d,%d ���� �� �� ������� � %s ������",X, Y, Z,GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CarColorAll", true) == 0 || strcmp(cmd, "/CarCAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/CarColorAll(CarCAll) [colors] [color1] :���� ������");
		color = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/CarColorAll(CarCAll) [colors] [color1] :���� ������");
		color1 = strval(tmp1);
		for(new i=0; i<MAX_VEHICLES; i++)
		{
			ChangeVehicleColor(GetPlayerVehicleID(i), color, color1);
		}
		format(string, sizeof(string),"���� ��� �������� ���� �� ���� %s ������",GetName(playerid));
		SendClientMessageToAll(Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetGunAll", true) == 0 || strcmp(cmd, "/RgAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
		    tmp = strtok(cmdtext, idx);
		    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ResetGun(Rg) [id] [weaponid] :���� ������");
		    weaponid = strval(tmp);
		    SetPlayerAmmo(i,weaponid,0);
		    format(string, sizeof(string),"%s ���� ��� ������� ���� �� ���� %s ������",WeaponName(weaponid) , GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SpawnAll", true) == 0 || strcmp(cmd, "/SpaAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i; i<MAX_PLAYERS; i++)
		{
			SpawnPlayer(i);
			format(string, sizeof(string),"���� �� �� ������� ���� ������ ����� ���� %s ������", GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/DisarmAll", true) == 0 || strcmp(cmd, "/DAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
			ResetPlayerWeapons(i);
			format(string, sizeof(string),"���� ��� ������� ���� �� ������ %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetSkinAll", true) == 0 || strcmp(cmd, "/SSAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i; i<MAX_PLAYERS; i++)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetSkin(SS) [ID] [idskin] :���� ������");
			any = strval(tmp);
			SetPlayerSkin(i, any);
			format(string, sizeof(string),"%d ���� ��� ������� ���� ����� ���� %s ������", any, GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ExpAll", true) == 0 || strcmp(cmd, "/ExplodeAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i; i<MAX_PLAYERS; i++)
		{
		  	GetPlayerPos(i, X, Y, Z);
		  	CreateExplosion(X, Y, Z, 6, 10);
		  	format(string, sizeof(string),"���� �� �� ������� ���� %s ������", GetName(playerid));
			SendClientMessage(i, Azure, string);
	  	}
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetArmourAll", true) == 0 || strcmp(cmd, "/SarAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetArmourAll(SarAll) [Health] :���� ������");
		any = strval(tmp);
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerArmour(i, any);
			format(string, sizeof(string),"%d ���� �� �� ���� �� �� ���� � %s ������", any, GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetHpAll", true) == 0 || strcmp(cmd, "/ShpAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetHpAll(ShpAll) [Health] :���� ������");
		any = strval(tmp);
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerHealth(i, any);
			format(string, sizeof(string),"%d ���� �� �� ����� �� �� ���� � %s ������", any, GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/RandomColorAll", true) == 0 || strcmp(cmd, "/RcAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i; i<MAX_PLAYERS; i++)
		{
			SetPlayerColor(i, RandomColor());
			format(string, sizeof(string),"��� ��� ���� ��� ������� %s ������",GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/UnFreezeAll", true) == 0 || strcmp(cmd, "/UnFall", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        TogglePlayerControllable(i, 1);
	        format(string, sizeof(string),"����� �� �� ���� %s ������",GetName(playerid));
			SendClientMessage(i, Azure, string);
	    }
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/FreezeAll", true) == 0 || strcmp(cmd, "/Fall", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        TogglePlayerControllable(i, 0);
	        format(string, sizeof(string),"����� �� �� ���� %s ������",GetName(playerid));
			SendClientMessage(i, Azure, string);
	    }
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GiveAllMoney", true) == 0 || strcmp(cmd, "/Gam", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp  = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GiveAllMoney(Gam) [Money] :���� ������");
	    any = strval(tmp);
	    for(new i; i<MAX_PLAYERS; i++)
	    {
	        GivePlayerMoney(i, any);
        	format(string, sizeof(string),"%d ���� ��� ���� �� ����� %s ������",any , GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Eject", true) == 0 || strcmp(cmd, "/Eje", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    if(!IsPlayerInAnyVehicle(id)) return SendClientMessage(playerid, White, "���� �� �� ���� ����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid,White, "/Eject(Eje) [id] :���� ������");
	    id = strval(tmp);
	    RemovePlayerFromVehicle(id);
        format(string, sizeof(string),"����� ���� ����� %s ������",WeaponName(weaponid) , GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"����� %s ������ �� �����",WeaponName(weaponid) , GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/EjectAll", true) == 0 || strcmp(cmd, "/EjeAll", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 7 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 7 && GetTempAdminLevel(playerid) < 7) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i; i<MAX_PLAYERS; i++)
		{
		    RemovePlayerFromVehicle(i);
	        format(string, sizeof(string),"����� �� �� ������� ����� %s ������",WeaponName(weaponid) , GetName(playerid));
			SendClientMessage(i, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/RandomColor", true) == 0 || strcmp(cmd, "/Rc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/RandomColor(Rc) [id] :���� ������");
		id = strval(tmp);
		SetPlayerColor(id, RandomColor());
		format(string, sizeof(string),"��� �� ��� ������� %s ������",WeaponName(weaponid) , GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"��� ������� %s ����� �����",WeaponName(weaponid) , GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/AdminSpay", true) == 0 || strcmp(cmd, "/As", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 2 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 2 && GetTempAdminLevel(playerid) < 2) return SendClientMessage(playerid, White, "��� ������ ��� �����");
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
			SendClientMessage(playerid, Azure, "������ ���� ����");
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
			SendClientMessage(playerid, Azure, "����� ���� ����");
			inadminspay[playerid] = 0;
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JailInfo", true) == 0 || strcmp(cmd, "/Ji", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/JailInfo(Ji) [id] :���� ������");
		id = strval(tmp);
		format(string, sizeof(string),"%s :���� ���� �� �����",GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s :���� ����",dini_Get(File(id), "ResonJail"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s:������ ����� �� ����",dini_Get(File(id), "AdminJail"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d:��� ������ ����",dini_Get(JailFile(id), "JailTime"));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/MuteInfo", true) == 0 || strcmp(cmd, "/Mi", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/MuteInfo(Mi) [id] :���� ������");
		id = strval(tmp);
		format(string, sizeof(string),"%s :���� ���� �� �����",GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s :���� ����",dini_Get(File(id), "ResonMute"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s:������ ����� �� ����",dini_Get(File(id), "AdminMute"));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d:��� ������ �����",dini_Get(MuteFile(id), "MuteTime"));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/CarColor", true) == 0 || strcmp(cmd, "/Carc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/CarColor(CarC) [colors] [color1] :���� ������");
		color = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/CarColor(CarC) [playerid] [colors] [color1] :���� ������");
		color1 = strval(tmp1);
		ChangeVehicleColor(vehicleid, color, color1);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ResetGun", true) == 0 || strcmp(cmd, "/Rg", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ResetGun(Rg) [id] [weaponid] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/ResetGun(Rg) [id] [weaponid] :���� ������");
	    weaponid = strval(tmp1);
	    SetPlayerAmmo(id,weaponid,0);
	    format(string, sizeof(string),"%s ���� �� �� ���� %s ������",WeaponName(weaponid) , GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s �� ���� %s ������ �����",WeaponName(weaponid) , GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetPos", true) == 0 || strcmp(cmd, "/SetP", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    X = strval(tmp1);
	    tmp2 = strtok(cmdtext, idx);
	    if(!strlen(tmp2)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    Y = strval(tmp2);
	    tmp3 = strtok(cmdtext, idx);
	    if(!strlen(tmp3)) return SendClientMessage(playerid, White, "/SetPos(SetP) [id] [x] [y] [z] :���� ������");
	    Z = strval(tmp3);
		SetPlayerPos(id, X,Y,Z);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Ccp", true) == 0 || strcmp(cmd, "/ChangePlayerColor", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :���� ������");
	    if(strcmp(tmp, "Yellow", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :���� ������");
	        id = strval(tmp1);
	        SetPlayerColor(id, Yellow);
	        format(string, sizeof(string),"���� �� �� ���� ����� %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ���� ����� %s ������ �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Red", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :���� ������");
	        id = strval(tmp1);
	        SetPlayerColor(id, Red);
	        format(string, sizeof(string),"���� �� �� ���� ����� %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ���� ����� %s ������ �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Green", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :���� ������");
	        id = strval(tmp1);
	        SetPlayerColor(id, Green);
	        format(string, sizeof(string),"���� �� �� ���� ����� %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ���� ����� %s ������ �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Yellow", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :���� ������");
	        id = strval(tmp1);
	        SetPlayerColor(id, Blue);
	        format(string, sizeof(string),"���� �� �� ���� ����� %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ���� ����� %s ������ �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		if(strcmp(tmp, "Pink", true) == 0)
	    {
	        tmp1 = strtok(cmdtext, idx);
	        if(!strlen(tmp)) return SendClientMessage(playerid, White, "/ChangePlayerColor(Ccp) [Yellow | Red | Green | Blue | Pink] [id] :���� ������");
	        id = strval(tmp1);
	        SetPlayerColor(id, Pink);
	        format(string, sizeof(string),"���� �� �� ���� ������ %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ���� ������ %s ������ �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Jet", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    SetPlayerSpecialAction(playerid, 2);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/pJet", true) == 0 || strcmp(cmd, "/PlayerJet", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/PlayerJet(pJet) [id] :���� ������");
	    id = strval(tmp);
	    SetPlayerSpecialAction(id, 2);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Marker", true) == 0 || strcmp(cmd, "/Mar", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Marker(Mar) [id] :���� ������");
		id = strval(tmp);
		SetPlayerColor(id, 0x33ff33ff);
		format(string, sizeof(string),"��� ���� ����� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"����� %s ����� �� �����", GetName(id));
		SendClientMessage(id1, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/ToPlayerToPlayer", true) == 0 || strcmp(cmd, "/TpTp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White,  "/ToPlayerToPlayer(TpTp) [id] [id] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White,  "/ToPlayerToPlayer(TpTp) [id] [id] :���� ������");
	    id = strval(tmp1);
	    GetPlayerPos(id, X, Y, Z);
		SetPlayerPos(id1, X, Y, Z);
		format(string, sizeof(string),"���� %s ���� �� ����� %s ������", GetName(id1), GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s ���� ���� �� ����� %s ������", GetName(id), GetName(playerid));
		SendClientMessage(id1, Azure, string);
		format(string, sizeof(string),"%s �� ����� %s ������ �� �����", GetName(id), GetName(id1));
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
				    SendClientMessage(playerid, Grellow, ":������ �������");
					format(string, sizeof(string),"%d:��� | %s:��",GetAdminLevel(i), GetName(i));
					SendClientMessage(playerid, White, string);
				}
				if(GetTempAdminLevel(i) >= 1)
				{
				    SendClientMessage(playerid, Grellow, ":������ ������ �������");
					format(string, sizeof(string),"%d:��� | %s:��",GetAdminLevel(i), GetName(i));
					SendClientMessage(playerid, White, string);
				}
			}
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/AdminsSpay", true) == 0 || strcmp(cmd, "/ASpay", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		SendClientMessage(playerid, Grellow, ":������ ������");
		for(new i=0; i<MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
					if(GetAdminSpay(i) >= 2)
					{
						format(string, sizeof(string),"%d:��� | %s:��",GetAdminSpay(i), GetName(i));
						SendClientMessage(playerid, White, string);
				}
			}
		}
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JumpPlayer", true) == 0 || strcmp(cmd, "/Jp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/JumpPlayer(Jp) [id] [number] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/JumpPlayer(Jp) [id] [number] :���� ������");
	    any = strval(tmp1);
	    SetPlayerVelocity(GetPlayerVehicleID(id), 3.0, 0.0, any);
		format(string, sizeof(string),"%d ������ �� %s ������ �� �����", any, GetName(id));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d ����� ���� ������ �� %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetMoney", true) == 0 || strcmp(cmd, "/Sm", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetMoney(Sm) [id] [Money] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetMoney(Sm) [id] [Money] :���� ������");
		any = strval(tmp1);
		ResetPlayerMoney(id);
		GivePlayerMoney(id, any);
        format(string, sizeof(string),"%d � %s ����� �� ����� ���� �� �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d ��� �� �� ���� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/JumpVehicle", true) == 0 || strcmp(cmd, "/Jv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/JumpVehicle(Jv) [id] [number] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/JumpVehicle(Jv) [id] [number] :���� ������");
	    any = strval(tmp1);
	    SetVehicleVelocity(GetPlayerVehicleID(id), 3.0, 0.0, any);
		format(string, sizeof(string),"%d ������ �� %s ������ �� �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d ����� ���� ������ �� %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetInt", true) == 0 || strcmp(cmd, "/Sint", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetInt(Sint) [id] [number] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetInt(Sint) [id] [number] :���� ������");
		any = strval(tmp1);
	    SetPlayerInterior(id, any);
	    format(string, sizeof(string),"%d �� ��������� %s ������ �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d���� �� �� ��������� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetVW", true) == 0 || strcmp(cmd, "/Svw", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetVw(Svw) [id] [number] :���� ������");
	    id = strval(tmp);
	    tmp1 = strtok(cmdtext, idx);
	    if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetVw(Svw) [id] [number] :���� ������");
		any = strval(tmp1);
	    SetPlayerVirtualWorld(id, any);
	    format(string, sizeof(string),"%d � %s ������ �� ����� ��������� �� �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d ���� �� �� ����� ��������� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetInt", true) == 0 || strcmp(cmd, "/Gint", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetInt(Gint) [id]:���� ������");
	    id = strval(tmp);
	    format(string, sizeof(string),"%d � %s ������ �� ��������� �� �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%d ���� �� ��� ��������� � %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetVW", true) == 0 || strcmp(cmd, "/Gvw", true) == 0)
	{
        if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetVw(Gvw) [id] :���� ������");
	    id = strval(tmp);
	    format(string, sizeof(string),"%d ����� ��������� �� ����� ���", GetPlayerVirtualWorld(id));
		SendClientMessage(playerid, Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetHp", true) == 0 || strcmp(cmd, "/Ghp", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetHp(Ghp) [id] :���� ������");
		id = strval(tmp);
		GetPlayerHealth(id, Health);
		format(string, sizeof(string),"%1.f ��� %s ���� ����� �� �����", Health, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Spector", true) == 0 || strcmp(cmd, "/Spec", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	  	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Spector(Spec) [playerid] :���� �����");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
		id = strval(tmp);
		if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(IsYou(id, playerid)) return SendClientMessage(playerid, White, "���� ���� ���� ����� �� �� ����");
		format(string, sizeof(string), "%s ��� ���� �����", GetName(id));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		if(!inSpec[playerid]) return SendClientMessage(playerid, White, "��� �� ���� �����");
		SendClientMessage(playerid, Azure , "���� ���� ����� �����");
		SetPlayerVirtualWorld(playerid, 0);
		TogglePlayerSpectating(playerid, 0);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Ann", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Ann [text] :���� ������");
	    format(string, 256, "%s", (result));
	  	GameTextForAll(string, 3000, 6);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Unjail", true) == 0 || strcmp(cmd, "/Unj", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	  	tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UNJail(Unj) [playerid] :���� �����");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(!inJail[id]) return SendClientMessage(playerid, White, "���� �� �� ����");
		format(string, sizeof(string),"����� ���� ����� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"����� %s ������ �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s ����� ����� �� ��� ������ %s �����", GetName(playerid), GetName(id));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
		if(GetAdminLevel(playerid) < 5 && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UNMute(Unm) [playerid] :���� �����");
		if(!IsNumeric(tmp)) return SendClientMessage(playerid, White, "������ ����� ����");
		id = strval(tmp);
	  	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, White, "���� �� �� �����");
		if(!inMute[id]) return SendClientMessage(playerid, White, "���� �� �� �����");
		format(string, sizeof(string),"����� ���� ������� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"������� %s ������ �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"%s ����� ������� �� ��� ������ %s �����", GetName(playerid), GetName(id));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetArmour(Gar) [id] :���� ������");
		id = strval(tmp);
		GetPlayerArmour(id, Health);
		format(string, sizeof(string),"%1.f ��� %s ���� ���� �� �����", Health, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/cd", true) == 0 || strcmp(cmd, "/CountDown", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    if(CountdownON == 1) return SendClientMessage(playerid, White, "�� ����� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/CountDown(Cd) [0\1] [Seconds]:���� ������");
	    if(strcmp(cmd, "0", true) == 0)
	    {
		    tmp1 = strtok(cmdtext, idx);
			if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Countdown(Cd) 0 [Seconds] :���� �����");
			any = strval(tmp1);
			if(any < 1 || any > 1000)  return SendClientMessage(playerid, White, "������ ����� ����� ��� 1 �1000 �����");
			format(string, sizeof(string), "������ ����� ��� ����� ����� %s ������", any, GetName(playerid));
			SendClientMessageToAll(Azure ,string);
			CountDown(any);
			CountdownON = 1;
	    }
	    if(strcmp(cmd, "1", true) == 0)
	    {
		    tmp1 = strtok(cmdtext, idx);
			if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Countdown(Cd) 1 [Seconds] :���� �����");
			any = strval(tmp1);
			if(any < 1 || any > 1000)  return SendClientMessage(playerid, White, "������ ����� ����� ��� 1 �1000 �����");
			format(string, sizeof(string), "������ ����� �� ����� ����� %s ������", any, GetName(playerid));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		if(CountdownON == 0) return SendClientMessage(playerid, White, "��� ����� �����");
		format(string, sizeof(string), "���� �� ������ %s ������", GetName(playerid));
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
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Explode(Exp) [id] :���� ������");
		id = strval(tmp);
		format(string, sizeof(string), "%s ����� �� �����", GetName(id));
	 	SendClientMessage(playerid, Azure ,string);
	  	GetPlayerPos(id, X, Y, Z);
	  	CreateExplosion(X, Y, Z, 6, 10);
	  	return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Spawn", true) == 0 || strcmp(cmd, "/Spa", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Spawn(Spa) [id] :���� ������");
		id = strval(tmp);
		SpawnPlayer(id);
		format(string, sizeof(string),"���� ���� ������ ������ %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"������ ������ %s ������ �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetVehicle", true) == 0 || strcmp(cmd, "/Gv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetVehicle(Gv) [id] :���� ������");
		id = strval(tmp);
		GetPlayerPos(playerid, X, Y, Z);
		SetVehiclePos(GetPlayerVehicleID(id), X, Y, Z+2);
		format(string, sizeof(string),"�� ���� %s ������ �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		format(string, sizeof(string),"���� ���� �� ���� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Getcar", true) == 0 || strcmp(cmd, "/Gc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Getcar(GC) [400-611] :���� ������");
		v = strval(tmp);
		if(v < 400 || v > 611) return SendClientMessage(playerid, White, "������ �� ���� ����� ����");
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, A);
		vid = CreateVehicle(v, X, Y, Z, A, -1, -1, 50000);
		PutPlayerInVehicle(playerid, vid, 0);
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(playerid));
 		format(string, sizeof(string), "����� %s ����� �� ����", VehicleNames[GetVehicleModel(vid)-400]);
    	SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetVehicleHp", true) == 0 || strcmp(cmd, "/Svh", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetVehicleHp(Svh) [id] [hp] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/SetVehicleHp(Svh) [id] [hp] :���� ������");
		any = strval(tmp1);
		SetVehicleHealth(GetPlayerVehicleID(id), any);
		format(string, sizeof(string),"%d � %s ������ �� ���� ��� ���� �� �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GetVehicleHp", true) == 0 || strcmp(cmd, "/Gvh", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GetVehicleHp(Gvh) [id] :���� ������");
		id = strval(tmp);
		GetVehicleHealth(GetPlayerVehicleID(id), Health);
		format(string, sizeof(string),"%1.f ��� %s ���� ��� ���� �� �����", Health, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Disarm", true) == 0 || strcmp(cmd, "/D", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Disarm(D) [id] :���� ������");
		id = strval(tmp);
		ResetPlayerWeapons(id);
		format(string, sizeof(string),"���� �� ������ ��� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s ������ �� ������ �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GiveMoney", true) == 0 || strcmp(cmd, "/Gm", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 6 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 6 && GetTempAdminLevel(playerid) < 6) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GiveMoney(Gm) [id] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/GiveMoney [id] :���� ������");
		any = strval(tmp1);
		GivePlayerMoney(id, any);
		format(string, sizeof(string),"%d ���� �� �� ����� %s ������", any, GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d �� ����� %s ����� �����", any, GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/FixVehicle", true) == 0 || strcmp(cmd, "/Fv", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 4 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 4 && GetTempAdminLevel(playerid) < 4) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/FixVehicle(Fv) [id] :���� ������");
		id = strval(tmp);
		RepairVehicle(GetPlayerVehicleID(id));
		format(string, sizeof(string),"���� �� ���� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"�� ���� %s ������ �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Radius", true) == 0 || strcmp(cmd, "/Rad", true) == 0)
 	{
    	if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
     	if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
  		tmp = strtok(cmdtext, idx);
  		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Radius(Rad) [Set | SetHp | SetArmour | GiveWeapon| Get | Spawn | Freeze | UnFreeze | Disarm | Inv | Vis | FixVehicle | SetSkin | Marker]");
     	if(strcmp(tmp, "Set", true) == 0 || strcmp(tmp, "S", true) == 0)
   		{
	       	tmp1 = strtok(cmdtext, idx);
	    	if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Rad Set [1-60] :���� ������");
	    	any = strval(tmp1);
	    	if(any < 0 || any > 60) return SendClientMessage(playerid, White, "���� ������ ��� ��� 0 � 60");
	    	format(string, sizeof(string), "%d ������ �� ������ ��� �", any);
	    	SendClientMessage(playerid, Azure, string);
	    	dini_IntSet(File(playerid), "Rad", any);
   		}
   		if(strcmp(tmp, "SetArmuor", true) == 0 || strcmp(tmp, "Sar", true) == 0)
   		{
	  		tmp1 = strtok(cmdtext, idx);
	    	if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/Rad sar [hp] :���� ������");
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
	     		format(string, sizeof(string), "%d � %d ���� �� ���� ���� ������ %s ������",any, GetRad(playerid), GetName(playerid));
	     		SendClientMessage(i, Azure, string);
	    	}
	   	}
   		if(strcmp(tmp, "GiveWeapon", true) == 0 || strcmp(tmp, "Gw", true) == 0)
   		{
	    	tmp2 = strtok(cmdtext, idx);
	    	if(!strlen(tmp2)) return SendClientMessage(playerid, White, "/GiveWeapon [Weaponid] [Ammu] :���� ������");
	    	weaponid = strval(tmp2);
	    	tmp3 = strtok(cmdtext,idx);
	    	if(!strlen(tmp3)) return SendClientMessage(playerid, White, "/GiveWeapon [Weaponid] [Ammu] :���� ������");
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
	     		format(string, sizeof(string), "%d �� ���� ������� %s �� ���� %d ���� ��� ������� ������ %s ������",ammu , WeaponName(weaponid), GetRad(playerid), GetName(playerid));
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
	     		format(string, sizeof(string), "%d ���� ���� �� �� ������� ������ %s ������",GetRad(playerid), GetName(playerid));
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
	     		format(string, sizeof(string), "������ ������ ���� %d ���� �� �� ������� ������ %s ������",GetRad(playerid), GetName(playerid));
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
	     		format(string, sizeof(string), "%d ����� �� �� ������� ������ %s ������", GetRad(playerid), GetName(playerid));
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
	     		format(string, sizeof(string), "%d ����� �� �� ������� ������ %s ������", GetRad(playerid), GetName(playerid));
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
	     		format(string, sizeof(string), "%d ���� ����� ��� ������� ������ %s ������", GetRad(playerid), GetName(playerid));
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
     			format(string, sizeof(string), "%d ���� �� �� �������� ������ %s ������", GetRad(playerid), GetName(playerid));
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
	     		format(string, sizeof(string), "%d ���� �� ����� ��� ������� ������ %s ������", GetRad(playerid), GetName(playerid));
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
		    	format(string, sizeof(string), "%d ��� �� �� ������� ����� ������ ������ %s ������", GetRad(playerid), GetName(playerid));
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
     			format(string, sizeof(string), "%d ��� �� �� ������� ������ ������ %s ������", GetRad(playerid), GetName(playerid));
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
    			format(string, sizeof(string), "%d � %d ���� �� ���� ����� ������ %s ������",any, GetRad(playerid), GetName(playerid));
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
    			format(string, sizeof(string), "������� %d ��� �� �� ������� ������ %s ������", GetRad(playerid), GetName(playerid));
    			SendClientMessage(i, Azure, string);
   			}
  		}
	  	return 1;
 	}
//==============================================================================
	if(strcmp(cmd, "/FixAllCar", true) == 0 || strcmp(cmd, "/Fac", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		for(new i=0; i<MAX_VEHICLES; i++)
		{
		    RepairVehicle(i);
		}
	    format(string, sizeof(string), "���� �� �� �������� ���� %s ������", GetName(playerid));
		SendClientMessageToAll(Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/inv", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/inv [id] :���� ������");
	    id = strval(tmp);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
			ShowPlayerNameTagForPlayer(i, id, false);
			SetPlayerColor(id, Invisible);
		}
		format(string, sizeof(string),"��� ���� ����� ����� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"����� ����� %s ����� �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/blockcmd", true) == 0 || strcmp(cmd, "/Bc", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 4 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 4 && GetTempAdminLevel(playerid) < 4) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/BlockCmd(Bc) [playerid] :���� ������");
	    id = strval(tmp);
	    if(GetBlockCmd(id) == 0)
	    {
	        dini_IntSet(File(id), "BlockCmd", 1);
			format(string, sizeof(string),"��� �� �� ������� %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ������� %s ����� �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		else if(GetBlockCmd(id) == 1)
	    {
	        dini_IntSet(File(id), "BlockCmd", 0);
			format(string, sizeof(string),"��� �� �� ������� %s ������", GetName(playerid));
			SendClientMessage(id, Azure, string);
			format(string, sizeof(string),"�� ������� %s ����� �����", GetName(id));
			SendClientMessage(playerid, Azure, string);
		}
		return 1;
	}
//==============================================================================

//==============================================================================
	if(strcmp(cmd, "/vis", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp)) return SendClientMessage(playerid, White, "/vis [id] :���� ������");
	    id = strval(tmp);
	    for(new i=0; i<MAX_PLAYERS; i++)
		{
			ShowPlayerNameTagForPlayer(i, id, true);
			SetPlayerColor(id, RandomColor());
		}
		format(string, sizeof(string),"��� ���� ����� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"����� %s ����� �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Freeze", true) == 0 || strcmp(cmd, "/F", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Freeze(F) [id] :���� ������");
		id = strval(tmp);
		TogglePlayerControllable(id, 0);
		format(string, sizeof(string),"����� ���� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s ����� �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/UnFreeze", true) == 0 || strcmp(cmd, "/UnF", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/UnFreeze(UnF) [id] :���� ������");
		id = strval(tmp);
		TogglePlayerControllable(id, 1);
		format(string, sizeof(string),"����� ���� %s ������", GetName(playerid));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%s ������ �� �����", GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/GiveWeapon", true) == 0 || strcmp(cmd, "/Gw", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 3 && GetTempAdminLevel(playerid) < 3) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/GiveWeapon(Gw) [id] [WeaponId] [Ammu] :���� ������");
		id = strval(tmp);
		tmp1 = strtok(cmdtext, idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/GiveWeapon(Gw) [id] [WeaponId] [Ammu] :���� ������");
		weaponid = strval(tmp1);
		tmp2 = strtok(cmdtext,idx);
		if(!strlen(tmp1)) return SendClientMessage(playerid, White, "/GiveWeapon(Gw) [id] [WeaponId] [Ammu] :���� ������");
		ammu = strval(tmp2);
		GivePlayerWeapon(id, weaponid, ammu);
		format(string, sizeof(string),"%d �� ���� ������� %s ���� �� �� ���� %s ������", ammu,WeaponName(weaponid), GetName(id));
		SendClientMessage(id, Azure, string);
		format(string, sizeof(string),"%d �� ���� ������� %s �� ���� %s ����� �����", ammu,WeaponName(weaponid), GetName(id));
		SendClientMessage(playerid, Azure, string);
		return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/SetTime", true) == 0 || strcmp(cmd, "/St", true) == 0)
	{
	    if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/SetTime(St) [Time] :���� ������");
		any = strval(tmp);
	    SetWorldTime(any);
	    format(string, sizeof(string),"%d ���� �� ���� ���� %s ������", any, GetName(playerid));
		SendClientMessageToAll(Azure, string);
	    return 1;
	}
//==============================================================================
	if(strcmp(cmd, "/Warning", true) == 0 || strcmp(cmd, "/Warn", true) == 0 || strcmp(cmd, "/Warn", true) == 0)
	{
		if(InAdmin[playerid] == 0) return SendClientMessage(playerid, White, "���� ����� ������ ��������");
	    if(GetAdminLevel(playerid) < 5 && !IsPlayerAdmin(playerid) && GetAdminSpay(playerid) < 5 && GetTempAdminLevel(playerid) < 5) return SendClientMessage(playerid, White, "��� ������ ��� �����");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)) return SendClientMessage(playerid, White, "/Warning(Warn) [id] [reason] :���� ������");
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
		if(!strlen(result)) return SendClientMessage(playerid, White, "/Warning(Warn) [id] [reason] :���� ������");
		if(GetWarning(id) == 0)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "�� ������� ��� ���� �� 1/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 1)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "�� ������� ��� ���� �� 2/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 2)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "�� ������� ��� ���� �� 3/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 3)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "�� ������� ��� ���� �� 4/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 4)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "�� ������� ��� ���� �� 5/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 5)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
			SendClientMessage(id, Azure, "�� ������� ��� ���� �� 6/7");
		    dini_IntSet(File(id), "Warning", dini_Int(File(id), "Warning")+1);
		}
		if(GetWarning(id) == 6)
		{
		    format(string, sizeof(string),"%s ���� ����� ��-��� ������ %s �����", GetName(playerid), GetName(id));
			SendClientMessageToAll(Azure, string);
			format(string, sizeof(string),"(%s)", (result));
			SendClientMessageToAll(Azure, string);
	  		SendClientMessage(id, Azure, "�� ������� ��� ���� �� 7/7");
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
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 2_1, DIALOG_STYLE_INPUT, "Register system", "Please type the password you want to put the user\n� You must write a password", "Enter", "Cancel");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 15) return ShowPlayerDialog(playerid, 2_1, DIALOG_STYLE_INPUT, "Register system", "Please type the password you want to put the user\n� Your password must be between 3 and 15 characters", "Enter", "Cancel");
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
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password\n� You must write a password", "Enter", "Cancel");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 15) return ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password\n� Your password must be between 3 and 15 characters", "Enter", "Cancel");
			if(!strcmp(inputtext, dini_Get(File(playerid), "Password"), true))
			{
				InAdmin[playerid] = 1;
				SendClientMessage(playerid, Bluesea, "User successfully logged on");
			}
			else
			{
 				ShowPlayerDialog(playerid, 3_1, DIALOG_STYLE_INPUT, "Login system", "Please type the user password\n� You writed a worng password", "Enter", "Cancel");
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
	SendClientMessage(playerid, White, "������ ����� ����� �������");
	format(string, sizeof(string),"** ����� ����� ����� ������� %s ����� **", GetName(playerid));
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
		SendClientMessage(playerid, White, "��� ����� ����. ��� ���� �� ����� �� ����� ����");
		return 0;
	}
    for(new word; word<sizeof(BlockedWords); word++)
	{
    	if(strfind(text, BlockedWords[word]) != -1)
		{
			new string[256];
			format(string, sizeof(string), "������� ������� ����� ���� ������ ����");
			SendClientMessage(playerid, Redwhite, string);
			dini_IntSet(MuteFile(playerid), "Mute", dini_Int(MuteFile(playerid), "Mute")+1);
			dini_IntSet(MuteFile(playerid), "inMute", 1);
			dini_Set(File(playerid), "AdminMute", "None");
			dini_Set(File(playerid), "ResonMute", "������ �����");
			inMute[playerid] = 1;
			dini_IntSet(MuteFile(playerid), "MuteTime", 2);
			MuteTimer[playerid] = SetTimerEx("AutomaticUnmute", 60*1000*2, 0, "d", playerid);
			MuteTimer1[playerid] = SetTimerEx("AutomaticMainusMuteTime", 60*1000, 0, "d", playerid);
			format(string, sizeof(string), "���� ��� ���� ���� �2 ���� %s ������ ����� ������ ����� ��� �����", GetName(playerid));
			SendClientMessageToAll(Redwhite, string);
			return 0;
		}
	}
	if(chet == 1)
 	{
		SendClientMessage(playerid, White, "���� ���� ����");
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
	SendClientMessage(playerid, Grellow, "������ ������� ����� �������");
	format(string, sizeof(string),"** ����� ������� ����� ������� %s ����� **", GetName(playerid));
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

