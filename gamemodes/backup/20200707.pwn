/*
    This server is modified from 5F free residential open source, Prace open source
    To the makers of Prace:[Ghost]Rui ushio_p [Ghost]Dylan
    Tribute to the makers of the free settlement :[ITC]dyq [ITC]fangye [ITC]Super_wlc [ITC
    Special thanks to ryddawn and technical advisor [Fire]KiVen OBJ:JoshenKM;

								The MIT License  
								
	Copyright (c) <2019-2020> <YuCarl77>  
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.  
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.  
	==================================
	��Ȩ(c) <2019-2020> <YuCarl77>   

	ʹ�ø����֤���������������Ȩ�ޣ���ѣ��κ��˿��Եõ���������������ĵ���һ��������
	���Ҿ�Ӫ����������κ����ƣ����������Ƶ�ʹ�á����ơ��޸ġ��ϲ������桢���С����Ŵ���֤�顢���߳��۸�����Ŀ�����Ȩ����
	ͬʱ��������Щ������û�������ЩȨ����ʹ����������������  
	
	���ϵİ�Ȩ֪ͨ��Ȩ��֪ͨӦ�ð��������и�����Ŀ����л������������������ʵ�����С�
	
	������������������ṩ��û���κ���ʽ�ĵ�������������ȷ�ػ��߰����ģ�������Щ���ǲ�����ҵ���ʵĵ��������ơ�
	�ʺ�һ���ض�����;���Ҳ����ַ������ߺͰ�Ȩ���������κγ��϶�ʹ�ø�����漰���κ�Ҫ���𺦻����������ζ���Ӧ����
	�����������������û���ֻ�Ǻ�ͬ��ʽ��������Ȩ����������ʽ�������������������÷�Χ�ڡ�����������ϵ���������ʹ�û����������������������Ϊ��  
	=====================================   
*/

//  �����ң����ڿ�Դ��д��лǰ�����˵����������֮���١�
//  �����޸���5F��Prace,PHouse,Goods�ȿ�Դ �ر���л��[Ghost]Rui ushio_p [Ghost]Dylan
//  �¾����ɾ�������Դ,������:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)
//  �ر���л ryddawn ������OBJָ����[Fire]KiVen JoshenKM
//  �ر���л GoodsSys������Episodes KiVen juse
//  �ر���л GTAUN GTABBS 
// RST�Ŷӷ�����������Ҫ��[R_ST]Hygen��YuCarl77���쵼
#pragma dynamic 30000 

AntiDeAMX() {
    new a[][] = {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

//2020.2.15 �޸� ԭ����float:sqrt

//#include <timerfix>
#include <a_samp>
// #include "ASAN" //����������    �ܶ�����õ�mk124��NPatcher ����ûlinux�汾
#define FIX_strcmp 0 //��ΪҪ��mk124��strcmp���Ծ͹ر����޸�samp�Դ�һЩ�����inc�����������
#define FIX_PutPlayerInVehicle 0 //��Ȼ�Ļ�������ը��
#define FIX_KEY_AIM 0
#define FIX_GogglesSync 0
#define FIX_OnPlayerSpawn 0
#include <yuki/fixes> //��Ҫ����a_samp����
//https://github.com/pawn-lang/sa-mp-fixes
//https://wiki.sa-mp.com/wiki/Fixes.inc#Expansion 
//�޸�SAMP�������Դ���һЩ����

#include <yuki/main>
#include <yuki/tele>
#include <yuki/HRace>
#include <yuki/PHouse>
#include <yuki/Goods_Sys>
#include <yuki/questionAnswer>
#include <yuki/npc>
#include <yuki/AntiCheat/Rogue-AC>//������
#include <yuki/Attire> //2020.2.29����
#include <yuki/billboard> //2020.3.1����
//#include <yuki/Cars> //2020.3.3����
#include <yuki/Team> //2020.3.14д
#include <yuki/camera> //2020-3-15����16��д�ľ�ͷ
#include <yuki/DeathMatch> // 2020.3.16����
#include <yuki/World> // 2020.3.28�ϲ� ����

// #include <crashdetect> //���Ա���


#define strlen mk_strlen
#define strcmp mk_strcmp
#define strfind mk_strfind
#define PlayerInfoDialog 1300
#define weapons 4670
#define Dialog_Register 0
#define Dialog_Login 1
//#define DIALOG_STYLE_PASSWORD 3
#define Dialog_SpawnVehicle 4
#define Ban_Choose 1000
#define Dialog_Designation 765
#define Dialog_Tail 766



// #define PRESSED(%0) \ (((newkeys & ( % 0)) == ( % 0)) && ((oldkeys & ( % 0)) != ( % 0)))

#define HOLDING(%0) \
((newkeys & ( % 0)) == ( % 0))


//��ջ���� Stack/heap size:16384 bytes; estimated max. usage:unknown, due to recursion 
// ����һֱû���Ż��� ��Ҫ�����ܼ��ٱ����ĳ��� �ر���ȫ�ֱ���   �ַ��Ͳ�Ҫ����1024
// �����������߸���15W��ջ �Ҿ��û���̫���� 30000�����ȥ12W ���
// Ĭ��ջ��16384bytes �����16KB��

// #pragma compat 1 //2020.2.15���� �±�����pawncc https://github.com/pawn-lang/compiler/ ����ģʽ

// #include <YSI\y_ini>

//�޵�ʱ�����
// new Text3D:NoDieTime[MAX_PLAYERS];
// PlayerText:LetterForYou[MAX_PLAYERS][4]
forward Float:sqrt(Float:number);
public Float:sqrt(Float:number) {
    new Float:new_guess;
    new Float:last_guess;
    if(number < 0.0) return -1.0;
    if(number == 0.0) return 0.0;
    new_guess = 1.0;
    do {
        last_guess = new_guess;
        new_guess = (last_guess + number / last_guess) / 2.0;
    } while (new_guess != last_guess);
    return new_guess;
}

new StopSecondsTimer = -1, StopGATimer = -1, StopMinuteTimer = -1, StopCheckStatus = -1; //���ʱ�� �����Զ��޳� �����жϵ� ϵͳ��ʱ��
static randSounds[7] = {
    1062,
    1068,
    1076,
    1097,
    1183,
    1185,
    1187
};





stock IsNumeric(const string[]) {
    for (int i = 0, j = strlen(string); i < j; i++)
        if(string[i] > '9' || string[i] < '0')
            return 0;
    return 1;
}

new dinfobj[MAX_PLAYERS], jd[MAX_PLAYERS], wy[MAX_PLAYERS], splp[MAX_PLAYERS];
//�Ƿ񾯵�,����OBJ,β��OBJ,�Ƿ񱣴�/s ����ɫ

enum ppctype {
    Float:ppX,
    Float:ppY,
    Float:ppZ,
    Float:ppR
};


//������new��
static PPC_SpawnPos[][ppctype] = {
    {
        -1776.967285,
        576.601135,
        234.617691,
        118.473152
    },
    {
        -1806.211547,
        524.291259,
        234.617675,
        356.940093
    },
    {
        -1835.493408,
        576.112365,
        234.615264,
        242.834381
    }
    // {
    //     -1790.714599,
    //     552.736389,
    //     234.615280,
    //     322.741027
    // },
    // {
    //     -1808.469238,
    //     579.068603,
    //     234.617675,
    //     88.461364
    // },
    // {
    //     -1773.020874,
    //     578.919433,
    //     234.617996,
    //     103.577575
    // },
    // {
    //     -1804.983642,
    //     519.567504,
    //     234.618896,
    //     355.549987
    // },
    // {
    //     -1840.326049,
    //     578.858642,
    //     234.614852,
    //     237.597930
    // },
    // {
    //     -1820.136474,
    //     545.843017,
    //     234.614517,
    //     201.193878
    // }
};

new p_PPC[MAX_PLAYERS], p_ppcCar[MAX_PLAYERS];

// static Float:RandomCameraLookAt[][6] = {
//     //��ͷ����:x,y,z ע������:x,y,z
//     {
//         2005.628173,
//         1161.630615,
//         96.700424,
//         2186.356201,
//         1112.973510,
//         26.706451
//     },
//     {
//         1471.778564,
//         -941.493041,
//         117.865547,
//         1412.722290,
//         -809.165771,
//         80.828323
//     },
//     {
//         -2298.547851,
//         2200.615478,
//         70.029342,
//         -2417.087890,
//         2310.907470,
//         1.660755
//     },
//     {
//         -2565.568847,
//         1407.917358,
//         120.223480,
//         -2663.229248,
//         1587.976440,
//         109.718269
//     },
//     {
//         726.227416,
//         -1640.945312,
//         27.079547,
//         764.914245,
//         -1655.571289,
//         4.716124
//     }
// };
// new CountDown = -1; //����ʱ
new Count[MAX_PLAYERS], Timer[MAX_PLAYERS];
// new wdzt[MAX_PLAYERS];

new RandMsg;
//ԭ����new ANNOUNCEMENTS[7][128] = {
static ANNOUNCEMENTS[7][] = {
    "[�㲥]:����ֿ�,�ֿڹ���Ա����Ե�Ӵ! ",
    "[�㲥]:����ָ���/help ��������/sz ",
    "[�㲥]:��Ҫ���˰�Tab�����Բ鿴��ǰ�����! ",
    "[�㲥]:�����з�����ʧ���³���/kill���Զ�������",
    "[�㲥]:��������ֱ�ӷ�ɱ!������Ϸ�����������ף� ",
    "[�㲥]:���⵷�һᱻ����Ա����������Ӵ! ",
    "[�㲥]:������Ϸ����R�����ֿڣ�"
};
forward GlobalAnnouncement();
public GlobalAnnouncement() {
    switch (RandMsg) {
        case 0:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[0]);
            new year = 0, month = 0, day = 0;
            getdate(year, month, day);
            if(year == 2020 && month <= 3 && day <= 15) SendRconCommand("hostname RST�Ŷӹٷ���������һ��Ϊ�人����!");
            // else SendRconCommand("hostname {****�� �� �� ��****}RST�Ŷӹٷ�������2020");
            RandMsg++;
        }
        case 1:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[1]);
            SendRconCommand("hostname RST�Ŷӹٷ�����������л�Ȱ�GTA������ ��");
            RandMsg++;
        }
        case 2:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[2]);
            SendRconCommand("hostname RST�Ŷӹٷ�������������|����|����|������|����|�Ҿߡ�");
            RandMsg++;
        }
        case 3:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[3]);
            // SendRconCommand("hostname Race Speed Time ����֮ʱ 2020");
            RandMsg++;
        }
        case 4:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[4]);
            SendRconCommand("hostname RST�Ŷӷ�������Bվ����RaceSpeedTime");
            RandMsg++;
        }
        case 5:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[5]);
            SendRconCommand("hostname RST�Ŷӹٷ�������������֮ʱ��");
            RandMsg++;
        }
        case 6:{
            SCMALL(0x0088FFFF, ANNOUNCEMENTS[6]);
            SendRconCommand("hostname RST����֮ʱ - 2020 [��������������������]");
            RandMsg++;
        }
        case 7:{
            //SCMALL(0x0088FFFF, ANNOUNCEMENTS[2]);
            // SendRconCommand("hostname RST�Ŷӹٷ���������24/7������...��");
            RandMsg = 0;
        }
    }
    return 1;
}
forward KickEx(playerid);
public KickEx(playerid) {
    Kick(playerid);
    return 1;
}
forward BansEx(playerid);
public BansEx(playerid) {
    Ban(playerid);
    return 1;
}
main() {
    print("-------------------------------------------------");
    print("�����޸���5F��Դ��Prace��Դ �¾���ԴPrace�������ߣ�[Ghost]Rui ushio_p [Ghost]Dylan");
    print("�¾����ɾ�������Դ,������:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)");
    print("�ر���л ryddawn ������OBJָ����[Fire]KiVen JoshenKM");
    print("[R_ST]Hygen:������������....");
    print("-------------------------------------------------");
}
public OnGameModeInit() {
    AntiDeAMX();
    SetGameModeText("����|����|����|����");
    print("[��ʾ]NPC������...");
    SetNameTagDrawDistance(200); //ԭ����70 ��������������ʾ��ҵ����ơ�
    // Streamer_SetTickRate(15 ); //Ĭ��50��������tickrate
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    UsePlayerPedAnims();
    AddPlayerClass(0, 1958.3782, 1343.1572, 15.3746, 269.1424, 0, 0, 0, 0, 0, 0);

    // Race_Load();
    Initialize_Main();
    Initialize_SysTransfer();
    Initialize_Transfer();
    Initialize_QA();
    Initialize_LocalObjects(); //����OBJ���� ��addobjects
    Initialize_PHouse(); //Phouse����
    Initialize_Attire(); //װ�����
    Initialize_Cars(); //��������
    Initialize_Boards(); //�����Ƽ���
    Race_OnFilterScriptInit(); //��������
    Initialize_DeathMatch(); //����DM
    Initialize_Team(); //��ʼ���Ŷ�
    LoadNpcs(); //����NPC
    Initialize_Camera(); //��ʼ������� 2020-3-15 16:41:07
    InitGoods(); //��ʼ���Ҿ�.
    // ����Timers
    StopGATimer = SetTimer("GlobalAnnouncement", 250000, true); //���ع����ʱ
    StopMinuteTimer = SetTimer("MinuteTimer", 60000, true); //���Ӽ�ʱ��
    StopCheckStatus = SetTimer("CheckStatus", 100, true); //�ٶȱ��ʱ��
    StopSecondsTimer = SetTimer("SecondsTimer", 1000, true); //���ʱ��
    // sqlconnect = mysql_connect("127.0.0.1","�û���","����","����");

    // ������֤�õı�����players
    // ��Ҫ�Ѽ���php���� ��php�ļ����µļ���ȥ php�ļ�������Ҫ�޸��û���������ĵط�
    // if(mysql_connect("127.0.0.1","root","sampemail","123456") == 0)
    // {
    //     print("[����]������֤���ݿ�����ʧ��[�뼰ʱ�޸�.]");
    //     // print("[����]������֤���ݿ�����ʧ��[�뼰ʱ�޸�,�����޷�����������.]");
    // 	// SendRconCommand("exit");
    // }
    // else
    // {
    // 	print("[��ʾ]������֤���ݿ����ӳɹ�!���������������������뿪����ط���.");
    // }
    // mysql_set_charset("gbk");
    // mysql_debug(1);
    return 1;
}
public OnGameModeExit() { //print("[��ʾ]�������ر�/����");
    // SCMALL(Color_Red, "[ϵͳ] ����ˢ�·����������ڱ������������...");
    SCMALL(Color_Red, "[ϵͳ] ������ݱ�����ϣ���ʼ����������..");
    KillTimer(StopGATimer);
    KillTimer(StopMinuteTimer);
    KillTimer(StopCheckStatus);
    KillTimer(StopSecondsTimer);
    UnLoadNpcs(); //ж��NPC
    Boards_OnGameModeExit(); //������ж��
    Attire_OnGameModeExit(); //װ��ж��
    Cars_OnGameModeExit(); //����ж��
    Team_OnGameModeExit(); //�Ŷ�ж��
    db_close(user); //�ر��û����ݿ�
    db_close(Racedb); //PRaceж��
    db_close(data); //print("[PHouse]ж��");
    return 1;
}
public OnPlayerRequestClass(playerid, classid) {
    if(IsPlayerNPC(playerid)) return 1;
    if(!PlayerInfo[playerid][Login]) {
        for (new i = 0; i <= 7; i++) {
            TextDrawShowForPlayer(playerid, Screen[i]);
        }
        new rand = random(sizeof(randSounds));
        PlaySoundForPlayer(playerid, randSounds[rand]);
        // rand = random(sizeof(RandomCameraLookAt));
        InterpolateCameraPos(playerid, random(6000) - 3000, random(6000) - 3000, random(120) + 50, random(6000) - 3000, random(6000) - 3000, random(120) + 50, 60000, CAMERA_MOVE);
        // SetPlayerCameraPos(playerid, RandomCameraLookAt[rand][0], RandomCameraLookAt[rand][1], RandomCameraLookAt[rand][2]);
        // SetPlayerCameraLookAt(playerid, RandomCameraLookAt[rand][3], RandomCameraLookAt[rand][4], RandomCameraLookAt[rand][5]);
        // SetPlayerPos(playerid, RandomCameraLookAt[rand][0], RandomCameraLookAt[rand][1], RandomCameraLookAt[rand][2] + 5);
        if(AccountCheck(GetName(playerid))) {
            PlayerInfo[playerid][Register] = true;
            new msg[256];
            format(msg, sizeof(msg), "SELECT `LastLogin` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
            new DBResult:uf;
            uf = db_query(user, msg);
            db_get_field_assoc(uf, "LastLogin", msg, sizeof(msg));
            new lastlogintime[41];
            format(lastlogintime, sizeof(lastlogintime), "%s", msg);
            db_free_result(uf);
            format(msg, sizeof(msg), "��ӭ,�����˺���ע��\n�����·����������½\n���һ������ʱ�� %s", lastlogintime);
            ShowPlayerDialog(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "RaceSpeedTime�Ŷӹٷ�������", msg, "��¼", "�˳�");
        } else {
            ShowPlayerDialog(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "RaceSpeedTime�Ŷӹٷ�������", "�����·��������������ע��!\n���μ������˺�����!\n�Ѳ���ɢ�м��������赣������й¶", "ע��", "�˳�");
            PlayerInfo[playerid][Register] = false;
        }
        return 1;
    }
    return 0;
}
public OnPlayerRequestSpawn(playerid) {
    if(IsPlayerNPC(playerid)) return 1;
    if(PlayerInfo[playerid][Login] == false && PlayerInfo[playerid][Register] == true) {
        new msg[256];
        format(msg, sizeof(msg), "SELECT `LastLogin` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
        new DBResult:uf;
        uf = db_query(user, msg);
        db_get_field_assoc(uf, "LastLogin", msg, sizeof(msg));
        new lastlogintime[41];
        format(lastlogintime, sizeof(lastlogintime), "%s", msg);
        db_free_result(uf);
        format(msg, sizeof(msg), "��ӭ,�����˺���ע��\n�����·����������½\n���һ������ʱ�� %s", lastlogintime);
        ShowPlayerDialog(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "RaceSpeedTime�Ŷӹٷ�������", msg, "��¼", "�˳�");
        // ShowPlayerDialog(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "�˺ŵ�½", "{9AFF9A}����3�λ��᳢�Ե�½!{FFFF00}\n������������������������½", "��¼", "�˳�");
    } else if(PlayerInfo[playerid][Register] == false) {
        ShowPlayerDialog(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "RaceSpeedTime�Ŷӹٷ�������", "�����·��������������ע��!\n���μ������˺�����!\n�Ѳ���ɢ�м��������赣������й¶", "ע��", "�˳�");
    } else {
        SpawnPlayer(playerid);
    }
    return 0;
}
public OnPlayerConnect(playerid) //����ҽ����ʱ��
{
    if(IsPlayerNPC(playerid)) {
        InitializationVelo(playerid);
        return 1;
    }
    // InitializationVelo(playerid); //��ʼ���ٶȱ�
    PlayerInfo[playerid][Login] = false;
    PlayerInfo[playerid][Register] = false;
    PlayerInfo[playerid][tvzt] = false;
    PlayerInfo[playerid][tvid] = playerid;
    p_PPC[playerid] = 0;
    p_ppcCar[playerid] = 0; //������
    //PlayerInfo[playerid][CheckYesNo] = false;
    PlayerInfo[playerid][Wrong] = 0;
    //PlayerInfo[playerid][AntiRaceTP] = 0;
    SetPlayerColor(playerid, PlayerColors[random(200)]); //�������С��ͼ��ɫ
    Race_OnPlayerConnect(playerid);
    Initialize_DeathMatch_Game(playerid);
    // for (new i = 0; i <= 7; i++) {
    //     TextDrawShowForPlayer(playerid, Screen[i]);
    // }
    new OwnIP[16];
    GetPlayerIp(playerid, OwnIP, sizeof(OwnIP));
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(PlayerInfo[i][Login] == false) {
            new OtherIP[16], a;
            GetPlayerIp(i, OtherIP, sizeof(OtherIP));
            if(strcmp(OtherIP, OwnIP) == 0) { //2020.2.8������ֹNPC����T  && !IsPlayerNPC(i)
                a++;
                if(a >= 2) {
                    return FuckAnitCheat(i, "���δ��¼", 997);
                }
            }
        }
    }
    printf("[���]%s(%d) �����˷����� ", GetName(playerid), playerid);
    if(AccountCheck(GetName(playerid))) { //����˺Ŵ����Ǿͻ�ȡ����saltֵ����ɢ���㷨
        new msg[128], DBResult:uf;
        // format(msg, sizeof(msg), "SELECT `ID`,`Salt` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
        format(msg, sizeof(msg), "SELECT `Salt` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
        uf = db_query(user, msg);
        db_get_field_assoc(uf, "Salt", PlayerInfo[playerid][Salt], 11); //ԭ����11
        db_free_result(uf);
    } else { //�������˺Ŵ���ûע����Ļ��ǲ��ܴ����ֺ�{}��
        if(strfind(GetName(playerid), "{", true) != -1 || strfind(GetName(playerid), "}", true) != -1) {
            SendClientMessage(playerid, Color_White, "[ϵͳ]��֧���û����д���{}");
            SetTimerEx("KickEx", 200, false, "i", playerid);
            return 1;
        }
        new placeholder;
        for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
        {
            placeholder = strfind(GetName(playerid), InvalidWords[i], true);
            if(placeholder != -1) {
                SendClientMessage(playerid, Color_White, "[ϵͳ]�û������н�ֹʹ�õĴʻ�");
                SetTimerEx("KickEx", 200, false, "i", playerid);
                return 1;
            }
        }
    }
    SCM(playerid, Color_White, "�����޸���5F��Դ��Prace��Դ �¾���ԴPrace�������ߣ�[Ghost]Rui ushio_p [Ghost]Dylan");
    SCM(playerid, Color_White, "�¾����ɾ�������Դ,������:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)");
    SCM(playerid, Color_White, "�ر���л ryddawn ������OBJָ����[Fire]KiVen JoshenKM");
    SCM(playerid, Color_White, "������Ҫ��װ���Ĳ�������������ʾ������Ϣ�����û�����Ĳ�������ʾ�쳣");
    SCM(playerid, Color_White, "�������Ĳ�������RST�Ŷ���Ⱥ��QQȺ680977910����");
    SCM(playerid, Color_White, "ָ���ȫ��ο�https://yucarl77.coding.me");
    SCM(playerid, Color_White, "������...");
    return 1;
}


public OnPlayerDisconnect(playerid, reason) //����뿪������ ���� �˳�������
{
    for (new a = 0; a <= 21; a++) {
        PlayerTextDrawDestroy(playerid, velo[playerid][a]);
    }
    if(PlayerInfo[playerid][Login] == true) {
        if(SavePlayerInfo(playerid)) {
            new Reasons[][] = {
                "(����)",
                "(�����˳�)",
                "(Kick/Ban)"
            };
            printf("[���]%s(%d)�뿪�˷�����,ԭ��:[%s].", GetName(playerid), playerid, Reasons[reason]);
            new string[128];
            format(string, sizeof(string), "[ϵͳ]:%s (%d) �뿪�˷����� (%s) ^^^", GetName(playerid), playerid, Reasons[reason]);
            SCMALL(Color_LightBlue, string);
            // SendDeathMessage(playerid, playerid, 201);
            SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
        }
    }
    return 1;
}

public OnPlayerSpawn(playerid) //����ҳ���ʱ
{
    if(IsPlayerNPC(playerid)) { //��������NPC�Ļ�
        InitializationNpcs(playerid); //��ʼ��NPC
        return 1;
    }
    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
    if(IsPlayerDeathMatch(playerid)) {
        DeathMatch_OnPlayerSpawn(playerid);
        return 1;
    }
    SpawnAttire(playerid); //���װ��
    if(CreateCamera[playerid][CreateStatus] != 0) return 1;
    if(pRaceing[playerid] != 1) {
        // SetPlayerVirtualWorld(playerid, 0);
        SetPlayerHealth(playerid, 1000000);
        SetPlayerPos_Birth(playerid);
        // SetPlayerPos(playerid, 1958.835693, 1343.151123, 15.374607);
        // SetPlayerFacingAngle(playerid, 269.142425);
        SetCameraBehindPlayer(playerid);
        new Float:X, Float:Y, Float:Z;
        GetPlayerPos(playerid, X, Y, Z);
        // NoDieTime[playerid] = CreateDynamic3DTextLabel("�޵�ʱ����...\n", 0xFF0000FF, X, Y, Z, 40.0, playerid);
        // // Attach3DTextLabelToPlayer(NoDieTime[playerid], playerid, 0.0, 0.0, 0.7);
        // SetTimerEx("CheckAso", 3000, 0, "i", playerid); //���������޵�
        if(GetPlayerScore(playerid) < 120) {
            SendClientMessage(playerid, Color_White, "[ϵͳ]��⵽����Ϸʱ��δ��120���ӣ��Զ��򿪰�����ʾ");
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/help");
            // OnPlayerCommandText(playerid, "/help");
        }
    } else if(p_PPC[playerid]) { //�������Ļ�
        PPC_Veh(playerid);
    } else { //����ʱ������
        // new raid = RaceHouse[GameRace[playerid][rgameid]][rraceid];
        // new trcp[racecptype];
        // if(GameRace[playerid][rgamecp] - 1 <= 0) Race_GetCp(raid, 1, trcp); //����ǵ�һ����Ļ�����������һ���㣬��Ȼ���Ǹ���
        // else Race_GetCp(raid, GameRace[playerid][rgamecp] - 1, trcp);
        // 2020.3.17 ע�� ���������� 

        //SetTimerEx("", 1000, 0, "i", playerid);
        PlayerInfo[playerid][lastVehSpeed] = 0;
        ReSpawnRaceVehicle(playerid); //2020.1.12�ģ���������Ч��
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    if(p_PPC[playerid] && IsPlayerInAnyVehicle(playerid)) DestroyVehicle(p_ppcCar[playerid]);
    if(pRaceing[playerid]) { //����������������������и�λs
        PlayerInfo[playerid][lastVehSpeed] = 0;
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~RESPAWNING", 3000, 3); //���½���ʾ
        // TextDrawShowForPlayer(playerid, ReSpawningText[playerid]);
    } else {
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~Wasted", 3000, 3); //���½���ʾ
    }
    DeathMatch_OnPlayerDeath(playerid, killerid);
    return 1;
}

public OnVehicleDeath(vehicleid, killerid) {
    return 1;
}

public OnPlayerText(playerid, text[]) {
    /*for (new i = 0; i < BadWordsCount; ++i)
    if(strfind (text, BadWords [i], true))
    {
		SCM(playerid,Color_Red,"[ϵͳ] ����������,������Ϸ����!");
        return 0;
    }*/
    if(PlayerInfo[playerid][Login] == false) {
        SCM(playerid, Color_Red, "[ϵͳ] �㻹δ��¼!");
        return 0;
    }
    if(PlayerInfo[playerid][JailSeconds] > 0) {
        SCM(playerid, Color_Red, "[����]:�����ڼ������뱣���侲,�Ժ�Ҫ��������!. ");
        return 0;
    }
    if(AntiCommand[playerid] == 1) {
        SCM(playerid, Color_Red, "[ϵͳ]:�㷢�Ե��ٶ�̫����!");
        return 0;
    }
    new placeholder;
    for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
    {
        placeholder = strfind(text, InvalidWords[i], true);
        if(placeholder != -1) {
            for (new x = placeholder; x < placeholder + strlen(InvalidWords[i]); x++) {
                text[x] = '*';
            }
        }
    }
    AntiCommand[playerid] = 1;
    new ChatText[144];
    if(text[0] == '#') {
        if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
            SendClientMessage(playerid, Color_Team, "[�Ŷ�]��δ���κ�һ���Ŷ���");
            return 0;
        }
        if(!isnull(PlayerInfo[playerid][Designation])) {
            format(ChatText, sizeof(ChatText), "[�Ŷ�]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        } else {
            format(ChatText, sizeof(ChatText), "[�Ŷ�]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        }
        team_SCM(ChatText, PlayerInfo[playerid][Team]);
        return 0;
    }
    if(GetPlayerVirtualWorld(playerid) == 0) {
        if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
            if(!isnull(PlayerInfo[playerid][Designation])) {
                format(ChatText, sizeof(ChatText), "[����]%s{%06x}%s(%d):{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            } else {
                format(ChatText, sizeof(ChatText), "[����]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            }
        } else {
            if(!isnull(PlayerInfo[playerid][Designation])) {
                format(ChatText, sizeof(ChatText), "[����]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            } else {
                format(ChatText, sizeof(ChatText), "[����]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            }
        }
        SCMALL(Color_White, ChatText); //GetPlayerColor(playerid)
    } else {
        if(text[0] == '!') //��С���緢���������� ��!
        {
            if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
                if(!isnull(PlayerInfo[playerid][Designation])) {
                    format(ChatText, sizeof(ChatText), "[����]%s{%06x}%s(%d):{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "[����]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            } else {
                if(!isnull(PlayerInfo[playerid][Designation])) {
                    format(ChatText, sizeof(ChatText), "[����]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "[����]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            }
            SCMALL(Color_White, ChatText);
        } else {
            if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
                if(!isnull(PlayerInfo[playerid][Designation])) {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[Ƶ��-%d]%s{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[Ƶ��-%d]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            } else {
                if(!isnull(PlayerInfo[playerid][Designation])) {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[Ƶ��-%d]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[Ƶ��-%d]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            }
            for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                if(IsPlayerConnected(i)) {
                    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
                        SCM(i, Color_White, ChatText); //GetPlayerColor(playerid)
                    }
                }
            }
        }
    }
    Common_Answer_QA(playerid, text);
    new removecolor = strfind(ChatText, "{", true); //�Զ�������ɫ��� ��ʡ��־�ռ� By YuCarl77
    while (removecolor != -1) {
        if(removecolor + 8 <= strlen(ChatText) && ChatText[removecolor + 7] == '}') {
            strdel(ChatText, removecolor, removecolor + 8);
            removecolor = strfind(ChatText, "{", true);
        } else {
            break;
        }
    }
    PlayerTextRecord(ChatText);
    // printf(ChatText);
    return 0;
}

public OnPlayerCommandReceived(const playerid, const cmdtext[]) //��ִ��commandtext֮ǰִ�� ���i-zcmd
{
    if(PlayerInfo[playerid][Login] == false) {
        SCM(playerid, Color_Red, "[ϵͳ]:�㻹û�е�¼ѽ");
        return 0;
    }
    if(PlayerInfo[playerid][JailSeconds] > 0) {
        SCM(playerid, Color_Red, "[ϵͳ]:�ڼ����н�ֹʹ������");
        return 0;
    }
    //if(TpCheck[playerid] == 1) return 1;
    if(AntiCommand[playerid] == 1) {
        SCM(playerid, Color_Red, "[ϵͳ]:������ָ����ٶ�̫����!");
        return 0;
    }
    if(p_PPC[playerid] && strcmp(cmdtext, "/ppc", true)) {
        SCM(playerid, Color_White, "[ϵͳ]:������������ֻ����ʹ��/ppc");
        return 0;
    }
    new cmd[128], idx;
    cmd = strtok(cmdtext, idx);
    if(strcmp("/pm", cmd, true) == 0) //cmdtext[1]=='p' && cmdtext[2]=='m'
    {
        // cmd_pm(playerid, strtok(cmdtext, idx));
        new Message[128], gMessage[128];
        Message = strtok(cmdtext, idx);
        if(!strlen(Message) || strlen(Message) > 5) {
            SCM(playerid, 0x99FFFFAA, "[pm] ��ʹ��:/pm ID Ҫ˵�Ļ���"); //PM������Ϣ
            return 0;
        }
        new id = strval(Message);
        gMessage = strrest(cmdtext, idx);
        if(!strlen(gMessage)) {
            SCM(playerid, 0x99FFFFAA, "[pm]��ʹ��:/pm ID Ҫ˵�Ļ���"); //PM������Ϣ
            return 0;
        }
        if(!IsPlayerConnected(id) || IsPlayerNPC(id)) {
            SCM(playerid, 0x99FFFFAA, "[pm]/pm :�������ID��"); //������Ϣ
            return 0;
        }
        if(playerid == id) {
            SCM(playerid, 0x99FFFFAA, "[pm] �㲻��PM���Լ�");
            return 0;
        }
        format(Message, sizeof(Message), "[pm] ����� %s(%d):%s", GetName(id), id, gMessage);
        SCM(playerid, 0x99FFFFAA, Message);
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Sent~w~.", 3000, 3); //��A���PM��B��ҵ�ʱ�� A��һ���ʾ���
        format(Message, sizeof(Message), "[pm] �������� %s(%d):%s", GetName(playerid), playerid, gMessage);
        SCM(id, 0x99FFFFAA, Message);
        GameTextForPlayer(id, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Recieved~w~.", 3000, 3); //��B����յ�A��ҵ�PM��ʱ�� B��һ���ʾ���
        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
        PlayerPlaySound(id, 1057, 0.0, 0.0, 0.0);
        AntiCommand[playerid] = 1; //�������pm�ͷ��籨��
        return 0;
    }
    if(IsPlayerDeathMatch(playerid) && strcmp(cmdtext, "/dm leave", true) && strcmp(cmdtext, "/kill", true) && strcmp(cmdtext, "/k", true)) {
        SCM(playerid, Color_White, "[DM]������ֻ��ͨ��/dm leave�뿪");
        return 0;
    }
    if(pRaceing[playerid] == 1 && strcmp("/c", cmd, true) == 0) {
        //���CP���ǵ�һ����Ļ�������
        if(GameRace[playerid][rgamecp] == 1) {
            cmd_c(playerid, strtok(cmdtext, idx));
            return 0;
        } else {
            SCM(playerid, Color_Red, "[����] ���ı����ѿ�ʼ,������ˢ��!");
            return 0;
        }
    }
    if(pRaceing[playerid] == 1 && strcmp(cmdtext, "/r l", true) != 0 && strcmp(cmdtext, "/r leave", true) != 0 && strcmp(cmdtext, "/kill", true) != 0 && strcmp(cmdtext, "/r s", true) != 0) {
        SCM(playerid, Color_Red, "[����] ������������ֻ����ʹ��˽��,����/r l�뿪����");
        return 0;
    }
    AntiCommand[playerid] = 1;
    return 1;
}

public OnPlayerCommandPerformed(const playerid, const cmdtext[], const success) // ��ִ��commandtext֮��ִ�� successΪִ�гɹ� Ҳ����1 ʧ�ܾ���0
{
    if(!success) {
        if(cmdtext[0] == '/' && cmdtext[1] == '/' && cmdtext[2]) {
            new tmp[128], str[128];
            format(tmp, 128, "%s", cmdtext);
            strdel(tmp, 0, 2);
            format(tmp, 128, "%s", tmp);
            new id = make_findgo(tmp);
            if(id == -1) return SCM(playerid, TransferColor, "[����] ��������Ĵ��͵㲻����!");
            format(str, sizeof(str), "[����] �㴫�͵���'//%s'", vmake[id][mname]);
            SCM(playerid, TransferColor, str);
            if(vmake[id][mz] >= 150.0) DynUpdateStart(playerid); //2020.3.21����
            if(IsPlayerInAnyVehicle(playerid)) {
                SetVehiclePos(GetPlayerVehicleID(playerid), vmake[id][mx], vmake[id][my], vmake[id][mz]);
                SetVehicleZAngle(GetPlayerVehicleID(playerid), vmake[id][ma]);
            } else {
                SetPlayerPos(playerid, vmake[id][mx], vmake[id][my], vmake[id][mz]);
                SetPlayerFacingAngle(playerid, vmake[id][ma]);
                if(PlayerInfo[playerid][enableInvincible] != 1) {
                    SetPlayerHealth(playerid, 100);
                }
            }
            return 1;
        }
        if(cmdtext[0] == '/' && cmdtext[1]) {
            new tmp[128], str[128];
            format(tmp, 128, "%s", cmdtext);
            strdel(tmp, 0, 1);
            format(tmp, 128, "%s", tmp);
            new id = make_Sysfindgo(tmp);
            if(id == -1) return SCM(playerid, 0xFFFFFFFF, "[ϵͳ]:û���������! , ���������/help");
            format(str, sizeof(str), "{33CCCC}%s(%d) {82D900}������{00FF99} %s {FF0066}/%s {82D900}", GetName(playerid), playerid, vsysmake[id][tdescribe], vsysmake[id][mname]);
            SCMALL(TransferColor, str);
            if(vsysmake[id][mz] >= 150.0) DynUpdateStart(playerid); //2020.3.21����
            if(IsPlayerInAnyVehicle(playerid)) {
                SetVehiclePos(GetPlayerVehicleID(playerid), vsysmake[id][mx], vsysmake[id][my], vsysmake[id][mz]);
                SetVehicleZAngle(GetPlayerVehicleID(playerid), vsysmake[id][ma]);
            } else {
                SetPlayerPos(playerid, vsysmake[id][mx], vsysmake[id][my], vsysmake[id][mz]);
                SetPlayerFacingAngle(playerid, vsysmake[id][ma]);
            }
            return 1;
        }
    }
    new tmp[128];
    format(tmp, sizeof(tmp), "[ָ��]%s(%d):%s", GetName(playerid), playerid, cmdtext);
    PlayerCommandRecord(tmp);
    return 1;
}

//����DM����
// public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
//     DeathMatch_OnPlayerWeaponShot(playerid, hittype, hitid);
//     return 1;
// }
//�����ʽ CMD:����(playerid,params[]) һ��Ϊ�˸�����Ǩ��ֱ�Ӱ�paramsд��cmdtext
// {
//     ��ע�⣬params[]��Զ����Ϊ�ա����������δΪ�����ṩ�κβ�����params[0]��Ϊ'\1'��ʹ�ð���isnull(string[])�渽�ĺ��������Ч�ԡ�
// iZCMD with sscanf is an efficient way to process commands
//  if(sscanf(params, "is[�ַ�������]", skinid,str))
//     return 1;
// }
// CMD:pm(const playerid, const cmdtext[]) { //PM˽����� ��������Ϊ���ƿ�PRace�ļ�� ����������ʱpm
//     new Message[128],gMessage[128],idx;
//     Message = strtok(cmdtext, idx);
//     if(!strlen(Message) || strlen(Message) > 5) {
//         SCM(playerid, 0x99FFFFAA, "[pm] ��ʹ��:/pm ID Ҫ˵�Ļ���"); //PM������Ϣ
//         return 0;
//     }
//     new id = strval(Message);
//     gMessage = strrest(cmdtext, idx);
//     if(!strlen(gMessage)) {
//         SCM(playerid, 0x99FFFFAA, "[pm]��ʹ��:/pm ID Ҫ˵�Ļ���"); //PM������Ϣ
//         return 0;
//     }
//     if(!IsPlayerConnected(id)) {
//         SCM(playerid, 0x99FFFFAA, "[pm]/pm :�������ID��"); //������Ϣ
//         return 0;
//     }
//     if(playerid == id) {
//         SCM(playerid, 0x99FFFFAA, "[pm] �㲻��PM���Լ�");
//         return 0;
//     }
//     format(Message, sizeof(Message), "[pm] ����� %s(%d):%s", GetName(id), id, gMessage);
//     SCM(playerid, 0x99FFFFAA, Message);
//     GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Sent~w~.", 3000, 3); //��A���PM��B��ҵ�ʱ�� A��һ���ʾ���
//     format(Message, sizeof(Message), "[pm] �������� %s(%d):%s", GetName(playerid), playerid, gMessage);
//     SCM(id, 0x99FFFFAA, Message);
//     GameTextForPlayer(id, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Recieved~w~.", 3000, 3); //��B����յ�A��ҵ�PM��ʱ�� B��һ���ʾ���
//     PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
//     PlayerPlaySound(id, 1057, 0.0, 0.0, 0.0);
//     AntiCommand[playerid] = 1; //�������pm�ͷ��籨��
//     return 1;
// }
CMD:chat(const playerid, const cmdtext[]) { //С����������ط�ʹ�ô�����˵�� ǰ��Ӹ�!ͬ��
    new ChatText[144], text[128];
    if(sscanf(cmdtext, "s[128]", text)) return SendClientMessage(playerid, Color_White, "[ϵͳ]���ں��������˵�Ļ�,�ʹ������");
    if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
        if(!isnull(PlayerInfo[playerid][Designation])) {
            format(ChatText, sizeof(ChatText), "[����]%s{%06x}%s(%d):{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        } else {
            format(ChatText, sizeof(ChatText), "[����]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        }
    } else {
        if(!isnull(PlayerInfo[playerid][Designation])) {
            format(ChatText, sizeof(ChatText), "[����]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        } else {
            format(ChatText, sizeof(ChatText), "[����]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        }
    }
    SCMALL(Color_White, ChatText);
    PlayerTextRecord(ChatText);
    return 1;
}
CMD:help(const playerid, const cmdtext[]) {
    Dialog_Show(playerid, HelpSystem, DIALOG_STYLE_LIST, "����ϵͳ", "����ƪ\n����ϵͳ\n���Ի�����\n�ճ�����\n�ؾ����\n�������\n�ۿ����\n����/����\n����ϵͳ\n�Ҿ�ϵͳ\nװ��ϵͳ\n�����ϵͳ\n����Աָ���ȫ\n����ϵͳ\n�Ŷ�ϵͳ\n���ϵͳ", "ȷ��", "ȡ��");
    return 1;
}
CMD:telemenu(const playerid, const cmdtext[]) {
    Tele_ShowListDialog(playerid, TelePage[playerid]);
    return 1;
}
CMD:sdb(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][speedoMeter]) {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawHide(playerid, velo[playerid][a]);
        }
        PlayerInfo[playerid][speedoMeter] = 0;
        SendClientMessage(playerid, Color_White, "[ϵͳ]��ر����ٶȱ�");
    } else {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawShow(playerid, velo[playerid][a]);
        }
        PlayerInfo[playerid][speedoMeter] = 1;
        SendClientMessage(playerid, Color_White, "[ϵͳ]�㿪�����ٶȱ�");
    }
    return 1;
}
CMD:cmds(const playerid, const cmdtext[]) {
    return cmd_help(playerid, cmdtext);
}
CMD:wdch(const playerid, const params[]) {
    new string[128];
    if(!isnull(PlayerInfo[playerid][Designation])) format(string, sizeof(string), "{FFFFFF}�����ڵĳƺ���[%s{FFFFFF}]\n����һ�γƺ���Ҫ3000���\n����null����ƺ�\n��ɫ��ʹ��{}�������", PlayerInfo[playerid][Designation]);
    else format(string, sizeof(string), "��Ŀǰ���޳ƺ�\n����һ�γƺ���Ҫ3000���");
    ShowPlayerDialog(playerid, Dialog_Designation, DIALOG_STYLE_INPUT, "�ҵĳƺ�", string, "ȷ��", "ȡ��");
    return 1;
}
CMD:motto(const playerid, const params[]) {
    new string[128];
    if(!isnull(PlayerInfo[playerid][Tail])) format(string, sizeof(string), "{FFFFFF}�����ڵ�Сβ����[%s{FFFFFF}]\n����һ��Сβ����Ҫ3000���\n����null���Сβ��\n��ɫ��ʹ��{}�������", PlayerInfo[playerid][Tail]);
    else format(string, sizeof(string), "��Ŀǰ����Сβ��\n����һ�γƺ���Ҫ3000���");
    ShowPlayerDialog(playerid, Dialog_Tail, DIALOG_STYLE_INPUT, "�ҵ�Сβ��", string, "ȷ��", "ȡ��");
    return 1;
}
CMD:tail(const playerid, const params[]) {
    return cmd_motto(playerid, "");
}
CMD:ppc(const playerid, const cmdtext[]) {
    new msg[128];
    if(p_PPC[playerid] == 0) {
        DisableRemoteVehicleCollisions(playerid, false);
        p_PPC[playerid] = 1;
        SetPlayerVirtualWorld(playerid, 10001);
        PPC_Veh(playerid);
        format(msg, sizeof msg, "[ϵͳ*]%s(%d) ������������ /ppc", GetName(playerid), playerid);
    } else {
        p_PPC[playerid] = 0;
        OnPlayerSpawn(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        format(msg, sizeof msg, "[ϵͳ*]%s(%d) �뿪��������", GetName(playerid), playerid);
        if(PlayerInfo[playerid][NoCrash]) DisableRemoteVehicleCollisions(playerid, true);
    }
    SendClientMessageToAll(Color_White, msg);
    return 1;
}
CMD:anim(const playerid, const cmdtext[]) { //�����ű�
    new tmp[128], idx;
    tmp = strtok(cmdtext, idx);
    if(isnull(tmp)) {
        new string[227];
        format(string, sizeof(string), "/anim [ID] ��F�������\n1.���� 2.���±�ͷ 3.����1 4.���� 5.����2 6.����3\n7.����4 8.�����޳� 9.��ǽ1 10.��ǽ2 11.����\n12.δ֪13.����1 14.����2 15.����3 16.����4 \n17.��̫�� 18.����19.Ͷ�� 20.���(��ǹ/ָ��) 21.����");
        ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "��������", string, "OK", "");
        return 1;
    }
    new id = strval(tmp);
    ClearAnimations(playerid); //���ԭ�ȶ���
    SetPlayerSpecialAction(playerid, 0); //������⶯��������������
    Action_Play(playerid, id);
    return 1;
}
CMD:mynetstats(const playerid, const cmdtext[]) {
    new stats[256];
    GetPlayerNetworkStats(playerid, stats, sizeof(stats)); // get your own networkstats
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "�ҵ� ��ǰ����״̬", stats, "Okay", "");
    return 1;
}
CMD:sound1(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1062);
    return 1;
}
CMD:sound2(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1063);
    PlaySoundForPlayer(playerid, 1068);
    return 1;
}
CMD:sound3(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1069);
    PlaySoundForPlayer(playerid, 1076);
    return 1;
}
CMD:sound4(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1077);
    PlaySoundForPlayer(playerid, 1097);
    return 1;
}
CMD:sound5(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1098);
    PlaySoundForPlayer(playerid, 1183);
    return 1;
}
CMD:sound6(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1184);
    PlaySoundForPlayer(playerid, 1185);
    return 1;
}
CMD:sound7(const playerid, const cmdtext[]) {
    PlaySoundForPlayer(playerid, 1186);
    PlaySoundForPlayer(playerid, 1187);
    return 1;
}
CMD:soundstop(const playerid, const cmdtext[]) {
    //2020.1.12 �޸�soundstop�޷�ֹͣ����
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
    return 1;
}
CMD:moveme(const playerid, const cmdtext[]) {
    SetPlayerCameraPos(playerid, 0, 0, 0);
    SetPlayerCameraLookAt(playerid, 0, 0, 0);
    TogglePlayerSpectating(playerid, true);
    InterpolateCameraPos(playerid, 2488.533, -1675.285, 17, 1000.0, 1000.0, 40.0, 30000, CAMERA_MOVE);
    SCM(playerid, Color_White, "���Ծ�ͷ1");
    InterpolateCameraLookAt(playerid, 2488.533, -1675.285, 17, 1000.0, 1000.0, 40.0, 30000, CAMERA_MOVE);
    SCM(playerid, Color_White, "���Ծ�ͷ2");
    //Move the player's camera from point A to B in 10000 milliseconds (10 seconds).
    return 1;
}
CMD:kill(const playerid, const cmdtext[]) {
    new Float:Health;
    GetPlayerHealth(playerid, Health);
    if(!Health) return SendClientMessage(playerid, Color_White, "[ϵͳ]����ֵΪ��,���������,��ȴ��������³�����");
    if(PlayerInfo[playerid][tvzt]) { //�����Ҵ���TV״̬ �����������˳�TV����ɱ ��Ȼ���BUG
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/tv off");
        // OnPlayerCommandText(playerid, "/tv off");
    }
    if(pRaceing[playerid]) {
        new Float:POS[3];
        GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
        SetPlayerPos(playerid, POS[0], POS[1], POS[2]);
    }
    SetPlayerHealth(playerid, -1.0);
    return 1;
}
CMD:s(const playerid, const cmdtext[]) { //����Ҫ���͵�������
    GetPlayerPos(playerid, PlayerInfo[playerid][SavePos][0], PlayerInfo[playerid][SavePos][1], PlayerInfo[playerid][SavePos][2]);
    PlayerInfo[playerid][SaveInterior] = GetPlayerInterior(playerid);
    splp[playerid] = 1;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), PlayerInfo[playerid][SavePos][3]);
    else GetPlayerFacingAngle(playerid, PlayerInfo[playerid][SavePos][3]);
    SCM(playerid, 0xFFFFFFAA, "[��������]��ǰ�����ѱ���, ����/l���ظ�����");
    return 1;
}
CMD:sp(const playerid, const cmdtext[]) return cmd_s(playerid, cmdtext); //����Ҫ���͵�������
CMD:l(const playerid, const cmdtext[]) { //���͵����������
    if(splp[playerid] != 1) return SCM(playerid, 0xFFFF00AA, "[��������]����ʹ��/s���б�������"); //�����û�б�������Ļ�����ʾ�ȱ���
    SetPlayerInterior(playerid, PlayerInfo[playerid][SaveInterior]);
    if(IsPlayerInAnyVehicle(playerid)) {
        SetVehiclePos(GetPlayerVehicleID(playerid), PlayerInfo[playerid][SavePos][0], PlayerInfo[playerid][SavePos][1], PlayerInfo[playerid][SavePos][2]);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), PlayerInfo[playerid][SavePos][3]);
    } else {
        SetPlayerPos(playerid, PlayerInfo[playerid][SavePos][0], PlayerInfo[playerid][SavePos][1], PlayerInfo[playerid][SavePos][2]);
        SetPlayerFacingAngle(playerid, PlayerInfo[playerid][SavePos][3]);
    }
    return 1;
}

CMD:lp(const playerid, const cmdtext[]) return cmd_l(playerid, cmdtext); //���͵���������� ���븴��
// CMD:stunt(const playerid, const cmdtext[]) {
//     new tmp[8];
//     if(sscanf(cmdtext, "s[8]", tmp)) return SCM(playerid, Color_White, "[ϵͳ]/stunt on���� off�ر��ؼ���ʾ");
//     if(strcmp(tmp, "on", true) == 0) {
//         EnableStuntBonusForPlayer(playerid, 1);
//         SCM(playerid, Color_White, "[ϵͳ] �ѿ����ؼ�������ʾ.");
//     } else {
//         EnableStuntBonusForPlayer(playerid, 0);
//         SCM(playerid, Color_White, "[ϵͳ] �ѹر��ؼ�������ʾ.");
//     }
//     return 1;
// }

CMD:xiufu(const playerid, const cmdtext[]) { //����ҿ�ס��ʱ���������ָ������޸���������ܺ���
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    SetPlayerPos(playerid, X, Y, Z + 2.8);
    return 1;
}
CMD:skin(const playerid, const cmdtext[]) {
    new skinid;
    if(sscanf(cmdtext, "d", skinid)) return ShowModelSelectionMenu(playerid, skinlist, "Select Skin");
    if(skinid < 0 || skinid > 311) return SCM(playerid, Color_White, "[����] �����Ƥ��ID.");
    if(IsPlayerInAnyVehicle(playerid)) {
        new seat = GetPlayerVehicleSeat(playerid);
        new vehid = GetPlayerVehicleID(playerid);
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x, y, z);
        SetPlayerSkin(playerid, skinid);
        PutPlayerInVehicle(playerid, vehid, seat);
    } else {
        SetPlayerSkin(playerid, skinid);
    }
    PlayerInfo[playerid][Skin] = skinid;
    SCM(playerid, Color_White, "[����] �����ɹ�.");
    return 1;
}
CMD:hf(const playerid, const cmdtext[]) return cmd_skin(playerid, cmdtext);
CMD:sz(const playerid, const cmdtext[]) {
    OnPlayerSettings(playerid);
    return 1;
}
CMD:wdsz(const playerid, const cmdtext[]) return cmd_sz(playerid, cmdtext);
stock OnPlayerSettings(const playerid) {
    ShowPlayerDialog(playerid, PlayerInfoDialog, DIALOG_STYLE_LIST, "�ҵ�����", "��ȫ����\n�ҵ�װ��\n�ҵļҾ�\n�ҵİ���\n�ҵ���ɫ\n�ҵĳƺ�\n�ҵ�Сβ��\n���Ի�����", "����", "ȡ��");
    return 1;
}
CMD:fxq(const playerid, const cmdtext[]) { //���������/fxq��ʱ�� ����ҷ�����   ������
    SetPlayerSpecialAction(playerid, 2);
    return 1;
}
CMD:jetpack(const playerid, const cmdtext[]) { //���������/fxq��ʱ�� ����ҷ�����   ������
    SetPlayerSpecialAction(playerid, 2);
    return 1;
}
CMD:weather(const playerid, const cmdtext[]) {
    new tweather;
    if(sscanf(cmdtext, "i", tweather)) return SCM(playerid, Color_LightBlue, "[����]�÷�:/tianqi [����ID] ��ΧΪ0~255 ����0~20Ϊ����ID"); //����������ָ���ʱ��
    if(tweather < 0 || tweather > 256) return SCM(playerid, Color_LightBlue, "[����]ID���󣬷�ΧΪ0~255"); //����������ָ���ʱ��
    SetPlayerWeather(playerid, tweather);
    PlayerInfo[playerid][tWeather] = tweather;
    new str[128];
    format(str, sizeof(str), "[����]�㽫�Լ�����������Ϊ \"%d\"", tweather);
    SCM(playerid, Color_LightBlue, str); //������������������óɶ���
    return 1;
}
CMD:tianqi(const playerid, const cmdtext[]) return cmd_weather(playerid, cmdtext);
//����ʱ��
CMD:time(const playerid, const cmdtext[]) {
    new hour, minute;
    if(sscanf(cmdtext, "ii", hour, minute)) return SCM(playerid, Color_LightBlue, "[ʱ��] /time ʱ �� СʱΪ0~24,��Ϊ0~59");
    if(hour < 0 || hour > 24) return SCM(playerid, Color_LightBlue, "[ʱ��] /time ʱ �� СʱΪ0~24,��Ϊ0~59");
    if(minute < 0 || minute > 59) return SCM(playerid, Color_LightBlue, "[ʱ��] /time ʱ �� СʱΪ0~24,��Ϊ0~59");
    SetPlayerTime(playerid, hour, minute);
    PlayerInfo[playerid][tHour] = hour;
    PlayerInfo[playerid][tMinute] = minute;
    new str[90];
    format(str, sizeof(str), "[ʱ��] �㽫�Լ���ʱ������Ϊ %02d:%02d ", hour, minute);
    SCM(playerid, Color_LightBlue, str);
    return 1;
}
CMD:shijian(const playerid, const cmdtext[]) return cmd_time(playerid, cmdtext);
CMD:wuqi(const playerid, const cmdtext[]) return ShowPlayerDialog(playerid, weapons, DIALOG_STYLE_LIST, "�����˵�", "С��\n�����\n��ͨ��ǹ\n������ǹ\nɳĮ֮ӥ\nɢ����ǹ\n�̹�ɢ��ǹ\nս��ɢ��ǹ\nTec-9ʽ΢��\n���ȳ��ǹ\nMP5΢�ͳ��ǹ\nAK-47�Զ���ǹ\nM4�Զ���ǹ\nС�;ѻ�ǹ\n��׼���;ѻ�ǹ\n���Ͳ\n��Դ׷���ͻ��Ͳ(RPG)\n�����\n����\n����\nơ��ƿ\nң�ض�ʱը��\nͿѻƿ\n�����\n�������������޵м�����", "ˢ��", "�ر�");
CMD:f(const playerid, const cmdtext[]) {
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, 0xAA3333AA, "[��ͨ����] �����㲻�ڳ���");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, Color_Orange, "[��ͨ����] �㲻��˾��!");
    new Float:POS[3];
    new Float:ZAngle;
    GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
    GetVehicleZAngle(GetPlayerVehicleID(playerid), ZAngle);
    SCM(playerid, Color_White, "[��ͨ����] �㷭���˳�����");
    SetVehiclePos(GetPlayerVehicleID(playerid), POS[0], POS[1], POS[2] + 2);
    SetVehicleZAngle(GetPlayerVehicleID(playerid), ZAngle);
    return 1;
}
//����ʱ
CMD:count(const playerid, const cmdtext[]) return cmd_djs(playerid, cmdtext);
CMD:daojishi(const playerid, const cmdtext[]) return cmd_djs(playerid, cmdtext);
CMD:djs(const playerid, const cmdtext[]) {
    // new count;
    // if(sscanf(cmdtext, "i", count)) count = 6; //������û���������� Ĭ��6-1 = 5��
    // if(count > 30) return SendClientMessage(playerid, 0xFFFF00AA, "[����ʱ]����ʱ�䲻�ɳ���30s");
    // if(CountDown == -1) {
    //     new string[128];
    //     format(string, sizeof(string), "[����ʱ] �� %s (%d) ����ĵ���ʱ��ʼ", GetName(playerid), playerid);
    //     SCMALL(0xFFFF00AA, string);
    //     CountDown = count;
    //     SetTimer("countdown", 1000, 0);
    //     return 1;
    // } 
    // else return SCM(playerid, Color_Red, "[����ʱ] ����:����ʱ���ڽ���");
    if(Count[playerid]) return SCM(playerid, Color_Red, "[����ʱ] ����:����ʱ���ڽ���");
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    Timer[playerid] = SetTimerEx("CountDown", 1000, true, "d", playerid);
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerInRangeOfPoint(i, 20, X, Y, Z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
                new str[16];
                Count[playerid] = 5;
                format(str, sizeof(str), "~w~%d", Count[playerid]);
                GameTextForPlayer(i, str, 3000, 3);
                PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
            }
        }
    }
    return 1;
}
//�޸�һ�γ�
CMD:fix(const playerid, const cmdtext[]) {
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, 0xFFFFFFFF, " ����:�㲻�ڳ���");
    RepairVehicle(GetPlayerVehicleID(playerid));
    SCM(playerid, Color_Orange, "[��ͨ����] ��ĳ����޸�");
    return 1;
}
CMD:dcar(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AutoFix]) {
        SCM(playerid, Color_Orange, "[��ͨ����] ��ر��˳����޵У��ٴ�����/dcar����");
        PlayerInfo[playerid][AutoFix] = 0;
    } else {
        SCM(playerid, Color_Orange, "[��ͨ����] ���Ѿ������˳����޵У��ٴ�����/dcar�ر�");
        PlayerInfo[playerid][AutoFix] = 1;
    }
    return 1;
}
CMD:autofix(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AutoFix]) {
        SCM(playerid, Color_Orange, "[��ͨ����] ��ر��˳����޵У��ٴ�����/dcar����");
        PlayerInfo[playerid][AutoFix] = 0;
    } else {
        SCM(playerid, Color_Orange, "[��ͨ����] ���Ѿ������˳����޵У��ٴ�����/dcar�ر�");
        PlayerInfo[playerid][AutoFix] = 1;
    }
    return 1;
}
CMD:jls(const playerid, const cmdtext[]) { //���������/jls��ʱ�� �����һ������ɡ
    GivePlayerWeapon(playerid, 46, 1);
    SCM(playerid, Color_LightBlue, "������һ������ɡ");
    return 1;
}
CMD:c(const playerid, const cmdtext[]) //ˢ��
{
    // printf("%s", cmdtext);
    new carcmd[128], str[128], idx;
    carcmd = strtok(cmdtext, idx);
    if(!strlen(carcmd)) {
        SCM(playerid, Color_LightBlue, "  ��������ˢ��������������");
        SCM(playerid, Color_LightBlue, " /c [����ID]��ˢ��������IDΪ400-611");
        SCM(playerid, Color_LightBlue, " /cc ��ɫ���� ��ɫ���� ����������ɫ");
        SCM(playerid, Color_LightBlue, " /f ���� /c kick ���� /c wode ˢ����ˢ���ĳ�");
        SCM(playerid, Color_LightBlue, " /c lock ���� /c chepai �������� /c listͼƬˢ�� ");
        return 1;
    }
    if(strcmp(carcmd, "list", true) == 0) {
        ShowPlayerDialog(playerid, Dialog_SpawnVehicle, DIALOG_STYLE_LIST, "------------ˢ���б�-------", "\n�ܳ�\n����\n�ɻ�\nĦ��\n��\nԽҰ\n�ϳ�\n����\n�𳵼���߳�\n������\n������", "ȷ��", "ȡ��");
    }
    if(strcmp(carcmd, "kick", true) == 0) {
        if(PlayerInfo[playerid][BuyID] == 0) return SCM(playerid, Color_Orange, "[��ͨ����]�㶼û��, ��ʲô��?");
        new ren = 0, i;
        for (i = 0; i < MAX_PLAYERS; i++)
            if(IsPlayerConnected(i) && GetPlayerVehicleID(i) == PlayerInfo[playerid][BuyID] && IsPlayerInAnyVehicle(playerid) == 1 && (i > playerid || i < playerid)) {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(i, x, y, z);
                SetPlayerPos(i, x, y, z + 5);
                format(str, sizeof(str), "[��ͨ����] �ó��������� %s , �Ѿ�����.", GetName(i));
                SCM(i, Color_Orange, str);
                ren = 1;
            }
        if(ren == 0) SCM(playerid, Color_Orange, "[��ͨ����]�㳵��û�˰�, ������.");
        return 1;
    }
    if(strcmp(carcmd, "wode", true) == 0) {
        if(PlayerInfo[playerid][BuyID] == 0) {
            SCM(playerid, Color_Orange, "[��ͨ����]�㶼û��, ��ʲô��?");
        } else {
            new Float:POS[3], Float:Angle;
            if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle);
            else GetPlayerFacingAngle(playerid, Angle);
            GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            if(IsPlayerInAnyVehicle(playerid)) SetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            // for (new i; i < MAX_PLAYERS; i++) //˵ʵ��û����д��仰������ͼ��ɶ
            // {
            //     if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == PlayerInfo[playerid][BuyID]) SetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            // }
            SetVehiclePos(PlayerInfo[playerid][BuyID], POS[0], POS[1], POS[2]);
            SetVehicleVirtualWorld(PlayerInfo[playerid][BuyID], GetVehicleVirtualWorld(playerid));
            PutPlayerInVehicle(playerid, PlayerInfo[playerid][BuyID], 0);
            //PlayerInfo[playerid][pVehicleEnteColor_Red] = GetPlayerVehicleID(playerid);
            SetVehicleZAngle(PlayerInfo[playerid][BuyID], Angle);
            LinkVehicleToInterior(PlayerInfo[playerid][BuyID], GetPlayerInterior(playerid));
            // SetTimerEx("CarCheck", 500, false, "i", playerid);
        }
        return 1;
    }
    if(strcmp(carcmd, "color", true) == 0) {
        if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_White, "[��ͨ����] ����:�㲻�ڳ���");
        new tmp[128];
        new color1, color2;
        tmp = strtok(cmdtext, idx);
        if(!strlen(tmp)) return SCM(playerid, Color_White, "[��ͨ����] ��ʽ:/cc ��ɫ ��ɫ");
        color1 = strval(tmp);
        tmp = strtok(cmdtext, idx);
        color2 = strval(tmp);
        if(color1 < 0 || color1 > 255) return SCM(playerid, Color_White, "[��ͨ����] ������ɫ���룬������ɫ����Ϊ0-255"); {
            ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
            SCM(playerid, Color_White, "[��ͨ����] ������˳�������ɫ��");
        }
    }
    if(strcmp(carcmd, "lock", true) == 0) //����
    {
        if(PlayerInfo[playerid][BuyID] == 0) return SCM(playerid, Color_White, "[��ͨ����]�㶼û��, ��ʲô��?");
        if(PlayerInfo[playerid][CarLock] == 0) {
            PlayerInfo[playerid][CarLock] = 1;
            SCM(playerid, Color_White, "[��ͨ����]��ĳ�������");
        } else {
            PlayerInfo[playerid][CarLock] = 0;
            SCM(playerid, Color_White, "[��ͨ����]��ĳ��ѽ���");
        }
        return 1;
    }
    if(strcmp(carcmd, "chepai", true) == 0) //�����ò��ˡ�����������
    {
        new tmp[128];
        tmp = strtok(cmdtext, idx);
        if(!strlen(tmp)) return SCM(playerid, Color_White, "[��ͨ����] �÷�:/c chepai Ҫ���õĳ���");
        if(strlen(tmp) > 10) return SCM(playerid, Color_White, "[��ͨ����] ����:ֻ������5λ���ֻ�10λӢ����ĸ");
        if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][BuyID]) return SCM(playerid, Color_White, "[��ͨ����] ����:�㲻���Լ����ؾ���");
        SetVehicleNumberPlate(PlayerInfo[playerid][BuyID], tmp);
        SCM(playerid, Color_White, "[��ͨ����] �������Ƴɹ�");
        new Float:x, Float:y, Float:z, Float:z_angle;
        GetPlayerPos(playerid, x, y, z);
        GetVehicleZAngle(PlayerInfo[playerid][BuyID], z_angle);
        SetPlayerPos(playerid, x, y, z);
        SetVehicleToRespawn(PlayerInfo[playerid][BuyID]);
        SetVehiclePos(PlayerInfo[playerid][BuyID], x, y, z);
        SetVehicleZAngle(PlayerInfo[playerid][BuyID], z_angle);
        PutPlayerInVehicle(playerid, PlayerInfo[playerid][BuyID], 0);
        AddVehicleComponent(PlayerInfo[playerid][BuyID], 1010);
        return 1;
    }
    new car;
    car = strval(carcmd);
    if(car < 400 || car > 611) return SCM(playerid, Color_White, "[��ͨ����] ����ID������{FFFFFF}400-611֮�䣡");
    SpawnVehicle(playerid, car);
    //2020.1.12 16:20�䶯
    // new Float:x, Float:y, Float:z;
    // GetPlayerPos(playerid, x, y, z);
    // SetPlayerPos(playerid, x, y, z);
    // SetTimerEx("SpawnVehicle", 300, false, "ii", playerid, car);
    return 1;
}
CMD:cc(const playerid, const cmdtext[]) { //��������ؾ���ɫ
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_White, "[��ͨ����] ����:�㲻�ڳ���");
    new color1, color2;
    if(sscanf(cmdtext, "ii", color1, color2)) return SCM(playerid, Color_White, "[��ͨ����] ��ʽ:/cc ��ɫ ��ɫ");
    if(color1 < 0 || color1 > 255) return SCM(playerid, Color_White, "[��ͨ����] ������ɫ���룬������ɫ����Ϊ0-255"); {
        ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
        SCM(playerid, Color_White, "[��ͨ����] ������˳�������ɫ��");
    }
    return 1;
}

// CMD:ww(const playerid, const cmdtext[]) { //2020.3.9����
//     // 2020.3.15�޸�����ר�����粻����ؾ߷Ž�ȥ������
//     if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), playerid + 1);
//     SetPlayerVirtualWorld(playerid, playerid + 1);
//     SCM(playerid, Color_Orange, "[ϵͳ] ����������ר������.");
//     for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//         if(IsPlayerConnected(i)) {
//             if(PlayerInfo[i][tvid] == playerid && i != playerid) {
//                 SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
//                 SetPlayerInterior(i, GetPlayerInterior(playerid));
//                 if(IsPlayerInAnyVehicle(i)) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
//                 else PlayerSpectatePlayer(i, playerid);
//                 SCM(i, Color_Orange, "[TV]:�Է��л������磬�Զ�׷�ٹۿ�.");
//             }
//         }
//     }
//     return 1;
// }
CMD:pos(const playerid, const cmdtext[]) {
    new Float:x, Float:y, Float:z, str[128];
    GetPlayerPos(playerid, x, y, z);
    format(str, 128, "[ϵͳ] ��Ŀǰ������Ϊ X:%f, Y:%f, Z:%f", x, y, z);
    SCM(playerid, Color_LightBlue, str);
    if(IsPlayerInAnyVehicle(playerid)) {
        new Float:angle = 0.0;
        GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        format(str, 128, "[ϵͳ] ��ĳ���Z�Ƕ�Ϊ%f", angle);
        SCM(playerid, Color_LightBlue, str);
    } else {
        new Float:angle = 0.0;
        GetPlayerFacingAngle(playerid, angle);
        format(str, 128, "[ϵͳ] ������ﳯ��Ƕ�Ϊ%f", angle);
        SCM(playerid, Color_LightBlue, str);
    }
    return 1;
}
CMD:wudi(const playerid, const cmdtext[]) { //����޵�
    if(!PlayerInfo[playerid][enableInvincible]) {
        SCM(playerid, 0x0FFF00FF, "[�޵�]�㿪�����޵�״̬,�ٴ�����/wudi�ر�");
        SetPlayerHealth(playerid, 999999999);
        PlayerInfo[playerid][enableInvincible] = 1;
    } else {
        SCM(playerid, 0x0FFF00FF, "[�޵�]��ر����޵�״̬,�ٴ�����/wudi����");
        SetPlayerHealth(playerid, 100);
        PlayerInfo[playerid][enableInvincible] = 0;
    }
    return 1;
}
CMD:hys(const playerid, const cmdtext[]) { //������ɫ��
    if(PlayerInfo[playerid][hys]) {
        PlayerInfo[playerid][hys] = false;
        SendClientMessage(playerid, Color_White, "[ϵͳ*]�رճ����Զ���ɫ");
    } else {
        PlayerInfo[playerid][hys] = true;
        SendClientMessage(playerid, Color_White, "[ϵͳ*]���������Զ���ɫ");
    }
    return 1;
}
CMD:infobj(const playerid, const cmdtext[]) { //�̳�dylanʱ���������ľ���
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, 0x0088FFFF, "[infobj] �㲻�ڳ���!");
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);
    if(dinfobj[playerid] == 0) {
        dinfobj[playerid] = 1;
        jd[playerid] = CreateDynamicObject(1001, pX, pY, pZ, 0.0, 0.0, 0.0, -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1);
        wy[playerid] = CreateDynamicObject(18646, pX, pY, pZ, 0.0, 0.0, 0.0, -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1);
        AttachDynamicObjectToVehicle(jd[playerid], GetPlayerVehicleID(playerid), -0.05, -2.35, 0.3099, 0, 0, 0);
        AttachDynamicObjectToVehicle(wy[playerid], GetPlayerVehicleID(playerid), -0.48, 0.28, 0.7099, 0, 0, 0);
        // AttachObjectToVehicle(jd[playerid], GetPlayerVehicleID(playerid), -0.05, -2.35, 0.3099, 0, 0, 0);
        // AttachObjectToVehicle(wy[playerid], GetPlayerVehicleID(playerid), -0.48, 0.28, 0.7099, 0, 0, 0);
        SCM(playerid, 0x0088FFFF, "[infobj] ������������INFOBJ");
    } else {
        dinfobj[playerid] = 0;
        DestroyDynamicObject(jd[playerid]); //���پ���
        DestroyDynamicObject(wy[playerid]); //����β��
        // DestroyObject(jd[playerid]);
        // DestroyObject(wy[playerid]);
        SCM(playerid, 0x0088FFFF, "[infobj] �������ɾȥ��INFOBJ");
    }
    return 1;
}
CMD:vmake(const playerid, const cmdtext[]) { //��Ҵ�������
    if(PlayerInfo[playerid][Score] < 30) return SCM(playerid, 0xFFFF00FF, "[����] Ϊ��ֹ��ҹ��Ƚ������͵㣬��ʱ��ִﵽ30�����ϲſɴ���.");
    if(PlayerInfo[playerid][Cash] < 30) return SCM(playerid, 0xFFFF00FF, "[����] ��Ҫ30��Ҵ���һ�δ��͵�.");
    new tmp[48];
    // tmp = strtok(cmdtext, idx);
    if(sscanf(cmdtext, "s[48]", tmp)) return SCM(playerid, 0xFFFF00FF, "[����] �÷�:/vmake [�����ǳ�,���ô�'/'] ����/vmake sf");
    if(strlen(tmp) >= 48) return SCM(playerid, 0xFFFF00FF, "[����] ���ֹ���������֧��48λӢ��/���ֻ�24λ����");
    if(make_findgo(tmp) != -1) return SCM(playerid, 0xFFFF00FF, "[����] �ô��͵��Ѿ�������.");
    new sb = make_getindex();
    if(sb == -1) return SCM(playerid, 0xFFFF00FF, "[����] ���͵��Ѵﵽ����.");
    pVmakePos(playerid, sb, tmp);
    return 1;
}
CMD:vsmake(const playerid, const cmdtext[]) { //����Ա����ϵͳ����
    if(PlayerInfo[playerid][AdminLevel] < 4) return 0;
    if(PlayerInfo[playerid][Cash] < 1000) return SCM(playerid, 0xFFFF00FF, "[����] ��Ҫ1000��Ҵ���һ��ϵͳ���͵�.");
    new tmp[48], describe[48];
    if(sscanf(cmdtext, "s[48]s[48]", tmp, describe)) return SCM(playerid, 0xFFFF00FF, "[����] �÷�:/vsmake [�����ǳ�,���ô�'/'] [����<���ɴ��ո�,����ᱻ��>] ����/vsmake sf SF����");
    if(strlen(tmp) >= 48) return SCM(playerid, 0xFFFF00FF, "[����] ���ֹ���������֧��48λӢ��/���ֻ�32λ����");
    if(strlen(describe) >= 48) return SCM(playerid, 0xFFFF00FF, "[����] ��������������֧��48λӢ��/���ֻ�32λ����");
    if(strfind(describe, "{", true) != -1 || strfind(describe, " ", true) != -1 || strfind(describe, "}", true) != -1) {
        SCM(playerid, 0xFFFF00FF, "[����] �����в��ɴ��ո�������ַ�");
        return 1;
    }
    if(strfind(describe, "[", true) != -1 || strfind(describe, "]", true) != -1) {
        SCM(playerid, 0xFFFF00FF, "[����] �����в��ɴ��ո�������ַ�");
        return 1;
    }
    if(make_Sysfindgo(tmp) != -1) return SCM(playerid, 0xFFFF00FF, "[����] ��ϵͳ���͵��Ѿ�������.");
    new sb = make_sysgetindex();
    if(sb == -1) return SCM(playerid, 0xFFFF00FF, "[����] ϵͳ���͵��Ѵﵽ����.");
    pVmakeSysPos(playerid, sb, tmp, describe);
    new str[96];
    format(str, sizeof(str), "[����Ա] %s ������ϵͳ���͵� %s. ", GetName(playerid), tmp);
    SCMToAdmins(0x0066FFFF, str);
    GivePlayerCash(playerid, -1000);
    return 1;
}

//���������tpa
CMD:tpa(const playerid, const cmdtext[]) {
    new id, tmp[128], idx;
    tmp = strtok(cmdtext, idx);
    if(strcmp(tmp, "ban", true) == 0) {
        if(tpaB[playerid] == 3) {
            tpaB[playerid] = 0;
            SCM(playerid, Color_White, "[tp]���ѹر�tpa�������迪�����ٴ�����!");
            return 1;
        }
        tpaB[playerid] = 3;
        SCM(playerid, Color_White, "[tp]���ѿ���tpa��������ر����ٴ�����!");
        return 1;
    }
    if(sscanf(cmdtext, "i", id)) return SCM(playerid, 0x99FFFFAA, "[tp] ��ʹ��:/tpa ID");
    if(IsPlayerNPC(id)) return SCM(playerid, 0x99FFFFAA, "[tp] ����tpa��NPC���");
    if(PlayerInfo[id][Login] != true) return SCM(playerid, 0x99FFFFAA, "[tp] �Է���δ���ߣ�");
    if(tpaB[id] == 1) return SCM(playerid, 0x99FFFFAA, "[tp] {FFA8FF}�Է����ڿ��Ǳ��˵Ĵ�������.");
    if(tpaB[id] == 2) return SCM(playerid, 0x99FFFFAA, "[tp] {FFA8FF}���������͵�����������.");
    if(tpaB[id] == 3) return SCM(playerid, 0x99FFFFAA, "[tp] {FFA8FF}�Է��Ѿ������˴���������Ϣ.");
    if(playerid == id) return SCM(playerid, 0xFFFFFFFFF, "[tp] �㲻��tpa���Լ�");
    tpaid[playerid] = id;
    tpaid[id] = playerid;
    tpaB[id] = 1;
    tpaB[playerid] = 2;
    format(tmp, sizeof(tmp), "[tp] �������͵� {FFFFFF}%s(%d)���,��ȴ��ظ�.", GetName(id), id);
    SCM(playerid, 0x99FFFFAA, tmp);
    format(tmp, sizeof(tmp), "[tp] һ��TPA�������� %s(%d) /taͬ�� /td �ܾ�", GetName(playerid), playerid);
    SCM(id, 0x99FFFFAA, tmp);
    SCM(id, 0x99FFFFAA, "[tp] ����{00FF80}����{FFFF00}/{FF0000}ȡ��{FFFFFF}����ģʽ,/tpa ban");
    GameTextForPlayer(id, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Player want to move ~r~you~w~.", 3000, 3);
    tpatime[playerid] = SetTimerEx("tpaTimer", 60000, false, "i", playerid);
    tpatime[id] = SetTimerEx("tpaTimer", 60000, false, "i", id);
    return 1;
}
CMD:tp(const playerid, const cmdtext[]) return cmd_tpa(playerid, cmdtext);
CMD:ta(const playerid, const cmdtext[]) {
    if(tpaB[playerid] == 1) {
        new Float:x, Float:y, Float:z, Float:Angle;
        new id = tpaid[playerid];
        if(pRaceing[id]) {
            tpaB[playerid] = 0;
            tpaB[id] = 0;
            KillTimer(tpatime[playerid]);
            KillTimer(tpatime[id]);
            tpaid[playerid] = -1;
            tpaid[id] = -1;
            return SendClientMessage(playerid, 0x99FFFFAA, "�Է�������������,���ܽ���TP");
            //2020.2.20����
        }
        GetPlayerPos(playerid, x, y, z);
        if(IsPlayerInAnyVehicle(tpaid[playerid])) {
            GetVehicleZAngle(GetPlayerVehicleID(tpaid[playerid]), Angle);
        } else GetPlayerFacingAngle(tpaid[playerid], Angle);
        if(IsPlayerInAnyVehicle(tpaid[playerid])) {
            SetVehiclePos(GetPlayerVehicleID(tpaid[playerid]), x + 3, y + 1, z);
            LinkVehicleToInterior(GetPlayerVehicleID(tpaid[playerid]), GetPlayerInterior(tpaid[playerid]));
            SetVehicleZAngle(GetPlayerVehicleID(tpaid[playerid]), Angle);
            SCM(playerid, 0x99FFFFAA, "[tp] ��ɹ�������tpa����");
            SCM(tpaid[playerid], 0x99FFFFAA, "[tp] ���Ѵ��͵�Ta��ߣ����Ta����С���磬��˽��Ta.");
            tpaB[playerid] = 0;
            tpaB[id] = 0;
            KillTimer(tpatime[playerid]);
            KillTimer(tpatime[id]);
            tpaid[playerid] = -1;
            tpaid[id] = -1;
        } else {
            SetPlayerPos(tpaid[playerid], x + 3, y + 1, z);
            SetPlayerFacingAngle(tpaid[playerid], Angle);
            SCM(playerid, 0x99FFFFAA, "[tp] ��ɹ�������tpa����");
            SCM(tpaid[playerid], 0x99FFFFAA, "[tp] ���Ѵ��͵�Ta��ߣ����Ta����С���磬��˽��Ta.");
            KillTimer(tpatime[playerid]);
            KillTimer(tpatime[id]);
            tpaB[playerid] = 0;
            tpaB[id] = 0;
            tpaid[playerid] = -1;
            tpaid[id] = -1;
        }
    } else {
        SCM(playerid, 0x99FFFFAA, "[tp] �㵱ǰû��tpa��������");
    }
    return 1;
}
CMD:td(const playerid, const cmdtext[]) {
    new id = tpaid[playerid];
    if(tpaB[playerid] == 1) {
        tpaB[playerid] = 0;
        tpaB[id] = 0;
        tpaid[playerid] = -1;
        tpaid[id] = -1;
        SCM(playerid, Color_Red, "[tp] ��ܾ��˶Է�����!");
        SCM(tpaid[playerid], Color_Red, "[tp] �Է��ܾ����������!");
        KillTimer(tpatime[playerid]);
        KillTimer(tpatime[id]);
    } else {
        SCM(playerid, Color_Red, "[tp] ��ʱû�д�������!");
        KillTimer(tpatime[playerid]);
        KillTimer(tpatime[id]);
        tpaB[playerid] = 0;
        tpaB[id] = 0;
        tpaid[playerid] = -1;
        tpaid[id] = -1;
    }
    return 1;
}
//����/�ر���ʾ�������
// CMD:name(const playerid, const cmdtext[]) {
//     new tmp[128];
//     if(sscanf(cmdtext, "s[128]", tmp)) return SCM(playerid, Color_White, "[ϵͳ]/name on���� off�ر�");
//     if(strcmp(tmp, "off", true) == 0) {
//         for (new i = GetPlayerPoolSize(); i >= 0; i--) 
//         {
//             ShowPlayerNameTagForPlayer(playerid, i, false);
//         }
//         SCM(playerid, Color_White, "[ϵͳ] �����������������.");
//         return 1;
//     }
//     if(strcmp(tmp, "on", true) == 0) {
//         // for (new i = GetPlayerPoolSize(); i != -1; --i) {
//         for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//             ShowPlayerNameTagForPlayer(playerid, i, true);
//         }
//         SCM(playerid, Color_White, "[ϵͳ] ����ʾ�����������.");
//         return 1;
//     }
//     return 1;
// }
//��ҹ�սϵͳ
CMD:tv(const playerid, const cmdtext[]) {
    new tmp[128];
    if(sscanf(cmdtext, "s[128]", tmp)) {
        SCM(playerid, Color_Orange, "[TV] |____________TV������___________|");
        SCM(playerid, Color_Orange, "[TV] |ʹ��:/tv [ID] �������          |");
        SCM(playerid, Color_Orange, "[TV] |��ʾ:/tv off  �رռ���          |");
        return 1;
    }
    if(strcmp(tmp, "off", true) == 0) {
        if(!PlayerInfo[playerid][tvzt]) return SCM(playerid, Color_Orange, "[TV]:������û����TV״̬�£�");
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawHide(playerid, velo[PlayerInfo[playerid][tvid]][a]);
        }
        if(PlayerInfo[playerid][speedoMeter]) {
            for (new a = 0; a <= 21; a++) {
                PlayerTextDrawShow(playerid, velo[playerid][a]);
            }
        }
        if(pRaceing[PlayerInfo[playerid][tvid]]) {
            PlayerTextDrawHide(playerid, CpTextDraw[PlayerInfo[playerid][tvid]]);
            PlayerTextDrawHide(playerid, Time[PlayerInfo[playerid][tvid]]);
            PlayerTextDrawHide(playerid, Top[PlayerInfo[playerid][tvid]]);
        }
        Race_HideCp(playerid);
        TogglePlayerSpectating(playerid, false);
        SetPlayerVirtualWorld(playerid, 0);
        SCM(playerid, Color_Orange, "[TV] ��ر���TV.");
        PlayerInfo[playerid][tvzt] = false;
        PlayerInfo[playerid][tvid] = playerid;
        return 1;
    }
    new id = strval(tmp);
    if(id == playerid) return SCM(playerid, Color_Orange, "[TV]:�㲻�ܹۿ����Լ�!");
    if(!IsPlayerNPC(id) && !IsPlayerConnected(id)) return SCM(playerid, Color_Orange, "[TV]:����!�Է�δ��¼");
    if(PlayerInfo[id][tvzt]) return SCM(playerid, Color_Orange, "[TV]:�Է������ڹ�ս״̬!");
    for (new a = 0; a <= 21; a++) {
        //TextDrawHideForPlayer(playerid, velo[playerid][a]);//2020.1.12��
        PlayerTextDrawHide(playerid, velo[PlayerInfo[playerid][tvid]][a]);
        // TextDrawHideForPlayer(playerid, velo[playerid][a]); //��������Լ����ٶȱ� �����������Ǿ仰Ҳû���� �������������ȡ��ע��
    }
    if(PlayerInfo[playerid][speedoMeter]) {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawShow(playerid, velo[id][a]); //��ʾ��ҹۿ�������ٶȱ�
        }
    }
    if(!PlayerInfo[playerid][tvzt]) SCM(playerid, Color_Orange, "[TV] ��ʾ:'/tv off' �رյ��ӻ�");
    PlayerTextDrawHide(playerid, CpTextDraw[PlayerInfo[playerid][tvid]]);
    PlayerTextDrawHide(playerid, Time[PlayerInfo[playerid][tvid]]);
    PlayerTextDrawHide(playerid, Top[PlayerInfo[playerid][tvid]]);
    if(pRaceing[id]) {
        PlayerTextDrawShow(playerid, CpTextDraw[id]);
        PlayerTextDrawShow(playerid, Time[id]);
        PlayerTextDrawShow(playerid, Top[id]);
        Race_ShowCp(playerid, GameRace[id][rgameid], GameRace[id][rgamecp]);
    }
    TogglePlayerSpectating(playerid, true);
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
    SetPlayerInterior(playerid, GetPlayerInterior(id));
    PlayerInfo[playerid][tvzt] = true; //�������TV״̬Ϊ��
    PlayerInfo[playerid][tvid] = id;
    if(IsPlayerInAnyVehicle(id)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
    else PlayerSpectatePlayer(playerid, id);
    return 1;
}



//����ʱ�ο�����7F�Ĺ���Ա�ű�
CMD:adminhelp(const playerid, const cmdtext[]) {
    if(!PlayerInfo[playerid][AdminLevel]) return 0;
    ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����Աָ���ȫ", "LV1\nLV2\nLV3\nLV4\nLV5\nLV?", "ȷ��", "����");
    new str[96];
    format(str, sizeof(str), "[����Ա] %s ʹ���� /AdminHelp. ", GetName(playerid));
    SCMToAdmins(0x0066FFFF, str);
    return 1;
}
CMD:goto(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new str[128], Float:x, Float:y, Float:z, id;
    if(sscanf(cmdtext, "i", id)) return SCM(playerid, Color_Red, "[ϵͳ] �������ID!");
    if(!PlayerInfo[id][Login]) return SCM(playerid, Color_Red, "[ϵͳ] ��������δ��¼.");
    format(str, sizeof(str), "[����Ա] %s ʹ���� /Goto. ", GetName(playerid));
    SCMToAdmins(0x0066FFFF, str);
    GetPlayerPos(id, x, y, z);
    if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z + 0.35);
    else SetPlayerPos(playerid, x, y, z + 0.35);
    AdminCommandRecord(playerid, "goto", str);
    return 1;
}
CMD:get(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new id, str[128], Float:x, Float:y, Float:z;
    if(sscanf(cmdtext, "i", id)) return SCM(playerid, Color_Red, "[ϵͳ] �������ID!");
    if(IsPlayerConnected(id) == 0) return SCM(playerid, Color_Red, "[ϵͳ] �������ID!");
    if(PlayerInfo[id][Login] == false) return SCM(playerid, Color_Red, "[ϵͳ] ��������δ��¼.");
    if(pRaceing[id]) return SendClientMessage(playerid, 0x99FFFFAA, "�Է�������������,����Get");
    format(str, sizeof(str), "[����Ա] %s ʹ���� Get. ", GetName(playerid));
    SCMToAdmins(0x0066FFFF, str);
    GetPlayerPos(playerid, x, y, z);
    if(IsPlayerInAnyVehicle(id)) SetVehiclePos(GetPlayerVehicleID(id), x, y, z + 0.35);
    else SetPlayerPos(id, x, y, z + 0.35);
    return 1;
}
CMD:givecash(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 4)) return 0;
    new id, cash, reason[64], str[96];
    if(sscanf(cmdtext, "iis[64]", id, cash, reason)) return SCM(playerid, Color_Red, "[ϵͳ] �÷�:/giveplayercash [���ID] [��Ǯ] [ԭ��]");
    if(PlayerInfo[id][Login] == false) return SCM(playerid, Color_Red, "[ϵͳ] ��������δ��¼.");
    if(cash < 1 || cash > 2000) return SCM(playerid, Color_Red, "[ϵͳ] ��Ǯ������������.");
    format(str, sizeof(str), "[ϵͳ]%s(LV%d) ������� %s (%d��Ǯ),ԭ��:%s", GetName(playerid), PlayerInfo[playerid][AdminLevel], GetName(id), cash, reason);
    SCMALL(Color_Red, str);
    format(str, sizeof(str), "[����Ա] %s ʹ�������� GivePlayerCash. ", GetName(playerid));
    SCMToAdmins(0x0066FFFF, str);
    AdminCommandRecord(playerid, "GivePlayerCash", reason);
    GivePlayerCash(id, cash);
    return 1;
}
CMD:selectnpc(const playerid, const cmdtext[]) {
    new content[1500];
    format(content, sizeof(content), "1.�״�վNPC\n\
                                    2.SF����NPC\n\
                                    3.LSɽ��NPC\n\
                                    4.LS����NPC\n\
                                    5.���н���ԽҰNPC\n\
                                    6.SF˫��NPC\n\
                                    7.�ۺ�NPC - FollowMe\n\
                                    8.�ۺ�NPC - FollowMe2");
    ShowPlayerDialog(playerid, NPC_DIALOG_ID, DIALOG_STYLE_LIST, "��ѡ��һ��NPC, Ȼ���㽫�ᱻ���͵���Ӧ��NPC�ĳ���.", content, "ȷ��", "ȡ��");
    return 1;
}
CMD:showname(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 4)) return 0;
    if(NPCNameShow) {
        for (new i = 0; i < sizeof(textid); i++) {
            DestroyDynamic3DTextLabel(textid[i]);
        }
        NPCNameShow = false;
        SendClientMessage(playerid, Color_Green, "[��ʾ:] NPC������ʾ�ѹر�.");
    } else {
        new str[50];

        //Drifter-LDZ
        format(str, sizeof(str), "Drifter-LDZ\n(ID:%d)", playerid);
        textid[0] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[0]);

        //Dirfter-SF Two Circles
        format(str, sizeof(str), "Drifter-SF Two Circles\n(ID:%d)", playerid);
        textid[1] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[1]);
        //Drifter-RunInMadd
        format(str, sizeof(str), "Drifter-RunInMadd\n(ID:%d)", playerid);
        textid[2] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[2]);
        //Drifter-LSEyeOut
        format(str, sizeof(str), "Drifter-LSEyeOut\n(ID:%d)", playerid);
        textid[3] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[3]);
        //Drifter-SFTestDrive
        format(str, sizeof(str), "Drifter-SFTestDrive\n(ID:%d)", playerid);
        textid[4] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[4]);
        //Drifter-OffControl(Rally)
        format(str, sizeof(str), "Drifter-OffControl(Rally)\n(ID:%d)", playerid);
        textid[5] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[5]);
        //Drifter-FM
        format(str, sizeof(str), "Drifter-FollowMe\n(ID:%d)", playerid);
        textid[6] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[6]);
        //Drifter-FM2
        format(str, sizeof(str), "Drifter-FollowMe2\n(ID:%d)", playerid);
        textid[7] = CreateDynamic3DTextLabel(str, Color_Green, 0.0, 0.0, 0.0, 15.0, INVALID_PLAYER_ID, npcCars[7]);
        NPCNameShow = true;
        SendClientMessage(playerid, Color_Green, "[��ʾ:] NPC������ʾ�ѿ���.");
    }
    return 1;
}
CMD:kick(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new id, reason[64], str[128];
    if(sscanf(cmdtext, "is[64]", id, reason)) return SCM(playerid, Color_Red, "[ϵͳ] �÷�:/kick [���ID] [ԭ��]");
    if(IsPlayerConnected(id) == 0 || IsPlayerNPC(id)) return SCM(playerid, Color_Red, "[ϵͳ] �������ID!��ҪT������NPC");
    SetTimerEx("KickEx", 200, false, "i", id);
    format(str, sizeof(str), "[ϵͳ]%s(LV%d) �� %s �߳��˷�����,ԭ��:%s", GetName(playerid), PlayerInfo[playerid][AdminLevel], GetName(id), reason);
    SCMALL(Color_Red, str);
    format(str, sizeof(str), "[����Ա] %s ʹ�������� Kick. ", GetName(playerid));
    SCMToAdmins(0x0066FFFF, str);
    AdminCommandRecord(playerid, "Kick", reason);
    return 1;
}
CMD:reset(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 5)) return 0;
    new pname[24], pPassWord[16];
    if(sscanf(cmdtext, "s[24]s[64]", pname, pPassWord)) return SCM(playerid, Color_Red, "[ϵͳ] �÷�:/reset �û��� ����");
    if(strlen(pPassWord) > 16 || strlen(pPassWord) < 6) return SCM(playerid, Color_Red, "[ϵͳ] ���볤�ȴ���,����6~16λ");
    if(strcmp(pname, GetName(playerid), true) == 0) return SCM(playerid, Color_Red, "[ϵͳ] �����������Լ����˻�,���������ǰ����ȫ����");
    if(!AccountCheck(pname)) return SCM(playerid, Color_Red, "[ϵͳ] �������õ��û�������");
    OnPlayerResetPassword(playerid, pname, pPassWord);
    new str[96];
    format(str, sizeof(str), "[����Ա] %s ʹ����������%s���˻�����. ", GetName(playerid), pname);
    SCMToAdmins(0x0066FFFF, str);
    AdminCommandRecord(playerid, "resetPassWord", str);
    return 1;
}
CMD:gmx(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 5)) return 0;
    SCMALL(Color_Red, "[ϵͳ] ����ˢ�·����������ڱ������������...");
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(PlayerInfo[i][Login] == true) { //�����������
            SavePlayerInfo(i);
            // new msg[512], string[96], saveinfo[512];
            // new h = 0, m = 0, s = 0, n = 0, y = 0, day = 0;
            // gettime(h, m, s), getdate(n, y, day); //��һ��Ҫʵʱ���û�ͬ��
            // format(string, sizeof(string), "%d-%d-%d %02d:%02d:%02d", n, y, day, h, m, s);
            // strins(saveinfo, "UPDATE `Users` SET `AdminLevel` = %d,`Skin` = %d,`Score` = %d,`Cash` = %d,`JailSeconds` = %d,`Yzwrong` = %d,`YzBantime` = %d,`LastLogin` = '%s',`Designation` = '%s',Tail = '%s' WHERE `Name` = '%s'", strlen(saveinfo));
            // format(msg, sizeof(msg), saveinfo, PlayerInfo[i][AdminLevel], PlayerInfo[i][Skin], PlayerInfo[i][Score], PlayerInfo[i][Cash], PlayerInfo[i][JailSeconds], PlayerInfo[i][yzwrong], PlayerInfo[i][yzbantime], string, PlayerInfo[i][Designation], PlayerInfo[i][Tail], GetName(i));
            // db_free_result(db_query(user, msg));
        }
    }
    // SCMALL(Color_Red, "[ϵͳ] ������ݱ�����ϣ���ʼ����������..");
    SendRconCommand("gmx");
    // RestartDjs = 0;//��������ʱ
    // SetTimer("RestartServerDjs",1000,0);
    return 1;
}
CMD:jail(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new id, reason[64];
    if(sscanf(cmdtext, "is[64]", id, reason)) return SCM(playerid, Color_Red, "[ϵͳ] �÷�:/jail [���ID] [ԭ��]");
    if(IsPlayerConnected(id) == 0) return SCM(playerid, Color_Red, "[ϵͳ] �������ID!");
    if(PlayerInfo[id][JailSeconds] > 0) return SCM(playerid, Color_Red, "[ϵͳ] ��������ڼ�����!");
    PlayerInfo[id][JailSeconds] = 60;
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    new msg[128];
    format(msg, sizeof(msg), "UPDATE `Users` SET `JailSeconds` = %d WHERE `Name` = '%s'", 60, GetName(id));
    db_free_result(db_query(user, msg));
    format(msg, sizeof(msg), "[ϵͳ] %s (LV%d)�� %s �ؽ��˼���,�Ժ��Զ��ų�,ԭ��:%s", GetName(playerid), PlayerInfo[playerid][AdminLevel], GetName(id), reason);
    SCMALL(Color_Red, msg);
    SCM(id, Color_Red, "[ϵͳ] Ϊ�˲�Ӱ���������������Ϸ,�����ܵ�����Ա�ͷ�,1���Ӻ󽫷ų�����!");
    format(msg, sizeof(msg), "[����Ա] %s ʹ�������� Jail. ", GetName(playerid));
    SCMToAdmins(0x0066FFFF, msg);
    AdminCommandRecord(playerid, "Jail", reason);
    return 1;
}
CMD:kgobj(const playerid, const cmdtext[]) {
    // new Float:pX, Float:pY, Float:pZ;
    // GetPlayerPos(playerid, pX, pY, pZ);
    if(PlayerInfo[playerid][displayObject]) {
        PlayerInfo[playerid][displayObject] = 0;
        Streamer_UpdateEx(playerid, 0, 0, -50000);
        // Streamer_UpdateEx(playerid, 0, 0, 3343077376, 4294967295, 4294967295);
        Streamer_ToggleItemUpdate(playerid, 0, 0);
        SendClientMessage(playerid, 0xFFFFFFFF, "[ϵͳ]:��ر��˵�ͼģ��,�ٴ����뿪��");
    } else {
        PlayerInfo[playerid][displayObject] = 1;
        // Streamer_UpdateEx(playerid, 0.0, 0.0, -50000.0);
        // Streamer_UpdateEx(playerid, pX, pY, pZ);
        Streamer_UpdateEx(playerid, 0, 0, -50000);
        Streamer_ToggleItemUpdate(playerid, 0, 1);
        SendClientMessage(playerid, 0xFFFFFFFF, "[ϵͳ]:�㿪���˵�ͼģ��,�ٴ�����ر�");
    }
    return 1;
}
CMD:giveadmin(const playerid, const cmdtext[]) {
    if(!IsPlayerAdmin(playerid)) return 0;
    new level, name[64];
    if(sscanf(cmdtext, "s[64]i", name, level)) return SCM(playerid, Color_Red, "[ϵͳ] �÷�:/giveadmin [����ǳ�] [GM�ȼ�]");
    if(AccountCheck(name)) {
        new msg[128];
        if(level < 1 || level > 5) return SCM(playerid, Color_Red, "[ϵͳ] GM�ȼ���Ч��ΧΪ1-5��");
        format(msg, sizeof(msg), "UPDATE `Users` SET AdminLevel = %d WHERE `Name` = '%s'", level, name);
        db_free_result(db_query(user, msg));
        format(msg, sizeof(msg), "[ϵͳ] %s ���� %s Ϊ GM{FFFF00}%d��", GetName(playerid), name, level);
        for (new i = GetPlayerPoolSize(); i >= 0; i--) { //2020.2.9�޸� //2020.2.27�ٴθ���
            if(strcmp(GetName(i), name, true) == 0) {
                PlayerInfo[i][AdminLevel] = level;
                break;
            }
        }
        // PlayerInfo[playerid][AdminLevel] = level; //2020.2.9�������� ��Ӧ����playerid ������Ҳû��id��
        SCMALL(Color_Red, msg);
        AdminCommandRecord(playerid, "GiveAdmin", "��GM");
        return 1;
    } else {
        SCM(playerid, Color_Red, "[ϵͳ] ������ǳƲ�����!");
    }
    return 1;
}
CMD:unadmin(const playerid, const cmdtext[]) {
    if(!IsPlayerAdmin(playerid)) return 0;
    new tmp[128];
    if(sscanf(cmdtext, "s[128]", tmp)) return SCM(playerid, Color_Red, "[ϵͳ] �÷�:/unadmin [����ǳ�]");
    if(AccountCheck(tmp)) {
        new msg[256];
        format(msg, sizeof(msg), "UPDATE `Users` SET `AdminLevel` = 0 WHERE `Name` = '%s'", tmp);
        db_free_result(db_query(user, msg));
        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
            if(strcmp(GetName(i), tmp, true) == 0) PlayerInfo[i][AdminLevel] = 0;
            break;
        }
        format(msg, sizeof(msg), "[ϵͳ] %s ȡ���� %s��GM", GetName(playerid), tmp);
        SCMALL(Color_Red, msg);
        AdminCommandRecord(playerid, "UnGiveAdmin", "ȡ��GM");
    } else {
        SCM(playerid, Color_Red, "[ϵͳ] ������ǳƲ�����!");
    }
    return 1;
}
CMD:ban(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 2)) return 0;
    ShowPlayerDialog(playerid, Ban_Choose, DIALOG_STYLE_INPUT, "Ban", "{FFFFFF}������:{33CCCC}Ҫ��ɱ�����{FF0000}����", "ȷ��", "ȡ��");
    return 1;
}
CMD:unban(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 2)) return 0;
    ShowPlayerDialog(playerid, Ban_Choose + 3, DIALOG_STYLE_INPUT, "Ban", "{FFFFFF}������:{33CCCC}Ҫ�������{FF0000}����", "ȷ��", "ȡ��");
    return 1;
}

//�Ҿ�ϵͳ
CMD:creategoods(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AdminLevel] < 4) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�ϵͳ]:��Ĺ���ԱȨ�޵ȼ�����.");
    //Create String to store in local values
    new modelid, seprice, Float:x, Float:y, Float:z;
    if(sscanf(cmdtext, "ii", modelid, seprice)) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�ϵͳ]:{FF0000}/creategoods{37FF00} [objid] [�۸�]");
    GetPlayerPos(playerid, x, y, z);
    new GID;
    GID = getAvailableGoodsID();
    GOODS[GID][GoodTaken] = 1;
    format(GOODS[GID][GoodOwner], 65, "N/A");
    format(GOODS[GID][GoodName], 65, "N/A");
    GOODS[GID][GoodObjid] = modelid;
    GOODS[GID][GoodPrize] = seprice;
    GOODS[GID][GoodX] = x + 1;
    GOODS[GID][GoodY] = y + 1;
    GOODS[GID][GoodZ] = z;
    GOODS[GID][GoodRX] = 0;
    GOODS[GID][GoodRY] = 0;
    GOODS[GID][GoodRZ] = 0;
    GOODS[GID][Key] = 0;
    GOODS[GID][WID] = GetPlayerVirtualWorld(playerid);
    GOODS[GID][issale] = true;
    GOODS[GID][topublic] = true;
    CreateGoods(GID);
    new tester[125];
    format(tester, sizeof(tester), "[�Ҿ�ϵͳ]�㴴���˷�����[ID %d ]�ļҾ� [Objid %d][�۸� %d]", GID, GOODS[GID][GoodObjid], GOODS[GID][GoodPrize]);
    SendClientMessage(playerid, 0xFF0000C8, tester);
    //Save it
    SaveGoods(GID);
    return 1;
}
CMD:delgoods(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AdminLevel] < 4) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�ϵͳ]:��Ĺ���ԱȨ�޵ȼ�����.");
    new deid;
    if(sscanf(cmdtext, "i", deid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�]{FF0000}/delgoods{37FF00} [ID]");
    if(deid < 0) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�]{FF0000} ID����Ϊ����!");
    if(GOODS[deid][GoodTaken] != 1) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�]�����*�Ҿ�*ID");
    new tester[125];
    format(tester, sizeof(tester), "[�Ҿ�]���Ѿ�ɾ���˼Ҿ�ID[%d] OBJID[%d]", deid, GOODS[deid][GoodObjid]);
    DelGoods(deid); //2020.2.11�޸� ԭ�������˳������� ����OBJIDһֱ��0 ��Ϊɾ����OBJID�Ǹ�����ͱ���0��
    SendClientMessage(playerid, 0xFF0000C8, tester);
    return 1;
}
CMD:gogoods(const playerid, const cmdtext[]) {
    // new gid, tmp[128]; //create string to store values
    new gid;
    if(sscanf(cmdtext, "i", gid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�]{FF0000}/gogoods{37FF00} [ID]");
    if(GOODS[gid][GoodTaken] != 1) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�]���󣡼Ҿ�ID�����ڣ�");
    // gid = strval(tmp);
    // GOODS[gid][OrderId] = strval(tmp); //2020.2.9?0?4?0?7?0?0?0?7gogoods?0?8?��?0?4?��
    //create float
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(GOODS[gid][OrderId], x, y, z);
    SetPlayerPos(playerid, x, y, z);
    SetPlayerVirtualWorld(playerid, GOODS[gid][WID]);
    new tester[125];
    format(tester, sizeof(tester), "[�Ҿ�]���Ѿ����͵��˼Ҿ�ID %d  %d", gid, GOODS[gid][OrderId]);
    SendClientMessage(playerid, 0xFF0000C8, tester);
    return 1;
}
CMD:resetgoods(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AdminLevel] < 4) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�ϵͳ]:��Ĺ���ԱȨ�޵ȼ�����.");
    new count = 0;
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if(GOODS_STATUS[i] == true) {
            ResetGoods(playerid, i);
            count++;
        }
    }
    new tester[125];
    format(tester, sizeof(tester), "[�Ҿ�]���мҾ� %d ����������", count);
    SendClientMessage(playerid, 0xFF0000C8, tester);
    return 1;
}
CMD:mygoods(const playerid, const cmdtext[]) {
    new GOODS_LIST[1000], title[256], tocount, youcount;
    strcat(GOODS_LIST, "{80FF80}[��ƷID]\t[��Ʒ����]\n");
    for (new i = 0; i < MAX_GOODS; i++) {
        if(GOODS[i][GoodTaken] == 1) {
            tocount++;
            if(!strcmp(GOODS[i][GoodOwner], GetName(playerid), true)) {
                new
                var [125];
                youcount++;
                //format(GOODS_LIST,sizeof(GOODS_LIST),"\n{80FF80}%s			%d\n",GOODS[i][GoodName],i);
                format(var, 1000, "ID:%d\t{80FF80}%s\n", i, GOODS[i][GoodName]);
                strcat(GOODS_LIST,
                    var);
            }

        }
    }
    format(title, sizeof(title), "{80FFFF}�ҵ���Ʒ - {80FF80}%d{80FFFF}�� ��������{80FF80}%d{80FFFF}�� ռ{80FF80}%d%", youcount, tocount, floatround(youcount * 100.0 / tocount));
    ShowPlayerDialog(playerid, GODIOG_LIST, DIALOG_STYLE_LIST, title, GOODS_LIST, "�༭", "�ر�");
    return 1;
}
CMD:wdjj(const playerid, const cmdtext[]) return cmd_mygoods(playerid, cmdtext);
CMD:resetowner(const playerid, const cmdtext[]) {
    new gid; //create string to store values
    if(sscanf(cmdtext, "i", gid)) return SendClientMessage(playerid, 0xFFFFFFFF, "[�Ҿ�]{FF0000}/resetowner{37FF00} [ID]");
    SellGoodsToSYS(playerid, gid);
    return 1;
}
CMD:goodshelp(const playerid, const cmdtext[]) {
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "{FF80C0}�Ҿ�{80FF80}����", "{C0C0C0}�鿴�ҵ���Ʒ{FF0000}/mygoods��/wdjj\n{C0C0C0}������Ʒ{FF0000}/gogoods{C0C0C0}\n������Ʒ�밴{FF0000}Y{C0C0C0}��", "�ر�", "");
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
    new Float:x, Float:y, Float:z;
    //2020.2.21�����·����� CarTroll ���ָĻ����ˡ��� ˢ��̫����
    GetVehiclePos(vehicleid, x, y, z);
    if(!IsPlayerInRangeOfPoint(playerid, 25.0, x, y, z) && !IsPlayerNPC(playerid)) {
        for (new i = 0; i < sizeof npcCars; i++) {
            if(vehicleid == npcCars[i]) return 1;
        }
        FuckAnitCheat(playerid, "�糵/����/�������", 3);
        // 2020.2.28�������ԭ�� �������NPC����һ˲��NPC���˵ط��ͻᱻ��� �͵��ж��ϵĳ��ǲ���NPC�� ������� �Ǿͷ�
        return 1;
    }

    // if(GetPlayerVehicleID(vehicleid) != PlayerInfo[playerid][BuyID]){
    //     for (new i = GetPlayerPoolSize(); i >= 0; i--) 
    //     {
    //         if(IsPlayerConnected(i) && PlayerInfo[i][CarLock] && PlayerInfo[i][BuyID] == vehicleid && i!=playerid){
    //             SendClientMessage(playerid, Color_White, "[��ͨ����] �ؾ�������");
    //             RemovePlayerFromVehicle(playerid);
    //         }
    //         return 1;
    //     }
    //     new msg[64];
    //     format(msg, sizeof(msg), "[��ͨ����]�����ؾ߲������Ŷ����Ҫӵ����һ��������/c %d",vehicleid);
    //     return SendClientMessage(playerid, Color_White, msg);
    // }
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid) { //������뿪�ؾ������������ϵͳʱ�����ж�Ϊ��Ҫ����
    if(pRaceing[playerid]) {
        new Float:pPos[3];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        SetPlayerPos(playerid, pPos[0] + 2, pPos[1] + 1.5, pPos[2] + 0.5);
        return ShowPlayerDialog(playerid, RACE_RESPAWNDIALOG, DIALOG_STYLE_MSGBOX, "����ϵͳ By YuCarl77", "��⵽�����������³���,�Ƿ���Ҫ����?\n���뵱�˿�����.", "��", "��");
    }
    if(p_PPC[playerid]) {
        return SetPlayerHealth(playerid, -1.0);
    }

    //��ʱ�ŵ�statechange�Ǳ��� ���ܸ��ɿ�һ��ɸ���  ������ôд
    // if(pRaceing[playerid])
    // {
    //     ReSpawningText[playerid] = TextDrawCreate(307.333374, 127.362937, "������...");
    //     TextDrawLetterSize(ReSpawningText[playerid], 0.375666, 1.512889);
    //     TextDrawTextSize(ReSpawningText[playerid], 18.000000, 187.000000);
    //     TextDrawAlignment(ReSpawningText[playerid], 2);
    //     TextDrawColor(ReSpawningText[playerid], 6736383);
    //     TextDrawUseBox(ReSpawningText[playerid], 1);
    //     TextDrawBoxColor(ReSpawningText[playerid], 73);
    //     TextDrawSetShadow(ReSpawningText[playerid], 3);
    //     TextDrawSetOutline(ReSpawningText[playerid], 1);
    //     TextDrawBackgroundColor(ReSpawningText[playerid], 255);
    //     TextDrawFont(ReSpawningText[playerid], 0);
    //     TextDrawSetProportional(ReSpawningText[playerid], 1);
    //     TextDrawSetShadow(ReSpawningText[playerid], 3);
    //     TextDrawShowForPlayer(playerid, ReSpawningText[playerid]);
    //     new raid = RaceHouse[GameRace[playerid][rgameid]][rraceid];
    //     new trcp[racecptype];
    //     if(GameRace[playerid][rgamecp] - 1 <= 0) Race_GetCp(raid, 1, trcp);//����ǵ�һ����Ļ�����������һ���㣬��Ȼ���Ǹ���
    //     else Race_GetCp(raid, GameRace[playerid][rgamecp] - 1, trcp);
    //     ReSpawnRaceVehicle(playerid);//2020.1.12�ģ���������Ч��
    // }
    return 1;
}
//
public OnPlayerStateChange(playerid, newstate, oldstate) {
    if(newstate == PLAYER_STATE_DRIVER) {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(CarInfo[vehicleid][ID] != 0) {
            if(CarInfo[vehicleid][UsersID] == 0) {
                new str[128];
                format(str, sizeof(str), "[����] �ð������ڳ�����,�۸�:%d �Ƿ���?", CarInfo[vehicleid][Value]);
                ShowPlayerDialog(playerid, AC_BUY, DIALOG_STYLE_MSGBOX, "[���򰮳�]", str, "��", "��");
                // SCM(playerid,ACColor,str);
            } else {
                if(CarInfo[vehicleid][UsersID] == PlayerInfo[playerid][ID]) {
                    SCM(playerid, ACColor, "[����] ��ӭ�ص���İ���.");
                    AddVehicleComponent(vehicleid, 1010);
                } else {
                    if(CarInfo[vehicleid][Lock]) {
                        new Float:x, Float:y, Float:z;
                        GetPlayerPos(playerid, x, y, z);
                        SetPlayerPos(playerid, x, y, z);
                        SetVehiclePos(vehicleid, CarInfo[vehicleid][CarX], CarInfo[vehicleid][CarY], CarInfo[vehicleid][CarZ]);
                        SendClientMessage(playerid, AC_Color, "[����]�������Ѿ�������");
                        return 1;
                    }
                    new str[128];
                    format(str, sizeof(str), "[����] �ؾ�ID:%s(%d) �۸�:%d ��� ӵ����:UID %d", VehicleNames[GetVehicleModel(vehicleid) - 400], GetVehicleModel(vehicleid), CarInfo[vehicleid][Value], CarInfo[vehicleid][UsersID]);
                    SCM(playerid, ACColor, str);
                    if(CarInfo[vehicleid][SellValue] != 0) {
                        format(str, sizeof(str), "[����] ���ؾ����ڳ�����,�۸�:%d �Ƿ���", CarInfo[vehicleid][SellValue]);
                        // SCM(playerid,ACColor,str);
                        ShowPlayerDialog(playerid, AC_BUY, DIALOG_STYLE_MSGBOX, "[���򰮳�]", str, "��", "��");
                    }
                }
            }
            return 1;
        }
        if(vehicleid == PlayerInfo[playerid][BuyID]) {
            AddVehicleComponent(vehicleid, 1010);
            for (new i = GetPlayerPoolSize(); i >= 0; i--) { //��ӦTV�ͱ����Լ� �ϳ���ʾ �³�����
                if(IsPlayerConnected(i)) {
                    if(PlayerInfo[i][tvid] == playerid) {
                        // for (new a = 0; a < 22; a++) {
                        //     TextDrawShowForPlayer(i, velo[playerid][a]);
                        // }
                        if(i != playerid) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid)); //������ɾ��
                    }
                    // �������������ı���
                    // if(i != playerid) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
                }
            }
            if(PlayerInfo[playerid][CarLock]) return SendClientMessage(playerid, Color_Green, "[�ؾ�]�ϰ延ӭ, ��ĳ�������");
        } else {
            for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                if(IsPlayerConnected(i) && vehicleid == PlayerInfo[i][BuyID] && PlayerInfo[i][CarLock]) {
                    new Float:X, Float:Y, Float:Z, tmp[64];
                    GetPlayerPos(playerid, X, Y, Z);
                    SetPlayerPos(playerid, X, Y, Z + 0.5);
                    format(tmp, sizeof(tmp), "[�ؾ�]��������%s�Ĳ����Ѿ�������Ŷ..", GetName(i));
                    SendClientMessage(playerid, Color_Green, tmp);
                    // return 1;
                }
            }
        }
    }
    if(newstate == PLAYER_STATE_ONFOOT) {
        // if(pRaceing[playerid]) SetPlayerHealth(playerid, -1.0);//������������³�����ɱ��λ
        for (new i = GetPlayerPoolSize(); i >= 0; i--) { //��ӦTV�ͱ����Լ� �ϳ���ʾ �³�����
            if(IsPlayerConnected(i)) {
                if(PlayerInfo[i][tvid] == playerid) {
                    // for (new a = 0; a < 22; a++) 
                    // {
                    //     TextDrawHideForPlayer(i, velo[playerid][a]);
                    // }
                    if(i != playerid) PlayerSpectatePlayer(i, playerid);
                }
            }
        }
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) {
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid) {

    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid) {
    new Float:pX, Float:pY, Float:pZ;
    // if(GetPlayerVehicleID(playerid) != 0) {
    GetPlayerPos(playerid, pX, pY, pZ);
    if(EditRace[playerid][rraceid] != -1 && EditRace[playerid][rtestcp] != -1) {
        new msg[128], raid = EditRace[playerid][rraceid];
        if(GetPlayerState(playerid) == 2) {
            Race_Cp_Script_Start(playerid, raid, EditRace[playerid][rtestcp]);
        }
        format(msg, 128, "[����]����[%s]����:%i/%i", Race[raid][rname], EditRace[playerid][rtestcp], Race[raid][rcps]);
        SendClientMessage(playerid, Color_Race, msg);
        PlayerPlaySound(playerid, 1056, pX, pY, pZ);
        if(EditRace[playerid][rtestcp] == Race[raid][rcps]) {
            format(msg, 128, "[����]����[%s]�����", Race[raid][rname]);
            SendClientMessage(playerid, Color_Race, msg);
            EditRace[playerid][rtestcp] = -1;
            Race_HideCp(playerid);
            return 1;
        }
        EditRace[playerid][rtestcp]++;
        Race_ShowCp(playerid, raid, EditRace[playerid][rtestcp]);
        return 1;
    }
    if(GameRace[playerid][rgameid] != -1) {
        if(RaceHouse[GameRace[playerid][rgameid]][rstate] == 0) {
            new msg[128];
            if(playerid == RaceHouse[GameRace[playerid][rgameid]][rplayerid]) format(msg, 128, "[����] ���Ƿ���,������ָ��/r s��ʼ����~");
            else format(msg, 128, "[����]�����ĵȴ�������ʼ..");
            SendClientMessage(playerid, Color_Race, msg);
            return 1;
        }
        if(RaceHouse[GameRace[playerid][rgameid]][rstate] == 1) {
            new msg[128];
            format(msg, 128, "[����]�������ڵ���ʱ,������׼��!");
            SendClientMessage(playerid, Color_Race, msg);
            return 1;
        }
        if(RaceHouse[GameRace[playerid][rgameid]][rstate] == 2) {
            new msg[128], raid = RaceHouse[GameRace[playerid][rgameid]][rraceid];
            if(GetPlayerState(playerid) == 2) {
                Race_Cp_Script_Start(playerid, raid, GameRace[playerid][rgamecp]);
            }
            if(GameRace[playerid][rgamecp] > 1 && GameRace[playerid][rgamecp] < Race[raid][rcps]) {
                new Float:x, Float:y, Float:z, Float:distance;
                new p1[racecptype], p2[racecptype];
                Race_GetCp(raid, GameRace[playerid][rgamecp], p1);
                Race_GetCp(raid, GameRace[playerid][rgamecp] + 1, p2); //û�ж��Ƿ�CP��>=���һ��cp�� ��Ȼ����Ӧ����3��0 �����������һ����ᱻ�ж�ΪG
                x = floatabs(p1[rcpx] - p2[rcpx]);
                y = floatabs(p1[rcpy] - p2[rcpy]);
                z = floatabs(p2[rcpz] - p2[rcpz]);
                distance = sqrt(x * x + y * y + z * z); //x*x+y*y+z*z
                // if(GameRace[playerid][rgamecp]+1==Race[raid][rcps]) distance=GetPlayerDistanceFromPoint(playerid,p2[rcpx],p2[rcpy],p2[rcpz]);
                if(GetSpeed(playerid) < 0.01 && distance > 20.0) {
                    new ss = Race_GetCp_Scripts(p1[rcpid]); //���ص�ǰCP���м����߼�CP�����������0�Ļ� ��ֱ�ӷ�; ���p2����Ļ�����p1��
                    if(!ss) {
                        return FuckAnitCheat(playerid, "������㴫��", 0); //������m0d�Ⱥ�㴫�� 2020.2.20���� ��ֹ���
                    } else {
                        if(Race_CheckPlayerCheat(ss, p1[rcpid])) return FuckAnitCheat(playerid, "������㴫��", 0);
                    }
                }
            }
            format(msg, 128, "�� �� �� / ~p~%i~w~/~y~%i", GameRace[playerid][rgamecp], Race[raid][rcps]);
            PlayerTextDrawSetString(playerid, CpTextDraw[playerid], msg);
            PlayerTextDrawShow(playerid, CpTextDraw[playerid]);
            GetPlayerPos(playerid, pX, pY, pZ);
            for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                if(IsPlayerConnected(i) && PlayerInfo[i][tvid] == playerid && PlayerInfo[i][tvzt]) PlayerPlaySound(i, 1056, pX, pY, pZ);
            }
            //2020.2.11�޸�û����

            PlayerPlaySound(playerid, 1056, pX, pY, pZ);
            //�����ҵ�CP����������������CP�� Ҳ����˵��ҵ����յ�
            if(GameRace[playerid][rgamecp] == Race[raid][rcps]) { //2020.1.13�޸�
                //���rtopҲ�����ڷ������ǵ�һ���ҷ������� > 1 Ҳ���ǻ���������ҵĻ�
                if(GetPlayerState(playerid) == 2) {
                    // PlayerInfo[playerid][Cash] += rand;
                    new time[3];
                    ms2time(time, GetTickCount() - GameRace[playerid][rtime]);
                    new rand;
                    if(Race[raid][rcps] < 10) {
                        rand = random(80);
                    } else if(Race[raid][rcps] < 20) {
                        rand = random(800) + 300;
                    } else rand = random(1500) + 300;
                    if(time[1] == 0 && time[2] < 50) {
                        rand = random(80);
                    }
                    GivePlayerCash(playerid, rand);
                    format(msg, 128, "[����] %s ���������[%s],��ʱ%d:%d:%d [%s��] (С���%i) ��� %d ���", GetName(playerid), Race[raid][rname], time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime]), RaceHouse[GameRace[playerid][rgameid]][rtop], rand); //��ɺ���ʾ��������
                    SendClientMessageToAll(Color_Race, msg);
                    printf("%s", msg);
                    RaceHouse[GameRace[playerid][rgameid]][rtop]++; //��ô���������˵������ͻ�+1
                    // KillTimer(jishu[playerid]);
                    // //									KillTimer(playerrank[GameRace[playerid][rgameid]]);
                    // TextDrawDestroy(Time[playerid]);
                    // TextDrawDestroy(Top[playerid]);
                    new top = Race_Game_End(playerid, raid, GetTickCount() - GameRace[playerid][rtime]);
                    pRaceing[playerid] = 0;
                    if(top != -1) {
                        format(msg, 128, "[����] ��ϲ %s ���������� %s �����а� {FFFF00}No.%i! ף��Ta!", GetName(playerid), Race[raid][rname], top + 1);
                        SendClientMessageToAll(Color_Race, msg);
                        printf("%s", msg);
                        pHouseid[playerid] = -1;
                    }
                }
                //���˵���ǵ�һ �� ������  > 1
                // KillTimer(RaceHouse[GameRace[playerid][rgameid]][playerrank]);//��仰���������Щ���� 1���˺�����û��Ҫ���������.. 
                // ����delete��race quit������ Ӧ�ûᴥ���İ� 
                if(RaceHouse[GameRace[playerid][rgameid]][rtop] == 2) //��Ϊ�����Ѿ�++��
                {
                    //������ұ��� �Լ���ս���Ķ��յ�winʤ��
                    new time[3];
                    ms2time(time, GetTickCount() - GameRace[playerid][rtime]);
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && PlayerInfo[i][tvid] == playerid || GameRace[i][rgameid] == GameRace[playerid][rgameid]) {
                            format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED 1ST \n~y~%d:%d:%d [%s second]", GetName(playerid), time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //��ɺ���ʾ��������
                            GameTextForPlayer(i, msg, 5000, 3);
                        }
                    }
                    if(RaceHouse[GameRace[playerid][rgameid]][rps] > 1) {
                        for (new i = 0; i < 6; i++) {
                            if(RaceHouse[GameRace[playerid][rgameid]][players][i] == playerid) { //�ҵ�����ڵĲ�λ
                                RaceHouse[GameRace[playerid][rgameid]][players][i] = INVALID_PLAYER_ID;
                                break; //�������λ����
                            }
                        }
                        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                            if(IsPlayerConnected(i) && i != playerid) {
                                if(GameRace[i][rgameid] == GameRace[playerid][rgameid]) GameTextForPlayer(i, "~w~����ѳ��ߣ��㻹��20��ʱ�䣬��ץ��!", 1000, 3);
                                // else GameTextForPlayer(playerid, "~w~���ѳ��ߣ���ȴ�������ҳ��ߣ���ץ��!", 1000, 3);Race_Game_Quit(playerid);
                            }
                        }
                        RaceHouse[GameRace[playerid][rgameid]][rtimes] = 20;
                        RaceHouse[GameRace[playerid][rgameid]][endcount] = SetTimerEx("RaceGameEndCount", 1000, true, "i", GameRace[playerid][rgameid], playerid);
                    }
                } else {
                    //������ұ��� �Լ���ս���Ķ��յ�finished���
                    new time[3];
                    ms2time(time, GetTickCount() - GameRace[playerid][rtime]);
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && PlayerInfo[i][tvid] == playerid || GameRace[i][rgameid] == GameRace[playerid][rgameid]) {
                            //��ͬһ�������ڵ��� (��ⷿ�������Ƿ�>1) Ҳ��ʾ�Ǹ��������
                            if(RaceHouse[GameRace[playerid][rgameid]][rtop] == 3) {
                                format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED 2ND \n~y~%d:%d:%d [%s second]", GetName(playerid), time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //��ɺ���ʾ��������
                            } else if(RaceHouse[GameRace[playerid][rgameid]][rtop] == 4) {
                                format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED 3RD \n~y~%d:%d:%d [%s second]", GetName(playerid), time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //��ɺ���ʾ��������
                            } else {
                                format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED %dTH \n~y~%d:%d:%d [%s second]", GetName(playerid), RaceHouse[GameRace[playerid][rgameid]][rtop], time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //��ɺ���ʾ��������
                            }
                            GameTextForPlayer(i, msg, 5000, 3);
                            //2020.3.26�� ��youtube��ĳ��������ʾ
                        }
                        // 2020.3.25�������� �޸�playeridΪi
                    }
                }
                Race_ShowGameDialog(playerid, raid); //2020,2,10�޸� ԭ���������
                new tmp = GameRace[playerid][rgameid];
                Race_Game_Quit(playerid);
                // Race_ShowGameDialog(i, raid); //�ĵ������ﲢֱ��ȡ��tv
                if(RaceHouse[tmp][rps] == 0) //��鷿�����Ƿ����� �еĻ��ͼ���Ƿ����˹�ս
                {
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i)) {
                            if(PlayerInfo[i][tvid] == playerid && i != playerid) //�������û���� �����ڹ�ս�򵯴��Ƿ���Ҫ�����ۿ�
                            {
                                AntiCommand[i] = 0;
                                CallRemoteFunction("OnPlayerCommandText", "is", i, "/tv off");
                                // OnPlayerCommandText(i, "/tv off");
                                // ShowPlayerDialog(i, RACE_MSGBOX, DIALOG_STYLE_MSGBOX, "����", "�Է���ǰδ�������У��Ƿ�����ۿ���", "Yes", "No");
                            }
                        }
                    }
                    //��ɱ�����ѡ�񵯳�dialogѡ���Ƿ������ս
                } else {
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && GameRace[i][rgameid] == tmp) { //�����ĳ����ҵķ���ID���������Ҹ��˳�����ID���Զ��ۿ��Ǹ����
                            new tmped[16];
                            format(tmped, 16, "/tv %i", i);
                            AntiCommand[i] = 0;
                            CallRemoteFunction("OnPlayerCommandText", "is", playerid, tmped);
                            // OnPlayerCommandText(playerid, tmped);
                            break; //2020.3.28д ��д�Ļ����������� ����������ٰ�������
                        }
                    }
                }
            } else //��������յ�Ļ��Ǿ�CP������1
            {
                GameRace[playerid][rgamecp]++;
                Race_ShowCp(playerid, raid, GameRace[playerid][rgamecp]); //��ʾCP
            }
        }
        return 1;
    }
    // }
    return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid) {
    return 1;
}

// public OnRconCommand(cmd[]) {
//     return 1;
// }

public OnPlayerObjectMoved(playerid, objectid) {
    return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid) {
    return 1;
}


public OnVehicleRespray(playerid, vehicleid, color1, color2) {
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row) {
    return 1;
}

public OnPlayerExitedMenu(playerid) {
    return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
    return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    //     /*if(newkeys & KEY_FIRE)//�л�TV����
    //     {
    //     	if(PlayerInfo[playerid][tvzt]==0)
    //     	{
    // 			new rd = random(MAX_PLAYERS);
    // 			while(rd == lastrandom || rd == playerid || !IsPlayerConnected(rd))
    // 			{
    // 	    		rd = random(MAX_PLAYERS);
    //  			}
    //  			lastrandom = rd;
    // 			TogglePlayerSpectating(playerid, 1);
    //     		SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(rd));
    //     		SetPlayerInterior(playerid,GetPlayerInterior(rd));
    // 			if(IsPlayerInAnyVehicle(rd)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(rd));
    // 			else PlayerSpectatePlayer(playerid, rd);
    // 		}
    //     }*/
    // if(PRESSED(KEY_FIRE) || PRESSED(KEY_ACTION))  �ɰ�д�� ���뱨029��
    // if(pRaceing[playerid] &&  HOLDING(KEY_CROUCH)){  // C������ϵͳ����
    // // SetTimerEx("KickEx", 100, false, "i", playerid);
    //     RaceReSpawnTextDraw(playerid);
    //     SetTimerEx("ReSpawnRaceVehicle", 1000, false, "i", playerid);
    // }

    // if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE) || (newkeys & KEY_ACTION) && !(oldkeys & KEY_ACTION)) { 2020.2.9ȡ��
    // if((newkeys & KEY_ACTION) && !(oldkeys & KEY_ACTION)) {
    //     if(IsPlayerInAnyVehicle(playerid)) AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
    // }
    if(Attire_Presskey(playerid, newkeys) == 1) return 1;
    if(PlayerEdit[playerid][2] != 0) {
        new Keys, ud, lr;
        GetPlayerKeys(playerid, Keys, ud, lr);
        if(Keys == KEY_LOOK_BEHIND) {
            new str[128];
            format(str, sizeof(str), "����\nǰ��\n����\nǰ��\n�෭\n��ת\n����\n{FF0000}ɾ��\n״̬:%s", TagObjectsState[VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects]]);
            ShowPlayerDialog(playerid, CDIALOG_CarZB, DIALOG_STYLE_LIST, "����༭", str, "ѡ��", "�˳�");
        }
        if(Keys == KEY_FIRE) {
            ShowPlayerDialog(playerid, CDIALOG_CarZBEditSave, DIALOG_STYLE_LIST, "����༭", "?�\n?�\n?�\n\
                ����������\n����������\n------------------------------\n{FF0000}�������ø�װ��\n------------------------------\n{00FF00}���ұ����װ��\n------------------------------", "����", "����");
        }
        if(Keys == KEY_ANALOG_LEFT) {
            DestroyDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID]);
            VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID] = CreateDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][ModelID], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
            switch (PlayerEdit[playerid][2]) {
                case 1:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaX] -= EditSpeed[playerid];
                case 2:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaY] -= EditSpeed[playerid];
                case 3:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaZ] -= EditSpeed[playerid];
                case 4:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRX] -= EditSpeed[playerid];
                case 5:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRY] -= EditSpeed[playerid];
                case 6:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRZ] -= EditSpeed[playerid];
            }
            AttachDynamicObjectToVehicle(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID], PlayerEdit[playerid][0],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaX],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaY],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaZ],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRX],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRY],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRZ]);
            Streamer_UpdateAll();
        }
        if(Keys == KEY_ANALOG_RIGHT) {

            DestroyDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID]);
            VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID] = CreateDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][ModelID], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
            switch (PlayerEdit[playerid][2]) {
                case 1:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaX] += EditSpeed[playerid];
                case 2:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaY] += EditSpeed[playerid];
                case 3:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaZ] += EditSpeed[playerid];
                case 4:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRX] += EditSpeed[playerid];
                case 5:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRY] += EditSpeed[playerid];
                case 6:
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRZ] += EditSpeed[playerid];
            }
            AttachDynamicObjectToVehicle(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID], PlayerEdit[playerid][0],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaX],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaY],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaZ],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRX],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRY],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRZ]);
            Streamer_UpdateAll();
        }
    }
    if(newkeys & KEY_FIRE) {
        CreatingCamera(playerid); //��������� ��ͷ
        if(IsPlayerDeathMatch(playerid)) {
            if(ForbiddenWeap(playerid, 1)) {
                //������뿪DM����ʾʹ�ý�ֹʹ�õ�����
                ResetPlayerWeapons(playerid);
                DeathMatch_Leave(playerid);
                ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�㲻��ʹ�ò�����ʹ�õ�����", "ȷ��", "");
                return 1;
            }
        } else {
            //�������ֹʹ����Щ���� Ȼ��ֱ��û����ҵ���������
            if(GetPlayerVirtualWorld(playerid) == 0 && ForbiddenWeap(playerid, 0)) {
                SendClientMessage(playerid, Color_White, "[ϵͳ]�������н�ֹʹ����Щ����");
                ResetPlayerWeapons(playerid);
                return 1;
            }
        }
        if(PlayerInfo[playerid][tvzt]) {
            if(pRaceing[PlayerInfo[playerid][tvid]]) {
                new tmp = GameRace[PlayerInfo[playerid][tvid]][rgameid];
                for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                    if(IsPlayerConnected(i) && i != PlayerInfo[playerid][tvid] && GameRace[i][rgameid] == tmp) { //�����ĳ����ҵķ���ID���������� ���л��ۿ�
                        new tmped[16];
                        format(tmped, 16, "/tv %i", i);
                        AntiCommand[i] = 0;
                        CallRemoteFunction("OnPlayerCommandText", "is", playerid, tmped);
                        // OnPlayerCommandText(playerid, tmped);
                        break;
                    }
                }
            } else {
                new rd = random(MAX_PLAYERS);
                while (rd == PlayerInfo[playerid][tvid] || rd == playerid || !IsPlayerConnected(rd)) {
                    if(GetPlayerPoolSize() <= 1) {
                        AntiCommand[playerid] = 0;
                        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/tv off");
                        // OnPlayerCommandText(playerid, "/tv off");
                        break;
                    }
                    rd = random(MAX_PLAYERS);
                }
                new tmped[16];
                format(tmped, 16, "/tv %i", rd);
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, tmped);
                // OnPlayerCommandText(playerid, tmped);
            }
        }
    }
    if(newkeys == 65536) { //"Y" Key
        if(KeyBoards(playerid) == 1) return 1; //����Y���ù����� ���������ڸ㹫���ƵĻ� �ǾͲ�����ִ���ˣ���Ȼ��ը����
        if(config_Nochangeobj == 0) { //PHouse��
            UseChangeObj(playerid);
            // return 1; //�����������Ҿ߾Ͷ�������
        }
        if(config_Nomoveobj == 0) { //������Phouse��
            UseMoveObj(playerid);
            //��������Ҿ߶�����
            // return 1;
        }
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
            GOODS_OPRATEID[playerid] = getClosestGOODS(playerid);
            // printf("GET ID = %d", GOODS_OPRATEID[playerid]);
            if(GOODS_STATUS[playerid] == true) return SendClientMessage(playerid, 0xFF0000C8, "[�Ҿ�]����,�����ڰ�һ����Ʒ!");
            if(GOODS[GOODS_OPRATEID[playerid]][Key]) return ShowPlayerDialog(playerid, GODIOG_PASS, DIALOG_STYLE_INPUT, "��ȫ��֤��ʽ", "����������", "OK", "ȡ��");

            if(GOODS[GOODS_OPRATEID[playerid]][issale] == true) {
                new string[256];
                format(string, sizeof(string), "{FFFFFF}[��Ʒ�۸�]:{80FF80} %d\n{FFFFFF}[��ƷID]:{80FF80}%d\n{FFFFFF}[��Ʒģ��ID]:{80FF80}%d\n{FFFF80}�_��Ҫ��ô?", GOODS[GOODS_OPRATEID[playerid]][GoodPrize], GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodObjid]);
                ShowPlayerDialog(playerid, GODIOG_BUY, DIALOG_STYLE_MSGBOX, "{FFFF80}__Ҫ��ô?__", string, "��", "����");
            } else {
                new pname[65];
                GetPlayerName(playerid, pname, 65);
                if(!strlen((GOODS[GOODS_OPRATEID[playerid]][GoodOwner]))) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR>.<", "{FF0000}ϵͳ�ڲ�����\n�ַ���Ϊ��!\n�п��ܴ���Ʒ���ݱ���\n����ϵ������!\n---->{FFFF80}episodes27@gmail.com", "Close", "");
                if(!strcmp(GOODS[GOODS_OPRATEID[playerid]][GoodOwner], pname, true)) {
                    if(GOODS[GOODS_OPRATEID[playerid]][topublic] == true) {
                        new title[285];
                        format(title, 285, "{FFFFFF}��ƷID:{80FF80}%d {FFFFFF}����:{80FF80}%s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                        ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_YES, "ѡ��", "�ر�");
                    } else {
                        new title[285];
                        format(title, 285, "{FFFFFF}��ƷID:{80FF80}%d {FFFFFF}����:{80FF80}%s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                        ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_NO, "ѡ��", "�ر�");
                    }
                } else {
                    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR>.<", "{FF0000}�ⲻ�������Ʒ!", "Close", "");
                } //sale
            }
        }
    }
    // if(newkeys == 262144 || newkeys == 2) {
    //     if(config_Nomoveobj == 0) {
    //         UseMoveObj(playerid);
    //         return 1;
    //     }
    // }
    return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid) {
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success) { //rcon��¼ʧ��ֱ�ӷ�
    if(!success) {
        new cmd[32];
        format(cmd, sizeof(cmd), "banip %s", ip);
        SendRconCommand(cmd);
    }
    return 1;
}

public OnPlayerUpdate(playerid) { //���¼Ҿ�
    GetPlayerFPS(playerid);
    if(GOODS_STATUS[playerid] == true && TAKEDOWN_STATUS[playerid] == false) {
        new up_dw, lf_rg, o_keys;
        GetPlayerKeys(playerid, o_keys, up_dw, lf_rg);
        if(o_keys == KEY_FIRE) {
            ShowPlayerDialog(playerid, GODIOG_TAKEDOWN, DIALOG_STYLE_MSGBOX, "{FFFF80}��Ʒ����", "{FFFF80}������Ʒ?", "����", "ȡ��");
            return 1;
        }
    }
    if(g_FlyMode[playerid][flyType] == 1) {
        new keys,ud,lr;
        GetPlayerKeys(playerid, keys, ud, lr);
        new Float:CP[3], Float:FV[3], olddir = g_FlyMode[playerid][flyDirection];
        GetPlayerCameraPos(playerid, CP[0], CP[1], CP[2]);
        GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);

        if(g_FlyMode[playerid][flyKeys][0] != ud || g_FlyMode[playerid][flyKeys][1] != lr) {
            if((g_FlyMode[playerid][flyKeys][0] != 0 || g_FlyMode[playerid][flyKeys][1] != 0) && ud == 0 && lr == 0) {
                StopDynamicObject(g_FlyMode[playerid][flyObject]);

                g_FlyMode[playerid][flyDirection] = 0;
            } else {
                if(lr < 0) {
                    if(ud < 0) {
                        g_FlyMode[playerid][flyDirection] = MOVE_FORWARD_LEFT;
                    } else if(ud > 0) {
                        g_FlyMode[playerid][flyDirection] = MOVE_BACK_LEFT;
                    } else {
                        g_FlyMode[playerid][flyDirection] = MOVE_LEFT;
                    }

                    MovePlayerCamera(playerid, CP, FV);
                } else if(lr > 0) {
                    if(ud < 0) {
                        g_FlyMode[playerid][flyDirection] = MOVE_FORWARD_RIGHT;
                    } else if(ud > 0) {
                        g_FlyMode[playerid][flyDirection] = MOVE_BACK_RIGHT;
                    } else {
                        g_FlyMode[playerid][flyDirection] = MOVE_RIGHT;
                    }

                    MovePlayerCamera(playerid, CP, FV);
                } else if(ud < 0) {
                    g_FlyMode[playerid][flyDirection] = MOVE_FORWARD;

                    MovePlayerCamera(playerid, CP, FV);
                } else if(ud > 0) {
                    g_FlyMode[playerid][flyDirection] = MOVE_BACK;

                    MovePlayerCamera(playerid, CP, FV);
                } else {
                    g_FlyMode[playerid][flyDirection] = -1;
                }
            }

            g_FlyMode[playerid][flyKeys][0] = ud;
            g_FlyMode[playerid][flyKeys][1] = lr;
        } else if(g_FlyMode[playerid][flyDirection] && (GetTickCount() - g_FlyMode[playerid][flyTick] > 100)) {
            if((g_FlyMode[playerid][flyKeys][0] != 0 || g_FlyMode[playerid][flyKeys][1] != 0) && ud == 0 && lr == 0) {
                StopDynamicObject(g_FlyMode[playerid][flyObject]);

                g_FlyMode[playerid][flyDirection] = 0;
            } else {
                MovePlayerCamera(playerid, CP, FV);
            }
        }

        if(funcidx("OnPlayerCameraUpdate") != -1) {
            new
            Float:NP[3];
            GetPlayerCameraPos(playerid, NP[0], NP[1], NP[2]);

            CallLocalFunction("OnPlayerCameraUpdate", "ifffifffi", playerid, CP[0], CP[1], CP[2], olddir, NP[0], NP[1], NP[2], g_FlyMode[playerid][flyDirection]);
        }
    }
    return 1;
}

public OnPlayerStreamIn(playerid, forplayerid) {
    return 1;
}

public OnPlayerStreamOut(playerid, forplayerid) {
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid) {
    return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid) {
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source) {
    new id = clickedplayerid;
    if(!PlayerInfo[id][Login]) return SendClientMessage(playerid, Color_White, "�Է�����û�е�¼..");
    new msgs[32], msg[512];
    if(PlayerInfo[id][AdminLevel]) format(msgs, sizeof(msgs), "[����ԱLV%d]%s����Ϣ", PlayerInfo[id][AdminLevel], GetName(id));
    else format(msgs, sizeof(msgs), "%s����Ϣ", GetName(id));
    if(clickedplayerid == playerid) {
        if(strcmp(PlayerInfo[id][Team], "null", true)) format(msg, sizeof(msg), "���Ǳ�����:%d λע������\n����ʱ��:%d(��)\nƤ��:%d\n���:%d\nע������:%s\n�Ŷ�:%s", PlayerInfo[id][ID], PlayerInfo[id][Score], PlayerInfo[id][Skin], PlayerInfo[id][Cash], PlayerInfo[id][regdate], PlayerInfo[id][Team]);
        else format(msg, sizeof(msg), "���Ǳ�����:%d λע������\n����ʱ��:%d(��)\nƤ��:%d\n���:%d\nע������:%s", PlayerInfo[id][ID], PlayerInfo[id][Score], PlayerInfo[id][Skin], PlayerInfo[id][Cash], PlayerInfo[id][regdate]);
    } else {
        if(strcmp(PlayerInfo[id][Team], "null", true)) format(msg, sizeof(msg), "������:%d λע������\n����ʱ��:%d(��)\nƤ��:%d\n���:%d\nע������:%s\n�Ŷ�:%s", PlayerInfo[id][ID], PlayerInfo[id][Score], PlayerInfo[id][Skin], PlayerInfo[id][Cash], PlayerInfo[id][regdate], PlayerInfo[id][Team]);
        else format(msg, sizeof(msg), "������:%d λע������\n����ʱ��:%d(��)\nƤ��:%d\n���:%d\nע������:%s", PlayerInfo[id][ID], PlayerInfo[id][Score], PlayerInfo[id][Skin], PlayerInfo[id][Cash], PlayerInfo[id][regdate]);
    }
    if(!isnull(PlayerInfo[id][Designation])) format(msg, sizeof(msg), "%s\n�ƺ�:%s", msg, PlayerInfo[id][Designation]);
    if(!isnull(PlayerInfo[id][Tail])) format(msg, sizeof(msg), "%s\n������:%s", msg, PlayerInfo[id][Tail]);
    // printf("%s", PlayerInfo[id][regdate]);
    ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, msgs, msg, "ȷ��", "");
    //2020.2.11�޸�ΪLIST��ʽ
    return 1;
}


stock PlaySoundForPlayer(const playerid, const soundid) {
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);
    PlayerPlaySound(playerid, soundid, pX, pY, pZ);
}

// forward PlaySoundForAll(soundid);
// public PlaySoundForAll(soundid) {
//     for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//         new Float:pX, Float:pY, Float:pZ;
//         GetPlayerPos(i, pX, pY, pZ);
//         PlayerPlaySound(i, soundid, pX, pY, pZ);
//     }
//     return 1;
// }

forward CountDown(playerid);
public CountDown(playerid) {
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    Count[playerid]--;
    if(Count[playerid] == 0) {
        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
            if(IsPlayerConnected(i)) {
                if(IsPlayerInRangeOfPoint(i, 20, X, Y, Z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
                    GameTextForPlayer(i, "~g~GO~r~!~n~~g~GO~r~!~n~~g~GO~r~!", 3000, 3);
                    PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
                }
            }
        }
        KillTimer(Timer[playerid]);
        return 1;
    }
    new str[16];
    format(str, sizeof(str), "~w~%d", Count[playerid]);
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerInRangeOfPoint(i, 20, X, Y, Z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid)) {
                GameTextForPlayer(i, str, 3000, 3);
                PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
            }
        }
    }
    return 1;
}
// forward countdown();
// public countdown() {
//     CountDown--;
//     if(CountDown == 0) {
//         GameTextForAll("~g~GO~r~!~n~~g~GO~r~!~n~~g~GO~r~!", 1000, 3); //����ʱ������ ��Ļ�г��ֵ����塣
//         CountDown = -1;
//         for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//             PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
//         }
//         return 0;
//     } else {
//         new text[7];
//         format(text, sizeof(text), "~w~%d", CountDown);
//         for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//             PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
//         }
//         GameTextForAll(text, 1000, 3);
//     }

//     SetTimer("countdown", 1000, 0);
//     return 0;
// }
forward SpawnVehicle(playerid, car); //ˢ�� ����������ʱ��
public SpawnVehicle(playerid, car) {
    new str[128];
    new Float:pos[3], Float:Angle;
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    //��ȡ������ڵ�����
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle); //�������ڳ����ȡ����ǰ�������ڵĽǶ�
    else GetPlayerFacingAngle(playerid, Angle); //������ڳ���ͻ�ȡ��ҳ���ĽǶ�

    // �ж�����Ƿ��Ѿ��й�һ�����ˣ��й��Ļ��Ͱ���ҷŵ�����Ȼ��ɾ��ԭ���ĳ�
    if(PlayerInfo[playerid][CreateCar] == 1) SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    DestroyVehicle(PlayerInfo[playerid][BuyID]);
    PlayerInfo[playerid][CreateCar] = 0;

    PlayerInfo[playerid][BuyID] = CreateVehicle(car, pos[0], pos[1], pos[2], 0.0, random(128), random(128), 60); //60���ӳ٣�������˵Ļ��͸Ĵ�һ��
    SetVehicleVirtualWorld(PlayerInfo[playerid][BuyID], GetPlayerVirtualWorld(playerid));
    //�����ؾߵ�����Ϊ��ҵ�����
    PutPlayerInVehicle(playerid, PlayerInfo[playerid][BuyID], 0);
    //����ҷŵ�������
    //PlayerInfo[playerid][pVehicleEnteColor_Red] = GetPlayerVehicleID(playerid);
    PlayerInfo[playerid][CreateCar] = 1;
    PlayerInfo[playerid][CarLock] = 0;

    SetVehicleZAngle(PlayerInfo[playerid][BuyID], Angle); //���ó����ĽǶ�Ϊ֮ǰ������ڵĳ����Ƕ�
    LinkVehicleToInterior(PlayerInfo[playerid][BuyID], GetPlayerInterior(playerid));
    AddVehicleComponent(PlayerInfo[playerid][BuyID], 1010); //����һ������
    if(!pRaceing[playerid]) { //�����Ҳ��������л����Ļ�����ʾ��� ��Ϊ��������cveh
        format(str, sizeof(str), "[��ͨ����]ˢ���ɹ�������/cc �ɻ���ɫ������ģ��(%s[%d])", VehicleNames[car - 400], car);
        SCM(playerid, Color_White, str);
    }
    for (new i = GetPlayerPoolSize(); i >= 0; i--) { //��ӦTV�ͱ����Լ� �ϳ���ʾ �³�����
        if(IsPlayerConnected(i)) {
            if(PlayerInfo[i][tvid] == playerid && PlayerInfo[i][speedoMeter]) {
                for (new a = 0; a <= 21; a++) {
                    PlayerTextDrawShow(i, velo[playerid][a]);
                }
                if(i != playerid) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
            }
        }
    }
    return 1;
}

stock ReSpawnRaceVehicle(playerid) { //��������
    // TextDrawHideForPlayer(playerid, ReSpawningText[playerid]); //���������е���ʾ
    new raid = RaceHouse[GameRace[playerid][rgameid]][rraceid];
    new trcp[racecptype];
    Race_GetCp(raid, GameRace[playerid][rgamecp] - 1, trcp);
    if(GameRace[playerid][rgamecp] - 1 <= 0) Race_GetCp(raid, 1, trcp);
    SetPlayerPos(playerid, trcp[rcpx], trcp[rcpy], trcp[rcpz]);
    if(PlayerInfo[playerid][BuyID] != 0) //�������г��Ļ�������
    {
        SetVehiclePos(PlayerInfo[playerid][BuyID], trcp[rcpx], trcp[rcpy], trcp[rcpz]);
        SetVehicleZAngle(PlayerInfo[playerid][BuyID], trcp[rcpa]); //2020.1.12д �޸� ����CP�����������ĳ���ǶȲ���CP��ĳ���Ƕ�
        SetVehicleVirtualWorld(PlayerInfo[playerid][BuyID], 6666 - GameRace[playerid][rgameid]);
        PutPlayerInVehicle(playerid, PlayerInfo[playerid][BuyID], 0);
        LinkVehicleToInterior(PlayerInfo[playerid][BuyID], GetPlayerInterior(playerid));
        AddVehicleComponent(PlayerInfo[playerid][BuyID], 1010); //����һ������
    }
    return 1;
}

forward MinuteTimer(); //���Ӽ�ʱ��
public MinuteTimer() {
    //ʱ��� ��ҵ�ʱ���ܹ����� ������ʱ����DB���ݿ�
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(PlayerInfo[i][Login] == true) {
            PlayerInfo[i][Score] = PlayerInfo[i][Score] + 1;
            PlayerInfo[i][Cash] = PlayerInfo[i][Cash] + random(30);
            SetPlayerScore(i, PlayerInfo[i][Score]);
        }
    }
    Common_Running_QA(); //ִ���ʴ�
    return 1;
}

stock GetName(const playerid) {
    new GPlayerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, GPlayerName, sizeof(GPlayerName));
    return GPlayerName;
}

// forward UpdatePlayerIni(playerid); //�����������
forward OnPlayerLogin(playerid, Password[]); //��ҵ�¼
public OnPlayerLogin(playerid, Password[]) {
    new msg[512], DBResult:uf, string[128];
    format(msg, sizeof(msg), "SELECT `Password` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
    uf = db_query(user, msg);
    db_get_field(uf, 0, msg, sizeof(msg));
    db_free_result(uf);
    if(PlayerInfo[playerid][Wrong] >= 2) {
        ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "��½", "�㱻����˷�������ԭ��:�����������������{FF0000}����!", "ȷ��", "");
        SetTimerEx("KickEx", 100, false, "i", playerid);
        return 1;
    }
    new Salted_Key[64 + 1];
    SHA256_PassHash(Password, PlayerInfo[playerid][Salt], Salted_Key, sizeof Salted_Key); //����65
    if(strcmp(Salted_Key, msg) == 0) {
        for (new i = 0; i <= 7; i++) {
            TextDrawHideForPlayer(playerid, Screen[i]);
        }
        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
            ShowPlayerNameTagForPlayer(playerid, i, true);
        }
        if(LoadPlayerInfo(playerid)) {
            PlayerInfo[playerid][Login] = true;
            format(string, sizeof(string), "[ϵͳ]:%s (%d) �����˷����� ^^^", GetName(playerid), playerid);
            SCMALL(Color_LightBlue, string);
            printf("[���]%s(%d) �ѵ�½.", GetName(playerid), playerid);
        }
        return 1;
    }
    PlayerInfo[playerid][Wrong]++;
    format(string, sizeof(string), "{FF0000}�������{00FFFF}�㻹��{80FF80}%d��{00FFFF}�����½!", 3 - PlayerInfo[playerid][Wrong]);
    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "��½", string, "��½", "�ر�");
    // db_free_result(uf);
    return 1;
}
forward OnPlayerRegister(playerid, Password[]); //���ע��
public OnPlayerRegister(playerid, Password[]) //ע��ɹ�
{
    if(AccountCheck(GetName(playerid))) //2020.3.29�޸�������ص�BUG
    {
        SCM(playerid, Color_Red, "[ϵͳ]ע���ʺ�ʱ��������,���ܸ��ʺ��Ѿ�����,����������");
        SetTimerEx("KickEx", 100, false, "i", playerid);
        return 1;
    }
    if(strfind(Password, "123", true) != -1 || strfind(Password, "456", true) != -1) {
        ShowPlayerDialog(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "ע��", "�벻Ҫ�������ƴ���{22DD22}123��{FFFFFF}�򵥵�����!\n�����·������������{22DD22}ע��..\n��������ɢ�м���,�����ע��", "ע��", "�˳�");
        return 1;
    }
    new msg[256], string[160], temp[64 + 1];
    for (new i = 0; i <= 10; i++) {
        PlayerInfo[playerid][Salt][i] = random(97) + 25;
    }
    SHA256_PassHash(Password, PlayerInfo[playerid][Salt], temp, sizeof temp);
    new h = 0, m = 0, s = 0, n = 0, y = 0, day = 0;
    gettime(h, m, s), getdate(n, y, day);
    format(string, sizeof(string), "%d-%d-%d %02d:%02d:%02d", n, y, day, h, m, s);
    format(msg, sizeof(msg), "INSERT INTO `Users` (`Name`,`Password`,`Salt`,`Yzwrong`,`YzBantime`,`Date`) VALUES ('%s','%s','%s',%d,%d,'%s')", GetName(playerid), temp, PlayerInfo[playerid][Salt], 0, 0, string);
    // printf("%s %s", temp, PlayerInfo[playerid][Salt]);
    db_free_result(db_query(user, msg)); //ԭ����û��db_free_result�� ���ע�᲻�ϵĻ� �͸Ļ���
    format(string, sizeof(string), "ע��ɹ�\n�ʺ� :%s\n ���� :%s\n{FF0000}���μ��ʺ�����.", GetName(playerid), Password);
    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "��½", string, "��½", "�ر�");

    // ������֤�ĳ�ʼ��ע���û�����
    // new Query2[256];
    format(string, sizeof string, "INSERT INTO `players` (`name`,`code`,`email`,`yz`) VALUES('%s',0,0,0)", GetName(playerid));
    mysql_free_result(mysql_query(string));

    // printf(Query2);
    return 1;
}
forward OnPlayerReloadRegister(playerid, Password[]);
public OnPlayerReloadRegister(playerid, Password[]) //����ע��
{
    if(strfind(Password, "123", true) != -1 || strfind(Password, "qwerty", true) != -1 || strfind(Password, "456", true) != -1 || strfind(Password, "789", true) != -1) {
        ShowPlayerDialog(playerid, PlayerInfoDialog + 9, DIALOG_STYLE_INPUT, "{FFFF00}��ȫ����", "{9AFF9A}��ӭ!\n����������������������޸�!\n���μ������˺�����!\n�Ѳ���ɢ�м��������赣������й¶", "ȷ��", "ȡ��");
        return 1;
    }
    new temp[64 + 1]; // ɢ�м�������ɢ����
    for (new i = 0; i <= 10; i++) {
        PlayerInfo[playerid][Salt][i] = random(97) + 25;
    }
    // PlayerInfo[playerid][Salt][10] = 0;
    SHA256_PassHash(Password, PlayerInfo[playerid][Salt], temp, 65); //�涨65�̶�
    new msg[256];
    format(msg, sizeof(msg), "UPDATE `Users` SET `Password` = '%s',`Salt` = '%s' WHERE `Name` = '%s'", temp, PlayerInfo[playerid][Salt], GetName(playerid));
    db_free_result(db_query(user, msg)); //ԭ����û��db_free_result�� ����ע�᲻�Ͼ͸Ļ���
    format(msg, sizeof(msg), "[ϵͳ]:�ʺ� :%s ���� :%s{FF0000}���μ��ʺ�����.\n�����µ�¼", GetName(playerid), Password);
    SendClientMessage(playerid, Color_White, msg);
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", msg, "ȷ��", "");
    SetTimerEx("KickEx", 100, false, "i", playerid);
    return 1;
}
stock OnPlayerResetPassword(const playerid, const changeidName[], Password[]) { //����Ա����������� ����Ҷ�ʧʱ��ʹ��
    new temp[64 + 1], pSalt[11]; // ɢ�м�������ɢ����
    for (new i = 0; i <= 10; i++) {
        pSalt[i] = random(97) + 25;
    }
    SHA256_PassHash(Password, pSalt, temp, 65); //�涨65�̶�
    new msg[256];
    format(msg, sizeof(msg), "UPDATE `Users` SET `Password` = '%s',`Salt` = '%s' WHERE `Name` = '%s'", temp, pSalt, changeidName);
    db_free_result(db_query(user, msg)); //ԭ����û��db_free_result�� ����ע�᲻�Ͼ͸Ļ���
    format(msg, sizeof(msg), "[ϵͳ]:���������ʺ�:%s ����:%s\n����ϵ�Է����µ�¼���޸�����", changeidName, Password);
    SendClientMessage(playerid, Color_White, msg);
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", msg, "ȷ��", "");
    return 1;
}
forward SavePlayerInfo(playerid);
public SavePlayerInfo(playerid) {
    for (new i = 0; i <= 10; i++) {
        PlayerTextDrawDestroy(playerid, PlayerText:network_txtdraw[playerid][i]);
    }
    new msg[512], saveinfo[512];
    new string[96];
    new h = 0, m = 0, s = 0, n = 0, y = 0, day = 0;
    gettime(h, m, s), getdate(n, y, day);
    format(string, sizeof(string), "%d-%d-%d %02d:%02d:%02d", n, y, day, h, m, s);
    strins(saveinfo, "UPDATE `Users` SET `AdminLevel`=%d,`Skin`=%d,`Score`=%d,`Cash`=%d,`JailSeconds`=%d,`Yzwrong`=%d,`YzBantime`=%d,`LastLogin`='%s',`Designation`='%s',`Tail`='%s' WHERE `Name` = '%s'", strlen(saveinfo));
    // format(msg, sizeof(msg), "", PlayerInfo[playerid][AdminLevel], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Score], PlayerInfo[playerid][Cash], PlayerInfo[playerid][JailSeconds], PlayerInfo[playerid][yzwrong], PlayerInfo[playerid][yzbantime], string, GetName(playerid));
    format(msg, sizeof(msg), saveinfo, PlayerInfo[playerid][AdminLevel], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Score], PlayerInfo[playerid][Cash], PlayerInfo[playerid][JailSeconds], PlayerInfo[playerid][yzwrong], PlayerInfo[playerid][yzbantime], string, PlayerInfo[playerid][Designation], PlayerInfo[playerid][Tail], GetName(playerid));

    db_free_result(db_query(user, msg));

    // �����������
    format(msg, sizeof msg, "UPDATE `Users` SET `tWeather`= %d,`tHour`= %d,`tMinute`= %d,`NoCrash`= %d,`AutoFlip`= %d WHERE `Name` = '%s'", PlayerInfo[playerid][tWeather], PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute], PlayerInfo[playerid][NoCrash], PlayerInfo[playerid][AutoFlip], GetName(playerid));
    db_free_result(db_query(user, msg));
    format(msg, sizeof msg, "UPDATE `Users` SET `displayObject`= %d,`speedoMeter`= %d,`AutoFix`= %d,`enableInvincible`= %d, `netStats`=%d WHERE `Name` = '%s'", PlayerInfo[playerid][displayObject], PlayerInfo[playerid][speedoMeter], PlayerInfo[playerid][AutoFix], PlayerInfo[playerid][enableInvincible], PlayerInfo[playerid][netStats], GetName(playerid));
    db_free_result(db_query(user, msg));

    HouseSellPlayerInitialize(playerid); //��֪�� ������PHouse���ʼ��sellto��buyit��
    PlayerInfo[playerid][AutoFlip] = false;
    if(dinfobj[playerid] == 1) {
        DestroyDynamicObject(jd[playerid]); //���پ���
        DestroyDynamicObject(wy[playerid]); //����β��
        dinfobj[playerid] = 0; //2020.1.12 �����޸�infobj�������ߺ�û�������һ����ҵ�����
    }
    if(PlayerInfo[playerid][CreateCar] == 1) {
        DestroyVehicle(PlayerInfo[playerid][BuyID]);
        PlayerInfo[playerid][CreateCar] = 0;
    }
    //TpCheck[playerid] = 0;
    if(p_ppcCar[playerid]) DestroyVehicle(p_ppcCar[playerid]);
    PlayerInfo[playerid][BuyID] = 0;
    PlayerInfo[playerid][CarLock] = 0;
    PlayerInfo[playerid][lastZpos] = 0; //��һ���Z������ ���ڷ��ؾ������쳣����
    PlayerInfo[playerid][lastVehSpeed] = 0; //��һ��ĳ��� ���ڷ��ؾ������쳣����
    Cleantpa(playerid);
    Race_OnPlayerDisconnect(playerid); //������ߺ�����ϵͳ����
    PHouse_OnPlayerDisconnect(playerid); //������ߺ���ϵͳ����
    Boards_OnPlayerDisconnect(playerid); //������ߺ󹫸��ƵĴ���
    DeathMatch_OnPlayerDisconnect(playerid); //DM���ߺ�Ĵ���
    Camera_OnPlayerDisConnect(playerid);//��������ߺ�Ĵ���
    if(PlayerInfo[playerid][yssyjsq] != -1) KillTimer(PlayerInfo[playerid][yssyjsq]);
    // DestroyDynamic3DTextLabel(NoDieTime[playerid]); //ɾ���޵�ʱ���3D����
    // TextDrawDestroy(ReSpawningText[playerid]);
    // Delete3DTextLabel(NoDieTime[playerid]);
    for (new i = GetPlayerPoolSize(); i >= 0; i--) { //������������ߣ������ڹۿ�������ô��Ӧ�Ĺۿ�������Ӧ�ùر�tv
        if(IsPlayerConnected(i)) {
            if(PlayerInfo[i][tvid] == playerid && i != playerid) {
                // for (new a = 0; a <= 21; a++) {
                //     TextDrawHideForPlayer(i, velo[PlayerInfo[i][tvid]][a]);
                // }
                // CallRemoteFunction("ActTogglePlayerSpectating", "ii", i, 0);
                TogglePlayerSpectating(i, false);
                PlayerInfo[i][tvzt] = false;
                PlayerInfo[i][tvid] = i;
                SetPlayerVirtualWorld(i, 0);
                SendClientMessage(i, Color_Orange, "[TV]:�Է������ˣ�ȡ��TV.");
            }
        }
    }


    //�Ҿ����߱���
    //We gonna check if player exit in pickup goods mode
    //Otherwise the obj would set to pos 0,0,99999 =w=
    if(GOODS_STATUS[playerid] == true) {
        //if is yes,we reset the pos
        //SetDynamicObjectPos(GOODS[GOODS_OPRATEID[playerid]][OrderId],GOODS[GOODS_OPRATEID[playerid]][GoodX],GOODS[GOODS_OPRATEID[playerid]][GoodY],GOODS[GOODS_OPRATEID[playerid]][GoodZ]);


        //	ResetGoods(playerid,GOODS_OPRATEID[playerid]);
        GetPlayerPos(playerid, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ]);
        CreateGoods(GOODS_OPRATEID[playerid]);

        SaveGoods(GOODS_OPRATEID[playerid]);
        GOODS_STATUS[playerid] = false;
        TAKEDOWN_STATUS[playerid] = false;
        printf("RESTORE GOODS [ORDERID]:%s during player exit", GOODS[GOODS_OPRATEID[playerid]][OrderId]);
    }
    return 1;
}
forward LoadPlayerInfo(playerid);
public LoadPlayerInfo(playerid) {
    new msg[256], DBResult:uf;
    // format(msg, sizeof(msg), "SELECT ID,AdminLevel,Skin,Score,Cash,JailSeconds,BanTime,BanReason,Yzwrong,YzBanTime,Salt,Date FROM Users WHERE `Name` = '%s'", GetName(playerid));
    format(msg, sizeof(msg), "SELECT `ID`,`AdminLevel`,`Skin`,`Score`,`Cash`,`JailSeconds`,`BanTime`,`BanReason`,`Yzwrong`,`YzBanTime`,`Date`,`Designation`,`Tail` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
    uf = db_query(user, msg);
    db_get_field_assoc(uf, "ID", msg, sizeof(msg));
    PlayerInfo[playerid][ID] = strval(msg);
    db_get_field_assoc(uf, "AdminLevel", msg, sizeof(msg));
    PlayerInfo[playerid][AdminLevel] = strval(msg);
    db_get_field_assoc(uf, "Skin", msg, sizeof(msg));
    PlayerInfo[playerid][Skin] = strval(msg);
    db_get_field_assoc(uf, "Score", msg, sizeof(msg));
    PlayerInfo[playerid][Score] = strval(msg);
    SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
    db_get_field_assoc(uf, "Cash", msg, sizeof(msg));
    PlayerInfo[playerid][Cash] = strval(msg);
    db_get_field_assoc(uf, "JailSeconds", msg, sizeof(msg));
    PlayerInfo[playerid][JailSeconds] = strval(msg);
    db_get_field_assoc(uf, "BanTime", msg, sizeof(msg));
    PlayerInfo[playerid][BanTime] = strval(msg);
    db_get_field_assoc(uf, "BanReason", msg, sizeof(msg));
    PlayerInfo[playerid][BanReason] = strval(msg);
    db_get_field_assoc(uf, "Yzwrong", msg, sizeof(msg));
    PlayerInfo[playerid][yzwrong] = strval(msg);
    db_get_field_assoc(uf, "YzBanTime", msg, sizeof(msg));
    PlayerInfo[playerid][yzbantime] = strval(msg);
    db_get_field_assoc(uf, "Date", PlayerInfo[playerid][regdate], 41);
    db_get_field_assoc(uf, "Designation", PlayerInfo[playerid][Designation], 19);
    db_get_field_assoc(uf, "Tail", PlayerInfo[playerid][Tail], 33);
    db_free_result(uf);
    //db_get_field(uf,2,Race[i][rpassword],32);
    if(PlayerInfo[playerid][yzbantime] - gettime() < 21600000) { //������֤ʱ������⣬���һ�쳬����6����֤�ͻ��24Сʱ����֤
        PlayerInfo[playerid][yzwrong] = 0;
        PlayerInfo[playerid][yzbantime] = 0;
    }
    if(PlayerInfo[playerid][BanTime]) { //�ж�����Ƿ񱻷�� ��������ʱ�䵽����<0�Ϳ��Խ���˷������ʾ�����߳�
        if(PlayerInfo[playerid][BanTime] - gettime() > 0) {
            new day[4];
            UnixToDate(day, PlayerInfo[playerid][BanTime] - gettime());
            format(msg, sizeof(msg), "ԭ��:ϵͳ��⵽�����ʹ�õ�������������Ӱ������Ϸ��ƽ��,Code violation #%d\n����������Ϸ�Ƿ��в�����ʹ�õ�CLEO��������\n�����ʱ��:%d�� %dʱ %d�� %d��", PlayerInfo[playerid][BanReason], day[0], day[1], day[2], day[3]);
            ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ] ��������Ͽ�����", msg, "ȷ��", "");
            SetTimerEx("KickEx", 300, false, "i", playerid);
            return 0;
        }
        PlayerInfo[playerid][BanTime] = 0;
        PlayerInfo[playerid][BanReason] = 0;
        format(msg, sizeof(msg), "UPDATE `Users` SET `BanTime` = '0',`BanReason` = '-1' WHERE `Name` = '%s'", GetName(playerid));
        db_free_result(db_query(user, msg));
    }

    // ��ȡ��������б����һЩ����
    format(msg, sizeof(msg), "SELECT `tWeather`,`tHour`,`tMinute`,`NoCrash`,`AutoFlip`,`displayObject`,`speedoMeter`,`AutoFix`,`enableInvincible`,`netStats` FROM `Users` WHERE `Name` = '%s'", GetName(playerid));
    uf = db_query(user, msg);
    db_get_field_assoc(uf, "tHour", msg, sizeof(msg));
    PlayerInfo[playerid][tHour] = strval(msg);
    db_get_field_assoc(uf, "tMinute", msg, sizeof(msg));
    PlayerInfo[playerid][tMinute] = strval(msg);
    SetPlayerTime(playerid, PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute]); //���ʱ��

    db_get_field_assoc(uf, "tWeather", msg, sizeof(msg)); //����
    PlayerInfo[playerid][tWeather] = strval(msg);
    SetPlayerWeather(playerid, PlayerInfo[playerid][tWeather]);

    db_get_field_assoc(uf, "displayObject", msg, sizeof(msg));
    PlayerInfo[playerid][displayObject] = strval(msg); //��ҿ���/����obj
    if(!PlayerInfo[playerid][displayObject]) {
        Streamer_UpdateEx(playerid, 0, 0, -50000);
        Streamer_ToggleItemUpdate(playerid, 0, 0);
    }


    db_get_field_assoc(uf, "NoCrash", msg, sizeof(msg));
    PlayerInfo[playerid][NoCrash] = strval(msg); //������γ�����ײ
    if(PlayerInfo[playerid][NoCrash]) DisableRemoteVehicleCollisions(playerid, true);

    db_get_field_assoc(uf, "speedoMeter", msg, sizeof(msg));
    PlayerInfo[playerid][speedoMeter] = strval(msg); //����ٶȱ�
    InitializationVelo(playerid); //��ʼ���ٶȱ�
    if(!PlayerInfo[playerid][speedoMeter]) {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawHide(playerid, velo[playerid][a]);
        }
    }

    db_get_field_assoc(uf, "AutoFlip", msg, sizeof(msg)); //�Զ�����
    PlayerInfo[playerid][AutoFlip] = strval(msg);

    db_get_field_assoc(uf, "AutoFix", msg, sizeof(msg)); //�Զ��޳�
    PlayerInfo[playerid][AutoFix] = strval(msg);

    db_get_field_assoc(uf, "enableInvincible", msg, sizeof(msg)); //α�޵�
    PlayerInfo[playerid][enableInvincible] = strval(msg);
    if(PlayerInfo[playerid][enableInvincible]) SetPlayerHealth(playerid, 999999999); //����޵�״̬

    db_get_field_assoc(uf, "netStats", msg, sizeof(msg));
    PlayerInfo[playerid][netStats] = strval(msg); //��ҿ���/�ر��������
    InitializationNetWork(playerid); //��ʼ���������

    db_free_result(uf);

    format(pemail[playerid], 256, "-1");
    team_OnPlayerLogin(playerid);
    Camera_OnPlayerConnect(playerid);
    DeathMatch_PlayerLogin(playerid);
    Initialize_pWorld(playerid);
    PHouse_PlayerLogin(playerid); //��ʼ��PHouse��Area
    HouseSellPlayerInitialize(playerid); //��֪�� ������PHouse���ʼ��sellto��buyit��
    Attire_ReadData(playerid); //��ȡ���װ������
    Boards_OnPlayerConnect(playerid); //��ʼ��������
    Cars_OnPlayerConnect(playerid); //������ҵ�����Ĭ�ϲ���
    Tele_OnPlayerLogin(playerid); //��Ҳ鿴�����б�ʱ�ĳ�ʼ��ҳ��
    EnableStuntBonusForPlayer(playerid, 1); //�ر���Ч������ʾ
    GivePlayerMoney(playerid, 99999999);
    //Race_OnPlayerConnect(playerid); 2020.1.13�ĵ�onplayerconnect
    //���ܻᵼ�����ݴ���
    PlayerInfo[playerid][showStunt] = 1;
    PlayerInfo[playerid][showName] = 1;
    PlayerColorPage[playerid] = 1; //����޸���ɫ�Ĳ˵�Ĭ�ϵ�һҳ
    PlayerInfo[playerid][hys] = false; //Ĭ����ҳ�������ɫ�ر�
    PlayerInfo[playerid][lastZpos] = 0; //��һ���Z������ ���ڷ��ؾ������쳣����
    // PlayerInfo[playerid][lastVehSpeed] = 0; //��һ��ĳ��� ���ڷ��ؾ������쳣����

    SelectHousePage[playerid] = 1; //���ѡ���ӵ�ҳ��Ĭ����1
    splp[playerid] = 0; //����Ƿ�ʹ����/sp��״̬�ж�
    PlayerInfo[playerid][AFKTimes] = 0; //��ҹһ�ʱ���ʼ��0�� ���ڼ������Ƿ��������йһ�
    PlayerInfo[playerid][yssyjsq] = -1;

    SpawnPlayer(playerid); //����ҳ���
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0); //ֹͣ��������
    new temp[512];
    format(temp, sizeof(temp), "��һ��������������ڵĿ���Ļ���Ϸ������Ȼ���뵽������ഺ����\n������ô���棬��ô��Ѫ����ôɵ\n������һ֧�Ŷӣ������ھ���һ��ɢɳ\n����һ�����뵽���Ѿ�������һ�����ܵ�SAMP\nҲֻ�ܱ�����Ļ���Ϸ�����ţ�ֱ����ȥ\n������һ��Ŭ��쭳�������\nÿ���˵�������״��ͬ��ÿ���˵ľ�������Ҳ��ͬ\nֻϣ�������ѵ�һ��,��ϧ�˴ˣ����ն��ܹ����Ҹ�����\n��ӭ�ؼң���ʼ���գ���������\nָ��󲿷ֶ����������Ϥ�ģ�/help�鿴ָ��\nBվ�˺�:RaceSpeedTime ϣ�����ܹۿ�һ��av16412914");
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "һ������[R_ST]Hygen����", temp, "���ǰ�SAMP", "");
    // ��Щ�����䱣��  
    // new Query[300],escpname[24];
    // mysql_real_escape_string(GetName(playerid), escpname);
    // format(Query, sizeof(Query), "SELECT * FROM `players` WHERE `name` = '%s'", pname);
    // mysql_store_result(mysql_query(Query));
    // if(mysql_num_rows() != 0) {
    //     new queryex[64], sqlresult[256];
    //     new Field[256];
    //     new yz;
    //     format(queryex, sizeof(queryex), "SELECT * FROM `players` WHERE name = '%s'", pname);
    //     mysql_query(queryex);
    //     mysql_store_result();
    //     if(mysql_fetch_row(sqlresult) == 1) {

    //     }
    //     mysql_fetch_field_row(Field, "yz");
    //     yz = strval(Field);
    //     if(yz == 1) {
    //         SCM(playerid, Color_White, "[ϵͳ]�����������䱣��,���˺������������������һ�!ʹ��/sz���Դ򿪽���");
    //     } else {
    //         SCM(playerid, Color_White, "[ϵͳ]�㻹δ�������䱣��,���˺������������������һ�!ʹ��/sz���Դ򿪽���");
    //     }
    // }
    return 1;
}



public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(dialogid >= 400 && dialogid < 500) return CallRemoteFunction("Attire_OnDialogResponse", "iiiis", playerid, dialogid, response, listitem, inputtext);
    // new idx; //���msg���Ȳ��� �����湫�������ֳ���64�ֵ�ʱ����ܻᵼ���쳣������msg����ȫ���þֲ�����
    if(dialogid == TeleListDialog) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��һҳ") == 0) {
                TelePage[playerid]--;
                Tele_ShowListDialog(playerid, TelePage[playerid]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                TelePage[playerid]++;
                Tele_ShowListDialog(playerid, TelePage[playerid]);
                return 1;
            }
            format(msg, sizeof msg, "/%s", inputtext);
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, msg);
            // OnPlayerCommandText(playerid, msg);
            return 1;
        }
        return 1;
    }
    if(dialogid == Dialog_Tail) {
        if(response) {
            if(PlayerInfo[playerid][Cash] < 3000) return SendClientMessage(playerid, Color_White, "[Сβ��]���Ľ�Ҳ���3000");
            if(strlen(inputtext) < 4 || strlen(inputtext) > 32) {
                SendClientMessage(playerid, Color_White, "[Сβ��]�����쳣,��ΧΪ2~16������,4~32�������ַ�");
                return cmd_motto(playerid, "");
            }
            if(strfind(inputtext, "\\", true) != -1 || strfind(inputtext, " ", true) != -1 || strfind(inputtext, "[", true) != -1 || strfind(inputtext, "]", true) != -1) {
                SendClientMessage(playerid, Color_White, "[Сβ��]����Ҫ��[],������ʹ�ÿո�,\\�ȷ���");
                return cmd_motto(playerid, "");
            }
            if(strfind(inputtext, "����", true) != -1 || strfind(inputtext, "GM", false) != -1 || strfind(inputtext, "admin", false) != -1) {
                SendClientMessage(playerid, Color_White, "[Сβ��]������ʹ�ù���Ա�����ǰ׺");
                return cmd_motto(playerid, "");
            }
            if(strcmp(inputtext, "null", false) == 0) {
                format(PlayerInfo[playerid][Tail], 33, "");
                SendClientMessage(playerid, Color_White, "[Сβ��]����ɹ�!");
                return 1;
            }
            new placeholder;
            for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
            {
                placeholder = strfind(inputtext, InvalidWords[i], true);
                if(placeholder != -1) return SendClientMessage(playerid, Color_White, "[Сβ��]���ڲ�����ʹ�õ�����");
            }
            format(PlayerInfo[playerid][Tail], 33, inputtext);
            GivePlayerCash(playerid, -3000);
            SendClientMessage(playerid, Color_White, "[Сβ��]�����ɹ�!");
        }
        return 1;
    }
    if(dialogid == Dialog_Designation) {
        if(response) {
            if(PlayerInfo[playerid][Cash] < 3000) return SendClientMessage(playerid, Color_White, "[�ƺ�]���Ľ�Ҳ���3000");
            if(strfind(inputtext, "{", true) == 0 && strfind(inputtext, "}", true) == 7) //�ж��Ƿ���������ɫ �еĻ����Ȳ��ܳ���5������
            {
                if(strlen(inputtext) < 2 || strlen(inputtext) > 18) {
                    SendClientMessage(playerid, Color_White, "[�ƺ�]�ƺų����쳣,��ΧΪ1~5������,2~10�������ַ�");
                    return cmd_wdch(playerid, "");
                }
            } else {
                if(strlen(inputtext) < 2 || strlen(inputtext) > 10) {
                    SendClientMessage(playerid, Color_White, "[�ƺ�]�ƺų����쳣,��ΧΪ1~5������,2~10�������ַ�");
                    return cmd_wdch(playerid, "");
                }
            }
            if(strfind(inputtext, "\\", true) != -1 || strfind(inputtext, " ", true) != -1 || strfind(inputtext, "[", true) != -1 || strfind(inputtext, "]", true) != -1) {
                SendClientMessage(playerid, Color_White, "[�ƺ�]�ƺŲ���Ҫ��[],������ʹ�ÿո�,\\�ȷ���");
                return cmd_wdch(playerid, "");
            }
            if(strfind(inputtext, "����", true) != -1 || strfind(inputtext, "GM", false) != -1 || strfind(inputtext, "admin", false) != -1) {
                SendClientMessage(playerid, Color_White, "[�ƺ�]������ʹ�ù���Ա�����ǰ׺");
                return cmd_wdch(playerid, "");
            }
            if(strcmp(inputtext, "null", false) == 0) {
                format(PlayerInfo[playerid][Designation], 19, "");
                SendClientMessage(playerid, Color_White, "[�ƺ�]����ɹ�!");
                return 1;
            }
            new placeholder;
            for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
            {
                placeholder = strfind(inputtext, InvalidWords[i], true);
                if(placeholder != -1) return SendClientMessage(playerid, Color_White, "[�ƺ�]�ƺ��д��ڲ�����ʹ�õ�����");
            }
            format(PlayerInfo[playerid][Designation], 19, inputtext);
            GivePlayerCash(playerid, -3000);
            SendClientMessage(playerid, Color_White, "[�ƺ�]�����ƺųɹ�!");
        }
        return 1;
    }
    if(dialogid == Dialog_DeathMatch) {
        if(response) {
            if(listitem == 0) {
                new msg[1024];
                for (new i = 0; i < DeathMatchCount; i++) {
                    format(msg, sizeof msg, "%s%s\n", msg, DeathMatch_Map[i]);
                }
                format(msg, sizeof msg, "%s\n________________________________________________\n������ [��ͼ��] [�Ƿ�������;����(0 = ������, 1 = ����)] [��ͷ]", msg);
                ShowPlayerDialog(playerid, Dialog_DeathMatch_R_C, DIALOG_STYLE_INPUT, Dialog_DeathMatch_Title, msg, "����", "����");
                return 1;
            }
            if(listitem == 1) {
                DeathMatch_Game[playerid][g_page] = 1;
                ShowSearchRoomDialog(playerid, 1);
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == Dialog_DeathMatch_S_R) {
        if(response) {
            new msg[128], idx, id;
            msg = strtok(inputtext, idx);
            if(mk_strcmp(msg, "��һҳ") == 0) {
                if(DeathMatch_Game[playerid][g_page] == 1) {
                    SCM(playerid, Color_White, "[DM]���ǵ�һҳ.");
                    return 1;
                }
                DeathMatch_Game[playerid][g_page]--;
                ShowSearchRoomDialog(playerid, DeathMatch_Game[playerid][g_page]);
                return 1;
            }
            if(mk_strcmp(msg, "��һҳ") == 0) {
                if(DeathMatch_Game[playerid][g_page] >= GetMaxPage(GetRoomCount())) {
                    SCM(playerid, Color_White, "[DM]�������һҳ.");
                    return 1;
                }
                DeathMatch_Game[playerid][g_page]++;
                ShowSearchRoomDialog(playerid, DeathMatch_Game[playerid][g_page]);
                return 1;
            }
            if(mk_strcmp(msg, "ID") == 0) {
                msg = strtok(inputtext, idx);
                id = strval(msg);
                new string[256];
                // new dstate[][8] = {
                //     "׼����",
                //     "�ѿ�ʼ"
                // };
                if(DeathMatch_Room[id][rstate] == 0) {
                    format(string, sizeof string, "������:[%s]\n������:[%s]\n��ǰ����:[%d]\nɱ¾:[%d]\n״̬:[׼����]", DeathMatch_Room[id][rmapname], DeathMatch_Room[id][rcreator], DeathMatch_Room[id][rplayer], DeathMatch_Room[id][rmax]);
                    format(string, sizeof string, "%s\n{00FF00}���� %d", string, id);
                }
                if(DeathMatch_Room[id][rstate] == 1 && DeathMatch_Room[id][rmode] == 1) {
                    format(string, sizeof string, "������:[%s]\n������:[%s]\n��ǰ����:[%d]\nɱ¾:[%d]\n״̬:[�ѿ�ʼ]", DeathMatch_Room[id][rmapname], DeathMatch_Room[id][rcreator], DeathMatch_Room[id][rplayer], DeathMatch_Room[id][rmax]);
                    format(string, sizeof string, "%s\n{00FF00}���� %d", string, id);
                }
                ShowPlayerDialog(playerid, Dialog_DeathMatch_R_D, DIALOG_STYLE_LIST, Dialog_DeathMatch_Title, string, "ѡ��", "����");
                return 1;
            }
        } else {
            ShowPlayerDeathMatchDialog(playerid);
        }
        return 1;
    }
    if(dialogid == Dialog_DeathMatch_R_D) {
        if(!response) {
            ShowSearchRoomDialog(playerid, DeathMatch_Game[playerid][g_page]);
            return 1;
        }
        new msg[128], idx, id;
        msg = strtok(inputtext, idx);
        if(mk_strcmp(msg, "����") == 0) {
            msg = strtok(inputtext, idx);
            id = strval(msg);
            if(DeathMatch_Room[id][rstate] == 1 && DeathMatch_Room[id][rmode] == 0) {
                SCM(playerid, Color_White, "[DM]�÷��䲻������;����.");
                return 1;
            }
            if(DeathMatch_Game[playerid][g_rid] != -1) {
                SCM(playerid, Color_White, "[DM]���Ѿ�������һ������.");
                return 1;
            }
            if(DeathMatch_Room_Join(playerid, id) == 0) {
                SCM(playerid, Color_White, "[DM]�÷�����������.");
            }
            if(DeathMatch_Room[id][rstate] == 1) {
                DeathMatch_Game[playerid][g_mapid] = DeathMatch_Room[id][rmapid];
                DeathMatch_SetGunSpawn(playerid);
            }
            return 1;
        }
        return 1;
    }
    if(dialogid == Dialog_DeathMatch_R_C) {
        if(!response) {
            ShowPlayerDeathMatchDialog(playerid);
            return 1;
        }
        new msg[128], idx, id;
        if(DeathMatch_Game[playerid][g_rid] != -1) {
            SCM(playerid, Color_White, "[DM]�����˳�����.");
            return 1;
        }
        msg = strtok(inputtext, idx);
        if(!strlen(msg)) {
            SCM(playerid, Color_White, "[DM]��ͼ������Ϊ��.");
            return 1;
        }
        new string[MAX_PLAYER_NAME];
        format(string, sizeof(string), msg);
        if(IsMapNameExist(string) == -1) {
            SCM(playerid, Color_White, "[DM]����ĵ�ͼ��.");
            return 1;
        }
        msg = strtok(inputtext, idx);
        if(!strlen(msg)) {
            SCM(playerid, Color_White, "[DM]����ģʽ����Ϊ��.");
            return 1;
        }
        new mode = strval(msg);
        if(mode < 0 || mode > 1) {
            SCM(playerid, Color_White, "[DM]�����ģʽ.");
            return 1;
        }
        id = SearchForIdleRoom();
        if(id == -1) {
            SCM(playerid, Color_White, "[DM]��ǰ��������.");
            return 1;
        }
        msg = strtok(inputtext, idx);
        if(!strlen(msg)) {
            SCM(playerid, Color_White, "[DM]��ͷ��������Ϊ��.");
            return 1;
        }
        new rmaxs = strval(msg);
        if(rmaxs < 10 || rmaxs > 300) {
            SCM(playerid, Color_White, "[DM]�������ͷ����,��Χ:10 - 300");
            return 1;
        }
        // new modename[2][8] = {"������","����"};
        DeathMatch_Room_Create(playerid, id, mode, string, rmaxs);
        if(mode) format(msg, sizeof msg, "[DM]���䴴���ɹ�. ��;����:[����], ��ʼ:[/dm start], �ر�:[/dm leave]");
        else format(msg, sizeof msg, "[DM]���䴴���ɹ�. ��;����:[������], ��ʼ:[/dm start], �ر�:[/dm leave]");
        // format(msg, sizeof msg, "[DM]���䴴���ɹ�. ��;����:[%s], ��ʼ:[/dm start], �ر�:[/dm leave]", modename[mode]);
        SCM(playerid, Color_White, msg);
        if(DeathMatch_Room_Join(playerid, id) == 0) {
            SCM(playerid, Color_White, "[DM]�÷�����������.");
            return 1;
        }
        return 1;
    }
    if(dialogid == CAMERA_DIALOG_MIAN) //��ͷ������
    {
        if(response) {
            switch (listitem) {
                case 0:{
                    Camera_SelectDialog(playerid, PlayerCamera[playerid][Page]);
                    return 1;
                }
                case 1:{
                    KillTimer(PlayerCamera[playerid][cTimerID]);
                    SetCameraBehindPlayer(playerid);
                    return 1;
                }
                case 2:{
                    Camera_ShowPlayerDialog(playerid, PlayerCamera[playerid][Page]);
                    return 1;
                }
                case 3:{
                    new msg[128];
                    format(msg, sizeof msg, "����ǰ�ķ���ģʽΪ%d\n1:�������ƶ����ƶ��������ת�����(Ĭ��)\n2:���ֻ�������ת(�޷��ƶ�)",g_FlyMode[playerid][flyMode]);
                    Dialog_Show(playerid,CameraType,DIALOG_STYLE_INPUT,"��༭����ƶ��ӽǵ�����",msg,"ȷ��","����");
                    // �ӽ�����
                    return 1;
                }
                case 4:{
                    new msg[128];
                    format(msg, sizeof msg, "����ǰ���ӽ�����Ϊ%.2f\n�����·�������Ҫ����ֵ,��ֵԽ����Խ��,��֮Խ��",g_FlyMode[playerid][flyMovementSpeed]);
                    Dialog_Show(playerid,diaCameraSpeed,DIALOG_STYLE_INPUT,"��༭����ƶ��ӽǵ��ٶ�",msg,"ȷ��","����");
                    // �ӽ�����
                    return 1;
                }
            }
            return 1;
        }
        return 1;
    }
    if(dialogid == CAMERA_DIALOG_MIAN + 1) //��������
    {
        if(response) {
            for (new i; i < CAMERA_DIALOG_ROWS; i++) {
                if(listitem == i) {
                    new row;
                    new title[32];
                    new msg[1024];
                    row = (PlayerCamera[playerid][Page] - 1) * CAMERA_DIALOG_ROWS + i;
                    if(CameraInfo[playerid][CameraStatus][row] == 0) format(msg, sizeof(msg), "������ͷ", msg);
                    else if(CameraInfo[playerid][CameraStatus][row] == 1) format(msg, sizeof(msg), "ɾ����ͷ\n�鿴\nMoveTime[%d]", CameraInfo[playerid][MoveTime][row]);
                    format(title, sizeof(title), "��ͷ[%d]", row);
                    PlayerCamera[playerid][Using] = row;
                    ShowPlayerDialog(playerid, CAMERA_DIALOG_MIAN + 2, DIALOG_STYLE_LIST, title, msg, "ȷ��", "ȡ��");
                    return 1;
                }
            }
            switch (listitem) {
                case 10:{
                    PlayerCamera[playerid][Page]--;
                    Camera_ShowPlayerDialog(playerid, PlayerCamera[playerid][Page]);
                    return 1;
                }
                case 11:{
                    PlayerCamera[playerid][Page]++;
                    Camera_ShowPlayerDialog(playerid, PlayerCamera[playerid][Page]);
                    return 1;
                }
            }
            return 1;
        }
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/camera");
        return 1;
    }
    if(dialogid == CAMERA_DIALOG_MIAN + 2) //��ʾ��ͷ��Ϣ
    {
        if(response) {
            new nUsing = PlayerCamera[playerid][Using];
            switch (listitem) {
                case 0:{
                    if(CameraInfo[playerid][CameraStatus][nUsing] == 0) {
                        CreateCamera[playerid][CreateStatus] = 1;
                        SetPlayerCustomCamera(playerid, g_FlyMode[playerid][flyMode]);
                        SCM(playerid, Color_White, "[�����]��һ�� - ���þ�ͷλ�ú�,��������������ͷ");
                        return 1;
                    }
                    if(CameraInfo[playerid][CameraStatus][nUsing] == 1) {
                        DeletCamera(playerid, nUsing);
                        Camera_ShowPlayerDialog(playerid, PlayerCamera[playerid][Page]);
                        return 1;
                    }
                }
                case 1:{
                    SetPlayerCameraPos(playerid, CameraInfo[playerid][CameraX][nUsing], CameraInfo[playerid][CameraY][nUsing], CameraInfo[playerid][CameraZ][nUsing]);
                    SetPlayerCameraLookAt(playerid, CameraInfo[playerid][CameraAtX][nUsing], CameraInfo[playerid][CameraAtY][nUsing], CameraInfo[playerid][CameraAtZ][nUsing]);
                    CreateCamera[playerid][CreateStatus] = 3;
                    SCM(playerid, Color_White, "[�����]������������");
                    return 1;
                }
                case 2:{
                    ShowPlayerDialog(playerid, CAMERA_DIALOG_MIAN + 3, DIALOG_STYLE_INPUT, "�޸�movetime", "�����޸���ֵ", "ȷ��", "ȡ��");
                    return 1;
                }
            }
            return 1;
        }
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/camera");
        return 1;
    }
    if(dialogid == CAMERA_DIALOG_MIAN + 3) //�޸�movetime����
    {
        if(response) {
            new id = PlayerCamera[playerid][Using];
            CameraInfo[playerid][MoveTime][id] = strval(inputtext);
            Camera_ShowPlayerDialog(playerid, PlayerCamera[playerid][Page]);
            return 1;
        }
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/camera");
        return 1;
    }
    if(dialogid == CAMERA_DIALOG_MIAN + 4) //ѡ�񲥷ž�ͷ����
    {
        if(response) {
            for (new i; i < CAMERA_DIALOG_ROWS; i++) {
                if(listitem == i) {
                    new row;
                    row = (PlayerCamera[playerid][Page] - 1) * CAMERA_DIALOG_ROWS + i;
                    if(CreateCamera[playerid][CreateStatus] == 4) {
                        PlayerCamera[playerid][EndID] = row;
                        PlayerCamera[playerid][cTimerID] = SetTimerEx("PlayCamera", 200, false, "iii", playerid, PlayerCamera[playerid][StartID], PlayerCamera[playerid][EndID]);

                        if(PlayerCamera[playerid][StartID] < PlayerCamera[playerid][EndID]) {
                            PlayerCamera[playerid][TF] = 1;
                        } else {
                            PlayerCamera[playerid][TF] = 2;
                        }
                        ResetCreateInfo(playerid);
                        return 1;
                    } else {
                        PlayerCamera[playerid][StartID] = row;
                        CreateCamera[playerid][CreateStatus] = 4;
                        Camera_SelectDialog(playerid, PlayerCamera[playerid][Page]);
                    }
                    return 1;
                }
            }
            switch (listitem) {
                case 10:{
                    PlayerCamera[playerid][Page]--;
                    Camera_SelectDialog(playerid, PlayerCamera[playerid][Page]);
                    return 1;
                }
                case 11:{
                    PlayerCamera[playerid][Page]++;
                    Camera_SelectDialog(playerid, PlayerCamera[playerid][Page]);
                    return 1;
                }
            }
            return 1;
        }
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/camera");
        return 1;
    }
    if(dialogid == Team_DescriptionDialog) //���������ʱ���ȰѼ�����
    {
        if(!response) {
            team_DescriptionChange(TeamInfo[SelectedTeam[playerid]][TID], TeamInfo[SelectedTeam[playerid]][Description]);
            SendClientMessage(playerid, Color_Team, "[�Ŷ�]�޸ļ��ɹ�");
            return 1;
        }
        if(strcmp(inputtext, " ") == 0 || strlen(inputtext) < 1 || strlen(inputtext) > 420) {
            ShowPlayerDialog(playerid, Team_DescriptionDialog, DIALOG_STYLE_INPUT, "�ŶӼ��", "{FF0000}��������\n����Ϊ�ղ��������ַ���(1-1024)֮��", "ȷ��", "����");
            return 1;
        }
        format(TeamInfo[SelectedTeam[playerid]][Description], 512, "%s\n", inputtext);
        new placeholder, msg[600];
        for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
        {
            placeholder = strfind(TeamInfo[SelectedTeam[playerid]][Description], InvalidWords[i], true);
            if(placeholder != -1) {
                for (new x = placeholder; x < placeholder + strlen(InvalidWords[i]); x++) {
                    TeamInfo[SelectedTeam[playerid]][Description][x] = '*';
                }
            }
        }
        format(msg, sizeof(msg), "��Ŀǰ���������:%s", TeamInfo[SelectedTeam[playerid]][Description]);
        ShowPlayerDialog(playerid, Team_NextDescriptionDialog, DIALOG_STYLE_INPUT, "�ŶӼ��", msg, "��һ��", "ȷ��");
        return 1;
    }
    if(dialogid == Team_NextDescriptionDialog) {
        if(!response) {
            team_DescriptionChange(TeamInfo[SelectedTeam[playerid]][TID], TeamInfo[SelectedTeam[playerid]][Description]);
            SendClientMessage(playerid, Color_Team, "[�Ŷ�]�޸ļ��ɹ�");
            return 1;
        }
        if(strcmp(inputtext, " ") == 0 || strlen(inputtext) < 1 || strlen(inputtext) > 512 || strlen(TeamInfo[SelectedTeam[playerid]][Description]) >= 900) {
            ShowPlayerDialog(playerid, Team_NextDescriptionDialog, DIALOG_STYLE_INPUT, "�ŶӼ��", "{FF0000}��������\n����Ϊ�ղ��������ַ���(1-1024)֮��", "ȷ��", "����");
            return 1;
        }
        format(TeamInfo[SelectedTeam[playerid]][Description], 512, "%s%s\n", TeamInfo[SelectedTeam[playerid]][Description], inputtext);
        new placeholder, msg[600];
        for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
        {
            placeholder = strfind(TeamInfo[SelectedTeam[playerid]][Description], InvalidWords[i], true);
            if(placeholder != -1) {
                for (new x = placeholder; x < placeholder + strlen(InvalidWords[i]); x++) {
                    TeamInfo[SelectedTeam[playerid]][Description][x] = '*';
                }
            }
        }
        format(msg, sizeof(msg), "��Ŀǰ���������:%s", TeamInfo[SelectedTeam[playerid]][Description]);
        ShowPlayerDialog(playerid, Team_NextDescriptionDialog, DIALOG_STYLE_INPUT, "�ŶӼ��", msg, "��һ��", "ȷ��");
        return 1;
    }
    if(dialogid == Team_DisbandDialog) {
        if(!response) {
            if(!strcmp(TeamInfo[SelectedTeam[playerid]][FullName], PlayerInfo[playerid][Team], true)) {
                team_Delete(TeamInfo[SelectedTeam[playerid]][TID]);
                SendClientMessage(playerid, Color_Team, "[�Ŷ�]���Ľ�ɢ��...");
            } else {
                SendClientMessage(playerid, Color_Team, "[�Ŷ�]ϵͳ�ڲ�����...");
            }
        }
        return 1;
    }
    if(dialogid == Team_ChangeShortNameDialog) { //Ҫ�Ӹ��ж��ǲ�����������
        if(response) {
            if(strlen(inputtext) < 2 || strlen(inputtext) > 12) return ShowPlayerDialog(playerid, Team_ChangeShortNameDialog, DIALOG_STYLE_INPUT, "�޸ļ��", "�����·������Ŷӵļ��\n������2~12λ����", "ȷ��", "ȡ��");
            new placeholder;
            for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
            {
                placeholder = strfind(inputtext, InvalidWords[i], true);
                if(placeholder != -1) {
                    SendClientMessage(playerid, Color_Team, "[�Ŷ�]����ʹ�÷Ƿ�����");
                    return 1;
                }
            }
            new flag = true;
            for (new i = 0; i < TeamCount; i++) {
                if((!strcmp(TeamInfo[i][FullName], inputtext, true)) || (!strcmp(TeamInfo[i][ShortName], inputtext, true))) {
                    flag = false;
                    break;
                }
            }
            if(!flag) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�Ѿ�����ͬ���Ƶ��ŶӴ�����Ŷ!");
            team_ShortNameChange(TeamInfo[SelectedTeam[playerid]][TID], inputtext);
            SendClientMessage(playerid, Color_Team, "[�Ŷ�]�޸��ŶӼ�Ƴɹ�");
        }
        return 1;
    }
    if(dialogid == Team_ChangeFullNameDialog) { //Ҫ�Ӹ��ж��ǲ�����������
        if(response) {
            if(strlen(inputtext) < 2 || strlen(inputtext) > 24) return ShowPlayerDialog(playerid, Team_ChangeShortNameDialog, DIALOG_STYLE_INPUT, "�޸ļ��", "�����·������Ŷӵļ��\n������2~12λ����", "ȷ��", "ȡ��");
            if(!strcmp(inputtext, "null", false)) return SCM(playerid, Color_Team, "[�Ŷ�]����ʹ�÷Ƿ���");
            new placeholder;
            for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
            {
                placeholder = strfind(inputtext, InvalidWords[i], true);
                if(placeholder != -1) {
                    SendClientMessage(playerid, Color_Team, "[�Ŷ�]����ʹ�÷Ƿ�����");
                    return 1;
                }
            }
            new flag = true;
            for (new i = 0; i < TeamCount; i++) {
                if((!strcmp(TeamInfo[i][FullName], inputtext, true)) || (!strcmp(TeamInfo[i][ShortName], inputtext, true))) {
                    flag = false;
                    break;
                }
            }
            if(!flag) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�Ѿ�����ͬ���Ƶ��ŶӴ�����Ŷ!");
            team_FullNameChange(TeamInfo[SelectedTeam[playerid]][TID], inputtext);
            SendClientMessage(playerid, Color_Team, "[�Ŷ�]�޸��Ŷ�ȫ�Ƴɹ�");
        }
        return 1;
    }
    if(dialogid == Team_ManageDialog) {
        // �޸ļ��\n�޸�ȫ��\n�޸Ľ���\n�����Ա\nת���Ŷ�\n{FF0000}��ɢ�Ŷ�
        // �����Ա�г�Ա�б� �߳���Ա ������Ա ȡ������Ա ������� ת���Ŷ�
        if(response) {
            if(listitem == 0) {
                ShowPlayerDialog(playerid, Team_ChangeShortNameDialog, DIALOG_STYLE_INPUT, "�޸ļ��", "�����·������Ŷӵļ��\n������2~12λ����", "ȷ��", "ȡ��");
                return 1;
            }
            if(listitem == 1) {
                ShowPlayerDialog(playerid, Team_ChangeFullNameDialog, DIALOG_STYLE_INPUT, "�޸�ȫ��", "�����·������Ŷӵ�ȫ��\n������2~24λ����", "ȷ��", "ȡ��");
                return 1;
            }
            if(listitem == 2) {
                format(TeamInfo[SelectedTeam[playerid]][Description], 1024, " ");
                ShowPlayerDialog(playerid, Team_DescriptionDialog, DIALOG_STYLE_INPUT, "�ŶӼ��", "{FF0000}��������\n����Ϊ�ղ��������ַ���(1-1024)֮��", "ȷ��", "����");
                return 1;
            }
            if(listitem == 3) { //�����Ա
                ShowPlayerDialog(playerid, Team_MemberManageDialog, DIALOG_STYLE_LIST, "�Ŷӹ���", "��Ա�б�\n�������", "ȷ��", "����");
                return 1;
            }
            // if(listitem == 4) { //ת���Ŷ�   ת���Ŷӷ��ڹ����Ա����ˣ�������ѡ����ҾͿ���ת����
            //     if(team_GetLevel(PlayerInfo[playerid][ID],SelectedTeam[playerid])!=2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�������ŶӵĴ�ʼ��");
            // }
            if(listitem == 4) {
                if(team_GetLevel(PlayerInfo[playerid][ID], SelectedTeam[playerid]) != 2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�������ŶӵĴ�ʼ��");
                ShowPlayerDialog(playerid, Team_DisbandDialog, DIALOG_STYLE_MSGBOX, "���һ��ȷ��", "�����ȷ��Ҫ��ɢ�����Ŷ���?�������һ����ʾ!", "��", "��");
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == Team_MemberManageDialog) {
        if(response) {
            if(listitem == 0) {
                team_MemberList(playerid, SelectMemberPage[playerid], TeamInfo[SelectedTeam[playerid]][TID]);
            }
            if(listitem == 1) {
                ShowPlayerDialog(playerid, Team_InviteDialog, DIALOG_STYLE_INPUT, "�������", "�����·���������Ҫ��������ID", "ȷ��", "ȡ��");
            }
        } else {
            team_Manage(playerid, SelectedTeam[playerid]); //���ع������
        }
        return 1;
    }
    if(dialogid == Team_InviteDialog) {
        if(response) {
            if(strlen(inputtext) < 2 || strlen(inputtext) > 24) return ShowPlayerDialog(playerid, Team_InviteDialog, DIALOG_STYLE_INPUT, "�������", "�����·���������Ҫ��������ID", "ȷ��", "ȡ��");
            if(AccountCheck(inputtext)) {

                new msg[256], DBResult:cf;
                format(msg, sizeof(msg), "SELECT * FROM `Users` WHERE `Name` = '%s'", inputtext); //��ȥ������UID 
                cf = db_query(user, msg);
                db_get_field_assoc(cf, "ID", msg, sizeof(msg));
                new uid = strval(msg);
                db_free_result(cf);

                //Ȼ���ж����ǲ����Ѿ����Ŷ���,���û�о�insert �оͳ���.
                format(msg, sizeof(msg), "SELECT * FROM `teamuser` WHERE `UID` = %d", uid);
                cf = db_query(Teamdb, msg);
                new cut = db_num_rows(cf);
                db_free_result(cf);
                if(cut) return ShowPlayerDialog(playerid, Team_InviteDialog, DIALOG_STYLE_INPUT, "�������", "�Է��Ѿ���ĳ���Ŷ�����\n�����·���������Ҫ��������ID", "ȷ��", "ȡ��");


                new flag = true;
                for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                    if(PlayerInfo[i][ID] == uid && tInvited[i] == -1) //�����ҵ��Ŷ���Ϣ
                    {
                        flag = false;
                        team_Invite(i, TeamInfo[SelectedTeam[playerid]][TID], GetName(playerid), TeamInfo[SelectedTeam[playerid]][FullName]);
                        SetTimerEx("tinviteTimer", 15000, false, "ii", i, playerid);
                        break;
                    }
                }
                if(flag) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�Է������߻���������...");
                SendClientMessage(playerid, Color_Team, "[�Ŷ�]���ѷ�������,��ȴ��Է��ظ�,15���ʧЧ");


                // format(msg, sizeof(msg), "SELECT * FROM `teamuser` ORDER BY Level DESC WHERE TID = %d", TeamInfo[SelectedTeam[playerid]][TID]); //�ж��Ŷ��Ƿ��������� Ĭ��100����
                // // �ʹ�ʼ�˿϶�������ǰ���
                // cf = db_query(Teamdb, msg);
                // cut = db_num_rows(cf);
                // db_free_result(cf);
                // if(cut >= MAX_TeamMember) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]��������,������������!");
                // team_Join(uid, TeamInfo[SelectedTeam[playerid]][TID]); //������ֱ�Ӱ����������� û��ͬ�������һ˵
                // format(msg, sizeof(msg), "[�Ŷ�]����ԱȨ�� - ����%s�����˶���", inputtext);
                // SendClientMessage(playerid, Color_Team, msg);
                // team_Manage(playerid, SelectedTeam[playerid]);
                // for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                //     if(PlayerInfo[i][ID] == uid) //�����ҵ��Ŷ���Ϣ
                //     {
                //         format(PlayerInfo[i][Team], 24, TeamInfo[SelectedTeam[playerid]][FullName]);
                //         break;
                //     }
                // }
                // Ҫ���������tpһ�� ̫������
            } else {
                ShowPlayerDialog(playerid, Team_InviteDialog, DIALOG_STYLE_INPUT, "�������", "��Ҳ�����\n�����·���������Ҫ��������ID", "ȷ��", "ȡ��");
            }
        } else {
            team_Manage(playerid, SelectedTeam[playerid]);
        }
        return 1;
    }
    if(dialogid == Team_MemberDialog) {
        if(response) {
            new msg[1024], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��һҳ") == 0) {
                SelectMemberPage[playerid]--;
                team_MemberList(playerid, SelectMemberPage[playerid], TeamInfo[SelectedTeam[playerid]][TID]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                SelectMemberPage[playerid]++;
                team_MemberList(playerid, SelectMemberPage[playerid], TeamInfo[SelectedTeam[playerid]][TID]);
                return 1;
            }
            if(!strlen(inputtext)) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�������ڲ�����");
            SelectedUID[playerid] = strval(inputtext); // ����ѡ�к�
            if(!TeamInfo[SelectedTeam[playerid]][TID]) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]������Ŷ�ID");
            if(strcmp(TeamInfo[SelectedTeam[playerid]][FullName], PlayerInfo[playerid][Team], false)) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�����Ǹ��Ŷӵĳ�Ա");
            // ©�˸������û��ǲ�������Ŷӵĳ�Ա ��Ȼ�Ļ�����ֿ�Ӳ������� 2020.3.23�޸�
            new title[48];
            format(title, sizeof(title), "��Ա - UID:%d", SelectedUID[playerid]);
            format(msg, sizeof msg, "��ѡ��\n��TA����\n���͵�TA\n�������Ա\nȡ������Ա\n{FF0000}ת���Ŷ�\n�Ƴ��Ŷ�", TeamInfo[SelectedTeam[playerid]][ShortName], TeamInfo[SelectedTeam[playerid]][TID], TeamInfo[SelectedTeam[playerid]][FullName]);
            ShowPlayerDialog(playerid, Team_MemberManagerInviteAndList, DIALOG_STYLE_LIST, "��ϸ��Ϣ", msg, "ȷ��", "����");
        } else {
            //����ǹ���Ա�Ļ��ͷ��ص�������� ���򷵻��ҵ��Ŷӽ���
            if(team_GetLevel(PlayerInfo[playerid][ID], SelectedTeam[playerid])) team_Manage(playerid, SelectedTeam[playerid]);
        }
        return 1;
    }
    if(dialogid == Team_MemberManagerInviteAndList) {
        if(response) {
            if(listitem == 1) {
                team_Get(-1, playerid);
                return 1;
            }
            if(listitem == 2) {
                team_Goto(-1, playerid);
                return 1;
            }
            if(listitem == 3) {
                if(team_GetLevel(SelectedUID[playerid], SelectedTeam[playerid])) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�Է��Ѿ��ǹ���Ա��");
                if(team_GetLevel(SelectedUID[playerid], SelectedTeam[playerid]) < 2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]����Ȩ�޲���");
                new msg[96]; //������ж϶Է���level�ȼ� �����2�Ļ� �Ͳ�Ӧ����ȥ������ 1�Ļ�Ҳ��
                team_GiveAdmin(SelectedUID[playerid], 1);
                // SendClientMessage(playerid, Color_Team, "[�Ŷ�]����Է�����ԱȨ��");
                format(msg, sizeof(msg), "[�Ŷ�]����Ա%s(%d)�����Ŷӳ�ԱUID:%d����Ա", GetName(playerid), playerid, SelectedUID[playerid]);
                team_SCM(msg, PlayerInfo[playerid][Team]);
                return 1;
            }
            if(listitem == 4) {
                if(team_GetLevel(SelectedUID[playerid], SelectedTeam[playerid]) == 2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]���ɶԴ�ʼ�˽��в���");
                if(team_GetLevel(SelectedUID[playerid], SelectedTeam[playerid]) < 2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]����Ȩ�޲���");
                new msg[96]; //������ж϶Է���level�ȼ� �����2�Ļ� �Ͳ�Ӧ����ȥ������
                team_GiveAdmin(SelectedUID[playerid], 0);
                // SendClientMessage(playerid, Color_Team, "[�Ŷ�]ȡ���Է�����ԱȨ��");
                format(msg, sizeof(msg), "[�Ŷ�]����Ա%s(%d)ȡ�����Ŷӳ�ԱUID:%d�Ĺ���ԱȨ��", GetName(playerid), playerid, SelectedUID[playerid]);
                team_SCM(msg, PlayerInfo[playerid][Team]);
                return 1;
            }
            if(listitem == 5) {
                if(team_GetLevel(PlayerInfo[playerid][ID], SelectedTeam[playerid]) != 2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�������ŶӵĴ�ʼ�˲���ת���Ŷ�");
                ShowPlayerDialog(playerid, Team_TransferDialog, DIALOG_STYLE_MSGBOX, "ת���Ŷ����һ��ȷ��", "{FF0000}��ȷ��Ҫת���Ŷ���?�������һ��ȷ��,����ϸ����!", "��", "��");
                return 1;
            }
            if(listitem == 6) {
                if(SelectedUID[playerid] == PlayerInfo[playerid][ID]) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�������Ƴ����Լ�,�����˳��Ŷ�����'�ҵ��Ŷ�'������");
                new msg[96];
                format(msg, sizeof(msg), "[�Ŷ�]����Ա%s(%d)�Ƴ����Ŷӳ�ԱUID:%d", GetName(playerid), playerid, SelectedUID[playerid]);
                team_SCM(msg, PlayerInfo[playerid][Team]);
                team_Kick(SelectedUID[playerid]);
                return 1;
            }
        } else {
            team_Manage(playerid, SelectedTeam[playerid]);
        }
        return 1;
    }
    if(dialogid == Team_TransferDialog) {
        if(!response) {
            if(SelectedUID[playerid] == PlayerInfo[playerid][ID]) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]������ת�ø����Լ�");
            team_Transfer(TeamInfo[SelectedTeam[playerid]][TID], SelectedUID[playerid], PlayerInfo[playerid][ID]);
            new msg[128];
            format(msg, sizeof(msg), "[�Ŷ�]��ʼ����UID:%d ���Ϊ UID:%d", PlayerInfo[playerid][ID], SelectedUID[playerid]);
            team_SCM(msg, PlayerInfo[playerid][Team]);
        } else {
            team_Manage(playerid, SelectedTeam[playerid]);
        }
        return 1;
    }
    if(dialogid == Team_ListDialog) {
        if(response) {
            new msg[1200], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��һҳ") == 0) {
                SelectTeamPage[playerid]--;
                team_List(playerid, SelectTeamPage[playerid]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                SelectTeamPage[playerid]++;
                team_List(playerid, SelectTeamPage[playerid]);
                return 1;
            }
            SelectedTeam[playerid] = strval(inputtext);
            if(!TeamInfo[SelectedTeam[playerid]][TID]) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]������Ŷ�ID");
            format(msg, sizeof msg, "�ŶӼ�� %s TID:%d\nȫ�� %s\n�Ŷӽ���\n�Ŷӳ�Ա\n�����Ŷ�", TeamInfo[SelectedTeam[playerid]][ShortName], TeamInfo[SelectedTeam[playerid]][TID], TeamInfo[SelectedTeam[playerid]][FullName]);
            ShowPlayerDialog(playerid, Team_Dialog, DIALOG_STYLE_LIST, "��ϸ��Ϣ", msg, "ȷ��", "ȡ��");
        }
        return 1;
    }
    if(dialogid == Team_Dialog) {
        if(response) {
            if(listitem <= 1) return team_List(playerid, SelectTeamPage[playerid]);
            if(listitem == 2) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "����", TeamInfo[SelectedTeam[playerid]][Description], "�˽�", "");
            if(listitem == 3) {
                team_MemberList(playerid, SelectMemberPage[playerid], TeamInfo[SelectedTeam[playerid]][TID]);
                return 1;
            }
            if(listitem == 4) return team_Manage(playerid, SelectedTeam[playerid]); //ѡ�е��Ŷ�ID
            if(listitem == 5) {
                if(team_GetLevel(PlayerInfo[playerid][ID], SelectedTeam[playerid]) == 2) return SendClientMessage(playerid, Color_Team, "[�Ŷ�]�����ŶӵĴ�ʼ��,�����ɢ�Ŷ����ڳ�Ա�б����ҵ��Լ�");
                new msg[96];
                format(msg, sizeof(msg), "[�Ŷ�]%s(%d)�뿪���Ŷ�...", GetName(playerid), playerid);
                team_SCM(msg, PlayerInfo[playerid][Team]);
                team_Kick(PlayerInfo[playerid][ID]);
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == Player_Color) {
        if(response) {
            new idx, tmp[128];
            tmp = strtok(inputtext, idx);
            if(strcmp(tmp, "��һҳ") == 0) {
                if(PlayerColorPage[playerid] == 1) return SCM(playerid, Color_White, "[ϵͳ] ��ҳʧ��,ԭ��:���ǵ�һҳ.");
                PlayerColorPage[playerid]--;
                ChangePlayerColor(playerid, PlayerColorPage[playerid]);
                return 1;
            }
            if(strcmp(tmp, "��һҳ") == 0) {
                if(PlayerColorPage[playerid] == GetMaxPage(sizeof(PlayerColors)) - 1) return SCM(playerid, Color_White, "[ϵͳ] ��ҳʧ��,ԭ��:�������һҳ.");
                PlayerColorPage[playerid]++;
                ChangePlayerColor(playerid, PlayerColorPage[playerid]);
                return 1;
            }
            if(strcmp(tmp, "ColorID", true) == 0) {
                tmp = strtok(inputtext, idx);
                new id = strval(tmp);
                SetPlayerColor(playerid, PlayerColors[id]);
                SendClientMessage(playerid, Color_White, "[ϵͳ]�޸���ɫ�ɹ�");
            }
        }
        return 1;
    }
    if(dialogid == AC_BUY) {
        if(!response) {
            new Float:x, Float:y, Float:z;
            new vid = GetPlayerVehicleID(playerid);
            if(CarInfo[vid][ID]) {
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z + 2);
                SetVehiclePos(vid, CarInfo[vid][CarX], CarInfo[vid][CarY], CarInfo[vid][CarZ]);
            }
            return 1;
            //��������
        }
        cmd_cars(playerid, "buy");
        return 1;
    }
    if(dialogid == AC_MyCar) {
        if(!response) return 1;
        if(listitem == 0) {
            LockCars(playerid);
            return 1;
        }
        if(listitem == 1) {
            if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:��û������ʻ��λ.");
            if(CarInfo[GetPlayerVehicleID(playerid)][UsersID] != PlayerInfo[playerid][ID]) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�ⲻ����İ���.");
            new Float:x, Float:y, Float:z, Float:a;
            GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
            GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
            CarInfo[pACEdit[playerid]][CarX] = x, CarInfo[pACEdit[playerid]][CarY] = y, CarInfo[pACEdit[playerid]][CarZ] = z, CarInfo[pACEdit[playerid]][CarA] = a;
            SCM(playerid, ACColor, "[����] �Ѹ��°�������.");
            UpdataACarData(pACEdit[playerid]);
            return 1;
        }
        if(listitem == 2) {
            if(CarInfo[pACEdit[playerid]][BanGoto] == 0) {
                CarInfo[pACEdit[playerid]][BanGoto] = 1;
                SCM(playerid, ACColor, "[����] ����������{FF0000}�ر�");
            } else {
                CarInfo[pACEdit[playerid]][BanGoto] = 0;
                SCM(playerid, ACColor, "[����] ����������{00FF00}����");
            }
            UpdataACarData(pACEdit[playerid]);
            return 1;
        }
        if(listitem == 3) {
            new str[1024];
            format(str, sizeof(str), "{FFFFFF}�ؾ�����\t%s(%d)\n�ؾ���ɫ\t{%06x}�~ {%06x}�~\n{FFFFFF}�ؾ�����\t%s\n��������\t%s\n�ؾ�����\t%s\n",
                VehicleNames[GetVehicleModel(pACEdit[playerid]) - 400], GetVehicleModel(pACEdit[playerid]), VehicleColoursTableRGBA[CarInfo[pACEdit[playerid]][Color1]] >>> 8,
                VehicleColoursTableRGBA[CarInfo[pACEdit[playerid]][Color2]] >>> 8, VehicleLockDoor[CarInfo[pACEdit[playerid]][Lock]], ListGotoNickName[CarInfo[pACEdit[playerid]][BanGoto]],
                CarInfo[pACEdit[playerid]][Text]);
            ShowPlayerDialog(playerid, AC_Dialog, DIALOG_STYLE_LIST, "�ҵİ���", str, "ȷ��", "�ر�");
            return 1;
        }
        if(listitem == 4) {
            new msg[256];
            format(msg, sizeof(msg), "{FFFFFF}ԭ���� >>> %s\n{FFFFFF}������������,�ò��������� %d ��Ǯ", CarInfo[pACEdit[playerid]][Text], ChangeCarTextScore);
            ShowPlayerDialog(playerid, AC_Text, DIALOG_STYLE_INPUT, "�ҵİ���", msg, "ȷ��", "�ر�");
            return 1;
        }
        if(listitem == 5) {
            pACPage[playerid] = 1;
            ChangeCarColor(playerid, 1);
            return 1;
        }
        if(listitem == 6) {
            new msg[256];
            format(msg, sizeof(msg), "�����������߳��ĳ˿�ID.");
            ShowPlayerDialog(playerid, AC_KickPassengers, DIALOG_STYLE_INPUT, "�ҵİ���", msg, "ȷ��", "�ر�");
            return 1;
        }
        if(listitem == 7) {
            CallMyAc(playerid);
            return 1;
        }
        if(listitem == 8) {
            new msg[256];
            format(msg, sizeof(msg), "�������ؾ�ID\t�ò��������� %d ��Ǯ", ChangeCarsScore);
            ShowPlayerDialog(playerid, AC_ChangeCars, DIALOG_STYLE_INPUT, "�ҵİ���", msg, "ȷ��", "�ر�");
            return 1;
        }
        if(listitem == 9) {
            SCM(playerid, 0xFF0000FF, "�ù�����ʱ�ر���");
            //ShowPlayerDialog(playerid,AC_GiveCars,DIALOG_STYLE_INPUT,"�ҵİ���","������Է�ID.","ȷ��","�ر�");
            return 1;
        }
        if(listitem == 10) {
            new string[64], d;
            new msg[256];
            PlayerEdit[playerid][0] = pACEdit[playerid];
            for (new i; i < 15; i++) {
                if(VehAttachedObject[PlayerEdit[playerid][0]][i][ModelID] != 0) {
                    format(string, 64, "��λ:%d\tģ��ID:%d\n", i, VehAttachedObject[PlayerEdit[playerid][0]][i][ModelID]);
                    strcat(msg, string);
                    VehAttachedObjectList[PlayerEdit[playerid][0]][d] = i;
                    d++;
                }
            }
            if(strlen(msg) == 0) {
                SCM(playerid, ACColor, "[�������] ���ؾ�û�����.");
            } else {
                ShowPlayerDialog(playerid, CDIALOG_CarZBParcel, DIALOG_STYLE_LIST, "����(��λ��:15)", msg, "ѡ��", "�˳�");
            }
            return 1;
        }
        if(listitem == 11) {
            ShowPlayerDialog(playerid, AC_Sell, DIALOG_STYLE_LIST, "�ҵİ���", "�������\n����ϵͳ({FF0000}ֻ���������ļ۸�)", "ȷ��", "ȡ��");
            return 1;
        }
        if(listitem == 12) {
            if(CarInfo[pACEdit[playerid]][Moded] == 0) {
                if(PlayerInfo[playerid][Cash] < 500) {
                    SCM(playerid, ACColor, "[����]�����װ��Ҫ500���");
                    return 1;
                }
                GivePlayerCash(playerid, -500);
                CarInfo[pACEdit[playerid]][Moded] = 1;
                SCM(playerid, ACColor, "[����]�����װ��{FF0000}����");
                UpdataACarData(pACEdit[playerid]);
                return 1;
            }
            if(CarInfo[pACEdit[playerid]][Moded] == 1) {
                CarInfo[pACEdit[playerid]][Moded] = 0;
                SCM(playerid, ACColor, "[����]�����װ��{00FF00}�ر�");
                UpdataACarData(pACEdit[playerid]);
                return 1;
            }
            return 1;
        }
    }
    if(dialogid == AC_Sell) {
        if(response) {
            if(listitem == 0) {
                // �������
                ShowPlayerDialog(playerid, AC_Sell + 1, DIALOG_STYLE_INPUT, "�ҵİ���", "�۸�Ϊ 0 = ������\n������۸�", "ȷ��", "�˳�");
                return 1;
            } else {
                // ����ϵͳ
                // �����ݿ���ɾ��
                GivePlayerCash(playerid, CarInfo[pACEdit[playerid]][Value]); //ɾ�����ݿ�ǰ�ȸ����MONEY
                AdminDeleteCar(pACEdit[playerid]); //2020-3-5 00:31:49���� ���-1���Ǵ� �ٿ���
                pACEdit[playerid] = -1; // ȡ����ұ༭״̬
                SendClientMessage(playerid, ACColor, "[����]���ո�ϵͳ�ɹ�!");
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == AC_Sell + 1) {
        if(!response) return 1;
        new value = strval(inputtext);
        if(value < CarInfo[pACEdit[playerid]][Value] - 500 || value < 2000) {
            SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�۸��ܵ���2000�Ҳ��ܵ��������-500.");
            pACEdit[playerid] = -1;
            return 1;
        }
        if(value == 0) {
            pACEdit[playerid] = -1;
            return 1;
        }
        // 2020.3.4д ע����Щ �о������� û��Ҫд����ж���
        // if(value == 0)
        // {
        //     new msg[256];
        // 	format(msg,sizeof(msg),"UPDATE Cars SET SellValue = %d WHERE ID = %d",0,CarInfo[pACEdit[playerid]][ID]);
        // 	db_free_result(db_query(Cardb,msg));
        // 	format(CarInfo[pACEdit[playerid]][Text],Text_Strlen,"%s�İ���",GetName(playerid));
        // 	Delete3DTextLabel(CarInfo[pACEdit[playerid]][TagText]);
        // 	CarInfo[pACEdit[playerid]][TagText] = Create3DTextLabel(CarInfo[pACEdit[playerid]][Text],ACColor,0.0,0.0,0.0,20.0,0);
        // 	Attach3DTextLabelToVehicle(CarInfo[pACEdit[playerid]][TagText],GetPlayerVehicleID(playerid),0.0,0.0,0.0);
        // 	UpdataACarData(pACEdit[playerid]);
        // 	CarInfo[pACEdit[playerid]][SellValue] = 0;
        // 	pACEdit[playerid] = -1;
        // 	return 1;
        // }
        // else
        // {
        new msg[256];
        format(msg, sizeof(msg), "UPDATE `Cars` SET `SellValue` = %d WHERE `ID` = %d", value, CarInfo[pACEdit[playerid]][ID]);
        db_free_result(db_query(Cardb, msg));
        format(CarInfo[pACEdit[playerid]][Text], Text_Strlen, "������\n�۸�:%d\nӵ����:%s", value, GetName(playerid));
        DestroyDynamic3DTextLabel(CarInfo[pACEdit[playerid]][TagText]);
        CarInfo[pACEdit[playerid]][TagText] = CreateDynamic3DTextLabel(CarInfo[pACEdit[playerid]][Text], ACColor, 0.0, 0.0, 0.0, 20.0, INVALID_PLAYER_ID, GetPlayerVehicleID(playerid));
        // Attach3DTextLabelToVehicle(CarInfo[pACEdit[playerid]][TagText],GetPlayerVehicleID(playerid),0.0,0.0,0.0);
        UpdataACarData(pACEdit[playerid]);
        CarInfo[pACEdit[playerid]][SellValue] = value;
        pACEdit[playerid] = -1;
        return 1;
        // }
    }
    if(dialogid == AC_GiveCars) {
        if(!response) return 1;
        if(CarInfo[pACEdit[playerid]][SellValue] != 0) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�������ڳ�����.");
        new id = strval(inputtext);
        // if(IsPlayerConnected(id) == 0) return SCM(playerid,ACColor,"[����] ����ʧ��,ԭ��:����Է�ID.");
        if(!PlayerInfo[playerid][Login]) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:����Է�ID��Է�δ��¼.");
        if(GetPlayerVehicleID(id) != pACEdit[playerid]) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�Է�û�ڰ�����.");
        if(id == playerid) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�㲻�ܸ������Լ�.");
        Search_MyCar_of_CarCont(id);
        if(pACEdit[id] != -1) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�Է��Ѿ���һ��������.");
        new msg[256];
        format(msg, sizeof(msg), "[����] %s ��һ������ [%s(%d)] ������", GetName(playerid), VehicleNames[GetVehicleModel(pACEdit[playerid]) - 400], GetVehicleModel(pACEdit[playerid]));
        SCM(id, ACColor, msg);
        format(msg, sizeof(msg), "[����] ����ⲿ�������� %s(%d)", GetName(id), id);
        SCM(playerid, ACColor, msg);
        CarInfo[pACEdit[playerid]][UsersID] = PlayerInfo[id][ID];
        UpdataACarData(pACEdit[playerid]);
        pACEdit[id] = pACEdit[playerid];
        pACEdit[playerid] = -1;
        return 1;
    }
    if(dialogid == AC_ChangeCars) {
        if(!response) return 1;
        if(CarInfo[pACEdit[playerid]][SellValue] != 0) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�������ڳ�����.");
        if(PlayerInfo[playerid][Cash] < ChangeCarsScore) {
            new msg[256];
            format(msg, sizeof(msg), "[����] ����ʧ��,ԭ��:��Ľ�Ǯ����.");
            SCM(playerid, ACColor, msg);
            return 1;
        }
        new id = strval(inputtext);
        if(id < 400 || id > 611) return SCM(playerid, ACColor, "[System] ����.");
        new msg[256];
        format(msg, sizeof(msg), "UPDATE `Cars` SET `ModelID` = %d WHERE `ID` = %d", id, CarInfo[pACEdit[playerid]][ID]);
        db_free_result(db_query(Cardb, msg));
        format(msg, sizeof(msg), "[����] �����ɹ�.");
        SCM(playerid, ACColor, msg);
        DestroyVehicle(pACEdit[playerid]);
        CreateVehicle(id, CarInfo[pACEdit[playerid]][CarX], CarInfo[pACEdit[playerid]][CarY], CarInfo[pACEdit[playerid]][CarZ],
            CarInfo[pACEdit[playerid]][CarA], CarInfo[pACEdit[playerid]][Color1], CarInfo[pACEdit[playerid]][Color2], -1);
        CarInfo[pACEdit[playerid]][ModelID] = id;
        GivePlayerCash(playerid, -ChangeCarsScore);
        return 1;
    }
    if(dialogid == AC_KickPassengers) {
        if(!response) return 1;
        new id = strval(inputtext);
        if(IsPlayerConnected(id) == 0) return SCM(playerid, ACColor, "[����] �߳�ʧ��,ԭ��:�����ID.");
        if(GetPlayerVehicleID(id) != pACEdit[playerid]) return SCM(playerid, ACColor, "[����] �߳�ʧ��,ԭ��:�����û������İ�����.");
        new Float:x, Float:y, Float:z;
        GetPlayerPos(id, x, y, z);
        SetPlayerPos(id, x, y, z + 3);
        new msg[128];
        format(msg, sizeof(msg), "[����] ��� %s �߳�����İ���.", GetName(id));
        SCM(playerid, ACColor, msg);
        format(msg, sizeof(msg), "[����] %s �����߳����ؾ�.", GetName(playerid));
        SCM(playerid, ACColor, msg);
        return 1;
    }
    if(dialogid == AC_Color) {
        if(!response) return 1;
        if(CarInfo[pACEdit[playerid]][SellValue] != 0) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�������ڳ�����.");
        new idx, tmp[128];
        tmp = strtok(inputtext, idx);
        if(strcmp(tmp, "��ѡ����ɫ") == 0) {
            if(pChangeCarColor[playerid] == 1) pChangeCarColor[playerid] = 2;
            else pChangeCarColor[playerid] = 1;
            ChangeCarColor(playerid, pACPage[playerid]);
            return 1;
        }
        if(strcmp(tmp, "��һҳ") == 0) {
            if(pACPage[playerid] == 1) return SCM(playerid, ACColor, "[����] ��ҳʧ��,ԭ��:���ǵ�һҳ.");
            pACPage[playerid]--;
            ChangeCarColor(playerid, pACPage[playerid]);
            return 1;
        }
        if(strcmp(tmp, "��һҳ") == 0) {
            if(pACPage[playerid] == GetMaxPage(sizeof(VehicleColoursTableRGBA)) - 1) return SCM(playerid, ACColor, "[����] ��ҳʧ��,ԭ��:�������һҳ.");
            pACPage[playerid]++;
            ChangeCarColor(playerid, pACPage[playerid]);
            return 1;
        }
        if(strcmp(tmp, "ColorID", true) == 0) {
            tmp = strtok(inputtext, idx);
            new id = strval(tmp);
            if(pChangeCarColor[playerid] == 1) {
                CarInfo[pACEdit[playerid]][Color1] = id;
                ChangeVehicleColor(pACEdit[playerid], id, CarInfo[pACEdit[playerid]][Color2]);
            } else {
                CarInfo[pACEdit[playerid]][Color2] = id;
                ChangeVehicleColor(pACEdit[playerid], CarInfo[pACEdit[playerid]][Color1], id);
            }
            ChangeCarColor(playerid, pACPage[playerid]);
            UpdataACarData(pACEdit[playerid]);
        }
        return 1;
    }
    if(dialogid == AC_Text) {
        if(!response) return 1;
        if(CarInfo[pACEdit[playerid]][SellValue] != 0) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�������ڳ�����.");
        if(GetPlayerVehicleSeat(playerid) != 0) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:��û������ʻ��λ.");
        if(CarInfo[GetPlayerVehicleID(playerid)][UsersID] != PlayerInfo[playerid][ID]) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�ⲻ����İ���.");
        if(PlayerInfo[playerid][Cash] < ChangeCarTextScore) {
            new str[256];
            format(str, sizeof(str), "[����] ����ʧ��,ԭ��:��Ľ�Ǯ����.");
            SCM(playerid, ACColor, str);
            return 1;
        }
        if(strlen(inputtext) > Text_Strlen - 10) return SCM(playerid, ACColor, "[����] �޸�ʧ��,ԭ��:�ַ�������.");
        new placeholder;
        for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
        {
            placeholder = strfind(inputtext, InvalidWords[i], true);
            if(placeholder != -1) {
                for (new x = placeholder; x < placeholder + strlen(InvalidWords[i]); x++) {
                    inputtext[x] = '*';
                }
            }
        }
        format(CarInfo[pACEdit[playerid]][Text], Text_Strlen, "%s", inputtext);
        GivePlayerCash(playerid, -ChangeCarTextScore);
        SCM(playerid, ACColor, "[����] �ؾ������޸ĳɹ�!");
        DestroyDynamic3DTextLabel(CarInfo[pACEdit[playerid]][TagText]);
        CarInfo[pACEdit[playerid]][TagText] = CreateDynamic3DTextLabel(CarInfo[pACEdit[playerid]][Text], ACColor, 0.0, 0.0, 0.0, 20.0, INVALID_PLAYER_ID, GetPlayerVehicleID(playerid));
        // Attach3DTextLabelToVehicle(CarInfo[pACEdit[playerid]][TagText],GetPlayerVehicleID(playerid),0.0,0.0,0.0);
        UpdataACarData(pACEdit[playerid]);
        return 1;
    }
    if(dialogid == AC_List) {
        if(!response) return 1;
        new idx, tmp[128];
        tmp = strtok(inputtext, idx);
        if(strcmp(tmp, "��һҳ") == 0) {
            if(pACPage[playerid] == 1) return SCM(playerid, ACColor, "[����] ��ҳʧ��,ԭ��:���ǵ�һҳ.");
            pACPage[playerid]--;
            pViewACList(playerid, pACPage[playerid]);
            return 1;
        }
        if(strcmp(tmp, "��һҳ") == 0) {
            if(pACPage[playerid] == GetMaxPage(CarCount)) return SCM(playerid, ACColor, "[����] ��ҳʧ��,ԭ��:�������һҳ.");
            pACPage[playerid]++;
            pViewACList(playerid, pACPage[playerid]);
            return 1;
        }
        if(strcmp(tmp, "����", true) == 0) {
            tmp = strtok(inputtext, idx);
            new id = strval(tmp);
            if(CarInfo[id][SellValue] == 0) {
                if(CarInfo[id][BanGoto] == 1) return SCM(playerid, ACColor, "[����] ����ʧ��,ԭ��:�ð������˽�ֹ����.");
            }
            new Float:x, Float:y, Float:z;
            GetVehiclePos(id, x, y, z);
            SetPlayerPos(playerid, x, y, z + 2);
            SCM(playerid, ACColor, "[����] �㴫�͵�����������.");
            return 1;
        }
    }
    new vid = GetPlayerVehicleID(playerid);
    if(dialogid == CDIALOG_CarZBEditSave) {
        if(!response) return 1;
        if(listitem == 6) {
            if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, ACColor, "[�������] �㲻���ؾ���.");
            if(CarInfo[vid][UsersID] != PlayerInfo[playerid][ID]) return SCM(playerid, ACColor, "[�������] �ⲻ������ؾ�.");
            new tmp[3];
            tmp[0] = PlayerEdit[playerid][0];
            tmp[1] = PlayerEdit[playerid][1];
            tmp[2] = PlayerEdit[playerid][2];
            VehAttachedObject[tmp[0]][tmp[1]][VaX] = 0.0;
            VehAttachedObject[tmp[0]][tmp[1]][VaY] = 0.0;
            VehAttachedObject[tmp[0]][tmp[1]][VaZ] = 0.0;
            VehAttachedObject[tmp[0]][tmp[1]][VaRX] = 0.0;
            VehAttachedObject[tmp[0]][tmp[1]][VaRY] = 0.0;
            VehAttachedObject[tmp[0]][tmp[1]][VaRZ] = 0.0;
            new Query[512], String[512], DBResult:uf;
            strins(String, "UPDATE Va SET Model = %d, X = '%f', Y = '%f', Z = '%f', RX = '%f'", strlen(String));
            strins(String, ", RY = '%f', RZ = '%f' WHERE VehicleID = %d AND Slot = %d", strlen(String));
            format(Query, sizeof(Query), String, VehAttachedObject[tmp[0]][tmp[1]][ModelID], VehAttachedObject[tmp[0]][tmp[1]][VaX], VehAttachedObject[tmp[0]][tmp[1]][VaY], VehAttachedObject[tmp[0]][tmp[1]][VaZ], VehAttachedObject[tmp[0]][tmp[1]][VaRX], VehAttachedObject[tmp[0]][tmp[1]][VaRY], VehAttachedObject[tmp[0]][tmp[1]][VaRZ], CarInfo[vid][ID], tmp[1]);
            uf = db_query(Cardb, Query);
            db_free_result(uf);
            new str[128];
            format(str, sizeof(str), "����\nǰ��\n����\nǰ��\n�෭\n��ת\n����\n{FF0000}ɾ��\n״̬:%s", TagObjectsState[VehAttachedObject[tmp[0]][tmp[1]][TagObjects]]);
            ShowPlayerDialog(playerid, CDIALOG_CarZB, DIALOG_STYLE_LIST, "����༭", str, "ѡ��", "�˳�");
            return 1;
        }
        if(listitem == 8) {
            if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, ACColor, "[�������] �㲻���ؾ���.");
            if(CarInfo[vid][UsersID] != PlayerInfo[playerid][ID]) return SCM(playerid, ACColor, "[�������] �ⲻ������ؾ�.");
            new tmp[3];
            tmp[0] = PlayerEdit[playerid][0];
            tmp[1] = PlayerEdit[playerid][1];
            tmp[2] = PlayerEdit[playerid][2];
            VehAttachedObject[tmp[0]][tmp[1]][VaX] = VehAttachedObject[tmp[0]][tmp[1]][VaX];
            VehAttachedObject[tmp[0]][tmp[1]][VaY] = VehAttachedObject[tmp[0]][tmp[1]][VaY];
            VehAttachedObject[tmp[0]][tmp[1]][VaZ] = VehAttachedObject[tmp[0]][tmp[1]][VaZ];
            VehAttachedObject[tmp[0]][tmp[1]][VaRX] = VehAttachedObject[tmp[0]][tmp[1]][VaRX];
            VehAttachedObject[tmp[0]][tmp[1]][VaRY] = VehAttachedObject[tmp[0]][tmp[1]][VaRY];
            VehAttachedObject[tmp[0]][tmp[1]][VaRZ] = VehAttachedObject[tmp[0]][tmp[1]][VaRZ];
            new Query[512], String[512], DBResult:uf;
            strins(String, "UPDATE Va SET Model = %d, X = '%f', Y = '%f', Z = '%f', RX = '%f', RY = '%f', RZ = '%f' ", strlen(String));
            strins(String, "WHERE VehicleID = %d AND Slot = %d", strlen(String));
            format(Query, sizeof(Query), String, VehAttachedObject[tmp[0]][tmp[1]][ModelID], VehAttachedObject[tmp[0]][tmp[1]][VaX], VehAttachedObject[tmp[0]][tmp[1]][VaY], VehAttachedObject[tmp[0]][tmp[1]][VaZ], VehAttachedObject[tmp[0]][tmp[1]][VaRX], VehAttachedObject[tmp[0]][tmp[1]][VaRY], VehAttachedObject[tmp[0]][tmp[1]][VaRZ], CarInfo[vid][ID], tmp[1]);
            uf = db_query(Cardb, Query);
            db_free_result(uf);
            PlayerEdit[playerid][0] = 0, PlayerEdit[playerid][1] = 0, PlayerEdit[playerid][2] = 0;
            return 1;
        }
    }
    if(dialogid == CDIALOG_CarZB) {
        if(!response) {
            PlayerEdit[playerid][0] = 0, PlayerEdit[playerid][1] = 0, PlayerEdit[playerid][2] = 0;
            return 1;
        }
        if(listitem == 6) {
            if(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects] == 0) {
                SCM(playerid, ACColor, "[�������] ����ʧ��,ԭ��:�����δװ��.");
                PlayerEdit[playerid][0] = 0, PlayerEdit[playerid][1] = 0, PlayerEdit[playerid][2] = 0;
                return 1;
            }
            new str[128];
            format(str, sizeof(str), "��������Ҫ�ĵ����ٶ�(��ǰ�ٶ�:%0.1f)", EditSpeed[playerid]);
            ShowPlayerDialog(playerid, CDIALOG_CarZBSpeed, DIALOG_STYLE_INPUT, "����", str, "ȷ��", "�ر�");
            return 1;
        }
        if(listitem == 7) {
            if(IsValidDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID])) {
                DestroyDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID]);
            }
            VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][ModelID] = 0;
            new DBResult:cf, msgs[256];
            format(msgs, 256, "DELETE FROM Va WHERE VehicleID = %d AND Slot = %d", CarInfo[vid][ID], PlayerEdit[playerid][1]);
            cf = db_query(Cardb, msgs);
            db_free_result(cf);
            SCM(playerid, ACColor, "[�������] ��ɾ���˸�װ��.");
            return 1;
        }
        if(listitem == 8) {
            new Query[512], DBResult:uf;
            if(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects] == 1) {
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects] = 0;
                DestroyDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID]);
            } else {
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects] = 1;
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID] = CreateDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][ModelID], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                AttachDynamicObjectToVehicle(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID], PlayerEdit[playerid][0],
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaX],
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaY],
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaZ],
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRX],
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRY],
                    VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRZ]);
            }
            format(Query, sizeof(Query), "UPDATE Va SET TagObjects = %d WHERE VehicleID = %d AND Slot = %d", VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects], CarInfo[vid][ID], PlayerEdit[playerid][1]);
            uf = db_query(Cardb, Query);
            db_free_result(uf);
            new str[128];
            format(str, sizeof(str), "����\nǰ��\n����\nǰ��\n�෭\n��ת\n����\n{FF0000}ɾ��\n״̬:%s", TagObjectsState[VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects]]);
            ShowPlayerDialog(playerid, CDIALOG_CarZB, DIALOG_STYLE_LIST, "����༭", str, "ѡ��", "�˳�");
            return 1;
        } else {
            if(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects] == 0) {
                SCM(playerid, ACColor, "[�������] ����ʧ��,ԭ��:�����δװ��.");
                PlayerEdit[playerid][0] = 0, PlayerEdit[playerid][1] = 0, PlayerEdit[playerid][2] = 0;
                return 1;
            }
            PlayerEdit[playerid][2] = listitem + 1;
            if(IsValidDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID])) {
                DestroyDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID]);
            }
            VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID] = CreateDynamicObject(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][ModelID], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
            AttachDynamicObjectToVehicle(VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaObjectID], PlayerEdit[playerid][0],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaX],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaY],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaZ],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRX],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRY],
                VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][VaRZ]);
            SCM(playerid, ACColor, "[�������] ʹ��С����'4/6'�ɽ��в���,����'2'�ɵ���������,����������ɽ��б���.");
            Streamer_UpdateAll();
            return 1;
        }
    }
    if(dialogid == CDIALOG_CarZBSpeed) {
        if(!response) return 1;
        EditSpeed[playerid] = floatstr(inputtext);
        new str[128];
        format(str, sizeof(str), "����\nǰ��\n����\nǰ��\n�෭\n��ת\n����\n{FF0000}ɾ��\n״̬:%s", TagObjectsState[VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects]]);
        ShowPlayerDialog(playerid, CDIALOG_CarZB, DIALOG_STYLE_LIST, "����༭", str, "ѡ��", "�˳�");
        return 1;
    }
    if(dialogid == CDIALOG_CarZBParcel) {
        if(!response) return 1;
        PlayerEdit[playerid][1] = VehAttachedObjectList[PlayerEdit[playerid][0]][listitem];
        new str[128];
        format(str, sizeof(str), "����\nǰ��\n����\nǰ��\n�෭\n��ת\n����\n{FF0000}ɾ��\n״̬:%s", TagObjectsState[VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects]]);
        ShowPlayerDialog(playerid, CDIALOG_CarZB, DIALOG_STYLE_LIST, "����༭", str, "ѡ��", "�˳�");
        return 1;
    }
    if(dialogid == AC_DressupList) {
        if(response) {
            new msgs[128], Query[512];
            if(vid == 0) return SCM(playerid, ACColor, "[�ؾ�] ��û�����ؾ���!");
            if(CarInfo[vid][UsersID] != PlayerInfo[playerid][ID]) return SCM(playerid, ACColor, "[�������] �ⲻ������ؾ�.");
            if(PlayerInfo[playerid][Cash] < buycarzbs[listitem][zbmoney]) {
                format(msgs, 128, "[�ؾ�] ��Ľ�Ҳ��� %d �����Թ��� %s", buycarzbs[listitem][zbmoney], buycarzbs[listitem][zbname]);
                SCM(playerid, -1, msgs);
                return 1;
            }
            if(buycarzbs[listitem][zbid] != 0) {
                for (new i; i < 15; i++) {
                    if(VehAttachedObject[vid][i][ModelID] == 0) {
                        VehAttachedObject[vid][i][ModelID] = buycarzbs[listitem][zbid];
                        format(Query, sizeof(Query), "INSERT INTO Va (VehicleID, Slot, Model, X, Y, Z, RX, RY, RZ) VALUES (%d, %d, %d, '%f', '%f', '%f', '%f', '%f', '%f')", CarInfo[vid][ID], i, VehAttachedObject[vid][i][ModelID], 0, 0, 0, 0, 0, 0);
                        db_free_result(db_query(Cardb, Query));
                        GivePlayerCash(playerid, -buycarzbs[listitem][zbmoney]);
                        format(msgs, 128, "[�ؾ�] �㹺���� %s ������ %d ���", buycarzbs[listitem][zbname], buycarzbs[listitem][zbmoney]);
                        SCM(playerid, ACColor, msgs);
                        return 1;
                    }
                }
                SCM(playerid, ACColor, "[�ؾ�] ���ؾ߰�������!");
            }
            return 1;
        }
    }
    if(dialogid == GODIOG_LIST) {
        if(response) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "ID:") == 0) {
                msg = strtok(inputtext, idx);
                GOODS_OPRATEID[playerid] = strval(msg);
                SetPlayerPos(playerid, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ]);
                if(GOODS[GOODS_OPRATEID[playerid]][topublic] == true) {
                    new title[285];
                    format(title, 285, "{FFFFFF}��ƷID:{80FF80} %d {FFFFFF}����:{80FF80} %s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                    ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_YES, "ѡ��", "�ر�");
                } else {
                    new title[285];
                    format(title, 285, "{FFFFFF}��ƷID:\
                        {80FF80} %d {FFFFFF}����:\
                        {80FF80} %s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                    ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_NO, "ѡ��", "�ر�");
                }
            } else {
                return SendClientMessage(playerid, Color_White, "[����ѡ]");
            }
        }
        return 1;
    }
    if(dialogid == NPC_DIALOG_ID) {
        #if defined DEBUG
        if(PlayerInfo[playerid][AdminLevel] > 4)
            SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse called.");
        #endif
        if(response) {
            #if defined DEBUG
            if(PlayerInfo[playerid][AdminLevel] > 4)
                SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - response = 1.");
            #endif
            switch (listitem) {
                case 0:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 0.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[0]);
                }
                case 1:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 1.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[4]);
                }
                case 2:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 2.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[2]);
                }
                case 3:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 3.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[3]);
                }
                case 4:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 4.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[5]);
                }
                case 5:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 5.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[1]);
                }
                case 6:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 6.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[6]);
                }
                case 7:{
                    #if defined DEBUG
                    if(PlayerInfo[playerid][AdminLevel] > 4)
                        SendClientMessage(playerid, Color_Green, "[DEBUG] OnDialogResponse - listitem = 7.");
                    #endif
                    SetPlayerToNPCVehicle(playerid, npcCars[7]);
                }
            }
        }
    }
    if(dialogid == 5) {
        if(!response) {
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/help");
            return 1;
            // OnPlayerCommandText(playerid, "/help");
        }
        new msg[128], idx;
        msg = strtok(inputtext, idx);
        if(!strcmp(msg, "LV1")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ԱLV1", "����:/jail\n�߳�:/kick����:/goto\n����:/get\n�����༭/r edit", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "LV2")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ԱLV2", "(���)��ɱ:/(un)ban\n�����ؾ�:/jyzj", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "LV3")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ԱLV3", "ͼ���ɫ:/acolor(�ݲ�����)", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "LV4")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ԱLV4", "������Ǯ:/givecash\n/creategoods �����Ҿ�\n/delgoodsɾ���Ҿ� /board delete ɾ�������\n/attire ����װ�� /cars create ��������\n/selectnpc ����NPC /showname �رջ���ʾNPC����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "LV5")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ԱLV5", "ˢ�·�����:/gmx\n����ϵͳ���͵�:/vsmake\n/houseedit �����༭ /attireװ�� /reset�����û�����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "LV?")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ԱLV?", "�������GM:/admin\nȡ���������GM:/undmin", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�����ճ�����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ϵͳ", "/house goto �ɴ���������.\n/house buy �ɹ�����.\n/house sell �ɳ��۷���.\n/house text �ɸ��ļ��.\n/house list �ɲ鿴�����б�.\n/house glist �ɲ鿴����Ȩ���б�.\n/house adp �ɸ��跿�ݲ���Ȩ��.\n/house rdp ���Ƴ����ݲ���Ȩ��.\n/house gdp �ɲ鿴���ݲ���Ȩ��.\n/house sellto �ɳ��۸�ָ������.\n/house buyit �ɽ������˷�������������", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "��������Ա����")) {
            SendClientMessage(playerid, Color_White, "[ϵͳ] ������/houseedit");
            return 1;
        }
        if(!strcmp(msg, "�Ҿ��ճ�����")) {
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/goodshelp");
            // OnPlayerCommandText(playerid, "/goodshelp");
            return 1;
        }
        if(!strcmp(msg, "�Ҿ߹���Ա����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�Ҿ߹���Աϵͳ", "/creategoods �����Ҿ�\n/delgoodsɾ���Ҿ�\n/resetgoods ���üҾ�", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "��������")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ϵͳ", "[����] ����:/r s (������),����/��ʼ����,��������ʡ��\n[����] ����:/r j,�������\n[����] ����:/r l,�뿪����\n[����] ����:/r page ҳ��,��ת������Ҫ��ҳ��\n[����] ����:/r create,��������\n[����] ����:/r edit,�༭��������\n����ϵͳ�з������³���/kill����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�༭����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ϵͳ", "�粻�ǹ���Ա��ֻ�ɱ༭�Լ�����������\n[����]����:/r edit [������] [�����༭����],�༭����\n[����]����:/r edit q �˳��༭ģʽ\n[����]����:/r edit cpsize,����/�鿴��ǰ�༭cp�ĳߴ�\n[����]����:/r edit d,�������\n[����]����:/r edit cp,�ڵ�ǰλ�÷���һ��cp��\n[����]����:/r edit trg,�鿴����˵��", "ȷ��", "����");
            return 1;
        }
        return 1;
    }
    if(dialogid == RACE_RESPAWNDIALOG) { //�Ƿ�����
        if(response) {
            new Float:POS[3];
            GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            SetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            SetPlayerHealth(playerid, -1.0);
            return 1;
        }
        return 1;
    }
    if(dialogid == RACE_EDIT_MAIN_DIALOG) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "���������¼") == 0) {
                Race_ReTop(EditRace[playerid][rraceid]);
                Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
                return 1;
            }
            if(strcmp(msg, "ɾ��������") == 0) {
                Race_Delete(EditRace[playerid][rraceid]);
                return 1;
            }
            if(strcmp(msg, "���Ը�����") == 0) {
                // 2020.3.23����
                for (new i = 0; i < CarCount; i++) {
                    if(GetPlayerVehicleID(playerid) == CarInfo[i][GotoID]) {
                        SendClientMessage(playerid, Color_Race, "[����] �򰮳�������������ϵͳ����,�Ұ���װ���Ӱ�칫ƽ��,��֧�ּ���");
                        return 1;
                    }
                }
                if(Race_Test(playerid, EditRace[playerid][rraceid], 1) == -1) {
                    SendClientMessage(playerid, Color_Race, "[����]�޷������������,��Ϊ���������Ϊ0");
                    Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
                } else {
                    EditRace[playerid][rdialogpage] = 1;
                    EditRace[playerid][rdialogcp] = 1;
                    EditRace[playerid][rdialogcppage] = 1;
                    EditRace[playerid][rdialogcplist] = -1;
                }
                return 1;
            }
            if(strcmp(msg, "�޸����м���ߴ�Ϊ") == 0) {
                Race_HideCp(playerid);
                Race_SetAllCpSize(playerid, EditRace[playerid][rraceid]);
                Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
                return 1;
            }
            if(strcmp(msg, "����") == 0) {
                msg = strtok(inputtext, idx);
                EditRace[playerid][rdialogcp] = strval(msg);
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "��������") == 0) {
                Race_ShowEditMiaoshuDialog(playerid, EditRace[playerid][rraceid], "");
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                EditRace[playerid][rdialogpage]--;
                Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                EditRace[playerid][rdialogpage]++;
                Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
                return 1;
            }
            Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
            return 1;
        } else {
            EditRace[playerid][rdialogpage] = 1;
            EditRace[playerid][rdialogcp] = 1;
            EditRace[playerid][rdialogcppage] = 1;
            EditRace[playerid][rdialogcplist] = -1;
            return 1;
        }

    }
    if(dialogid == RACE_EDIT_MIAOSHU_DIALOG) {
        if(response == 1) {
            if(strlen(inputtext) >= 64) {
                Race_ShowEditMiaoshuDialog(playerid, EditRace[playerid][rraceid], "\n{00FF00}��������~���ʵ�������һ��");
                return 1;
            }
            Race_SetMiaoshu(EditRace[playerid][rraceid], inputtext);
            Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
            return 1;
        } else {
            Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
            return 1;
        }
    }
    if(dialogid == RACE_EDIT_CP_DIALOG) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "������㿪ʼ��������") == 0) {
                for (new i = 0; i < CarCount; i++) {
                    if(GetPlayerVehicleID(playerid) == CarInfo[i][GotoID]) {
                        SendClientMessage(playerid, Color_Race, "[����] �򰮳�������������ϵͳ����,�Ұ���װ���Ӱ�칫ƽ��,��֧�ּ���");
                        return 1;
                    }
                }
                if(Race_Test(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]) == -1) {
                    SendClientMessage(playerid, Color_Race, "[����]�޷������������,��Ϊ���������Ϊ0");
                    Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                } else {
                    EditRace[playerid][rdialogpage] = 1;
                    EditRace[playerid][rdialogcp] = 1;
                    EditRace[playerid][rdialogcppage] = 1;
                    EditRace[playerid][rdialogcplist] = -1;
                }
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                EditRace[playerid][rdialogcppage]--;
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                EditRace[playerid][rdialogcppage]++;
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "����") == 0) {
                msg = strtok(inputtext, idx);
                EditRace[playerid][rdialogcplist] = strval(msg);
                Race_ShowEditCpScriptDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], "");
                return 1;
            }
            if(strcmp(msg, "ɾ�����д���") == 0) {
                Race_DelCp_Scripts(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                EditRace[playerid][rdialogcplist] = -1;
                EditRace[playerid][rdialogcppage] = 1;
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "����´���") == 0) {
                EditRace[playerid][rdialogcplist] = -1;
                Race_ShowEditCpScriptDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], "");
                return 1;
            }
            if(strcmp(msg, "�������") == 0) {
                Race_InsCp(EditRace[playerid][rraceid], playerid, EditRace[playerid][rdialogcp]);
                EditRace[playerid][rdialogpage] = 1;
                EditRace[playerid][rdialogcp] = 1;
                EditRace[playerid][rdialogcplist] = -1;
                Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "ɾ������") == 0) {
                new s;
                Race_HideCp(playerid);
                Race_DelCp(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                s = GetMaxPage(Race[EditRace[playerid][rraceid]][rcps]);
                if(EditRace[playerid][rdialogpage] > s) {
                    EditRace[playerid][rdialogpage] = s;
                }
                EditRace[playerid][rdialogcp] = 1;
                EditRace[playerid][rdialogcppage] = 1;
                EditRace[playerid][rdialogcplist] = -1;
                Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
                return 1;
            }
            if(strcmp(msg, "���͵�����") == 0) {
                new trcp[racecptype];
                Race_ShowCp(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                Race_GetCp(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], trcp);
                SetPlayerPosEx(playerid, trcp[rcpx], trcp[rcpy], trcp[rcpz]);
                SetPlayerFacingAngleEx(playerid, trcp[rcpa]);
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "�ƶ�����") == 0) {
                Race_SetCpPos(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                Race_ShowCp(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            if(strcmp(msg, "size") == 0) {
                Race_SetCpSize(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                Race_ShowCp(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp]);
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
            Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
            return 1;
        } else {
            EditRace[playerid][rdialogcp] = 1;
            EditRace[playerid][rdialogcppage] = 1;
            EditRace[playerid][rdialogcplist] = -1;
            Race_ShowEditDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogpage]);
            return 1;
        }
    }
    if(dialogid == RACE_EDIT_CP_SCRIPT_DIALOG) {
        if(response == 1) {
            if(EditRace[playerid][rdialogcplist] == -1) {
                if(strcmp(inputtext, "ɾ��") == 0 || strcmp(inputtext, "����") == 0) {
                    Race_ShowEditCpScriptDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], "\n�����´���ʱ'����'��'ɾ��'ָ���޷�ʹ��");
                    return 1;
                }
                if(strlen(inputtext) >= RACE_CP_MAX_FUNCTION) {
                    Race_ShowEditCpScriptDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], "\n{00FF00}����̫����,������һ���...");
                    return 1;
                }
                Race_NewCp_Script(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], inputtext);
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            } else {
                if(strcmp(inputtext, "ɾ��") == 0) {
                    Race_DelCp_Script(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcplist]);
                    EditRace[playerid][rdialogcplist] = -1;
                    new tr[racecptype];
                    Race_GetCp(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], tr);
                    new s = GetMaxPage(Race_GetCp_Scripts(tr[rcpid]));
                    if(EditRace[playerid][rdialogcppage] > s) {
                        EditRace[playerid][rdialogcppage] = s;
                    }
                    Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                    return 1;
                }
                if(strcmp(inputtext, "����") == 0) {
                    Race_InsCp_Script(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcplist], "�²���Ĵ���,���޸Ĵ�������~");
                    Race_ShowEditCpScriptDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], "");
                    return 1;
                }
                if(strlen(inputtext) >= RACE_CP_MAX_FUNCTION) {
                    Race_ShowEditCpScriptDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], "\n{00FF00}����̫����,������һ���...");
                    return 1;
                }
                Race_SetCp_Script(EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcplist], inputtext);
                Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
                return 1;
            }
        }
        EditRace[playerid][rdialogcplist] = -1;
        Race_ShowEditCpDialog(playerid, EditRace[playerid][rraceid], EditRace[playerid][rdialogcp], EditRace[playerid][rdialogcppage]);
        return 1;
    }
    if(dialogid == RACE_GAME_MAIN_DIALOG) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��ʼ") == 0) {
                msg = strtok(inputtext, idx);
                new id = Race_CheckName(msg);
                if(id != -1) {
                    format(msg, 128, "/r s %s", Race[id][rname]);
                    // OnPlayerCommandText(playerid, msg);
                    CallRemoteFunction("OnPlayerCommandText", "is", playerid, msg);
                    return 1;
                }
                SendClientMessage(playerid, Color_Race, "[����]������һ������:GAME_MAIN_DIALOG_RESPONSE");
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == RACE_GAME_MAIN_DIALOG_SEL) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��һҳ") == 0) {
                SelectRacePage[playerid]--;
                Race_ShowGameSelDialog(playerid, SelectRacePage[playerid]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                SelectRacePage[playerid]++;
                Race_ShowGameSelDialog(playerid, SelectRacePage[playerid]);
                return 1;
            }
            if(strcmp(msg, "����") == 0) {
                msg = strtok(inputtext, idx);
                new id = Race_CheckName(msg);
                if(id != -1) {
                    Race_ShowGameDialog(playerid, id);
                    return 1;
                }
                SendClientMessage(playerid, Color_Race, "[����]������һ������:RACE_GAME_MAIN_DIALOG_SEL");
                return 1;
            }
            Race_ShowGameSelDialog(playerid, SelectRacePage[playerid]);
            return 1;
        } else {
            SelectRacePage[playerid] = 1;
            return 1;
        }
    }
    if(dialogid == RACE_EDIT_CP_SCRIPT_HELP) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "�鿴�﷨") == 0) {
                Race_ShowTrgDialog(playerid, "�﷨");
                return 1;
            }
            if(strcmp(msg, "�鿴����") == 0) {
                Race_ShowTrgDialog(playerid, "����");
                return 1;
            }
            if(strcmp(msg, "�鿴ת���") == 0) {
                Race_ShowTrgDialog(playerid, "ת���");
                return 1;
            }
            if(strcmp(msg, "����>") == 0) {
                msg = strtok(inputtext, idx);
                Race_ShowTrgFunDialog(playerid, msg);
                return 1;
            }
            if(strcmp(msg, "ת���>") == 0) {
                msg = strtok(inputtext, idx);
                Race_ShowTrgRetDialog(playerid, msg);
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == Ban_Choose) {
        if(response == 1) {
            if(!AccountCheck(inputtext)) {
                SCM(playerid, Color_Red, "[Ban] ����ʧ��,������˺Ų�����.");
                return 1;
            }
            format(aInfo[playerid][WannaBanName], 32, "%s", inputtext);
            ShowPlayerDialog(playerid, Ban_Choose + 1, DIALOG_STYLE_LIST, "��ɱ����", "{04FB04}1��\n{CAFB04}3��\n{E6FF00}7��\n{F2970D}30��\n{FF0000}365��", "ȷ��", "ȡ��");
            return 1;
        }
        return 1;
    }
    if(dialogid == Ban_Choose + 1) {
        if(response == 1) {
            switch (listitem) {
                case 0:{
                    aInfo[playerid][WannaBanTime] = 1;
                    ShowPlayerDialog(playerid, Ban_Choose + 2, DIALOG_STYLE_LIST, "��ɱԭ��", "��������/���/����/�糵\n����ɧ�ŵ�", "ȷ��", "ȡ��");
                    return 1;
                }
                case 1:{
                    aInfo[playerid][WannaBanTime] = 3;
                    ShowPlayerDialog(playerid, Ban_Choose + 2, DIALOG_STYLE_LIST, "��ɱԭ��", "��������/���/����/�糵\n����ɧ�ŵ�", "ȷ��", "ȡ��");
                    return 1;
                }
                case 2:{
                    aInfo[playerid][WannaBanTime] = 7;
                    ShowPlayerDialog(playerid, Ban_Choose + 2, DIALOG_STYLE_LIST, "��ɱԭ��", "��������/���/����/�糵\n����ɧ�ŵ�", "ȷ��", "ȡ��");
                    return 1;
                }
                case 3:{
                    aInfo[playerid][WannaBanTime] = 30;
                    ShowPlayerDialog(playerid, Ban_Choose + 2, DIALOG_STYLE_LIST, "��ɱԭ��", "��������/���/����/�糵\n����ɧ�ŵ�", "ȷ��", "ȡ��");
                    return 1;
                }
                case 4:{
                    aInfo[playerid][WannaBanTime] = 365;
                    ShowPlayerDialog(playerid, Ban_Choose + 2, DIALOG_STYLE_LIST, "��ɱԭ��", "��������/���/����/�糵\n����ɧ�ŵ�", "ȷ��", "ȡ��");
                    return 1;
                }
            }
        }
        return 1;
    }
    if(dialogid == Ban_Choose + 2) {
        if(response == 1) {
            switch (listitem) {
                case 0:{
                    new msgs[512], str[128], DBResult:uf;
                    new t = gettime() + 86400 * aInfo[playerid][WannaBanTime];
                    format(msgs, sizeof(msgs), "UPDATE `Users` SET `BanTime` = %d,`BanReason` = 999 WHERE `Name` = '%s'", t, aInfo[playerid][WannaBanName]);
                    uf = db_query(user, msgs);
                    db_free_result(uf);
                    format(msgs, sizeof(msgs), "[ϵͳ] %s �� %s ��ɱ�� %d ��,ԭ��:ʹ�õ�������������Ӱ������Ϸ��ƽ�� ", GetName(playerid), aInfo[playerid][WannaBanName], aInfo[playerid][WannaBanTime]);
                    SCMALL(Color_Red, msgs);
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i)) {
                            if(PlayerInfo[i][Login] == true) {
                                if(strcmp(GetName(i), aInfo[playerid][WannaBanName]) == 0) {
                                    PlayerInfo[i][BanTime] = t;
                                    SetTimerEx("KickEx", 250, false, "i", i);
                                }
                            }
                        }
                    }
                    format(str, sizeof(str), "[����Ա] %s ʹ�������� Ban. ", GetName(playerid));
                    SCMToAdmins(0x0066FFFF, str);
                    AdminCommandRecord(playerid, "Ban", "ϵͳ��⵽���ʹ�õ���������ǿ��Ӱ����Ϸ��ƽ��");
                    format(aInfo[playerid][WannaBanName], 32, "None");
                    format(aInfo[playerid][WannaBanTime], 32, "None");
                    format(aInfo[playerid][WannaBanReason], 32, "None");
                    return 1;
                }
                case 1:{
                    new msgs[512], str[128], DBResult:uf;
                    new t = gettime() + 86400 * aInfo[playerid][WannaBanTime];
                    format(msgs, sizeof(msgs), "UPDATE `Users` SET BanTime = %d,BanReason = '999' WHERE `Name` = '%s'", t, aInfo[playerid][WannaBanName]);
                    uf = db_query(user, msgs);
                    db_free_result(uf);
                    format(msgs, sizeof(msgs), "[ϵͳ] %s �� %s ��ɱ�� %d ��,ԭ��:����ɧ����һ���թƭǮ ", GetName(playerid), aInfo[playerid][WannaBanName], aInfo[playerid][WannaBanTime]);
                    SCMALL(Color_Red, msgs);
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i)) {
                            if(PlayerInfo[i][Login] == true) {
                                if(strcmp(GetName(i), aInfo[playerid][WannaBanName]) == 0) {
                                    PlayerInfo[i][BanTime] = t;
                                    SetTimerEx("KickEx", 250, false, "i", i);
                                }
                            }
                        }
                    }
                    format(str, sizeof(str), "[����Ա] %s ʹ�������� Ban. ", GetName(playerid));
                    SCMToAdmins(0x0066FFFF, str);
                    AdminCommandRecord(playerid, "Ban", "����ɧ����һ���թƭǮ");
                    format(aInfo[playerid][WannaBanName], 32, "None");
                    format(aInfo[playerid][WannaBanTime], 32, "None");
                    format(aInfo[playerid][WannaBanReason], 32, "None");
                    return 1;
                }
            }
        }
        return 1;
    }
    if(dialogid == Ban_Choose + 3) {
        if(response == 1) {
            if(!AccountCheck(inputtext)) {
                SCM(playerid, Color_Red, "[Ban] ����ʧ��,������˺Ų�����.");
                return 1;
            }
            new msgs[256], str[128];
            format(msgs, sizeof(msgs), "UPDATE `Users` SET `BanTime` = 0,`BanReason` = -1 WHERE `Name` = '%s'", inputtext);
            db_free_result(db_query(user, msgs));
            format(msgs, sizeof(msgs), "[ϵͳ] %s �� %s ���ʺ� �����", GetName(playerid), inputtext);
            SCMALL(Color_Red, msgs);
            format(str, sizeof(str), "[����Ա] %s ʹ�������� UnBan. ", GetName(playerid));
            SCMToAdmins(0x0066FFFF, str);
            AdminCommandRecord(playerid, "UnBan", "���");
            return 1;
        }
        return 1;
    }
    if(dialogid == weapons) {
        if(response == 1) {
            switch (listitem) {
                case 0:{
                    GivePlayerWeapon(playerid, 4, 1);
                }
                case 1:{
                    GivePlayerWeapon(playerid, 5, 1);
                }
                case 2:{
                    GivePlayerWeapon(playerid, 22, 5000);
                }
                case 3:{
                    GivePlayerWeapon(playerid, 23, 5000);
                }
                case 4:{
                    GivePlayerWeapon(playerid, 24, 5000);
                }
                case 5:{
                    GivePlayerWeapon(playerid, 25, 5000);
                }
                case 6:{
                    GivePlayerWeapon(playerid, 26, 5000);
                }
                case 7:{
                    GivePlayerWeapon(playerid, 27, 5000);
                }
                case 8:{
                    GivePlayerWeapon(playerid, 32, 5000);
                }
                case 9:{
                    GivePlayerWeapon(playerid, 28, 5000);
                }
                case 10:{
                    GivePlayerWeapon(playerid, 29, 5000);
                }
                case 11:{
                    GivePlayerWeapon(playerid, 30, 5000);
                }
                case 12:{
                    GivePlayerWeapon(playerid, 31, 5000);
                }
                case 13:{
                    GivePlayerWeapon(playerid, 33, 5000);
                }
                case 14:{
                    GivePlayerWeapon(playerid, 34, 5000);
                }
                case 15:{
                    GivePlayerWeapon(playerid, 35, 5000);
                }
                case 16:{
                    GivePlayerWeapon(playerid, 36, 5000);
                }
                case 17:{
                    GivePlayerWeapon(playerid, 37, 5000);
                }
                case 18:{
                    GivePlayerWeapon(playerid, 16, 5000);
                }
                case 19:{
                    GivePlayerWeapon(playerid, 17, 5000);
                }
                case 20:{
                    GivePlayerWeapon(playerid, 18, 5000);
                }
                case 21:{
                    GivePlayerWeapon(playerid, 39, 5000);
                    GivePlayerWeapon(playerid, 40, 1);
                }
                case 22:{
                    GivePlayerWeapon(playerid, 41, 5000);
                }
                case 23:{
                    GivePlayerWeapon(playerid, 42, 5000);
                }
                case 24:{
                    GivePlayerWeapon(playerid, 38, 5000);
                }
            }
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog) {
        if(response == 1) {
            switch (listitem) {
                case 0:{ //�ҵ�����
                    // if(!strcmp(msg, "�ҵ�����")) {
                    if(PlayerInfo[playerid][yzwrong] >= 6) {
                        new msgs[512], DBResult:uf;
                        new t = gettime() + 86400;
                        format(msgs, sizeof(msgs), "UPDATE `Users` SET `YzBantime` = %d WHERE `Name` = '%s'", t, GetName(playerid));
                        uf = db_query(user, msgs);
                        db_free_result(uf);
                        ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "����֤��������,��������������!", "ȷ��", "");
                        return 1;
                    } else {
                        ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
                    }
                    return 1;
                    // break;
                }
                case 1:{ //װ��
                    ShowPlayerAttireDialog(playerid);
                    return 1;
                }
                case 2:{ //�Ҿ�
                    AntiCommand[playerid] = 0;
                    cmd_mygoods(playerid, "");
                    return 1;
                }
                case 3:{
                    pViewMyCar(playerid);
                    return 1;
                }
                case 4:{
                    ChangePlayerColor(playerid, PlayerColorPage[playerid]);
                    return 1;
                }
                case 5:{
                    cmd_wdch(playerid, "");
                    return 1;
                }
                case 6:{
                    cmd_motto(playerid, "");
                    return 1;
                }
                case 7:
                {
                    new tpaState[32], wdState[32], fixState[32], objShow[32], autoflip[32], time[32], tweather[32], pbpz[32], sdb[32], net[32];
                    new showName_[32], showStunt_[32], tmp[384];
                    if(tpaB[playerid] == 3) format(tpaState, sizeof(tpaState), "������Ҵ�����Ϣ:{FF0000}��");
                    else format(tpaState, sizeof(tpaState), "������Ҵ�����Ϣ:{00FF00}��");

                    if(PlayerInfo[playerid][enableInvincible]) format(wdState, sizeof(wdState), "α�޵�״̬:{00FF00}��");
                    else format(wdState, sizeof(wdState), "α�޵�״̬:{FF0000}��");

                    if(PlayerInfo[playerid][AutoFix]) format(fixState, sizeof(fixState), "�Զ��޳�:{00FF00}��");
                    else format(fixState, sizeof(fixState), "�Զ��޳�:{FF0000}��");

                    if(!PlayerInfo[playerid][displayObject]) format(objShow, sizeof(objShow), "OBJ��ʾ:{FF0000}��");
                    else format(objShow, sizeof(objShow), "OBJ��ʾ:{00FF00}��");

                    if(PlayerInfo[playerid][AutoFlip]) format(autoflip, sizeof(autoflip), "��������:{00FF00}��");
                    else format(autoflip, sizeof(autoflip), "��������:{FF0000}��");

                    if(PlayerInfo[playerid][NoCrash]) format(pbpz, sizeof(pbpz), "������ײ:{00FF00}��");
                    else format(pbpz, sizeof(pbpz), "������ײ:{FF0000}��");

                    if(PlayerInfo[playerid][speedoMeter]) format(sdb, sizeof(sdb), "�ٶȱ�:{00FF00}��");
                    else format(sdb, sizeof(sdb), "�ٶȱ�:{FF0000}��");

                    if(PlayerInfo[playerid][netStats]) format(net, sizeof(net), "�������:{00FF00}��");
                    else format(net, sizeof(net), "�������:{FF0000}��");

                    if(PlayerInfo[playerid][showName]) format(showName_, sizeof(showName_), "�������:{00FF00}��");
                    else format(showName_, sizeof(showName_), "�������:{FF0000}��");

                    if(PlayerInfo[playerid][showStunt]) format(showStunt_, sizeof(showStunt_), "��Ч����:{00FF00}��");
                    else format(showStunt_, sizeof(showStunt_), "��Ч����:{FF0000}��");

                    format(time, sizeof(time), "�ҵ�ʱ��:%02d:%02d", PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute]);
                    format(tweather, sizeof(tweather), "�ҵ�����:%d", PlayerInfo[playerid][tWeather]);
                    format(tmp, sizeof(tmp), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s", tpaState,wdState,fixState,objShow,autoflip,pbpz,sdb,net,showName_,showStunt_,time,tweather);
                    // format(tmp, sizeof(tmp), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",tpaState,?wdState,?fixState,?objShow,?autoflip,?pbpz,?sdb,?net,?showName_, showStunt_, time,?tweather);
                    Dialog_Show(playerid, CustomSettings, DIALOG_STYLE_LIST, "���Ի�����", tmp, "ȷ��", "����");
                    return 1;
                }
            }
            return 1;
        }
    }
    if(dialogid == PlayerInfoDialog + 4) {
        if(response == 1) {
            new str[32], temp[32], thour[128], tminute[128], hour, minute, idx;
            format(temp, 32, "%s", inputtext);
            thour = strtok(temp, idx);
            hour = strval(thour);
            tminute = strtok(temp, idx);
            minute = strval(tminute);
            if(hour < 0 || hour > 24) return SCM(playerid, Color_LightBlue, "[ʱ��] /time ʱ �� СʱΪ0~24,��Ϊ0~59");
            if(minute < 0 || minute > 59) return SCM(playerid, Color_LightBlue, "[ʱ��] /time ʱ �� СʱΪ0~24,��Ϊ0~59");
            PlayerInfo[playerid][tHour] = hour;
            PlayerInfo[playerid][tMinute] = minute;
            format(str, sizeof(str), "/time %d %d", PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute]);
            AntiCommand[playerid] = 0;
            OnPlayerCommandText(playerid, str);
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
        }
        // }
        // else {
        //     SetPlayerTime(playerid, hour, minute);
        // }
        // new time = strtok(inputtext, ":");
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 5) {
        if(response == 1) {
            AntiCommand[playerid] = 0;
            new str[16];
            format(str, sizeof(str), "/tianqi %d", strval(inputtext));
            AntiCommand[playerid] = 0;
            OnPlayerCommandText(playerid, str);
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 1) {
        if(response == 1) {
            if(strfind(inputtext, "@", true) == -1) {
                ShowPlayerDialog(playerid, PlayerInfoDialog + 1, DIALOG_STYLE_INPUT, "��ȫ������", "{FFFF00}������������˺�{FF0000}����{FFFF00}(����12345@qq.com)\n{33CCCC}�������������������������֤", "ȷ��", "ȡ��");
                return 1;
            }
            new query[200];
            format(query, sizeof(query), "SELECT `email` FROM players WHERE email = '%s'", inputtext);
            mysql_query(query);
            mysql_store_result();
            new numrows = mysql_num_rows();
            if(numrows == 1) {
                ShowPlayerDialog(playerid, PlayerInfoDialog + 1, DIALOG_STYLE_INPUT, "��ȫ������", "{FFFF00}������������˺�{FF0000}�ѱ�ע��{FFFF00}\n{33CCCC}�������������������������֤", "ȷ��", "ȡ��");
                mysql_free_result();
                return 1;
            }
            SendClientMessage(playerid, 0xFFFFFFFF, "��֤���Ѿ��ɹ����͵��������,��鿴���������֤");
            new string[256], pname[24];
            GetPlayerName(playerid, pname, 24);
            format(string, sizeof(string), "127.0.0.1/email.php?name=%s&email=%s", pname, inputtext);
            HTTP(playerid, HTTP_GET, string, "", "MyHttpResponseEX");
            new queryex[64];
            format(queryex, sizeof(queryex), "UPDATE `players` SET `email` = '%s' WHERE name = '%s'", inputtext, pname);
            mysql_query(queryex);
            format(pemail[playerid], 256, "%s", inputtext);
            ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���(��Ҫ60���)\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
            PlayerInfo[playerid][Yztime] = 60;
            return 1;
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 2) {
        if(!response) {
            if(!PlayerInfo[playerid][Login]) {
                // ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
                Kick(playerid);
                return 1;
            }
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
            return 1;
        }
        switch (listitem) {
            case 0:{
                ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
            }
            case 1:{
                if(PlayerInfo[playerid][Yztime] != 0) {
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
                }
                if(PlayerInfo[playerid][yzwrong] >= 6) {
                    new msgs[512], DBResult:uf;
                    new t = gettime() + 86400;
                    format(msgs, sizeof(msgs), "UPDATE `Users` SET `YzBantime` = %d WHERE `Name` = '%s'", t, GetName(playerid));
                    uf = db_query(user, msgs);
                    db_free_result(uf);
                    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "����֤��������,��������������!", "ȷ��", "");
                    return 1;
                }
                if(strcmp(pemail[playerid], "-1") == 0) {
                    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "��ʱ��֤!", "ȷ��", "");
                    return 1;
                }
                if(strcmp(pemail[playerid], "-1") != 0) {
                    new Query[300], pname[24], escpname[24];
                    GetPlayerName(playerid, pname, 24);
                    mysql_real_escape_string(pname, escpname);
                    format(Query, sizeof(Query), "SELECT * FROM `players` WHERE `name` = '%s'", pname);
                    mysql_query(Query);
                    mysql_store_result();
                    if(mysql_num_rows() != 0) {
                        new queryex[64], sqlresult[256];
                        new Field[256];
                        new yz;
                        format(queryex, sizeof(queryex), "SELECT * FROM `players` WHERE name = '%s'", pname);
                        mysql_query(queryex);
                        mysql_store_result();
                        if(mysql_fetch_row(sqlresult) == 1) {

                        }
                        mysql_fetch_field_row(Field, "yz");
                        yz = strval(Field);
                        if(yz == 1) {
                            ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "�����������䱣��,���˺������������������һ�!", "ȷ��", "");
                        }
                    }
                    //���else��д�� ��Ϊ��Ĭ����ע���ʱ��Ų������� ���ڴ˹���֮ǰ�Ѿ�ע�����û�����ݵ� ������Ҫ����һ������ 
                    // 2020.3.29�� ����������Ƶ�
                    else {
                        new Query2[256];
                        format(Query2, 256, "INSERT INTO `players` (`name`,`code`,`email`,`yz`) VALUES('%s',0,0,0)", GetName(playerid));
                        mysql_query(Query2);
                        mysql_free_result();
                    }
                    SendClientMessage(playerid, 0xFFFFFFFF, "��֤���Ѿ��ɹ����͵��������,��鿴���������֤");
                    new string[256];
                    GetPlayerName(playerid, pname, 24);
                    format(string, sizeof(string), "127.0.0.1/email.php?name=%s&email=%s", pname, inputtext);
                    HTTP(playerid, HTTP_GET, string, "", "MyHttpResponseEX");
                    new queryex[64];
                    format(queryex, sizeof(queryex), "UPDATE `players` SET `email` = '%s' WHERE name = '%s'", inputtext, pname);
                    mysql_query(queryex);
                    format(pemail[playerid], 256, "%s", inputtext);
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���(��Ҫ60���)\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
                    PlayerInfo[playerid][Yztime] = 60;
                    SCM(playerid, Color_White, "ϵͳ:����ղ�����֤�볢�Ը�����������,����ᱻ��ֹ��֤1��!");
                    PlayerInfo[playerid][yzwrong]++;
                }
            }
            case 2:{
                //.
                new Query[300], pname[24], escpname[24];
                GetPlayerName(playerid, pname, 24);
                mysql_real_escape_string(pname, escpname);
                format(Query, sizeof(Query), "SELECT * FROM `players` WHERE `name` = '%s'", pname);
                mysql_query(Query);
                mysql_store_result();
                if(mysql_num_rows() != 0) {
                    new queryex[64], sqlresult[256];
                    new Field[256];
                    new yz;
                    format(queryex, sizeof(queryex), "SELECT * FROM `players` WHERE name = '%s'", pname);
                    mysql_query(queryex);
                    mysql_store_result();
                    if(mysql_fetch_row(sqlresult) == 1) {

                    }
                    mysql_fetch_field_row(Field, "yz");
                    yz = strval(Field);
                    if(yz == 1) {
                        ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "�����������䱣��,���˺������������������һ�!", "ȷ��", "");
                        return 1;
                    }
                }
                if(PlayerInfo[playerid][Yztime] != 0) {
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
                } else {
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 1, DIALOG_STYLE_INPUT, "��ȫ������", "{FFFFFF}������:{33CCCC}�������", "ȷ��", "ȡ��");
                }
            }
            case 3:{
                if(strcmp(pemail[playerid], "-1") == 0) {
                    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "��ʱ��֧����֤!", "ȷ��", "");
                    return 1;
                }
                if(PlayerInfo[playerid][yzmode] == 1) {
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 8, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n������֤��", "ȷ��", "ȡ��");
                    return 1;
                }
                ShowPlayerDialog(playerid, PlayerInfoDialog + 3, DIALOG_STYLE_INPUT, "��ȫ������", "{FFFFFF}������:{33CCCC}��֤��", "ȷ��", "ȡ��");
            }
            case 4:{
                if(PlayerInfo[playerid][yzwrong] >= 3) {
                    SCM(playerid, Color_White, "[ϵͳ]�벻Ҫ��ʱ�����ظ���������!");
                    return 1;
                }
                if(PlayerInfo[playerid][Yztime] != 0) {
                    SCM(playerid, Color_White, "[ϵͳ]�벻Ҫ��ʱ�����ظ���������!");
                    return 1;
                }
                new query[300], pname[24], escpname[24];
                pname = GetName(playerid);
                mysql_real_escape_string(pname, escpname);
                format(query, sizeof(query), "SELECT * FROM `players` WHERE `name` = '%s'", pname);
                mysql_query(query);
                mysql_store_result();
                if(mysql_num_rows() != 0) {
                    new queryex[64], sqlresult[256];
                    new Field[256];
                    new yz;
                    format(queryex, sizeof(queryex), "SELECT * FROM `players` WHERE name = '%s'", pname);
                    mysql_query(queryex);
                    mysql_store_result();
                    if(mysql_fetch_row(sqlresult) == 1) {

                    }
                    mysql_fetch_field_row(Field, "yz");
                    yz = strval(Field);
                    if(yz != 1) {
                        // ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ϵͳ", "�㻹û�������䱣��!��������!", "ȷ��", "");
                        // 2020.2.28 ȡ������ û���ñ�������һ��֧���޸�����
                        ShowPlayerDialog(playerid, PlayerInfoDialog + 9, DIALOG_STYLE_INPUT, "{FFFF00}��ȫϵͳ", "{9AFF9A}��ӭ!\n����������������������޸�!\n���μ������˺�����!\n�Ѳ���ɢ�м��������赣������й¶", "ȷ��", "ȡ��");
                    } else {
                        new string[132];
                        format(query, sizeof(query), "SELECT email FROM `players` WHERE name = '%s'", GetName(playerid));
                        mysql_query(query);
                        mysql_store_result();
                        mysql_fetch_field_row(Field, "email");
                        format(pemail[playerid], 256, "%s", Field);
                        SendClientMessage(playerid, 0xFFFFFFFF, "��֤���Ѿ��ɹ����͵��������,��鿴���������֤");
                        format(string, sizeof(string), "127.0.0.1/email.php?name=%s&email=%s", pname, Field);
                        HTTP(playerid, HTTP_GET, string, "", "MyHttpResponseEX");
                        format(queryex, sizeof(queryex), "UPDATE `players` SET `email` = '%s' WHERE name = '%s'", Field, pname);
                        mysql_query(queryex);
                        format(pemail[playerid], 256, "%s", Field);
                        ShowPlayerDialog(playerid, PlayerInfoDialog + 8, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n������֤��", "ȷ��", "ȡ��");
                        PlayerInfo[playerid][Yztime] = 60;
                        PlayerInfo[playerid][yzmode] = 1;
                    }
                }
                return 1;
            }
            case 5:{
                if(!PlayerInfo[playerid][Login]) return ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
                ShowPlayerDialog(playerid, PlayerInfoDialog + 10, DIALOG_STYLE_INPUT, "{FFFF00}��ȫϵͳ", "��������Ҫ�޸ĳɵ��û���\n����ʹ�������������дʵ��ַ�,��ʧ������˺���ʧ���Լ�����\nUID������,�޸�һ���û�����6000���", "ȷ��", "ȡ��");
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 3) {
        if(response == 1) {
            new query1[64], sqlresult[256];
            new Field[256];
            format(query1, sizeof(query1), "SELECT * FROM `players` WHERE name = '%s'", GetName(playerid));
            mysql_query(query1);
            mysql_store_result();
            if(mysql_fetch_row(sqlresult) == 1) {}
            mysql_fetch_field_row(Field, "code");
            strmid(pcode[playerid], Field, 0, strlen(Field), 255);
            if(strcmp(pcode[playerid], inputtext, true) == 0) {
                new query[1028];
                format(query, sizeof(query), "UPDATE `players` SET `yz` = 1,`email` ='%s' WHERE name = '%s'", pemail[playerid], GetName(playerid));
                mysql_query(query);
                SendClientMessage(playerid, 0xFFFFFFFF, "[ϵͳ]��ϲ��,������֤�ɹ�!");
                format(pemail[playerid], 256, "-1");
                PlayerInfo[playerid][yzwrong] = 0;
                PlayerInfo[playerid][yzmode] = 0;
            } else {
                if(strcmp(pcode[playerid], inputtext, true) != 0) {
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 3, DIALOG_STYLE_INPUT, "������֤ϵͳ", "��֤���������\n������������������֤������֤", "ȷ��", "ȡ��");
                    PlayerInfo[playerid][yzwrong]++;
                }
            }
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 8) {
        if(response == 1) {
            new query1[64], sqlresult[256];
            new Field[256];
            format(query1, sizeof(query1), "SELECT * FROM `players` WHERE name = '%s'", GetName(playerid));
            mysql_query(query1);
            mysql_store_result();
            if(mysql_fetch_row(sqlresult) == 1) {}
            mysql_fetch_field_row(Field, "code");
            strmid(pcode[playerid], Field, 0, strlen(Field), 255);
            if(strcmp(pcode[playerid], inputtext, true) == 0) {
                ShowPlayerDialog(playerid, PlayerInfoDialog + 9, DIALOG_STYLE_INPUT, "{FFFF00}������֤ϵͳ", "{FFFFFF}��֤�ɹ�!������{FFFF00}�����룡", "ȷ��", "ȡ��");
                PlayerInfo[playerid][yzwrong] = 0;
                PlayerInfo[playerid][yzmode] = 0;
            } else {
                if(strcmp(pcode[playerid], inputtext, true) != 0) {
                    ShowPlayerDialog(playerid, PlayerInfoDialog + 8, DIALOG_STYLE_INPUT, "{FFFF00}������֤ϵͳ", "��֤���������\n������������������֤������֤", "ȷ��", "ȡ��");
                    PlayerInfo[playerid][yzwrong]++;
                }
            }
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 9) {
        if(response == 1) {
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, PlayerInfoDialog + 9, DIALOG_STYLE_INPUT, "{FFFF00}��ȫ����", "{9AFF9A}��ӭ!\n����������������������޸�!\n���μ������˺�����!\n�Ѳ���ɢ�м��������赣������й¶", "ȷ��", "ȡ��");
            if(strlen(inputtext) < 6 || strlen(inputtext) > 16) ShowPlayerDialog(playerid, PlayerInfoDialog + 9, DIALOG_STYLE_INPUT, "{FFFF00}������֤ϵͳ", "{FFFFFF}��֤�ɹ�!������6-16λ��{FFFF00}�����룡", "ȷ��", "ȡ��");
            new query[1028];
            format(query, sizeof(query), "UPDATE `players` SET `yz` = 1,`email` ='%s' WHERE name = '%s'", pemail[playerid], GetName(playerid));
            mysql_query(query);
            OnPlayerReloadRegister(playerid, inputtext);
        }
        return 1;
    }
    if(dialogid == PlayerInfoDialog + 10) {
        if(response) {
            if(PlayerInfo[playerid][Cash] < 6000) return SendClientMessage(playerid, Color_White, "[ϵͳ]�����˻�����6000,���㹻���ڸ���");
            if(strlen(inputtext) < 4 || strlen(inputtext) > 24) return SendClientMessage(playerid, Color_White, "[ϵͳ]�û������ȴ���");
            new placeholder;
            for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
            {
                placeholder = strfind(inputtext, InvalidWords[i], true);
                if(placeholder != -1) {
                    SendClientMessage(playerid, Color_White, "[ϵͳ]����ʹ�÷Ƿ��û���");
                    return 1;
                }
            }
            if(strfind(inputtext, "{", true) != -1 || strfind(inputtext, "}", true) != -1) {
                return SendClientMessage(playerid, Color_White, "[ϵͳ]�û������ɴ���{}");
            }
            new flag = false;
            for (new i = 0; i < strlen(inputtext); i++) {
                if((inputtext[i] >= 48 && inputtext[i] <= 57) || (inputtext[i] >= 65 && inputtext[i] <= 125)) flag = true;
                else flag = false;
            }
            if(!flag) return SendClientMessage(playerid, Color_White, "[ϵͳ]�û�����[0-9a-Z_]���");
            // ֻҪ�ж��Ƿ��������ģ�û�о�ֱ�Ӹ���UID UPDATE�û����Ϳ�����
            if(AccountCheck(inputtext)) return SendClientMessage(playerid, Color_White, "[ϵͳ]����û����Ѿ�����ʹ����Ŷ");
            new name[25];
            format(name, sizeof name, GetName(playerid));
            for (new i = 0; i < MAX_SELL; i++) {
                if(mk_strcmp(p_Sell[i][sell_player], name) == 0) ChangeSellPlayer(i, inputtext); // ��������û�з��� �еĻ���������ȫת����
            }
            for (new i = 0; i < loadcount; i++) { // ��������û�мҾ� �еĻ��Ҿ�ת��
                if(mk_strcmp(GOODS[i][GoodOwner], name) == 0) {
                    format(GOODS[i][GoodOwner], 65, inputtext);
                    format(GOODS[i][GoodName], 125, "%s ����Ʒ", inputtext);
                    UpdateGoods3dtextlabel(i);
                    SaveGoods(i);
                }
            }
            new msg[128];
            format(msg, sizeof(msg), "UPDATE `Users` SET `Name` = '%s' WHERE `ID` = %d", inputtext, PlayerInfo[playerid][ID]);
            db_free_result(db_query(user, msg));
            GivePlayerCash(playerid, -6000);
            SetPlayerName(playerid, inputtext);
            SendClientMessage(playerid, Color_White, "[ϵͳ]�����û����ɹ�");
        }
        return 1;
    }
    if(dialogid == Dialog_SpawnVehicle) {
        if(response == 1) {
            switch (listitem) {
                case 0:{
                    ShowModelSelectionMenu(playerid, chaopaolist, "->Cars<-");
                }
                case 1:{
                    ShowModelSelectionMenu(playerid, jingchelist, "->Cars<-");
                }
                case 2:{
                    ShowModelSelectionMenu(playerid, planelist, "->Planes<-");
                }
                case 3:{
                    ShowModelSelectionMenu(playerid, Motorolalist, "->Motorolas<-");
                }
                case 4:{
                    ShowModelSelectionMenu(playerid, Shiplist, "->Ships<-");
                }
                case 5:{
                    ShowModelSelectionMenu(playerid, yueyelist, "->Cars<-");
                }
                case 6:{
                    ShowModelSelectionMenu(playerid, tuoche, "->Cars<-");
                }
                case 7:{
                    ShowModelSelectionMenu(playerid, huoche, "->Cars<-");
                }
                case 8:{
                    ShowModelSelectionMenu(playerid, trainlist, "->Trains<-");
                }
                case 9:{
                    ShowModelSelectionMenu(playerid, minzhen, "->Cars<-");
                }
                case 10:{
                    ShowModelSelectionMenu(playerid, Otherlist, "->Others<-");
                }
            }
        }
        return 1;
    }
    if(dialogid == Dialog_Register) {
        if(!response) return Kick(playerid);
        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "ע��", "���ʺŻ�û�б�{22DD22}ע��{FFFFFF},�������������{22DD22}ע��..", "ע��", "�˳�");
        if(strlen(inputtext) < 6 || strlen(inputtext) > 16) return ShowPlayerDialog(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "ע��", "{FFFFFF}�������������{22DD22}ע��{FFFFFF},�������Ϊ{22DD22}6-16λ֮��!.", "ע��", "�˳�");
        if(!IsValidPassword(inputtext)) return ShowPlayerDialog(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "ע��", "���ʺŻ�û�б�ע��,�������������ע��.", "ע��", "�˳�");
        OnPlayerRegister(playerid, inputtext);
        return 1;
    } else if(dialogid == Dialog_Login) {
        if(!response) {
            // ShowPlayerDialog(playerid, PlayerInfoDialog + 2, DIALOG_STYLE_LIST, "��ȫ������", "\n��ѡ�����������\n���·���\n��������\n������֤��\n�޸�����\n�޸��û���", "ȷ��", "ȡ��");
            // return 1;
            return Kick(playerid); //û��¼�Ļ�Ȼ�󵯳���Ұ�ȫ���� ����ֻ���һ���������
        }
        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "��¼", "{00FFFF}����˺���ע��\n{00FFFF}�������������������.�㻹��{80FF80}3�λ���{00FFFF}��������", "��¼", "�˳�");
        OnPlayerLogin(playerid, inputtext);
        return 1;
    }
    if(dialogid == GODIOG_BUY) {
        if(response == 1) {

            if(GOODS[GOODS_OPRATEID[playerid]][issale] == false) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR>.<[���ظ�����BUG]", "{FF0000}����Ʒ�Ѿ���������", "��~", "");
            if(GetPlayerMoney(playerid) < GOODS[GOODS_OPRATEID[playerid]][GoodPrize]) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ERROR>.<", "��~���ֲ���", "����", "");

            // if(GetPlayerScore(playerid) < GOODS[GOODS_OPRATEID[playerid]][GoodPrize]) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "ERROR>.<", "��~���ֲ���", "����", "");
            // SetPlayerScore(playerid, GetPlayerScore(playerid) - GOODS[GOODS_OPRATEID[playerid]][GoodPrize]);
            GivePlayerMoney(playerid, GOODS[GOODS_OPRATEID[playerid]][GoodPrize] * -1);
            SendClientMessage(playerid, 0xFFFFFFC8, "[�Ҿ�]����ɹ�");
            new owner[65];
            GetPlayerName(playerid, owner, 65);
            format(GOODS[GOODS_OPRATEID[playerid]][GoodOwner], 65, owner);
            format(GOODS[GOODS_OPRATEID[playerid]][GoodName], 125, "%s ����Ʒ", owner);
            GOODS[GOODS_OPRATEID[playerid]][Key] = 0;
            GOODS[GOODS_OPRATEID[playerid]][issale] = false;
            GOODS[GOODS_OPRATEID[playerid]][topublic] = false;
            // 		GOODS[GOODS_OPRATEID[playerid]][GoodPrize]=0; Disabled
            GOODS[GOODS_OPRATEID[playerid]][WID] = GetPlayerVirtualWorld(playerid);
            UpdateGoods3dtextlabel(GOODS_OPRATEID[playerid]);
            SaveGoods(GOODS_OPRATEID[playerid]);
            //SaveGoods();
            return 1;
        }
        return 1;
    }

    if(dialogid == GODIOG_PL) {
        if(response) {
            if(listitem == 0) {
                //Pick up goods here
                ApplyAnimation(playerid, "CARRY", "liftup", 4, 0, 0, 1, 1, 1);
                SetTimerEx("PickUP", 1500, false, "i", playerid);
                SendClientMessage(playerid, 0x00FFFFC8, "[�Ҿ�]:��ס�����������Ʒ");
                return 1;
            }
            if(listitem == 1) {
                //here is for name changing
                ShowPlayerDialog(playerid, GODIOG_CGNAME, DIALOG_STYLE_INPUT, "{FF80C0}�����޸�", "{FF80C0}������������", "�޸�", "�ر�");
                return 1;
            }
            if(listitem == 2) {
                //here is for pos editing
                EditDynamicObject(playerid, GOODS[GOODS_OPRATEID[playerid]][OrderId]);
                return 1;
            }
            if(listitem == 3) {
                //here is for key
                ShowPlayerDialog(playerid, GODIOG_KEY, DIALOG_STYLE_INPUT, "{8000FF}����", "{8000FF}�����������Ʒ����(������)\n{FF0000}ע��'0'Ϊû������", "���", "�ر�");
                return 1;
            }
            if(listitem == 4) {
                //here is for public setting
                if(GOODS[GOODS_OPRATEID[playerid]][topublic] == true) {
                    GOODS[GOODS_OPRATEID[playerid]][topublic] = false;
                    //	print("YES");
                } else {
                    GOODS[GOODS_OPRATEID[playerid]][topublic] = true;
                    //print("NO");
                }
                //save it
                SaveGoods(GOODS_OPRATEID[playerid]);
                //then show player dialog
                //I wonder if i should put a if to see that player is owner?
                if(GOODS[GOODS_OPRATEID[playerid]][topublic] == true) {
                    new title[285];
                    format(title, 285, "{FFFFFF}��ƷID:{80FF80} %d {FFFFFF}����:{80FF80} %s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                    ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_YES, "ѡ��", "�ر�");
                } else {
                    new title[285];
                    format(title, 285, "{FFFFFF}��ƷID:\
                        {80FF80} %d {FFFFFF}����:\
                        {80FF80} %s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                    ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_NO, "ѡ��", "�ر�");
                }
                return 1;
            }
            if(listitem == 5) {
                new title[285];
                format(title, 285, "���� {FFFFFF}��ƷID:\
                    {80FF80} %d {FFFFFF}����:\
                    {80FF80} %s - {80FFFF} �_�J��?", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                ShowPlayerDialog(playerid, GODIOG_SELL, DIALOG_STYLE_LIST, title, "����ϵͳ(���)\n�������", "ѡ��", "�ر�");
                return 1;
            }
        }
        return 1;
    }

    if(dialogid == GODIOG_SELL) {
        if(response == 1) {
            if(listitem == 0) {
                SellGoodsToSYS(playerid, GOODS_OPRATEID[playerid]);
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == GODIOG_CGNAME) {
        if(response == 1) {
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, GODIOG_CGNAME, DIALOG_STYLE_INPUT, "{FF0000}�ܴa�޸�", "{FF0000}���ֲ���Ϊ��!", "�޸�", "�ر�");
            format(GOODS[GOODS_OPRATEID[playerid]][GoodName], 125, inputtext);
            UpdateGoods3dtextlabel(GOODS_OPRATEID[playerid]);
            SendClientMessage(playerid, 0xFFFFFFC8, "[�Ҿ�]�����޸ĳɹ�");
            SaveGoods(GOODS_OPRATEID[playerid]);
            return 1;
        }
        return 1;
    }
    if(dialogid == GODIOG_TAKEDOWN) {
        if(response == 1) {
            ApplyAnimation(playerid, "Freeweights", "gym_free_putdown", 2, 0, 0, 1, 1, 1);
            RemovePlayerAttachedObject(playerid, 9);
            TAKEDOWN_STATUS[playerid] = true;
            SetTimerEx("TakeDown", 1500, false, "i", playerid);
            return 1;
        }
        return 1;
    }
    if(dialogid == GODIOG_KEY) {
        if(response == 1) {
            if(!strval(inputtext)) {
                GOODS[GOODS_OPRATEID[playerid]][Key] = 0;
                ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "{80FF80}�����޸�", "{80FF80}���뱻ȡ����", "OK", "");
                return 1;
            }
            GOODS[GOODS_OPRATEID[playerid]][Key] = strval(inputtext);
            SendClientMessage(playerid, 0xFFFFFFC8, "[�Ҿ�]�����޸ĳɹ�");
            SaveGoods(GOODS_OPRATEID[playerid]);
            return 1;
        }
        return 1;
    }
    if(dialogid == GODIOG_PASS) { //password check
        if(response == 1) {
            if(GOODS[GOODS_OPRATEID[playerid]][Key] == strval(inputtext)) {

                SendClientMessage(playerid, 0xFFFFFFC8, "[�Ҿ�]:������ȷ,����Բ��������Ʒ��!");
                if(GOODS[GOODS_OPRATEID[playerid]][topublic] == true) {
                    new title[285];
                    format(title, 285, "{FFFFFF}��ƷID:{80FF80}%d {FFFFFF}����:{80FF80}%s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                    ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_YES, "ѡ��", "�ر�");
                } else {
                    new title[285];
                    format(title, 285, "{FFFFFF}��ƷID:{80FF80}%d {FFFFFF}����:{80FF80}%s - {80FFFF}�����˵�", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                    ShowPlayerDialog(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_NO, "ѡ��", "�ر�");
                }
            } else {
                ShowPlayerDialog(playerid, GODIOG_PASS, DIALOG_STYLE_INPUT, "{80FF80}��ȫ��֤��ʽ", "{FF0000}���������!\nҪ��������������\n{80FF80}���������������ȥ��̳����", "OK", "ȡ��");
                return 1;
            }
        }
    }
    if(dialogid == DIALOG_ACL_LIST) {
        if(response == 1) {
            new txt[PHOUSE_TXTLEN], idx;
            GetPVarString(playerid, "PHouse_AclList_TxtNmae", txt, PHOUSE_TXTLEN);
            if(mk_strcmp(inputtext, "��һҳ") == 0) {
                SetPVarInt(playerid, "PHouse_AclList_NowSelect", GetPVarInt(playerid, "PHouse_AclList_NowSelect") + 1);
                ShowAclList(playerid, txt);
                return 1;
            }
            if(mk_strcmp(inputtext, "��һҳ") == 0) {
                SetPVarInt(playerid, "PHouse_AclList_NowSelect", GetPVarInt(playerid, "PHouse_AclList_NowSelect") - 1);
                ShowAclList(playerid, txt);
                return 1;
            }
            if(GetTxtPlayer(txt) != 0) {
                RedPlayerToTxt(strtok(inputtext, idx), txt);
                ShowAclList(playerid, txt);
                return 1;
            }
            return 1;
        }
    }
    if(dialogid == HouseListDialog) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��һҳ") == 0) {
                SelectHousePage[playerid]--;
                House_ShowListDialog(playerid, SelectHousePage[playerid]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                SelectHousePage[playerid]++;
                House_ShowListDialog(playerid, SelectHousePage[playerid]);
                return 1;
            }
            format(msg, sizeof msg, "/house goto %s", inputtext);
            AntiCommand[playerid] = 0;
            OnPlayerCommandText(playerid, msg);
            return 1;
        }
        return 1;
    }
    if(dialogid == BoardsListDialog) {
        if(response == 1) {
            new msg[128], idx;
            msg = strtok(inputtext, idx);
            if(strcmp(msg, "��һҳ") == 0) {
                SelectBoardsPage[playerid]--;
                Board_ShowListDialog(playerid, SelectBoardsPage[playerid]);
                return 1;
            }
            if(strcmp(msg, "��һҳ") == 0) {
                SelectBoardsPage[playerid]++;
                Board_ShowListDialog(playerid, SelectBoardsPage[playerid]);
                return 1;
            }
            format(msg, sizeof msg, "/board goto %s", inputtext);
            AntiCommand[playerid] = 0;
            OnPlayerCommandText(playerid, msg);
            return 1;
        }
        return 1;
    }
    if(dialogid == Dialog_BOARDS) {
        if(!response) {
            pInEditTagBoards[playerid] = -1;
            return 1;
        }
        if(listitem == 0) return ShowPlayerDialog(playerid, Dialog_BOARDSTEXT, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ�ڹ����д����", "ȷ��", "����");
        if(listitem == 1) return ShowPlayerDialog(playerid, Dialog_BOARDSMINDEX, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õĲ���ָ��(0-15)", "ȷ��", "����");
        if(listitem == 2) return ShowPlayerDialog(playerid, Dialog_BOARDSMSIZE, DIALOG_STYLE_LIST, "�����(ѡ����Ҫ�Ĳ��ʴ�С)", "32x32\n64x32\n64x64\n128x32\n128x64\n128x128\n256x32\n256x64\n256x128\n256x256\n512x64\n512x128\n512x256\n512x512", "ȷ��", "����");
        if(listitem == 3) return ShowPlayerDialog(playerid, Dialog_BOARDSFONTFACE, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õ�����\n�����������ȷʵ���ڵ�����,�����޷���ʾ", "ȷ��", "����");
        if(listitem == 4) return ShowPlayerDialog(playerid, Dialog_BOARDSFONTFACESIZE, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õ������С(1-256)", "ȷ��", "����");
        if(listitem == 5) return ShowPlayerDialog(playerid, Dialog_BOARDSBOLD, DIALOG_STYLE_LIST, "�����(�����Ƿ�Ӵ�)", "��\n��", "ȷ��", "����");
        if(listitem == 6) return ShowPlayerDialog(playerid, Dialog_BOARDSFONTCOLOR, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õ���ɫ��ֵ", "ȷ��", "����");
        if(listitem == 7) return ShowPlayerDialog(playerid, Dialog_BOARDSBACKCOLOR, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õ���ɫ��ֵ", "ȷ��", "����");
        if(listitem == 8) return ShowPlayerDialog(playerid, Dialog_BOARDSTextA, DIALOG_STYLE_LIST, "�����(������뷽ʽ)", "�������\n���ж���\n���Ҷ���", "ȷ��", "����");
        if(listitem == 9) return EditBoards(playerid, pInEditTagBoards[playerid]);
        if(listitem == 10) {
            if(DeleteBoards(playerid, pInEditTagBoards[playerid]) != -1) {
                SendClientMessage(playerid, Color_White, "[�����]ɾ���ɹ����˻������˽��..");
                pInEditTagBoards[playerid] = -1;
            } else {
                SendClientMessage(playerid, Color_White, "[�����]ɾ��ʧ����..");
                MyBoard(playerid, pInEditTagBoards[playerid]);
            }
            return 1;
        }
        return 1;
    }
    if(dialogid == Dialog_BOARDSTEXT) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(strcmp(inputtext, " ") == 0 || strlen(inputtext) < 1 || strlen(inputtext) > 1024) {
            ShowPlayerDialog(playerid, Dialog_BOARDSTEXT, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ�ڹ����д����\n����Ϊ�ղ��������ַ���(1-1024)֮��", "ȷ��", "����");
            return 1;
        }
        format(BoardsInfo[pInEditTagBoards[playerid]][BText], 1024, "%s\n", inputtext);
        new placeholder, msg[1024];
        for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
        {
            placeholder = strfind(BoardsInfo[pInEditTagBoards[playerid]][BText], InvalidWords[i], true);
            if(placeholder != -1) {
                for (new x = placeholder; x < placeholder + strlen(InvalidWords[i]); x++) {
                    BoardsInfo[pInEditTagBoards[playerid]][BText][x] = '*';
                }
            }
        }
        format(msg, 1024, "��Ŀǰ���������:%s", BoardsInfo[pInEditTagBoards[playerid]][BText]);
        ShowPlayerDialog(playerid, Dialog_BOARDSTEXT2, DIALOG_STYLE_INPUT, "�����", msg, "��һ��", "ȷ��");
        return 1;
    }
    if(dialogid == Dialog_BOARDSTEXT2) {
        if(!response) {
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(strcmp(inputtext, " ") == 0 || strlen(inputtext) < 1 || strlen(inputtext) > 1024 || strlen(BoardsInfo[pInEditTagBoards[playerid]][BText]) >= 1024) {
            ShowPlayerDialog(playerid, Dialog_BOARDSTEXT2, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ�ڹ����д����\n����Ϊ�ղ��������ַ���(1-1024)֮��", "��һ��", "ȷ��");
            return 1;
        }
        format(BoardsInfo[pInEditTagBoards[playerid]][BText], 1024, "%s%s\n", BoardsInfo[pInEditTagBoards[playerid]][BText], inputtext);
        new placeholder, msg[1024];
        for (new i = 0; i < sizeof InvalidWords; i++) //���δ��Զ���*
        {
            placeholder = strfind(BoardsInfo[pInEditTagBoards[playerid]][BText], InvalidWords[i], true);
            if(placeholder != -1) {
                for (new x = placeholder; x < placeholder + strlen(InvalidWords[i]); x++) {
                    BoardsInfo[pInEditTagBoards[playerid]][BText][x] = '*';
                }
            }
        }
        format(msg, 1024, "��Ŀǰ���������:%s", BoardsInfo[pInEditTagBoards[playerid]][BText]);
        ShowPlayerDialog(playerid, Dialog_BOARDSTEXT2, DIALOG_STYLE_INPUT, "�����", msg, "��һ��", "ȷ��");
        return 1;
    }
    if(dialogid == Dialog_BOARDSMINDEX) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(strval(inputtext) < 0 || strval(inputtext) > 15) {
            ShowPlayerDialog(playerid, Dialog_BOARDSMINDEX, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õĲ���ָ��\n��ȷ����(0-15)֮��", "ȷ��", "����");
            return 1;
        }
        BoardsInfo[pInEditTagBoards[playerid]][MaterialIndex] = strval(inputtext);
        UpdateBoards(pInEditTagBoards[playerid]);
        pInEditTagBoards[playerid] = -1;
        SCM(playerid, -1, "[�����]:�޸ĳɹ�");
        return 1;
    }
    if(dialogid == Dialog_BOARDSMSIZE) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(listitem == 0) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 10;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 1) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 20;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 2) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 30;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 3) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 40;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 4) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 50;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 5) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 60;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 6) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 70;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 7) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 80;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 8) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 90;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 9) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 100;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 10) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 110;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 11) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 120;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 12) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 130;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 13) {
            BoardsInfo[pInEditTagBoards[playerid]][MaterialSize] = 140;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        return 1;
    }
    if(dialogid == Dialog_BOARDSFONTFACE) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(strcmp(inputtext, " ") == 0 || strlen(inputtext) < 1 || strlen(inputtext) > 16) {
            ShowPlayerDialog(playerid, Dialog_BOARDSFONTFACE, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õ�����\n����Ϊ�ղ��������ַ���(1-16)֮��", "ȷ��", "����");
            return 1;
        }
        format(BoardsInfo[pInEditTagBoards[playerid]][FontFace], 64, inputtext);
        UpdateBoards(pInEditTagBoards[playerid]);
        pInEditTagBoards[playerid] = -1;
        SCM(playerid, -1, "[�����]:�޸ĳɹ�");
        return 1;
    }
    if(dialogid == Dialog_BOARDSFONTFACESIZE) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(strval(inputtext) < 1 || strval(inputtext) > 256) {
            ShowPlayerDialog(playerid, Dialog_BOARDSFONTFACESIZE, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ���õ������С(1-256)\n���ܳ�����Χ", "ȷ��", "����");
            return 1;
        }
        BoardsInfo[pInEditTagBoards[playerid]][FontSize] = strval(inputtext);
        UpdateBoards(pInEditTagBoards[playerid]);
        pInEditTagBoards[playerid] = -1;
        SCM(playerid, -1, "[�����]:�޸ĳɹ�");
        return 1;
    }
    if(dialogid == Dialog_BOARDSBOLD) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(listitem == 0) {
            BoardsInfo[pInEditTagBoards[playerid]][Bold] = 1;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 1) {
            BoardsInfo[pInEditTagBoards[playerid]][Bold] = 0;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        return 1;
    }
    //������
    if(dialogid == Dialog_BOARDSFONTCOLOR) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        new color = strval(inputtext);
        if(!strlen(inputtext) || color < -9999999999 || color > 9999999999) return ShowPlayerDialog(playerid, Dialog_BOARDSFONTCOLOR, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ����ARGB��ʽ����ɫֵ\n����Ϊ��", "ȷ��", "����");
        BoardsInfo[pInEditTagBoards[playerid]][FontColor] = color;
        UpdateBoards(pInEditTagBoards[playerid]);
        pInEditTagBoards[playerid] = -1;
        SCM(playerid, -1, "[�����]:�޸ĳɹ�");
        return 1;
    }
    //���Ҳ���
    if(dialogid == Dialog_BOARDSBACKCOLOR) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        new color = strval(inputtext);
        if(!strlen(inputtext) || color < -9999999999 || color > 9999999999) return ShowPlayerDialog(playerid, Dialog_BOARDSFONTCOLOR, DIALOG_STYLE_INPUT, "�����", "{FF0000}��������Ҫ����ARGB��ʽ����ɫֵ\n����Ϊ��", "ȷ��", "����");
        BoardsInfo[pInEditTagBoards[playerid]][BackColor] = color;
        UpdateBoards(pInEditTagBoards[playerid]);
        pInEditTagBoards[playerid] = -1;
        SCM(playerid, -1, "[�����]:�޸ĳɹ�");
        return 1;
    }
    if(dialogid == Dialog_BOARDSTextA) {
        if(!response) {
            MyBoard(playerid, pInEditTagBoards[playerid]);
            return 1;
        }
        if(listitem == 0) {
            BoardsInfo[pInEditTagBoards[playerid]][TextAlignment] = 0;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 1) {
            BoardsInfo[pInEditTagBoards[playerid]][TextAlignment] = 1;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        if(listitem == 2) {
            BoardsInfo[pInEditTagBoards[playerid]][TextAlignment] = 2;
            UpdateBoards(pInEditTagBoards[playerid]);
            pInEditTagBoards[playerid] = -1;
            SCM(playerid, -1, "[�����]:�޸ĳɹ�");
            return 1;
        }
        return 1;
    }
    if(dialogid == Dialog_BUYBOARDS) {
        if(!response) {
            return 1;
        }
        if(listitem == 0) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJPRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJPRICE);
            return 1;
        }
        if(listitem == 1) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJPRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ2, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ2PRICE);
            return 1;
        }
        if(listitem == 2) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJ3PRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ3, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ3PRICE);
            return 1;
        }
        if(listitem == 3) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJ4PRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ4, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ4PRICE);
            return 1;
        }
        if(listitem == 4) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJ5PRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ5, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ5PRICE);
            return 1;
        }
        if(listitem == 5) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJ6PRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ6, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ6PRICE);
            return 1;
        }
        if(listitem == 6) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJ7PRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ7, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ7PRICE);
            return 1;
        }
        if(listitem == 7) {
            if(PlayerInfo[playerid][Cash] < BOARDOBJ8PRICE) {
                SCM(playerid, -1, "[�����]��Ľ�Ҳ���");
                return 1;
            }
            SCM(playerid, -1, "[�����]�㹺����һ�������!");
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CreateBoard(playerid, BOARDOBJ8, x, y, z + 2, PlayerInfo[playerid][ID]);
            GivePlayerCash(playerid, -BOARDOBJ8PRICE);
            return 1;
        }
    }
    return 1;
}


// �ٶȱ��TV��ս���ٶȱ�����趨
forward CheckStatus();
public CheckStatus() {
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            new string[32];
            format(string, sizeof(string), "%03d", GetSpeed(i));
            PlayerTextDrawSetString(i, velo[i][1], string);
            switch (GetSpeed(i)) {
                case 0:{
                    for (new a = 2; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 1..9:{
                    PlayerTextDrawColor(i, velo[i][2], 0xFFCC00C8);
                    // TextDrawShowForPlayer(i, velo[i][2]);
                    for (new a = 3; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 10..19:{
                    for (new a = 2; a < 3; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 4; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 20..29:{
                    for (new a = 2; a < 4; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 5; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 30..39:{
                    for (new a = 2; a < 5; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 6; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 40..49:{
                    for (new a = 2; a < 6; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 7; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 50..59:{
                    for (new a = 2; a < 7; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 8; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 60..69:{
                    for (new a = 2; a < 8; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 9; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 70..79:{
                    for (new a = 2; a < 9; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 10; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 80..89:{
                    for (new a = 2; a < 10; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 11; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 90..99:{
                    for (new a = 2; a < 11; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 12; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 100..109:{
                    for (new a = 2; a < 12; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 13; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 110..119:{
                    for (new a = 2; a < 13; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 14; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 120..129:{
                    for (new a = 2; a < 14; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 15; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 130..139:{
                    for (new a = 2; a < 15; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 16; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 140..149:{
                    for (new a = 2; a < 16; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 17; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 150..159:{
                    for (new a = 2; a < 17; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 18; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 160..169:{
                    for (new a = 2; a < 18; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 18; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xC0C0C0C8);
                    }
                    for (new a = 19; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 170..179:{
                    for (new a = 2; a < 19; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    for (new a = 21; a < 22; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0x9D4D4DFF);
                    }
                }
                case 180..189:{
                    for (new a = 2; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    PlayerTextDrawColor(i, velo[i][19], 0x9D4D4DFF);
                    PlayerTextDrawColor(i, velo[i][20], 0x9D4D4DFF);
                    PlayerTextDrawColor(i, velo[i][21], 0x9D4D4DFF);
                }
                case 190..199:{
                    for (new a = 2; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    PlayerTextDrawColor(i, velo[i][19], 0xF20D0DC8);
                    PlayerTextDrawColor(i, velo[i][20], 0x9D4D4DFF);
                    PlayerTextDrawColor(i, velo[i][21], 0x9D4D4DFF);
                }
                case 200..209:{
                    for (new a = 2; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    PlayerTextDrawColor(i, velo[i][19], 0xF20D0DC8);
                    PlayerTextDrawColor(i, velo[i][20], 0xF20D0DC8);
                    PlayerTextDrawColor(i, velo[i][21], 0x9D4D4DFF);
                }
                case 210..999:{
                    for (new a = 2; a < 20; a++) {
                        PlayerTextDrawColor(i, velo[i][a], 0xFFCC00C8);
                    }
                    PlayerTextDrawColor(i, velo[i][19], 0xF20D0DC8);
                    PlayerTextDrawColor(i, velo[i][20], 0xF20D0DC8);
                    PlayerTextDrawColor(i, velo[i][21], 0xF20D0DC8);
                }
            }
            // 2020.3.29ע�� ���������ȡ����ȥ
            for (new j = GetPlayerPoolSize(); j >= 0; j--) {
                if(IsPlayerConnected(j)) {
                    if(PlayerInfo[j][tvid] == i && PlayerInfo[j][speedoMeter]) {
                        for (new a = 1; a <= 21; a++) {
                            PlayerTextDrawShow(j, velo[i][a]); //drawcolor���������show�Ż�ˢ��  ���ٶȲ��� ��������Ҫ��ôд
                        }
                    }
                }
            }
        }
    }
    return 0;
}



/*else
{
	for(new a; a<22; a++) TextDrawHideForPlayer(i,velo[i][a]);
	PlayerTextDrawSetString(i,velo[i][1],"");
}*/
/*else
				{
					if(GetPlayerState(PlayerInfo[i][tvid]) == PLAYER_STATE_DRIVER) 
					{
						for(new a=0; a<24; a++)
						{
							TextDrawShowForPlayer(i,velo[PlayerInfo[i][tvid]][a]);
						}
					}
					if(GetPlayerState(PlayerInfo[i][tvid]) == PLAYER_STATE_ONFOOT)
					{
						for(new a=0; a<24; a++)
						{
							TextDrawHideForPlayer(i,velo[PlayerInfo[i][tvid]][a]);
						}
					}
				format(msg, sizeof(msg), "�ٶ�:%.1f km/h",GetSpeed(PlayerInfo[i][tvid]));//ԭ�����ݵ��ٶȱ�
				TextDrawSetString(Speedtextdraw[PlayerInfo[i][tvid]], msg);	
				}
			}*/


forward tpaTimer(playerid);
public tpaTimer(playerid) {
    if(tpaB[playerid] == 1) {
        SCM(playerid, 0xFFFFFFFF, "[tp]����1������û�н��ܴ�������,������������ʧЧ");
    }
    if(tpaB[playerid] == 2) {
        SCM(playerid, 0xFFFFFFFF, "[tp]�Է���1������û�н�����Ĵ�������,������������ʧЧ.");
    }
    tpaB[playerid] = 0;
    tpaid[playerid] = -1;
    return 1;
}
public OnPlayerModelSelection(playerid, response, listid, modelid) {
    if(listid == planelist || listid == chaopaolist || listid == Motorolalist || listid == Shiplist || listid == Otherlist || listid == trainlist || listid == minzhen || listid == yueyelist || listid == tuoche || listid == huoche || listid == jingchelist) {
        if(response) {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(playerid, x + 1, y, z + 2);
            SetTimerEx("SpawnVehicle", 200, false, "ii", playerid, modelid);
        }
        return 1;
    }
    if(listid == skinlist) {
        if(response) {
            SendClientMessage(playerid, Color_White, "[Ƥ��] �Ѹ�������Ƥ��.");
            SetPlayerSkin(playerid, modelid);
            PlayerInfo[playerid][Skin] = modelid;
        } else SendClientMessage(playerid, Color_White, "[Ƥ��] ����ȡ������Ƥ��.");
        return 1;
    }
    return 1;
}

forward SecondsTimer();
public SecondsTimer() {
    new n, y, day;
    getdate(n, y, day);
    if(day == 4 && y == 4) {
        new hour, minute, second;
        gettime(hour, minute, second);
        new str[90];
        // h = 24-h;
        // m = 60-m;
        // s = 60-s;
        hour = 24 - hour;
        if(hour == 24) hour = 0;

        if(minute != 0) hour--;
        minute = 60 - minute;
        if(minute == 60) minute = 0;

        if(second != 0) minute--;
        second = 60 - second;
        if(second == 60) second = 0;

        format(str, sizeof(str), "hostname [RST�Ŷ�]�廳���ߣ��¾�Ӣ�� %02d:%02d:%02d", hour, minute, second);
        SendRconCommand(str);
        SendRconCommand("password !?@#^WAgse30ut");
        if(day >= 5) SendRconCommand("password");
    }
    if(day == 31 && y == 12) {
        new hour, minute, second;
        gettime(hour, minute, second);
        new str[90];
        // h = 24-h;
        // m = 60-m;
        // s = 60-s;
        hour = 24 - hour;
        if(hour == 24) hour = 0;

        if(minute != 0) hour--;
        minute = 60 - minute;
        if(minute == 60) minute = 0;

        if(second != 0) minute--;
        second = 60 - second;
        if(second == 60) second = 0;
        format(str, sizeof(str), "hostname [RST�Ŷ�]����%d���� %02d:%02d:%02d", n, hour, minute, second);
        SendRconCommand(str);
        if(hour == 23 && minute == 59) {
            format(str, sizeof(str), "[����]����%d���� %02d:%02d:%02d", n, hour, minute, second);
            SendClientMessageToAll(Color_White, str);
            if(second + 1 == 0) {
                format(str, sizeof(str), "[����]�ټ�%d,���%d", n, n + 1);
                SendClientMessageToAll(Color_White, str);
                SendClientMessageToAll(Color_White, "һƬ�����������������죬ɢ�����������ķ����������帣���߿գ�������˳�ģ�����ӭ���꣬�˷��պ������þ�����");
            }
        }
    }
    if(day == 1 && y == 1) {
        new hour, minute, second;
        gettime(hour, minute, second);
        new str[90];
        format(str, sizeof(str), "hostname [RST]RST�Ŷ�ף������������! %02d:%02d:%02d", hour, minute, second);
        SendRconCommand(str);
    }
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerNPC(i)) {
                new VehID = GetPlayerVehicleID(i);
                if(VehID == PlayerInfo[i][BuyID]) {
                    if(gettime() - PlayerInfo[i][nitro] >= 15) //ÿ15������һ������ ԭ���ĵ����㷨
                    {
                        AddVehicleComponent(VehID, 1010);
                        PlayerInfo[i][nitro] = gettime();
                    }
                }
            }
            if(PlayerInfo[i][Login] == true) {
                updatePlayerNetWorkState(i); //�����������
                if(PlayerInfo[i][JailSeconds] != 0) { //�����ұ�������Ǹ�ʱ���������
                    PlayerInfo[i][JailSeconds]--;
                    if(PlayerInfo[i][JailSeconds] <= 0) {
                        PlayerInfo[i][JailSeconds] = 0; //����0�˾ͷų���������DB���ݿ�
                        SpawnPlayer(i);
                        new msg[128];
                        format(msg, sizeof(msg), "UPDATE `Users` SET JailSeconds = 0 WHERE `Name` = '%s'", GetName(i));
                        db_free_result(db_query(user, msg));
                    } else {
                        SetPlayerPos(i, 1607.480, 1670.444, 10.549);
                    }
                }
                if(PlayerInfo[i][Yztime]) { //�����������֤��ʱ�䣬�����Ϊ0�Ļ���һֱ����0
                    PlayerInfo[i][Yztime]--;
                    if(PlayerInfo[i][Yztime] <= 0) {
                        PlayerInfo[i][Yztime] = 0;
                    }
                }
                running_PPC(i);
                Attire_Preview_Range(i); //װ��Ԥ����Χ �����˾��Զ�ж��
                AntiCommand[i] = 0; //��ҵĹ��ȷ�������0
                //PlayerInfo[i][pLastCheck] = GetTickCount(); 
                //���˵GetTickCount() > pLastCheck+2000�Ļ�˵����ҹһ� 2000ָ2������Ҷ�û���µĻ� ���ǲ��ܷ��������ж�
                //����˵�ٿ�����ʱ��ȥ���Ǹ�lastcheck
                if(GetPlayerState(i) == PLAYER_STATE_DRIVER) //�������ڳ��ϵĻ�
                {
                    new VehID = GetPlayerVehicleID(i);
                    // pACEdit[playerid]����ҵİ���ID �����-1�Ļ���û�а���
                    //   ���� Ӧ����pACEdit[i][gotoId]
                    if(VehID == PlayerInfo[i][BuyID] || VehID == CarInfo[pACEdit[i]][GotoID]) {
                        if(gettime() - PlayerInfo[i][nitro] >= 15) //ÿ15������һ������ ԭ���ĵ����㷨
                        {
                            AddVehicleComponent(VehID, 1010);
                            PlayerInfo[i][nitro] = gettime();
                        }
                        if(PlayerInfo[i][hys]) ChangeVehicleColor(VehID, random(256), random(256)); //�����ҿ��˻���ɫ���Զ���������ɫ
                        // ��⳵���Ƿ�ת By Babul https://forum.sa-mp.com/member.php?u=64500
                        if(PlayerInfo[i][AutoFlip]) {
                            new Float:VehPosX, Float:VehPosY, Float:VehPosZ, Float:VehAngle, Float:Q[4];
                            GetVehiclePos(VehID, VehPosX, VehPosY, VehPosZ);
                            GetVehicleZAngle(VehID, VehAngle);
                            GetVehicleRotationQuat(VehID, Q[0], Q[1], Q[2], Q[3]);
                            new Float:sqw = Q[0] * Q[0];
                            new Float:sqx = Q[1] * Q[1];
                            new Float:sqy = Q[2] * Q[2];
                            new Float:sqz = Q[3] * Q[3];
                            new Float:bank = atan2(2 * (Q[2] * Q[3] + Q[1] * Q[0]), -sqx - sqy + sqz + sqw);
                            if(floatabs(bank) > 160 && GetSpeed(i) < 0.01) {
                                SetVehiclePos(VehID, VehPosX, VehPosY, VehPosZ);
                                SetVehicleZAngle(VehID, VehAngle);
                                SendClientMessage(i, Color_White, "[ϵͳ]�㿪���˳����Զ���������,��ת�ɹ�������/sz�ر�");
                                GameTextForPlayer(i, "~w~vehicle ~g~fl~h~ip~h~pe~h~d", 2000, 4);
                            }
                        }
                        //�������ؾ������쳣������ By:[R_ST]Hygen
                        if(pRaceing[i]) { //�������������� �����ڳ��� 2020.2.23���� ��Ȼ�Ļ������  //�����ͣ״̬�Ļ�Ҫ�����㷨 ��Ȼ���˷���Դ
                            if(IsPlayerInAnyVehicle(i)) {
                                new Float:VehPosX, Float:VehPosY, Float:VehPosZ;
                                GetVehiclePos(VehID, VehPosX, VehPosY, VehPosZ);
                                //2020.3.15���� ---��ʼ
                                new Float:secondsxyz;
                                secondsxyz = GetPlayerDistanceFromPoint(i, PlayerInfo[i][lastXMoved], PlayerInfo[i][lastYMoved], PlayerInfo[i][lastZMoved]);
                                //ÿ�����һ��ľ��� ������������������쳣 ������˲��
                                new Float:difference = VehPosZ - PlayerInfo[i][lastZpos];
                                if(difference <= -1.0) difference *= -1; //ȡ����Z��߶Ȳ�ľ���ֵ
                                if(difference <= 3) {
                                    if(secondsxyz >= 79.333333) {
                                        if(GameRace[i][rgamecp] > 1 && PlayerInfo[i][lastVehSpeed]) { //2020.3.17д��һ��lastVehSpeed  ��Ȼ�������������
                                            if(!IsModelAPlane(VehID)) {
                                                if(GetSpeed(i) >= 225 || GetSpeed(i) <= 90) {
                                                    //�����ҿ��ĳ����Ƿɻ��Ļ�
                                                    //2020.4.3���� �ٶ��Ƿ����223.123�ٽ����ж� �� �ٶ�̫��˲��  ��ֹ��ping̫����ը������
                                                    new trcp[racecptype];
                                                    Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                                    new ss = Race_GetCp_Scripts(trcp[rcpid]); //���ص�ǰCP���м����߼�CP�����������0�Ļ� ��ֱ�ӷ�;
                                                    // new Float:health;
                                                    // GetPlayerHealth(i, health);
                                                    if(!ss) {
                                                        return FuckAnitCheat(i, "�°淴˲�Ʋ���1", 11);
                                                    } else {
                                                        if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "�°淴˲�Ʋ���2", 11);
                                                    }
                                                }
                                            } else //��Ȼ�Ļ����÷ɻ������ÿ���ƶ�����������
                                            {
                                                if(secondsxyz >= 89.333333) {
                                                    new trcp[racecptype];
                                                    Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                                    new ss = Race_GetCp_Scripts(trcp[rcpid]); //���ص�ǰCP���м����߼�CP�����������0�Ļ� ��ֱ�ӷ�;
                                                    if(!ss) {
                                                        return FuckAnitCheat(i, "�°淴˲�Ʋ���3", 11);
                                                    } else {
                                                        if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "�°淴˲�Ʋ���4", 11);
                                                    }
                                                    return 1;
                                                }
                                            }
                                        }
                                    }
                                    if(secondsxyz <= 0.001 && GameRace[i][rgamecp] > 1) { //����Ƿ�һ�  �һ�ʱ��̫���Ļ� �˳�����
                                        PlayerInfo[i][AFKTimes]++;
                                        if(PlayerInfo[i][AFKTimes] >= 45) {
                                            Race_Game_Quit(i);
                                            ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "��Դ��ʡ", "�һ�ʱ�����,�����Ƴ�����", "�յ�", "");
                                            return 1;
                                        }
                                    }
                                }
                                PlayerInfo[i][lastXMoved] = VehPosX;
                                PlayerInfo[i][lastYMoved] = VehPosY;
                                PlayerInfo[i][lastZMoved] = VehPosZ;
                                //2020.3.15���� ---��β

                                //����ֵ
                                //����߶Ȳ�����... ��ΪMTA���������̫���� MTA�������ǽ����������ķ����׷���
                                if(VehPosZ < 300.0 && !IsModelAPlane(VehID) && GetSpeed(i) >= 233.456 && difference <= 0.1987) { //�����һ���ڸ߶�ƫ��̫��Ҳ����
                                    if(GameRace[i][rgamecp] > 1) {
                                        new trcp[racecptype];
                                        Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                        new ss = Race_GetCp_Scripts(trcp[rcpid]); //���ص�ǰCP���м����߼�CP�����������0�Ļ� ��ֱ�ӷ�;
                                        // new Float:health;
                                        // GetPlayerHealth(i, health);
                                        if(!ss) {
                                            if(GameRace[i][rgamecp] > 2) {
                                                //�����һ����Ҳ���Ǹ߼�CP����ôֱ��΢���� ���дд�� ΢����Ҫ��˲ʱ�ٶ�ȥд �Ͷ�һ����ʱ���ٶȺܿ�ܿ� 
                                                // updateҲ�� ��������ȥ������һ�μ����ٶ����̫������ ֱ�ӷ�ͺ���
                                                Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 2, trcp);
                                                ss = Race_GetCp_Scripts(trcp[rcpid]);
                                                if(!ss) {
                                                    Race_Game_Quit(i);
                                                    ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:10", "ȷ��", "");
                                                    // FuckAnitCheat(i,"˫�߼�CP����΢����",10);
                                                    return 1;
                                                } else {
                                                    return 1;
                                                }
                                            }
                                            Race_Game_Quit(i);
                                            ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:10", "ȷ��", "");
                                            return 1;
                                            // FuckAnitCheat(i,"����΢����",10);
                                        }
                                    } else if(GameRace[i][rgamecp] == 1) {
                                        Race_Game_Quit(i);
                                        ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:10", "ȷ��", "");
                                        return 1;
                                        // FuckAnitCheat(i,"�׸�CP���쳣",10);
                                    }
                                    return 1;
                                }
                                if(VehPosZ > PlayerInfo[i][lastZpos] && GetSpeed(i) > 290 && difference >= 25.0 && GameRace[i][rgamecp] > 1) { //�����һ���ڸ߶�ƫ��̫��Ҳ����
                                    new trcp[racecptype];
                                    Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                    new ss = Race_GetCp_Scripts(trcp[rcpid]); //���ص�ǰCP���м����߼�CP�����������0�Ļ� ��ֱ�ӷ�;
                                    // new Float:health;
                                    // GetPlayerHealth(i, health);
                                    if(!ss) {
                                        return FuckAnitCheat(i, "�������ؾ�+Z��߶Ⱥ��ٶ��쳣", 1);
                                    } else {
                                        if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "�������ؾ�+Z��߶Ⱥ��ٶ��쳣", 1);
                                    }
                                }
                                if(difference <= 3 && GameRace[i][rgamecp] > 1) { //�������Z����������ľ���ֵ  < 4 �Ļ�
                                    //�����һ��ĳ��ٱ���εͣ�����һ���ȥ��һ���ֵ��̫�� ��һ����ٶȶ���70�� ���� z��ûʲô�仯
                                    // Ҳ����˵����ڼ���û�ı�߶ȵ�����³�����˲������ȥ����ô�����Ͼ������ݻ���CLEO���쳣
                                    if((PlayerInfo[i][lastVehSpeed] >= 0 && PlayerInfo[i][lastVehSpeed] < GetSpeed(i) && !IsModelAPlane(VehID) && GetSpeed(i) - PlayerInfo[i][lastVehSpeed] >= 104.0) || (PlayerInfo[i][lastVehSpeed] >= 85 && PlayerInfo[i][lastVehSpeed] < GetSpeed(i) && GetSpeed(i) - PlayerInfo[i][lastVehSpeed] >= 75) || (GetSpeed(i) > 266 && !IsModelAPlane(VehID)) || (GetSpeed(i) > 290 && IsModelAPlane(VehID))) {
                                        //�ж���ҵ�CP���Ƿ��Ǹ߼�CP�㣬����������ɱ
                                        // Ӧ���ǿ��Լ���ؾ������쳣 / ΢���� / �������ʱ�ٸı�
                                        new trcp[racecptype];
                                        Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                        new ss = Race_GetCp_Scripts(trcp[rcpid]); //���ص�ǰCP���м����߼�CP�����������0�Ļ� ��ֱ�ӷ�;
                                        if(!ss) {
                                            return FuckAnitCheat(i, "�������ؾ�+Z��߶Ⱥ��ٶ��쳣", 2);
                                        } else {
                                            if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "�������ؾ�+Z��߶Ⱥ��ٶ��쳣", 1);
                                        }
                                    }
                                }
                                PlayerInfo[i][lastZpos] = VehPosZ; //��¼��һ���Z��
                                PlayerInfo[i][lastVehSpeed] = GetSpeed(i); //��¼��һ��ĳ���
                            }
                        }
                    }
                    if(PlayerInfo[i][AutoFix] && p_PPC[i] == 0 && GetPlayerVehicleID(i)) RepairVehicle(GetPlayerVehicleID(i)); //�����ҿ����Զ��޳��в������������޳�
                } else //���û�ڳ��ϵ�ʱ���״̬
                {
                    if(pRaceing[i] && GetPlayerState(i) == PLAYER_STATE_ONFOOT) //�������е��ǲ��ڳ���
                    {
                        new Float:pPos[3], Float:secondsxyz;
                        GetPlayerPos(i, pPos[0], pPos[1], pPos[2]);
                        secondsxyz = GetPlayerDistanceFromPoint(i, PlayerInfo[i][lastXMoved], PlayerInfo[i][lastYMoved], PlayerInfo[i][lastZMoved]);
                        if(secondsxyz <= 0.001 && GameRace[i][rgamecp] > 1) { //����Ƿ�һ�  �һ�ʱ��̫���Ļ� �˳�����
                            PlayerInfo[i][AFKTimes]++;
                            if(PlayerInfo[i][AFKTimes] >= 45) {
                                Race_Game_Quit(i);
                                ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "��Դ��ʡ", "�һ�ʱ�����,�����Ƴ�����", "�յ�", "");
                                return 1;
                            }
                        }
                        PlayerInfo[i][lastXMoved] = pPos[0];
                        PlayerInfo[i][lastYMoved] = pPos[1];
                        PlayerInfo[i][lastZMoved] = pPos[2];
                        // printf("%f", secondsxyz);
                        new Float:difference = pPos[2] - PlayerInfo[i][lastZpos];
                        PlayerInfo[i][lastZpos] = pPos[2];
                        if(difference <= -1.0) difference *= -1; //ȡ����Z��߶Ȳ�ľ���ֵ
                        if(difference <= 1.55) {
                            if(GetSpeed(i) > 48.00 || secondsxyz > 13.00) {
                                Race_Game_Quit(i);
                                ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:13.1", "ȷ��", "");
                                return 1;
                            }
                        } else // if(difference>=3)
                        {
                            if(secondsxyz > 61.33) {
                                Race_Game_Quit(i);
                                ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:13.2", "ȷ��", "");
                                return 1;
                            }
                        }
                        return 1;
                    }
                    if(IsPlayerDeathMatch(i) && DeathMatch_Game[i][g_anticheat]) { //2020.3.31д ���������ֱ��ȡ����
                        new Float:health;
                        GetPlayerHealth(i, health);
                        if(health) {
                            new Float:pPos[3], Float:secondsxyz;
                            GetPlayerPos(i, pPos[0], pPos[1], pPos[2]);
                            secondsxyz = GetPlayerDistanceFromPoint(i, PlayerInfo[i][lastXMoved], PlayerInfo[i][lastYMoved], PlayerInfo[i][lastZMoved]);
                            PlayerInfo[i][lastXMoved] = pPos[0];
                            PlayerInfo[i][lastYMoved] = pPos[1];
                            PlayerInfo[i][lastZMoved] = pPos[2];
                            // printf("%f", secondsxyz);
                            new Float:difference = pPos[2] - PlayerInfo[i][lastZpos];
                            PlayerInfo[i][lastZpos] = pPos[2];
                            if(difference <= -1.0) difference *= -1; //ȡ����Z��߶Ȳ�ľ���ֵ
                            if(difference <= 1.55) {
                                if(GetSpeed(i) > 48.00 || secondsxyz > 13.00) {
                                    DeathMatch_Leave(i);
                                    ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:13.1", "ȷ��", "");
                                    return 1;
                                }
                            } else // if(difference>=3)
                            {
                                if(secondsxyz > 61.33) {
                                    DeathMatch_Leave(i);
                                    ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ]", "�����쳣,���Ժ��� Code:13.2", "ȷ��", "");
                                    return 1;
                                }
                            }
                        }
                        return 1;
                    }
                }
            }
        }
    }
    return 1;
}

/*if(GetPlayerState(i) == PLAYER_STATE_ONFOOT || (GetPlayerState(i) == PLAYER_STATE_DRIVER && JB::GetPlayerSpeed (i, true) < 30))
{
    new var,Float:x,y,z;
    var = (floatround (floatsqroot (YukiGetSquaColor_Redistance (x, y, z, PlayerInfo [i][pCurrentPos][0], PlayerInfo [i][pCurrentPos][1], PlayerInfo [i][pCurrentPos][2])) * 3600) / (GetTickCount () - PlayerInfo [i][pLastCheck]));
    if(var >= 300 && var <= 1500)
    {
        FuckAnitCheat (i, "�����ƶ�");
    }
}*/

public OnVehicleDamageStatusUpdate(vehicleid, playerid) //0.3a�ĺ���������������ʱ��������Զ��޸����޸�
{
    if(PlayerInfo[playerid][AutoFix] && p_PPC[playerid] == 0) RepairVehicle(vehicleid);
    return 1;
}
forward RaceGameEndCount(houseid, winner); //��������󵹼�ʱ
public RaceGameEndCount(houseid, winner) {
    new msg[128];
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            if(GameRace[i][rgameid] == houseid) {
                // if(RaceHouse[GameRace[i][rgameid]][rtop]-1 == RaceHouse[GameRace[i][rgameid]][rps]) 
                // //������ôд ��Ҫ�ǡ�������ʲô������֮��� �����ͻ�ֻʣ��һ�� ���������������˳�������ֱ��...
                // //���˽�����ʱ  ע��Ҫ����1 ��Ϊ��һ�������յ������rtop������ Ҳ����˵�˼һ�û���յ�
                // {           
                //     Race_Game_Quit(i);
                //     KillTimer(RaceHouse[houseid][endcount]);
                //     RaceHouse[houseid][rtimes] = 0;
                //     return 1;
                // }
                if(RaceHouse[houseid][rtimes] < 1) {
                    if(GameRace[i][rgamecp] - 1 != Race[RaceHouse[GameRace[i][rgameid]][rraceid]][rcps]) {
                        GameTextForPlayer(i, "~w~unFinished!", 1000, 1);
                        PlaySoundForPlayer(i, 1056);
                        format(msg, 128, "[����]�ź�,%s δ����� %s ", GetName(i), Race[RaceHouse[GameRace[i][rgameid]][rraceid]][rname]);
                        Race_Game_Msg(houseid, msg);
                    }
                    RaceHouse[houseid][rtimes] = 0;
                    Race_Game_Quit(i);
                    KillTimer(RaceHouse[houseid][endcount]);
                } else {
                    //�������ʾ����ʱ
                    format(msg, 128, "~w~%i", RaceHouse[houseid][rtimes]);
                    GameTextForPlayer(i, msg, 1000, 3);
                    PlaySoundForPlayer(i, 1056);
                }
            }
        }
    }
    RaceHouse[houseid][rtimes]--; //ʱ���1
    return 1;
}
/*stock GetRaceGameFinishList(playerid)
{
	if(pRaceing[playerid]=0 && GameRace[playerid][rgameid]]==kiven)
	{
 		new string[512];
		format(string,sizeof(string),"%s\n%s (%d:%d:%d) ��%i��",string,PlayerName[playerid],time[0],time[1],time[2],RaceHouse[GameRace[playerid][rgameid]][rtop]);
		ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX,"����ս��",string,"ȷ��","");
	}
	return 1;
}*/

/*stock JB::GetPlayerSpeed (playerid, get3d)
{
	if(IsPlayerInAnyVehicle (playerid))
		GetVehicleVelocity (GetPlayerVehicleID (playerid), x, y, z);
	else
		GetPlayerVelocity (playerid, x, y, z);
#define JB_Speed(%0,%1,%2,%3,%4)	floatround(floatsqroot((%4)?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1))*%3*1.6)
	//return JB::Speed(x, y, z, 100.0, get3d);
	return floatround(floatsqroot((false)?(x*x+y*y+z*z):(x*x+y*y))*100.0*1.6)
}*/
stock SCMToAdmins(const color, const string[]) {
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            if(PlayerInfo[i][AdminLevel] >= 1) {
                SCM(i, color, string);
            }
        }
    }
    printf(string);
    return 1;
}
forward GivePlayerCash(playerid, Cashs);
public GivePlayerCash(playerid, Cashs) {
    PlayerInfo[playerid][Cash] = PlayerInfo[playerid][Cash] + Cashs;
    new str[64];
    if(Cashs > 0) format(str, sizeof(str), "~g~+%d Cash", Cashs);
    else format(str, sizeof(str), "~r~%d Cash", Cashs);
    GameTextForPlayer(playerid, str, 1234, 1);
    // ���ڽ�Ǯ�Ĳ���ʵʱ�������ݿ��Է�ֹ���ⶪʧ
    new msg[128];
    format(msg, sizeof(msg), "UPDATE `Users` SET `Cash` = %d WHERE `Name` = '%s'", PlayerInfo[playerid][Cash], GetName(playerid));
    db_free_result(db_query(user, msg));
    return 1;
}
stock bigstrtok(const string[], & idx) {
    new length = strlen(string);
    while ((idx < length) && (string[idx] <= ' ')) {
        idx++;
    }
    new offset = idx;
    new result[128];
    while ((idx < length) && ((idx - offset) < (sizeof(result) - 1))) {
        result[idx - offset] = string[idx];
        idx++;
    }
    result[idx - offset] = EOS;
    return result;
}
stock AdminCommandRecord(const playerid, const command[], const text[]) {
    new str[256], File:hFile;
    hFile = fopen("Users/AdminCommandRecord.log", io_append);
    if(hFile) {
        new h = 0, m = 0, s = 0, n = 0, y = 0, day = 0, ip[24];
        gettime(h, m, s), getdate(n, y, day);
        GetPlayerIp(playerid, ip, sizeof(ip));
        format(str, sizeof(str), "%s ʹ�������� %s ԭ��:%s,ʱ��:%d/%d/%d %d:%d:%d,IP:%s\r\n", GetName(playerid), command, text, n, y, day, h, m, s, ip);
        pfwrite(hFile, str);
        fclose(hFile);
    }
    return 1;
}
stock PlayerChestRecord(const playerid, const text[]) {
    new str[256], File:hFile;
    hFile = fopen("Users/ChestRecord.log", io_append);
    if(hFile) {
        new h = 0, m = 0, s = 0, n = 0, y = 0, day = 0, ip[24];
        gettime(h, m, s), getdate(n, y, day);
        GetPlayerIp(playerid, ip, sizeof(ip));
        format(str, sizeof(str), "%s��%s��ϵͳ��ɱ %d/%d/%d %d:%d:%d,IP:%s\r\n", GetName(playerid), text, n, y, day, h, m, s, ip);
        pfwrite(hFile, str);
        fclose(hFile);
    }
    SetTimerEx("KickEx", 200, false, "i", playerid); //�ӳ�T�����
    return 1;
}
stock PlayerTextRecord(const text[]) { //��¼�������
    new str[183], File:hFile;
    new n = 0, y = 0, day = 0;
    new h = 0, m = 0, s = 0;
    gettime(h, m, s);
    getdate(n, y, day);
    format(str, sizeof(str), "Users/Text/%d.%d.%d.txt", n, y, day);
    hFile = fopen(str, io_append);
    if(hFile) {
        format(str, sizeof(str), "[%d:%d:%d]%s\r\n", h, m, s, text);
        pfwrite(hFile, str);
        fclose(hFile);
    }
    return 1;
}
stock PlayerCommandRecord(const text[]) { //��¼�������
    new str[200], File:hFile;
    new n = 0, y = 0, day = 0;
    new h = 0, m = 0, s = 0;
    gettime(h, m, s);
    getdate(n, y, day);
    format(str, sizeof(str), "Users/Command/%d.%d.%d.txt", n, y, day);
    hFile = fopen(str, io_append);
    if(hFile) {
        format(str, sizeof(str), "[%d:%d:%d]%s\r\n", h, m, s, text);
        pfwrite(hFile, str);
        fclose(hFile);
    }
    return 1;
}
stock pfwrite(File:handle, const text[]) {
    new l = strlen(text);
    for (new i = 0; i < l; i++) {
        fputchar(handle, text[i], false);
    }
}
stock FuckAnitCheat(const playerid, const text[], const violationCode) {
    // violationCode -1:�����˺� 0:��㴫�� 1:Z���쳣 2:�ؾ������쳣 3:�����糵 999:����Ա��ɱ 7:Fakekilling 8:CarSpam 10:ֱ��΢���� 997 ���δ��¼����
    new msgs[256], DBResult:uf;
    // new t=3600;
    new t = gettime() + 600;
    // new t = gettime() + 86400 * 7; Ĭ��7�� ̫����
    format(msgs, sizeof(msgs), "UPDATE `Users` SET `BanTime` = %d,`BanReason` = %d WHERE `Name` = '%s'", t, violationCode, GetName(playerid));
    uf = db_query(user, msgs);
    db_free_result(uf);
    format(msgs, sizeof(msgs), "[ϵͳ] ���:%s ʹ�õ�������������Ӱ������Ϸ��ƽ��,Code violation #%d �������׷�ɱ��! ", GetName(playerid), violationCode);
    SCMALL(Color_Red, msgs);
    format(msgs, sizeof(msgs), "ԭ��:ϵͳ��⵽���������ʹ�õ�������������Ӱ������Ϸ��ƽ��,Code violation #%d\n����������Ϸ�Ƿ��в�����ʹ�õ�CLEO��������\n���ʱ��:0�� 0ʱ 10�� 0��,�˹��޷���Ԥ\n��·ǧ���� ��ȫ��һ��\n�г����淶 ����������", violationCode);
    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "[ϵͳ] ��������Ͽ�����", msgs, "ȷ��", "");
    PlayerChestRecord(playerid, text);
    return 1;
}
// forward CheckAso(playerid);
// public CheckAso(playerid) {
//     DestroyDynamic3DTextLabel(NoDieTime[playerid]);
//     if(wdzt[playerid] != 1) SetPlayerHealth(playerid, 100);
//     return 1;
// }
// forward PutPlayerInVehicleEx(playerid, vehicleid, seatid);
// public PutPlayerInVehicleEx(playerid, vehicleid, seatid) {
//     if(IsPlayerConnected(playerid) && vehicleid != INVALID_VEHICLE_ID) {
//         if(PutPlayerInVehicle(playerid, vehicleid, seatid)) {
//             PlayerInfo[playerid][pVehicleEnteColor_Red] = vehicleid;
//             return 1;
//         }
//     }
//     return 0;
// }
forward MyHttpResponseEX(index, response_code, sData[]);
public MyHttpResponseEX(index, response_code, sData[]) {
    new buffer[128];
    new h, m, s, y, day, d;
    new msg[128];
    if(response_code == 200) {
        gettime(h, m, s);
        getdate(y, day, d);
        format(msg, 128, "�ʼ����ͳɹ�[%d.%d.%d][%d:%d:%d]", y, day, d, h, m, s);
        SendClientMessage(index, 0xFFFFFFFF, msg);
    } else {
        format(buffer, sizeof(buffer), "�ʼ�����ʧ��,�������[%d]", response_code);
        SendClientMessage(index, 0xFFFFFFFF, buffer);
    }
}
// public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
//     if(playertextid == LetterForYou[playerid][3]) {
//         for (new i; i < 4; i++) {
//             PlayerTextDrawDestroy(playerid, LetterForYou[playerid][i]);
//         }
//         CancelSelectTextDraw(playerid);
//         SendClientMessage(playerid, 0xFFFFFFAA, "лл��������GTA:SAMP");
//         if(GetPlayerScore(playerid) < 120) {
//             SendClientMessage(playerid, Color_White, "[ϵͳ]��⵽����Ϸʱ��δ��120���ӣ��Զ��򿪰�����ʾ");
//             AntiCommand[playerid] = 0;
//             OnPlayerCommandText(playerid, "/help");
//         }
//         return 1;
//     }
//     return 0;
// }

static Float:BirthPointInfo[][4] = {
    {
        1958.835693,
        1343.151123,
        15.374607,
        269.142425
    }, //ԭ����Ĭ�ϳ����� �ĳ��Ǳ�
    {
        1751.1097,
        -2106.4529,
        13.5469,
        183.1979
    }, // El-Corona - Outside random house
    {
        2652.6418,
        -1989.9175,
        13.9988,
        182.7107
    }, // Random house in willowfield - near playa de seville and stadium
    {
        2489.5225,
        -1957.9258,
        13.5881,
        2.3440
    }, // Hotel in willowfield - near cluckin bell
    {
        2689.5203,
        -1695.9354,
        10.0517,
        39.5312
    }, // Outside stadium - lots of cars
    {
        2770.5393,
        -1628.3069,
        12.1775,
        4.9637
    }, // South in east beach - north of stadium - carparks nearby
    {
        2807.9282,
        -1176.8883,
        25.3805,
        173.6018
    }, // North in east beach - near apartments
    {
        2552.5417,
        -958.0850,
        82.6345,
        280.2542
    }, // Random house north of Las Colinas
    {
        2232.1309,
        -1159.5679,
        25.8906,
        103.2939
    }, // Jefferson motel
    {
        2388.1003,
        -1279.8933,
        25.1291,
        94.3321
    }, // House south of pig pen
    {
        2481.1885,
        -1536.7186,
        24.1467,
        273.4944
    }, // East LS - near clucking bell and car wash
    {
        2495.0720,
        -1687.5278,
        13.5150,
        359.6696
    }, // Outside CJ's house - lots of cars nearby
    {
        2306.8252,
        -1675.4340,
        13.9221,
        2.6271
    }, // House in ganton - lots of cars nearby
    {
        2191.8403,
        -1455.8251,
        25.5391,
        267.9925
    }, // House in south jefferson - lots of cars nearby
    {
        1830.1359,
        -1092.1849,
        23.8656,
        94.0113
    }, // Mulholland intersection carpark
    {
        2015.3630,
        -1717.2535,
        13.5547,
        93.3655
    }, // Idlewood house
    {
        1654.7091,
        -1656.8516,
        22.5156,
        177.9729
    }, // Right next to PD
    {
        1219.0851,
        -1812.8058,
        16.5938,
        190.0045
    }, // Conference Center
    {
        1508.6849,
        -1059.0846,
        25.0625,
        1.8058
    }, // Across the street of BANK - lots of cars in intersection carpark
    {
        1421.0819,
        -885.3383,
        50.6531,
        3.6516
    }, // Outside house in vinewood
    {
        1133.8237,
        -1272.1558,
        13.5469,
        192.4113
    }, // Near hospital
    {
        1235.2196,
        -1608.6111,
        13.5469,
        181.2655
    }, // Backalley west of mainstreet
    {
        590.4648,
        -1252.2269,
        18.2116,
        25.0473
    }, // Outside "BAnk of San Andreas"
    {
        842.5260,
        -1007.7679,
        28.4185,
        213.9953
    }, // North of Graveyard
    {
        911.9332,
        -1232.6490,
        16.9766,
        5.2999
    }, // LS Film Studio
    {
        477.6021,
        -1496.6207,
        20.4345,
        266.9252
    }, // Rodeo Place
    {
        255.4621,
        -1366.3256,
        53.1094,
        312.0852
    }, // Outside propery in richman
    {
        281.5446,
        -1261.4562,
        73.9319,
        305.0017
    }, // Another richman property
    {
        790.1918,
        -839.8533,
        60.6328,
        191.9514
    }, // Mulholland house
    {
        1299.1859,
        -801.4249,
        84.1406,
        269.5274
    }, // Maddoggs
    {
        1240.3170,
        -2036.6886,
        59.9575,
        276.4659
    }, // Verdant Bluffs
    {
        2215.5181,
        -2627.8174,
        13.5469,
        273.7786
    }, // Ocean docks 1
    {
        2509.4346,
        -2637.6543,
        13.6453,
        358.3565
    }, // Ocean Docks spawn 2
    {
        1435.8024,
        2662.3647,
        11.3926,
        1.1650
    }, //  Northern train station
    {
        1457.4762,
        2773.4868,
        10.8203,
        272.2754
    }, //  Northern golf club
    {
        1739.6390,
        2803.0569,
        14.2735,
        285.3929
    }, //  Northern housing estate 1
    {
        1870.3096,
        2785.2471,
        14.2734,
        42.3102
    }, //  Northern housing estate 2
    {
        1959.7142,
        2754.6863,
        10.8203,
        181.4731
    }, //  Northern house 1
    {
        2314.2556,
        2759.4504,
        10.8203,
        93.2711
    }, //  Northern industrial estate 1
    {
        2216.5674,
        2715.0334,
        10.8130,
        267.6540
    }, //  Northern industrial estate 2
    {
        2101.4192,
        2678.7874,
        10.8130,
        92.0607
    }, //  Northern near railway line
    {
        1951.1090,
        2660.3877,
        10.8203,
        180.8461
    }, //  Northern house 2
    {
        1666.6949,
        2604.9861,
        10.8203,
        179.8495
    }, //  Northern house 3
    {
        2808.3367,
        2421.5107,
        11.0625,
        136.2060
    }, //  Northern shopping centre
    {
        2633.3203,
        2349.7061,
        10.6719,
        178.7175
    }, //  V-Rock
    {
        2606.6348,
        2161.7490,
        10.8203,
        88.7508
    }, //  South V-Rock
    {
        2616.5286,
        2100.6226,
        10.8158,
        177.7834
    }, //  North Ammunation 1
    {
        2491.8816,
        2397.9370,
        10.8203,
        266.6003
    }, //  North carpark 1
    {
        2531.7891,
        2530.3223,
        21.8750,
        91.6686
    }, //  North carpark 2
    {
        2340.6677,
        2530.4324,
        10.8203,
        177.8630
    }, //  North Pizza Stack
    {
        2097.6855,
        2491.3313,
        14.8390,
        181.8117
    }, //  Emerald Isle
    {
        1893.1000,
        2423.2412,
        11.1782,
        269.4385
    }, //  Souvenir shop
    {
        1698.9330,
        2241.8320,
        10.8203,
        357.8584
    }, //  Northern casino
    {
        1479.4559,
        2249.0769,
        11.0234,
        306.3790
    }, //  Baseball stadium 1
    {
        1298.1548,
        2083.4016,
        10.8127,
        256.7034
    }, //  Baseball stadium 2
    {
        1117.8785,
        2304.1514,
        10.8203,
        81.5490
    }, //  North carparks
    {
        1108.9878,
        1705.8639,
        10.8203,
        0.6785
    }, //  Dirtring racing 1
    {
        1423.9780,
        1034.4188,
        10.8203,
        90.9590
    }, //  Sumo
    {
        1537.4377,
        752.0641,
        11.0234,
        271.6893
    }, //  Church
    {
        1917.9590,
        702.6984,
        11.1328,
        359.2682
    }, //  Southern housing estate
    {
        2089.4785,
        658.0414,
        11.2707,
        357.3572
    }, //  Southern house 1
    {
        2489.8286,
        928.3251,
        10.8280,
        67.2245
    }, //  Wedding chapel
    {
        2697.4717,
        856.4916,
        9.8360,
        267.0983
    }, //  Southern construction site
    {
        2845.6104,
        1288.1444,
        11.3906,
        3.6506
    }, //  Southern train station
    {
        2437.9370,
        1293.1442,
        10.8203,
        86.3830
    }, //  Wedding chapel (near Pyramid)
    {
        2299.5430,
        1451.4177,
        10.8203,
        269.1287
    }, //  Carpark (near Pyramid)
    {
        2214.3008,
        2041.9165,
        10.8203,
        268.7626
    }, //  Central parking lot
    {
        2005.9174,
        2152.0835,
        10.8203,
        270.1372
    }, //  Central motel
    {
        2222.1042,
        1837.4220,
        10.8203,
        88.6461
    }, //  Clowns Pocket
    {
        2025.6753,
        1916.4363,
        12.3382,
        272.5852
    }, //  The Visage
    {
        2087.9902,
        1516.5336,
        10.8203,
        48.9300
    }, //  Royal Casino
    {
        2172.1624,
        1398.7496,
        11.0625,
        91.3783
    }, //  Auto Bahn
    {
        2139.1841,
        987.7975,
        10.8203,
        0.2315
    }, //  Come-a-lot
    {
        1860.9672,
        1030.2910,
        10.8203,
        271.6988
    }, //  Behind 4 Dragons
    {
        1673.2345,
        1316.1067,
        10.8203,
        177.7294
    }, //  Airport carpark
    {
        1412.6187,
        2000.0596,
        14.7396,
        271.3568
    }, //  South baseball stadium houses
    {
        -2723.4639,
        -314.8138,
        7.1839,
        43.5562
    }, // golf course spawn
    {
        -2694.5344,
        64.5550,
        4.3359,
        95.0190
    }, // in front of a house
    {
        -2458.2000,
        134.5419,
        35.1719,
        303.9446
    }, // hotel
    {
        -2796.6589,
        219.5733,
        7.1875,
        88.8288
    }, // house
    {
        -2706.5261,
        397.7129,
        4.3672,
        179.8611
    }, // park
    {
        -2866.7683,
        691.9363,
        23.4989,
        286.3060
    }, // house
    {
        -2764.9543,
        785.6434,
        52.7813,
        357.6817
    }, // donut shop
    {
        -2660.9402,
        883.2115,
        79.7738,
        357.4440
    }, // house
    {
        -2861.0796,
        1047.7109,
        33.6068,
        188.2750
    }, //  parking lot
    {
        -2629.2009,
        1383.1367,
        7.1833,
        179.7006
    }, // parking lot at the bridge
    {
        -2079.6802,
        1430.0189,
        7.1016,
        177.6486
    }, // pier
    {
        -1660.2294,
        1382.6698,
        9.8047,
        136.2952
    }, //  pier 69
    {
        -1674.1964,
        430.3246,
        7.1797,
        226.1357
    }, // gas station]
    {
        -1954.9982,
        141.8080,
        27.1747,
        277.7342
    }, // train station
    {
        -1956.1447,
        287.1091,
        35.4688,
        90.4465
    }, // car shop
    {
        -1888.1117,
        615.7245,
        35.1719,
        128.4498
    }, // random
    {
        -1922.5566,
        886.8939,
        35.3359,
        272.1293
    }, // random
    {
        -1983.3458,
        1117.0645,
        53.1243,
        271.2390
    }, // church
    {
        -2417.6458,
        970.1491,
        45.2969,
        269.3676
    }, // gas station
    {
        -2108.0171,
        902.8030,
        76.5792,
        5.7139
    }, // house
    {
        -2097.5664,
        658.0771,
        52.3672,
        270.4487
    }, // random
    {
        -2263.6650,
        393.7423,
        34.7708,
        136.4152
    }, // random
    {
        -2287.5027,
        149.1875,
        35.3125,
        266.3989
    }, // baseball parking lot
    {
        -2039.3571,
        -97.7205,
        35.1641,
        7.4744
    }, // driving school
    {
        -1867.5022,
        -141.9203,
        11.8984,
        22.4499
    }, // factory
    {
        -1537.8992,
        116.0441,
        17.3226,
        120.8537
    }, // docks ship
    {
        -1708.4763,
        7.0187,
        3.5489,
        319.3260
    }, // docks hangar
    {
        -1427.0858,
        -288.9430,
        14.1484,
        137.0812
    }, // airport
    {
        -2173.0654,
        -392.7444,
        35.3359,
        237.0159
    }, // stadium
    {
        -2320.5286,
        -180.3870,
        35.3135,
        179.6980
    }, // burger shot
    {
        -2930.0049,
        487.2518,
        4.9141,
        3.8258
    } // harbor
};
stock SetPlayerPos_Birth(const playerid) {
    new rand = random(sizeof BirthPointInfo);
    SetPlayerPos(playerid, BirthPointInfo[rand][0], BirthPointInfo[rand][1], BirthPointInfo[rand][2]);
    SetPlayerFacingAngle(playerid, BirthPointInfo[rand][3]);
}
stock Action_Play(const playerid, const aid) {
    if(aid < 1 || aid > 21) return SCM(playerid, Color_White, "[����] ������Ķ���ID������.");
    if(aid == 1) SetPlayerSpecialAction(playerid, 68);
    if(aid == 2) ApplyAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
    if(aid == 3) ApplyAnimation(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
    if(aid == 4) ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 5) ApplyAnimation(playerid, "BEACH", "lay_bac_loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 6) ApplyAnimation(playerid, "BEACH", "sitnwait_loop_w", 4.0, 1, 0, 0, 0, 0);
    if(aid == 7) ApplyAnimation(playerid, "SUNBATHE", "batherdown", 3.0, 0, 1, 1, 1, 0);
    if(aid == 8) ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 9) ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 10) ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 11) ApplyAnimation(playerid, "SMOKING", "M_smkstnd_loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 12) ApplyAnimation(playerid, "SMOKING", "M_smk_out", 4.0, 1, 0, 0, 0, 0);
    if(aid == 13) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
    if(aid == 14) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
    if(aid == 15) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
    if(aid == 16) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
    if(aid == 17) ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0);
    if(aid == 18) ApplyAnimation(playerid, "ped", "SEAT_DOWN", 4.0, 0, 0, 0, 1, 0);
    // if(aid == 19) ApplyAnimation(playerid,"PAULNMAC","wank_loop",4.1,1,0,0,0,0,1); //luguan
    if(aid == 19) SetPlayerSpecialAction(playerid, 10);
    if(aid == 20) ApplyAnimation(playerid, "SHOP", "ROB_StickUp_In", 4.0, 0, 0, 0, 1, 0);
    if(aid == 21) ApplyAnimation(playerid, "PARACHUTE", "FALL_skyDive_DIE", 4.0, 0, 0, 0, 1, 0);
    return 1;
}
// 430, 446, 452, 453, 454, 472, 473, 484, 483, 595
stock PPC_Veh(const playerid) {
    DestroyVehicle(p_ppcCar[playerid]);
    new rand = random(sizeof(PPC_SpawnPos));
    new veh = random(200) + 400;
    p_ppcCar[playerid] = CreateVehicle(veh, PPC_SpawnPos[rand][ppX], PPC_SpawnPos[rand][ppY], PPC_SpawnPos[rand][ppZ], 0, -1, -1, 60);
    while (IsModelAPlane(p_ppcCar[playerid]) || IsModelASpecial(p_ppcCar[playerid]) || IsModelABoat(p_ppcCar[playerid])) { //�����ж��Ƿ��Ƿɻ� �ǵĻ��Ͳ�ˢ
        DestroyVehicle(p_ppcCar[playerid]);
        veh = random(200) + 400;
        p_ppcCar[playerid] = CreateVehicle(veh, PPC_SpawnPos[rand][ppX], PPC_SpawnPos[rand][ppY], PPC_SpawnPos[rand][ppZ], 0, -1, -1, 60);
    }
    //���0~211֮������� + 400 ������IDΪ400~611
    SetVehicleVirtualWorld(p_ppcCar[playerid], 10001);
    SetPlayerPos(playerid, PPC_SpawnPos[rand][ppX], PPC_SpawnPos[rand][ppY], PPC_SpawnPos[rand][ppZ]);
    SetPlayerFacingAngle(playerid, PPC_SpawnPos[rand][ppR]);
    SetVehiclePos(p_ppcCar[playerid], PPC_SpawnPos[rand][ppX], PPC_SpawnPos[rand][ppY], PPC_SpawnPos[rand][ppZ]);
    // LinkVehicleToInterior(PlayerInfo[playerid][BuyID], GetPlayerInterior(playerid));
    SetVehicleZAngle(p_ppcCar[playerid], PPC_SpawnPos[rand][ppR]);
    PutPlayerInVehicle(playerid, p_ppcCar[playerid], 0);
    return 1;
}
stock running_PPC(const playerid) {
    if(p_PPC[playerid]) {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        // if(z >= 233 && z<=270 && GetSpeed(playerid)>399) { //�����㷨̫������ �����RҲ��
        //     FuckAnitCheat(playerid, "�����������쳣");
        //     return 1;
        // }
        if(z < 150 || z > 260) return PPC_Veh(playerid);
        //�����ҵĸ߶�< 150 �Ǿ��ǵ���ȥ��  ̫��Ҳ����
    }
    return 1;
}
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
    Board_EditMode(playerid, objectid, response, x, y, z, rx, ry, rz);
    //First you should detete 3dtext otherwise u will create so many 3dtext labels
    DestroyDynamic3DTextLabel(GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel]);
    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
    GetDynamicObjectPos(objectid, oldX, oldY, oldZ);
    GetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);

    /*
    	if(!playerDynamicobject) // If this is a global object, move it for other players
    	{
     	if(!IsValidObject(objectid)) return;
     	MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
    	}
    	*/
    if(response == EDIT_RESPONSE_FINAL) {
        GOODS[GOODS_OPRATEID[playerid]][GoodX] = x;
        GOODS[GOODS_OPRATEID[playerid]][GoodY] = y;
        GOODS[GOODS_OPRATEID[playerid]][GoodZ] = z;
        GOODS[GOODS_OPRATEID[playerid]][GoodRX] = rx;
        GOODS[GOODS_OPRATEID[playerid]][GoodRY] = ry;
        GOODS[GOODS_OPRATEID[playerid]][GoodRZ] = rz;
        GOODS[GOODS_OPRATEID[playerid]][WID] = GetPlayerVirtualWorld(playerid);
        SetDynamicObjectPos(objectid, x, y, z);
        SetDynamicObjectRot(objectid, rx, ry, rz);
        new string[285];
        if(GOODS[GOODS_OPRATEID[playerid]][issale] == true) {

            format(string, sizeof(string), "{80FF80}��Ʒ��������...\n{FFFFFF}[��ƷID]:{80FF80} %d\n{FFFFFF}[���˳��ID]:{80FF80} %d\n{FFFFFF}[ģ��ID]:{80FF80} %d\n{FFFFFF}[�۸�]:{80FF80} %d\n{FFFFFF}��{80FF80}Y{FFFFFF}����", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid], GOODS[GOODS_OPRATEID[playerid]][GoodPrize]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        } else {
            format(string, sizeof(string), "{80FF80}%s\n{FFFFFF}[����]:{80FF80} %s\n{FFFFFF}[��ƷID]:{80FF80} %d\n{FFFFFF}[���˳��ID]:{80FF80} %d\n{FFFFFF}[ģ��ID]:{80FF80} %d\n{FFFFFF}��{80FF80}Y{FFFFFF}����", GOODS[GOODS_OPRATEID[playerid]][GoodName], GOODS[GOODS_OPRATEID[playerid]][GoodOwner], GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        }
        SaveGoods(GOODS_OPRATEID[playerid]);

    }

    if(response == EDIT_RESPONSE_CANCEL) {

        SetDynamicObjectPos(objectid, oldX, oldY, oldZ);
        SetDynamicObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
        GOODS[GOODS_OPRATEID[playerid]][GoodX] = oldX;
        GOODS[GOODS_OPRATEID[playerid]][GoodY] = oldY;
        GOODS[GOODS_OPRATEID[playerid]][GoodZ] = oldZ;
        GOODS[GOODS_OPRATEID[playerid]][GoodRX] = oldRotX;
        GOODS[GOODS_OPRATEID[playerid]][GoodRY] = oldRotY;
        GOODS[GOODS_OPRATEID[playerid]][GoodRZ] = oldRotZ;
        GOODS[GOODS_OPRATEID[playerid]][WID] = GetPlayerVirtualWorld(playerid);
        new string[285];
        if(GOODS[GOODS_OPRATEID[playerid]][issale] == true) {

            format(string, sizeof(string), "{80FF80}��Ʒ��������...\n{FFFFFF}[��ƷID]:{80FF80} %d\n{FFFFFF}[���˳��ID]:{80FF80} %d\n{FFFFFF}[ģ��ID]:{80FF80} %d\n{FFFFFF}[�۸�]:{80FF80} %d\n{FFFFFF}��{80FF80}Y{FFFFFF}����", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid], GOODS[GOODS_OPRATEID[playerid]][GoodPrize]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        } else {
            format(string, sizeof(string), "{80FF80}%s\n{FFFFFF}[����]:{80FF80} %s\n{FFFFFF}[��ƷID]:{80FF80} %d\n{FFFFFF}[���˳��ID]:{80FF80} %d\n{FFFFFF}[ģ��ID]:{80FF80} %d\n{FFFFFF}��{80FF80}Y{FFFFFF}����", GOODS[GOODS_OPRATEID[playerid]][GoodName], GOODS[GOODS_OPRATEID[playerid]][GoodOwner], GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        }
        SaveGoods(GOODS_OPRATEID[playerid]);
    }
    return 1;
}


// 2020.3.21����  ��5Fֱ�Ӱ������ ��Ҵ���ʱ�ȴ�һ����OBJ�ȼ���

stock DynUpdateStart(const playerid) {
    TogglePlayerControllable(playerid, false); // Freeze
    new string[64];
    format(string, sizeof(string), "~g~Objects~n~~r~Loading");
    GameTextForPlayer(playerid, string, 3000, 6);
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    SetTimerEx("DynUpdateEnd", 2000, 0, "i", playerid);
    return 1;
}
forward DynUpdateEnd(playerid);
public DynUpdateEnd(playerid) {
    TogglePlayerControllable(playerid, true); // Unfreeze
    new string[64];
    format(string, sizeof(string), "~g~Objects~n~~r~Loaded!");
    GameTextForPlayer(playerid, string, 3000, 6);
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    return 1;
}

stock IsModelABoat(const vehicleid) {
    switch (GetVehicleModel(vehicleid)) {
        case 430, 446, 452, 453, 454, 472, 473, 484, 483, 595:
            return true;
    }
    return false;
}

stock IsModelASpecial(const vehicleid) // RC trailer
{
    switch (GetVehicleModel(vehicleid)) {
        case 435, 441, 449, 450, 464, 465, 501, 537, 538, 539, 545, 564, 569..572, 583, 584, 590, 591, 594, 606, 607, 608, 610:
            return true;
    }
    return false;
}

stock IsModelAPlane(const vehicleid) {
    switch (GetVehicleModel(vehicleid)) {
        case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 464:
            return true;
        case 548, 425, 417, 487, 488, 497, 563, 447, 469, 465, 501:
            return true;
    }
    return false;
}


stock Race_CheckPlayerCheat(const ss, const tempcpid) { //�����߼�CP������
    new tmp[128], script[RACE_CP_MAX_FUNCTION], idx;
    new flag;
    for (new i = 0; i < ss; i++) {
        flag = false;
        Race_GetCp_Script(tempcpid, i, script);
        format(script, RACE_CP_MAX_FUNCTION, "%s", script);
        tmp = strtok(script, idx); //tmpȡ������������
        if(Race_Cp_Script_Check(tmp) != -1) {
            //���ĳ��CP���б���ĸ߼����� �����ض��Ļ�Ӱ�췴���׵ĺ���
            // �����ĺ��� ����true �������for���� ֻҪ��һ���ǻ�Ӱ�췴�����жϵ� ���յ���false
            // �������for�ж����˻���true �Ǿ��ǹ���     
            if(!strcmp(tmp, "time", false)) flag = true;
            if(!strcmp(tmp, "weather", false)) flag = true;
            if(!strcmp(tmp, "msg", false)) flag = true;
            if(!strcmp(tmp, "fix", false)) flag = true;
            if(!strcmp(tmp, "damage", false)) flag = true;
            // ����Ժ�д���µĺ��������ǲ�Ӱ�췴���׵ĺ�����Ҫ�������
        }
        idx = 0;
    }
    if(flag) return 1;
    return 0; //����0��ζ�����û����
}




CMD:yssy(const playerid, const cmdtext[]) { //��ʱ��Ӱ by KiVen & YuCarl77
    // if() //�������Ѿ�����ʱ��Ӱ��������ֹ
    // �����ҵ����˵�ʱ���ж��Ƿ�����ʱ��Ӱ �������ɱ����ʱ��
    if(PlayerInfo[playerid][yssyjsq] != -1) return SendClientMessage(playerid, Color_White, "[��ʱ]�����ڽ�����ʱ��Ӱ");
    // KillTimer(PlayerInfo[playerid][yssyjsq]);
    new endminute, endseconds, howlong;
    if(sscanf(cmdtext, "iii", endminute, endseconds, howlong)) return SendClientMessage(playerid, Color_White, "[��ʱ]��������� /yssy ʱ �� �೤����");
    if(endminute > 24 || endminute < 0) return SendClientMessage(playerid, Color_White, "[��ʱ]�����Сʱ");
    if(endseconds > 60 || endseconds < 0) return SendClientMessage(playerid, Color_White, "[��ʱ]����ķ���");
    if(howlong > 300 || howlong < 3) return SendClientMessage(playerid, Color_White, "[��ʱ]ʱ�䲻�ɵ���3���Ҳ��ɴ���5����");
    new howlonginterval = min_test(PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute], endminute, endseconds);
    // if(endminute < PlayerInfo[playerid][tHour]) endminute+=24;
    PlayerInfo[playerid][yssym] = endseconds; //PlayerInfo[playerid][tMinute];//endseconds;
    PlayerInfo[playerid][yssyh] = endminute; //PlayerInfo[playerid][tHour];//endminute;
    PlayerInfo[playerid][yssyjsq] = SetTimerEx("SetPlayerYssyJisuan", 20, true, "ii", playerid, howlonginterval / howlong);
    // ������ҵ���ʱ��Ӱ״̬Ϊ��

    //����������ʱ��Ӱ��״̬��ɱ����ʱ��
    return 1;
}

forward SetPlayerYssyJisuan(playerid, howlong);
public SetPlayerYssyJisuan(playerid, howlong) {
    //�������100���� Խ��Խƽ�� ����ҲҪ����ʱ�䳤��ȥ����ÿִ�е�Ƶ��Ӧ�ø����ٷ���ÿִ��Ƶ��
    //������ʱ��420�� Ȼ�����˵Ҫ3��󵽴�420�� ��ô�͵�Ҫÿ��7���� ÿ100�������0.7����
    // PlayerInfo[playerid][yssym]=PlayerInfo[playerid][yssym]+(howlong/10);
    PlayerInfo[playerid][tMinute] = PlayerInfo[playerid][tMinute] + (howlong / 50);
    if(PlayerInfo[playerid][tMinute] >= 60) {
        PlayerInfo[playerid][tMinute] = 0; //���ӹ�0
        PlayerInfo[playerid][tHour]++; //Сʱ��1
        if(PlayerInfo[playerid][tHour] >= 24) {
            PlayerInfo[playerid][tHour] = 0; //Сʱ���賿
        }
    }
    SetPlayerYssy(playerid, PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute]);
    return 1;
}

stock SetPlayerYssy(playerid, hour, minute) {
    printf("hour:%d minute:%d", hour, minute);
    SetPlayerTime(playerid, hour, minute);
    // if(PlayerInfo[playerid][yssyh]>24) 
    // {
    //     if(hour>=PlayerInfo[playerid][yssyh] && minute>= PlayerInfo[playerid][yssym])
    //     {
    //         SendClientMessage(playerid, Color_White, "[��ʱ]��ʱ������");
    //         KillTimer(PlayerInfo[playerid][yssyjsq]);
    //         PlayerInfo[playerid][yssyjsq]=-1;
    //         // ���������ʱ��Ӱ״̬Ϊ��
    //     }
    // }
    // if(hour>=PlayerInfo[playerid][tHour] && minute>= PlayerInfo[playerid][tMinute])
    if(hour >= PlayerInfo[playerid][yssyh] && minute >= PlayerInfo[playerid][yssym]) {
        SendClientMessage(playerid, Color_White, "[��ʱ]��ʱ������");
        KillTimer(PlayerInfo[playerid][yssyjsq]);
        PlayerInfo[playerid][yssyjsq] = -1;
        // ���������ʱ��Ӱ״̬Ϊ��
    }
    return 1;
}


stock min_test(sh, sm, eh, em) //��ʼʱ���֣�����ʱ���� ���ؽ���ʱ��
{
    new min_count, hour, minute;
    if(eh < sh) {
        sh = sh - 12;
        eh = eh + 12; //������
    }
    hour = (eh - sh) * 60; //��ʵ����Ϸ��ķ�  //������Сʱ��ȥ��ʼ��Сʱ ��ʵ��ʹ���� 1���� =60����Ǽ�����*60��
    minute = (em - sm); //��ʵ����Ϸ�����
    if(hour < 0) hour *= -1; //ȡ����ֵ �������ʱ��ȿ�ʼʱ��С
    if(minute < 0) minute *= -1; //ȡ����ֵ
    min_count = hour + minute; //���ص������� 
    printf("%d", min_count);
    //��������Ǽ����ԭ����ʱ�䵽��Ҫ��ʱ�� ��ԭ����ʱ��������Ҫ������

    // if(sh < eh)//�жϿ�ʼʱ�ǲ��Ǵ��ڽ���ʱ���������ϵ��ڶ�����������
    // {
    //     sh = sh - 12;
    //     eh = eh + 12;//������
    // }
    // min_count = (sh - eh) * 60;//���Сʱ�ļ�ķ���
    // if(sm > em) min_count += sm - em; 
    // else min_count -= em -sm;
    //���Ƿ��ӣ����ھ���Ҫ�� С�����ҪҪ��
    return min_count;
}

Dialog:HelpSystem(playerid, response, listitem, inputtext[]){
    if(response == 1) {
        new msg[128], idx;
        msg = strtok(inputtext, idx);
        if(!strcmp(msg, "����ƪ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ƪ", "/sound1~7 ��SAMP�Դ������֣���Щ���־�����SAMP����������ʹ��Ŷ ����/sound1\n/soundstop ֹͣ��������", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "����ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ϵͳ", "��������\n�༭����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "���Ի�����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "���Ի�����", "/mynetstats �Ի�����ϸ����״̬\n/sz ��������\n/tianqi �����Լ�������\n/time �����Լ���ʱ��\n/skin��/hf �����Լ�������Ƥ��\n/kgobj ������ر�OBJģ�͵���ʾ\n/kgname ������ر�������ҵ�����\n/name on/off ����/�ر�������ҵ�����\n/stunt on/off ����/�ر���Ļ���·����ؼ���ʾ", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�ճ�����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "���Ի�����", "/pm id ˽�� ����/pm 1\n/xiufu �����ﱻ��ס��ʱ��ɳ���ʹ�ø�����Ŷ\n/fxq ˢ��һ����������\n/jlsˢ��һ������ɡ���������ֵ���ɡ֮��\n/wuqi ˢ�����������������������ҿ�ǹŶ��һ������Ƶ�����ֵ�������;ʹ��\n/count��/djs ����ʱ����С��Χ�ĸ�����Ҷ����յ��㷢��ĵ���ʱ�󣬿���һ���������Ƶ��쭳���\n/wudi ���������޵�\n/ppc һ������������", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�ؾ����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�ؾ����", "/c [����ID]��ˢ��������IDΪ400-611\n/cc ��ɫ���� ��ɫ���� ����������ɫ ����/cc 0 0 \n/c ti û����ͬ������ҳ�������Ū��ȥ\n/c wode ��С�İѳ�Ū���ˣ�����Զ�ˣ��ٻ���֮ǰˢ�������ĳ�\n/c suo ���� \n/c chepai\n/fix �޸�һ����ĳ���\n/dcar����/�ر��ؾ��޵�\n/f ����ʱʹ��.������ϵͳ����ʹ��/kill���³�������\n/infobj ���ƺ�β��\n/hys ��ɫ��", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�������")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�������", "/w �ص������磬�������Ĭ�϶����������\n/w id �����ض�������\n���Ժ�С���һ��ȥ'С����'��������Ƶ��һ����ˣ�Ҳ������˴���", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�ۿ����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�ۿ����", "/tv ���id ����/tv 1\n/tv off �رչۿ����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "����/����")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����/����", "/sp��/s����Ŀǰ������λ��\n/lp��/l���͵�֮ǰ�����λ��\n/vmake����һ������ ��ʽΪ/vmake ������(�淶Ӣ��) ����vmake ldz\n/telemenu�鿴����ϵͳ���͵�\n��������һ����Ϊldz�������´μ���ʹ��/ldz����\n/tpa����һ�������������� ����/tpa playerid\n/ta����������Ҹ��㷢��������\n/td�ܾ�������Ҹ��㷢��������\n/tpa ban����tpa�����ٴ�����ر�", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "����Աָ���ȫ")) {
            if(!PlayerInfo[playerid][AdminLevel]) return SendClientMessage(playerid, Color_White, "[ϵͳ]�㻹���ǹ���ԱŶ~");
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����Աָ���ȫ", "LV1\nLV2\nLV3\nLV4\nLV5\nLV?", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "����ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ϵͳ", "�����ճ�����\n��������Ա����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�Ҿ�ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�Ҿ�ϵͳ", "�Ҿ��ճ�����\n�Ҿ߹���Ա����", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "װ��ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "װ��ϵͳ", "/wdzb��/sz�鿴�ҵ�װ��\n/buyattire����װ��\nװ�繺���/yyk\n��������˻ؽ��", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�����ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�����ϵͳ", "�ڹ���Ƹ�����Y�ɲ��������,�ɻ��ս��\n/board buy��������.\n/board list �鿴������б�\n/board goto id���͵������", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "����ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "����ϵͳ", "Ŀǰ����ֻ���ɹ���Ա����./cars buy �ɹ��򰮳� /cars list �鿴�����б�\n /aczb ����װ�� /wdac �ҵİ���\n", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "�Ŷ�ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "�Ŷ�ϵͳ", "�����Ŷ�/t create �Ŷ��б�/t list\n�ҵ��Ŷ�/t wode��/wdtd\n��ȡ����/t get ���͵���Ա/t goto\n/t invite������Ҽ����Ŷ�\n�б�ʽ����\n�Ŷ��û��ȼ���Ϊ0,1,2\n0Ϊ��Ա,1Ϊ����Ա,2Ϊ��ʼ��\n����Ա����ȡ�������Ϊ�Ŷӳ�Ա\n��ʼ�߱ȹ���Ա��һ��ת�úͽ�ɢȨ��", "ȷ��", "����");
            return 1;
        }
        if(!strcmp(msg, "���ϵͳ")) {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "���ϵͳ", "/cam�����\nͨ�����������д���,�Ƚϼ�,�Ͳ�������ϸ������", "ȷ��", "����");
            return 1;
        }
    }
    return 1;
}

Dialog:CustomSettings(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch (listitem) 
        {
            case 0:{ //������
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/tpa ban");
                // OnPlayerCommandText(playerid, "/tpa ban");
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 1:{ //�����޵�
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/wudi");
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 2:{ //�����޵�
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/dcar");
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 3:{ //����OBJ
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/kgobj");
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 4:{ //
                if(PlayerInfo[playerid][AutoFlip]) {
                    PlayerInfo[playerid][AutoFlip] = 0;
                    SendClientMessage(playerid, Color_White, "[ϵͳ]�����Զ������ѹر�");
                } else {
                    PlayerInfo[playerid][AutoFlip] = 1;
                    SendClientMessage(playerid, Color_White, "[ϵͳ]�����Զ������ѿ���");
                }
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 5:{ //������ײ
                if(PlayerInfo[playerid][NoCrash]) {
                    PlayerInfo[playerid][NoCrash] = 0;
                    DisableRemoteVehicleCollisions(playerid, false);
                    SendClientMessage(playerid, Color_White, "[ϵͳ]������ײ�ѹر�");
                } else {
                    PlayerInfo[playerid][NoCrash] = 1;
                    DisableRemoteVehicleCollisions(playerid, true);
                    SendClientMessage(playerid, Color_White, "[ϵͳ]������ײ�ѿ���");
                }
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 6:{ //�ٶȱ�
                cmd_sdb(playerid, "");
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 7:{
                if(PlayerInfo[playerid][netStats]) {
                    SendClientMessage(playerid, 0xFFFFFFFF, "[ϵͳ]�������������");
                    for (new i = 0; i <= 10; i++) {
                        PlayerTextDrawHide(playerid, PlayerText:network_txtdraw[playerid][i]);
                    }
                    PlayerInfo[playerid][netStats] = false;
                } else {
                    SendClientMessage(playerid, 0xFFFFFFFF, "[ϵͳ]�����������ʾ");
                    for (new i = 0; i <= 10; i++) {
                        PlayerTextDrawShow(playerid, PlayerText:network_txtdraw[playerid][i]);
                    }
                    PlayerInfo[playerid][netStats] = true;
                }
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 8:
            {
                if(PlayerInfo[playerid][showName])
                {
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) 
                    {
                        ShowPlayerNameTagForPlayer(playerid, i, false);
                    }
                    SCM(playerid, Color_White, "[ϵͳ] �����������������.");
                    PlayerInfo[playerid][showName] = 0;
                    return 1;
                }
                for (new i = GetPlayerPoolSize(); i >= 0; i--) 
                {
                    ShowPlayerNameTagForPlayer(playerid, i, true);
                }
                SCM(playerid, Color_White, "[ϵͳ] ����ʾ�����������.");
                PlayerInfo[playerid][showName] = 1;
                return 1;
            }
            case 9:
            {
                if(PlayerInfo[playerid][showStunt])
                {
                    EnableStuntBonusForPlayer(playerid, 0);
                    SCM(playerid, Color_White, "[ϵͳ] �ѹر��ؼ�������ʾ.");
                    PlayerInfo[playerid][showStunt] = 0;
                    return 1;
                }
                EnableStuntBonusForPlayer(playerid, 1);
                SCM(playerid, Color_White, "[ϵͳ] �ѿ����ؼ�������ʾ.");
                PlayerInfo[playerid][showStunt] = 1;
                return 1;
            }
            case 10:{ //ʱ��
                ShowPlayerDialog(playerid, PlayerInfoDialog + 4, DIALOG_STYLE_INPUT, "ʱ������", "������ʱ��,��ʽ:ʱ ��,����5 30", "ȷ��", "ȡ��");
                // break;
                return 1;
            }
            case 11:{ //����
                ShowPlayerDialog(playerid, PlayerInfoDialog + 5, DIALOG_STYLE_INPUT, "��������", "0-LA����\n1-LA��\n2-LA������\n3-LA����\n4-LA��\n5-SF��\n6-SF����\n7-SF��\n8-SF��\n9-SF��\n10-LV��\n11-LV�Ⱦ�\n12-LV��\n13-��弫��\n14-�����\n15-�����\n16-�����\n17-ɳĮ����\n18-ɳĮ��\n19-ɳĮɳ����\n20-ˮ�£��̣���\n��������������ʽ:���� ����12", "ȷ��", "ȡ��");
                return 1;
            }
        }
        return 1;
    }
    AntiCommand[playerid] = 0;
    CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/help");
    return 1;
}