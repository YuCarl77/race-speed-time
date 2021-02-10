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
	版权(c) <2019-2020> <YuCarl77>   

	使用该许可证的软件被授予以下权限，免费，任何人可以得到这个软件及其相关文档的一个拷贝，
	并且经营该软件不受任何限制，包括无限制的使用、复制、修改、合并、出版、发行、发放从属证书、或者出售该软件的拷贝的权利。
	同时允许获得这些软件的用户享受这些权利，使其服从下面的条件：  
	
	以上的版权通知和权限通知应该包含在所有该软件的拷贝中或者是其他该软件的真实部分中。
	
	该软件按本来的样子提供，没有任何形式的担保，不管是明确地或者暗含的，包含这些但是不受商业性质的担保的限制。
	适合一个特定的用途并且不受侵犯。作者和版权持有人在任何场合对使用该软件涉及的任何要求、损害或者其他责任都不应负责。
	不管它是正在起作用还是只是合同形式、民事侵权或是其他方式，如由它引起，在其作用范围内、与该软件有联系、该软件的使用或者有这个软件引起的其他行为。  
	=====================================   
*/

//  相信我，能在开源里写鸣谢前辈的人的人真的是少之又少。
//  本服修改自5F，Prace,PHouse,Goods等开源 特别鸣谢：[Ghost]Rui ushio_p [Ghost]Dylan
//  致敬自由居民区开源,制作者:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)
//  特别鸣谢 ryddawn 技术及OBJ指导；[Fire]KiVen JoshenKM
//  特别鸣谢 GoodsSys开发者Episodes KiVen juse
//  特别鸣谢 GTAUN GTABBS 
// RST团队服务器开发主要由[R_ST]Hygen（YuCarl77）领导



//2020.2.15 修改 原本是float:sqrt

//#include <timerfix>
#include <a_samp>
// #include "ASAN" //中文名补丁    很多服都用的mk124的NPatcher 但是没linux版本
#define FIX_strcmp 0 //因为要用mk124的strcmp所以就关闭了修复samp自带一些问题的inc例的这个功能
#define FIX_PutPlayerInVehicle 0 //不然的话赛道就炸了
#define FIX_KEY_AIM 0
#define FIX_GogglesSync 0
#define FIX_OnPlayerSpawn 0
#include <yuki/fixes> //需要放在a_samp下面
//https://github.com/pawn-lang/sa-mp-fixes
//https://wiki.sa-mp.com/wiki/Fixes.inc#Expansion 
//修复SAMP服务器自带的一些问题

#include <yuki/main>
#include <yuki/tele>
#include <yuki/HRace>
#include <yuki/PHouse>
#include <yuki/Goods_Sys>
#include <yuki/questionAnswer>
#include <yuki/npc>
#include <yuki/AntiCheat/Rogue-AC>//反作弊
#include <yuki/Attire> //2020.2.29新增
#include <yuki/billboard> //2020.3.1新增
//#include <yuki/Cars> //2020.3.3新增
#include <yuki/Team> //2020.3.14写
#include <yuki/camera> //2020-3-15增加16年写的镜头
#include <yuki/DeathMatch> // 2020.3.16新增
#include <yuki/World> // 2020.3.28合并 世界

// #include <crashdetect> //测试崩溃

#define strlen mk_strlen
#define strcmp mk_strcmp
#define strfind mk_strfind
#define MailDialogContent "\n请选择↓↓↓↓↓\n重新发送\n设置邮箱\n输入验证码\n修改密码\n修改用户名"
// #define PlayerInfoDialog 1300
// #define PRESSED(%0) \ (((newkeys & ( % 0)) == ( % 0)) && ((oldkeys & ( % 0)) != ( % 0)))
#define HOLDING(%0) \
((newkeys & ( % 0)) == ( % 0))
#pragma dynamic 30000 

//堆栈问题 Stack/heap size:16384 bytes; estimated max. usage:unknown, due to recursion 
// 代码一直没有优化过 需要尽可能减少变量的长度 特别是全局变量   字符型不要超过1024
// 曾经的自由者给过15W的栈 我觉得还是太大了 30000编译出去12W 差不多
// 默认栈是16384bytes 好像就16KB？

// #pragma compat 1 //2020.2.15新增 新编译器pawncc https://github.com/pawn-lang/compiler/ 兼容模式

new g_MysqlRaceCheck[MAX_PLAYERS];

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
    print("-----------------------------------");
    printf("Error ID: %d, Error: %s", errorid, error);
    printf("Callback: %s", callback);
    printf("Query: %s", query);
    print("-----------------------------------");
	return 1;
}

// #include <YSI\y_ini>

//无敌时间标题
// new Text3D:NoDieTime[MAX_PLAYERS];
// PlayerText:LetterForYou[MAX_PLAYERS][4]


AntiDeAMX() {
    new a[][] = {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

function Float:sqrt(Float:number) {
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

// new StopSecondsTimer = -1, StopGATimer = -1, StopMinuteTimer = -1, StopupdateSpeedometer = -1; //秒计时器 用于自动修车 积分判断等 系统计时器
new Float:exp_multiple = 1.0; //经验倍数 默认正常经验 如果有需要双倍经验等功能可自行操控

static randSounds[7] = {
    1062,
    1068,
    1076,
    1097,
    1183,
    1185,
    1187
};

// stock IsNumeric(const string[]) {
//     for (int i = 0, j = strlen(string); i < j; i++)
//         if(string[i] > '9' || string[i] < '0')
//             return 0;
//     return 1;
// }

new dinfobj[MAX_PLAYERS], jd[MAX_PLAYERS], wy[MAX_PLAYERS], splp[MAX_PLAYERS];
//是否警灯,警灯OBJ,尾翼OBJ,是否保存/s 换颜色

enum ppctype {
    Float:ppX,
    Float:ppY,
    Float:ppZ,
    Float:ppR
};


//本来是new的
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
//     //镜头坐标:x,y,z 注视坐标:x,y,z
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
// new CountDown = -1; //倒计时
new Count[MAX_PLAYERS], Timer[MAX_PLAYERS];
// new wdzt[MAX_PLAYERS];

new RandMsg;
//原来是new ANNOUNCEMENTS[7][128] = {
static ANNOUNCEMENTS[7][] = {
    "[广播]:请勿粗口,粗口管理员会禁言的哟! ",
    "[广播]:可用指令尽在/help 个人设置/sz ",
    "[广播]:不要忘了按Tab键可以查看当前玩家数! ",
    "[广播]:赛车中翻车、失误，下车或/kill可自动重生√",
    "[广播]:赛车开挂直接封杀!遵守游戏规则！请勿作弊！ ",
    "[广播]:故意捣乱会被管理员丢进监狱的哟! ",
    "[广播]:素质游戏，禁R，禁粗口！"
};
function GlobalAnnouncement() {
    switch (RandMsg) {
        case 0:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[0]);
            new year = 0, month = 0, day = 0;
            getdate(year, month, day);
            if(year == 2020 && month <= 3 && day <= 15) SendRconCommand("hostname RST团队官方服务器，一起为武汉加油!");
            // else SendRconCommand("hostname {****新 年 快 乐****}RST团队官方服务器2020");
            RandMsg++;
        }
        case 1:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[1]);
            SendRconCommand("hostname RST团队官方服务器「感谢热爱GTA的你们 」");
            RandMsg++;
        }
        case 2:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[2]);
            SendRconCommand("hostname RST团队官方服务器「赛车|自由|娱乐|碰碰车|房屋|家具」");
            RandMsg++;
        }
        case 3:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[3]);
            // SendRconCommand("hostname Race Speed Time 骇速之时 2020");
            RandMsg++;
        }
        case 4:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[4]);
            SendRconCommand("hostname RST团队服务器，B站搜索RaceSpeedTime");
            RandMsg++;
        }
        case 5:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[5]);
            SendRconCommand("hostname RST团队官方服务器「骇速之时」");
            RandMsg++;
        }
        case 6:{
            SCMALL(Color_Announcement, ANNOUNCEMENTS[6]);
            SendRconCommand("hostname RST骇速之时 - 2020 [百条经典赛道等你来玩]");
            RandMsg++;
        }
        case 7:{
            //SCMALL(Color_Announcement, ANNOUNCEMENTS[2]);
            // SendRconCommand("hostname RST团队官方服务器「24/7运行中...」");
            RandMsg = 0;
        }
    }
    return 1;
}
function _KickPlayerDelayed(playerid) {
    Kick(playerid);
    return 1;
}
function BansEx(playerid) {
    Ban(playerid);
    return 1;
}
main() {}
public OnGameModeInit() {
    AntiDeAMX();
    SetGameModeText("自由|赛车|拍摄|娱乐");

    g_Sql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
    new errno = mysql_errno(g_Sql);
    if(g_Sql == MYSQL_INVALID_HANDLE || errno != 0)
    {
        new error[100];
        mysql_error(error, sizeof (error), g_Sql);
        printf("[ERROR] #%d '%s'", errno, error);
        print("[MySQL]无法连接到MYSQL服务器");
        SetGameModeText("Error - 数据库异常");
        new rand = random(89999)+10000;
        new string[64];
        format(string, sizeof(string), "password %d", rand);
        SendRconCommand(string);
        SendRconCommand("hostname [错误]RaceSpeedTime数据库加载失败,请联系管理员");
        return 1;
    }
    SetupPlayerTable();
    mysql_set_charset(MYSQL_charset);
    // ReSetAllPlayerPass();//临时使用请及时删除！
    

    print("[提示]NPC加载中...");
    SetNameTagDrawDistance(200); //原来是70 设置最大距离以显示玩家的名称。
    // Streamer_SetTickRate(15 ); //默认50，服务器tickrate
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    UsePlayerPedAnims();
    // AddPlayerClass(0, 1958.3782, 1343.1572, 15.3746, 269.1424, 0, 0, 0, 0, 0, 0);

    // Race_Load();
    Initialize_Main();
    Initialize_SysTransfer();
    Initialize_Transfer();
    Initialize_QA();
    Initialize_LocalObjects(); //本地OBJ加载 非addobjects
    Initialize_PHouse(); //Phouse加载
    Initialize_Attire(); //装扮加载
    Initialize_Cars(); //爱车加载
    Initialize_Boards(); //公告牌加载
    Race_OnFilterScriptInit(); //载入赛道
    Initialize_DeathMatch(); //载入DM
    Initialize_Team(); //初始化团队
    LoadNpcs(); //加载NPC
    Initialize_Camera(); //初始化摄像机 2020-3-15 16:41:07
    InitGoods(); //初始化家具.
    // 加载Timers
    // StopGATimer = SetTimer("GlobalAnnouncement", 250000, true); //加载公告计时
    // StopMinuteTimer = SetTimer("MinuteTimer", 60000, true); //分钟计时器
    // StopupdateSpeedometer = SetTimer("updateSpeedometer", 100, true); //速度表计时器
    // StopSecondsTimer = SetTimer("SecondsTimer", 1000, true); //秒计时器
    // 因为用不到KillTimer了 所以就不写那些个变量了;
    SetTimer("GlobalAnnouncement", 250000, true); //加载公告计时
    SetTimer("MinuteTimer", 60000, true); //分钟计时器
    SetTimer("updateSpeedometer", 200, true); //速度表计时器
    SetTimer("SecondsTimer", 1000, true); //秒计时器
    // sqlconnect = mysql_connect("127.0.0.1","用户名","库名","密码");

    // 邮箱验证用的表名是players
    // 需要把架设php服务 把php文件夹下的架上去 php文件里有需要修改用户名和密码的地方
    // if(mysql_connect("127.0.0.1","root","sampemail","123456") == 0)
    // {
    //     print("[警告]邮箱验证数据库连接失败[请及时修复.]");
    //     // print("[警告]邮箱验证数据库连接失败[请及时修复,否则无法开启服务器.]");
    // 	// SendRconCommand("exit");
    // }
    // else
    // {
    // 	print("[提示]邮箱验证数据库连接成功!但如果出生后服务器崩溃请开启相关服务.");
    // }
    // mysql_set_charset("gbk");
    // mysql_debug(1);
    print("-------------------------------------------------");
    print("本服修改自5F开源，Prace开源 致敬开源Prace，制作者：[Ghost]Rui ushio_p [Ghost]Dylan");
    print("致敬自由居民区开源,制作者:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)");
    print("特别鸣谢 ryddawn 技术及OBJ指导；[Fire]KiVen JoshenKM");
    print("[R_ST]Hygen:服务器运行中....");
    print("-------------------------------------------------");
    return 1;
}
public OnGameModeExit() { //print("[提示]服务器关闭/重启");
    // SCMALL(Color_Red, "[系统] 即将刷新服务器，正在保存玩家数据中...");
    // for (StopMinuteTimeri = GetPlayerPoolSize(); i >= 0; i--) {
    //     if(IsPlayerConnected(i)) OnPlayerDisconnect(i,1); // We do that so players wouldn't lose their data upon server's close.
    // }
    // KillTimer(StopGATimer);
    // KillTimer(StopMinuteTimer);
    // KillTimer(StopupdateSpeedometer);
    // KillTimer(StopSecondsTimer);
    UnLoadNpcs(); //卸载NPC
    Boards_OnGameModeExit(); //公告牌卸载
    Attire_OnGameModeExit(); //装扮卸载
    Cars_OnGameModeExit(); //爱车卸载
    Team_OnGameModeExit(); //团队卸载
    db_close(Racedb); //PRace卸载
    db_close(data); //print("[PHouse]卸载");
    // db_close(user); //关闭用户数据库
    for (new i = 0, j = GetPlayerPoolSize(); i <= j; i++) 
	{
		if (IsPlayerConnected(i))
		{
		    // reason is set to 1 for normal 'Quit'
			OnPlayerDisconnect(i, 1);
		}
	}
    mysql_close(g_Sql);//关闭mysql数据库
    SCMALL(Color_Red, "[系统] 玩家数据保存完毕，开始重启服务器..");
    return 1;
}
public OnPlayerRequestClass(playerid, classid) {
    if(IsPlayerNPC(playerid)) return 1;
    if(!PlayerInfo[playerid][Login]) {
        new rand = random(sizeof(randSounds));
        PlaySoundForPlayer(playerid, randSounds[rand]);
        InterpolateCameraPos(playerid, random(6000) - 3000, random(6000) - 3000, random(120) + 50, random(6000) - 3000, random(6000) - 3000, random(120) + 50, 60000, CAMERA_MOVE);
        return 0;
    }
    new rand = random(sizeof BirthPointInfo);
    SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][Skin], BirthPointInfo[rand][0], BirthPointInfo[rand][1], BirthPointInfo[rand][2], BirthPointInfo[rand][3], 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid); //让玩家出生
    return 1;
}
public OnPlayerRequestSpawn(playerid) {
    if(IsPlayerNPC(playerid)) return 1;
    if(!PlayerInfo[playerid][Login]) {
        SendClientMessage(playerid, Color_Yellow, "[系统]你还没登录!");
        return 0;
    }
    new rand = random(sizeof BirthPointInfo);
    SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][Skin], BirthPointInfo[rand][0], BirthPointInfo[rand][1], BirthPointInfo[rand][2], BirthPointInfo[rand][3], 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid); //让玩家出生
    // if(PlayerInfo[playerid][Login]) 
    // {
    //     SetSpawnInfo(playerid, NO_TEAM, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    //     SpawnPlayer(playerid);
    //     return 1;
    // }
    return 1;
}
public OnPlayerConnect(playerid) //当玩家进入的时候
{
    if(IsPlayerNPC(playerid)) 
    {
        InitializationVelo(playerid);
        return 1;
    }
	g_MysqlRaceCheck[playerid]++;

    PlayerInfo[playerid][LoginTimer] = -1;
    // InitializationVelo(playerid); //初始化速度表
    PlayerInfo[playerid][Login] = false;
    // PlayerInfo[playerid][Register] = false;
    PlayerInfo[playerid][tvzt] = false;
    PlayerInfo[playerid][tvid] = playerid;
    p_PPC[playerid] = 0;
    p_ppcCar[playerid] = 0; //碰碰车
    //PlayerInfo[playerid][CheckYesNo] = false;
    PlayerInfo[playerid][LoginAttempts] = 1;
    //PlayerInfo[playerid][AntiRaceTP] = 0;
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
            if(strcmp(OtherIP, OwnIP) == 0) { //2020.2.8新增防止NPC被误T  && !IsPlayerNPC(i)
                a++;
                if(a >= 2) {
                    return FuckAnitCheat(i, "多号未登录", 997);
                }
            }
        }
    }


    new query[103];
	mysql_format(g_Sql, query, sizeof query, "SELECT * FROM `users` WHERE `Name` = '%e' LIMIT 1", GetName(playerid));
	mysql_tquery(g_Sql, query, "OnPlayerDataLoaded", "dd", playerid, g_MysqlRaceCheck[playerid]);

    // printf("[玩家]%s(%d) 进入了服务器 ", GetName(playerid), playerid);
    // if(AccountCheck(GetName(playerid))) { //如果账号存在那就获取他的salt值用来散列算法
    //     new msg[128], DBResult:uf;
    //     // format(msg, sizeof(msg), "SELECT `ID`,`Salt` FROM `Users` where `Name` = '%e'", GetName(playerid));
    //     format(msg, sizeof(msg), "SELECT `Salt` FROM `Users` where `Name` = '%e'", GetName(playerid));
    //     uf = db_query(user, msg);
    //     db_get_field_assoc(uf, "Salt", PlayerInfo[playerid][Salt], 11); //原本是11
    //     db_free_result(uf);
    // } else { //如果这个账号从来没注册过的话是不能带脏字和{}的
    //     if(strfind(GetName(playerid), "{", true) != -1 || strfind(GetName(playerid), "}", true) != -1) {
    //         SendClientMessage(playerid, Color_White, "[系统]不支持用户名中带有{}");
    //         DelayedKick(playerid);
    //         return 1;
    //     }
    //     new placeholder;
    //     for (new i = 0; i < sizeof InvalidWords; i++) //屏蔽词自动变*
    //     {
    //         placeholder = strfind(GetName(playerid), InvalidWords[i], true);
    //         if(placeholder != -1) {
    //             SendClientMessage(playerid, Color_White, "[系统]用户名带有禁止使用的词汇");
    //             DelayedKick(playerid);
    //             return 1;
    //         }
    //     }
    // }
    SCM(playerid, Color_White, "本服修改自5F开源，Prace开源 致敬开源Prace，制作者：[Ghost]Rui ushio_p [Ghost]Dylan");
    SCM(playerid, Color_White, "致敬自由居民区开源,制作者:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)");
    SCM(playerid, Color_White, "特别鸣谢 ryddawn 技术及OBJ指导；[Fire]KiVen JoshenKM");
    SCM(playerid, Color_White, "本服需要安装中文补丁才能正常显示部分信息，如果没有中文补丁会显示异常");
    SCM(playerid, Color_White, "汉化中文补丁请于RST团队主群或QQ群680977910下载");
    SCM(playerid, Color_White, "指令大全请参考https://yucarl77.coding.me");
    SCM(playerid, Color_White, "加载中...");
    return 1;
}


public OnPlayerDisconnect(playerid, reason) //玩家离开服务器 掉线 退出服务器
{
    if(IsPlayerNPC(playerid)) return 1;
	g_MysqlRaceCheck[playerid]++;

    UpdatePlayerData(playerid, reason);

    if (cache_is_valid(PlayerInfo[playerid][Cache_ID]))
	{
		cache_delete(PlayerInfo[playerid][Cache_ID]);
		PlayerInfo[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
	}
	
    if (PlayerInfo[playerid][LoginTimer])
	{
		KillTimer(PlayerInfo[playerid][LoginTimer]);
		PlayerInfo[playerid][LoginTimer] = -1;
	}
    
	PlayerInfo[playerid][Login] = false;
    return 1;
}

public OnPlayerSpawn(playerid) //当玩家出生时
{
    if(IsPlayerNPC(playerid)) { //如果玩家是NPC的话
        InitializationNpcs(playerid); //初始化NPC
        return 1;
    }
    SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);
    if(IsPlayerDeathMatch(playerid)) {
        DeathMatch_OnPlayerSpawn(playerid);
        return 1;
    }
    SpawnAttire(playerid); //玩家装扮
    if(CreateCamera[playerid][CreateStatus] != 0) return 1;
    if(pRaceing[playerid] != 1) {
        // SetPlayerVirtualWorld(playerid, 0);
        SetPlayerHealth(playerid, 1000000);
        SetPlayerPos_Birth(playerid);
        // SetPlayerPos(playerid, 1958.835693, 1343.151123, 15.374607);
        // SetPlayerFacingAngle(playerid, 269.142425);
        // SetCameraBehindPlayer(playerid);
        // new Float:X, Float:Y, Float:Z;
        // GetPlayerPos(playerid, X, Y, Z);
        // NoDieTime[playerid] = CreateDynamic3DTextLabel("无敌时间中...\n", 0xFF0000FF, X, Y, Z, 40.0, playerid);
        // // Attach3DTextLabelToPlayer(NoDieTime[playerid], playerid, 0.0, 0.0, 0.7);
        // SetTimerEx("CheckAso", 3000, 0, "i", playerid); //复活五秒无敌
        if(GetPlayerScore(playerid) < 120) {
            SendClientMessage(playerid, Color_White, "[系统]检测到您游戏时长未满120分钟，自动打开帮助提示");
            AntiCommand[playerid] = 0;
            CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/help");
            // OnPlayerCommandText(playerid, "/help");
        }
    } else if(p_PPC[playerid]) { //碰碰车的话
        PPC_Veh(playerid);
    } else { //赛车时重生后
        // new raid = RaceHouse[GameRace[playerid][rgameid]][rraceid];
        // new trcp[racecptype];
        // if(GameRace[playerid][rgamecp] - 1 <= 0) Race_GetCp(raid, 1, trcp); //如果是第一个点的话就重生到第一个点，不然会是负数
        // else Race_GetCp(raid, GameRace[playerid][rgamecp] - 1, trcp);
        // 2020.3.17 注释 好像冗余了 

        //SetTimerEx("", 1000, 0, "i", playerid);
        PlayerInfo[playerid][lastVehSpeed] = 0;
        ReSpawnRaceVehicle(playerid); //2020.1.12改，提升重生效率
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    if(p_PPC[playerid] && IsPlayerInAnyVehicle(playerid)) DestroyVehicle(p_ppcCar[playerid]);
    if(pRaceing[playerid]) { //如果玩家在赛车中死亡则进行复位s
        PlayerInfo[playerid][lastVehSpeed] = 0;
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~RESPAWNING", 3000, 3); //右下角提示
        // TextDrawShowForPlayer(playerid, ReSpawningText[playerid]);
    } else {
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~r~Wasted", 3000, 3); //右下角提示
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
		SCM(playerid,Color_Red,"[系统] 请文明用语,遵守游戏规则!");
        return 0;
    }*/
    if(PlayerInfo[playerid][Login] == false) {
        SCM(playerid, Color_Red, "[系统] 你还未登录!");
        return 0;
    }
    if(PlayerInfo[playerid][JailSeconds] > 0) {
        SCM(playerid, Color_Red, "[狱警]:现在在监狱中请保持冷静,以后不要再作死了!. ");
        return 0;
    }
    if(AntiCommand[playerid] == 1) {
        SCM(playerid, Color_Red, "[系统]:你发言的速度太快了!");
        return 0;
    }
    new placeholder;
    for (new i = 0; i < sizeof InvalidWords; i++) //屏蔽词自动变*
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
            SendClientMessage(playerid, Color_Team, "[团队]您未在任何一个团队中");
            return 0;
        }
        if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
            format(ChatText, sizeof(ChatText), "[团队]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        } else {
            format(ChatText, sizeof(ChatText), "[团队]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        }
        team_SCM(ChatText, PlayerInfo[playerid][Team]);
        return 0;
    }
    if(GetPlayerVirtualWorld(playerid) == 0) {
        if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
            if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
                format(ChatText, sizeof(ChatText), "[世界]%s{%06x}%s(%d):{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            } else {
                format(ChatText, sizeof(ChatText), "[世界]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            }
        } else {
            if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
                format(ChatText, sizeof(ChatText), "[世界]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            } else {
                format(ChatText, sizeof(ChatText), "[世界]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
            }
        }
        SCMALL(Color_White, ChatText); //GetPlayerColor(playerid)
    } else {
        if(text[0] == '!') //在小世界发大世界语言 加!
        {
            if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
                if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
                    format(ChatText, sizeof(ChatText), "[世界]%s{%06x}%s(%d):{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "[世界]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            } else {
                if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
                    format(ChatText, sizeof(ChatText), "[世界]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "[世界]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            }
            SCMALL(Color_White, ChatText);
        } else {
            if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
                if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[频道-%d]%s{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[频道-%d]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                }
            } else {
                if(!strcmp(PlayerInfo[playerid][Designation], "null", false)) {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[频道-%d]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
                } else {
                    format(ChatText, sizeof(ChatText), "{FFB6C1}[频道-%d]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerVirtualWorld(playerid), GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
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
    new removecolor = strfind(ChatText, "{", true); //自动屏蔽颜色输出 节省日志空间 By YuCarl77
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

public OnPlayerCommandReceived(const playerid, const cmdtext[]) //在执行commandtext之前执行 配合i-zcmd
{
    if(PlayerInfo[playerid][Login] == false) {
        SCM(playerid, Color_Red, "[系统]:你还没有登录呀");
        return 0;
    }
    if(PlayerInfo[playerid][JailSeconds] > 0) {
        SCM(playerid, Color_Red, "[系统]:在监狱中禁止使用命令");
        return 0;
    }
    //if(TpCheck[playerid] == 1) return 1;
    if(AntiCommand[playerid] == 1) {
        SCM(playerid, Color_Red, "[系统]:你输入指令的速度太快了!");
        return 0;
    }
    if(p_PPC[playerid] && strcmp(cmdtext, "/ppc", true)) {
        SCM(playerid, Color_White, "[系统]:你在碰碰车中只允许使用/ppc");
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
            SCM(playerid, 0x99FFFFAA, "[pm] 请使用:/pm ID 要说的话！"); //PM错误信息
            return 0;
        }
        new id = strval(Message);
        gMessage = strrest(cmdtext, idx);
        if(!strlen(gMessage)) {
            SCM(playerid, 0x99FFFFAA, "[pm]请使用:/pm ID 要说的话！"); //PM错误信息
            return 0;
        }
        if(!IsPlayerConnected(id) || IsPlayerNPC(id)) {
            SCM(playerid, 0x99FFFFAA, "[pm]/pm :错误玩家ID！"); //错误信息
            return 0;
        }
        if(playerid == id) {
            SCM(playerid, 0x99FFFFAA, "[pm] 你不能PM你自己");
            return 0;
        }
        format(Message, sizeof(Message), "[pm] 密语给 %s(%d):%s", GetName(id), id, gMessage);
        SCM(playerid, 0x99FFFFAA, Message);
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Sent~w~.", 3000, 3); //当A玩家PM给B玩家的时候 A玩家会显示这个
        format(Message, sizeof(Message), "[pm] 密语来自 %s(%d):%s", GetName(playerid), playerid, gMessage);
        SCM(id, 0x99FFFFAA, Message);
        GameTextForPlayer(id, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Recieved~w~.", 3000, 3); //当B玩家收到A玩家的PM的时候 B玩家会显示这个
        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
        PlayerPlaySound(id, 1057, 0.0, 0.0, 0.0);
        AntiCommand[playerid] = 1; //这个不加pm就发电报了
        return 0;
    }
    if(IsPlayerDeathMatch(playerid) && strcmp(cmdtext, "/dm leave", true) && strcmp(cmdtext, "/kill", true) && strcmp(cmdtext, "/k", true)) {
        SCM(playerid, Color_White, "[DM]竞技中只能通过/dm leave离开");
        return 0;
    }
    if(pRaceing[playerid] == 1 && strcmp("/c", cmd, true) == 0) {
        //如果CP点是第一个点的话允许换车
        if(GameRace[playerid][rgamecp] == 1) {
            cmd_c(playerid, strtok(cmdtext, idx));
            return 0;
        } else {
            SCM(playerid, Color_Red, "[赛车] 您的比赛已开始,不允许刷车!");
            return 0;
        }
    }
    if(pRaceing[playerid] == 1 && strcmp(cmdtext, "/r l", true) != 0 && strcmp(cmdtext, "/r leave", true) != 0 && strcmp(cmdtext, "/kill", true) != 0 && strcmp(cmdtext, "/r s", true) != 0) {
        SCM(playerid, Color_Red, "[赛车] 你正在赛道中只允许使用私聊,除非/r l离开赛道");
        return 0;
    }
    AntiCommand[playerid] = 1;
    return 1;
}

public OnPlayerCommandPerformed(const playerid, const cmdtext[], const success) // 在执行commandtext之后执行 success为执行成功 也就是1 失败就是0
{
    if(!success) {
        if(cmdtext[0] == '/' && cmdtext[1] == '/' && cmdtext[2]) {
            new tmp[128], str[128];
            format(tmp, 128, "%s", cmdtext);
            strdel(tmp, 0, 2);
            format(tmp, 128, "%s", tmp);
            new id = make_findgo(tmp);
            if(id == -1) return SCM(playerid, TransferColor, "[传送] 你所输入的传送点不存在!");
            format(str, sizeof(str), "[传送] 你传送到了'//%s'", vmake[id][mname]);
            SCM(playerid, TransferColor, str);
            if(vmake[id][mz] >= 150.0) DynUpdateStart(playerid); //2020.3.21新增
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
            if(id == -1) return SCM(playerid, Color_White, "[系统]:没有这个命令! , 可用命令尽在/help");
            format(str, sizeof(str), "{33CCCC}%s(%d) {82D900}传送至{00FF99} %s {FF0066}/%s {82D900}", GetName(playerid), playerid, vsysmake[id][tdescribe], vsysmake[id][mname]);
            SCMALL(TransferColor, str);
            if(vsysmake[id][mz] >= 150.0) DynUpdateStart(playerid); //2020.3.21新增
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
    format(tmp, sizeof(tmp), "[指令]%s(%d):%s", GetName(playerid), playerid, cmdtext);
    PlayerCommandRecord(tmp);
    return 1;
}

//放在DM里了
// public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
//     DeathMatch_OnPlayerWeaponShot(playerid, hittype, hitid);
//     return 1;
// }
//命令格式 CMD:命令(playerid,params[]) 一般为了更容易迁移直接把params写成cmdtext
// {
//     请注意，params[]永远不会为空。如果播放器未为命令提供任何参数，params[0]则将为'\1'。使用包含isnull(string[])随附的宏来检查无效性。
// iZCMD with sscanf is an efficient way to process commands
//  if(sscanf(params, "is[字符串长度]", skinid,str))
//     return 1;
// }
// CMD:pm(const playerid, const cmdtext[]) { //PM私聊玩家 放在这是为了绕开PRace的检测 允许在赛车时pm
//     new Message[128],gMessage[128],idx;
//     Message = strtok(cmdtext, idx);
//     if(!strlen(Message) || strlen(Message) > 5) {
//         SCM(playerid, 0x99FFFFAA, "[pm] 请使用:/pm ID 要说的话！"); //PM错误信息
//         return 0;
//     }
//     new id = strval(Message);
//     gMessage = strrest(cmdtext, idx);
//     if(!strlen(gMessage)) {
//         SCM(playerid, 0x99FFFFAA, "[pm]请使用:/pm ID 要说的话！"); //PM错误信息
//         return 0;
//     }
//     if(!IsPlayerConnected(id)) {
//         SCM(playerid, 0x99FFFFAA, "[pm]/pm :错误玩家ID！"); //错误信息
//         return 0;
//     }
//     if(playerid == id) {
//         SCM(playerid, 0x99FFFFAA, "[pm] 你不能PM你自己");
//         return 0;
//     }
//     format(Message, sizeof(Message), "[pm] 密语给 %s(%d):%s", GetName(id), id, gMessage);
//     SCM(playerid, 0x99FFFFAA, Message);
//     GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Sent~w~.", 3000, 3); //当A玩家PM给B玩家的时候 A玩家会显示这个
//     format(Message, sizeof(Message), "[pm] 密语来自 %s(%d):%s", GetName(playerid), playerid, gMessage);
//     SCM(id, 0x99FFFFAA, Message);
//     GameTextForPlayer(id, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Private message ~r~Recieved~w~.", 3000, 3); //当B玩家收到A玩家的PM的时候 B玩家会显示这个
//     PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
//     PlayerPlaySound(id, 1057, 0.0, 0.0, 0.0);
//     AntiCommand[playerid] = 1; //这个不加pm就发电报了
//     return 1;
// }
CMD:chat(const playerid, const cmdtext[]) { //小世界等其他地方使用大世界说话 前面加个!同理
    new ChatText[144], text[128];
    if(sscanf(cmdtext, "s[128]", text)) return SendClientMessage(playerid, Color_White, "[系统]请在后面加上想说的话,送达大世界");
    if(!strcmp(PlayerInfo[playerid][Team], "null", true)) {
        if(!isnull(PlayerInfo[playerid][Designation])) {
            format(ChatText, sizeof(ChatText), "[世界]%s{%06x}%s(%d):{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        } else {
            format(ChatText, sizeof(ChatText), "[世界]{%06x}%s(%d):{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        }
    } else {
        if(!isnull(PlayerInfo[playerid][Designation])) {
            format(ChatText, sizeof(ChatText), "[世界]%s{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", PlayerInfo[playerid][Designation], GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        } else {
            format(ChatText, sizeof(ChatText), "[世界]{%06x}%s(%d) {FFBA51}[V]:{FFFFFF} %s         %s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text, PlayerInfo[playerid][Tail]);
        }
    }
    SCMALL(Color_White, ChatText);
    PlayerTextRecord(ChatText);
    return 1;
}
CMD:help(const playerid, const cmdtext[]) {
    Dialog_Show(playerid, HelpSystem, DIALOG_STYLE_LIST, "帮助系统", "声音篇\n赛车系统\n个性化设置\n日常操作\n载具相关\n世界操作\n观看玩家\n坐标/传送\n房产系统\n家具系统\n装扮系统\n广告牌系统\n管理员指令大全\n爱车系统\n团队系统\n相机系统", "确定", "取消");
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
        SendClientMessage(playerid, Color_White, "[系统]你关闭了速度表");
    } else {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawShow(playerid, velo[playerid][a]);
        }
        PlayerInfo[playerid][speedoMeter] = 1;
        SendClientMessage(playerid, Color_White, "[系统]你开启了速度表");
    }
    return 1;
}
CMD:cmds(const playerid, const cmdtext[]) {
    return cmd_help(playerid, cmdtext);
}
CMD:wdch(const playerid, const params[]) {
    new string[128];
    if(!isnull(PlayerInfo[playerid][Designation])) format(string, sizeof(string), "{FFFFFF}您现在的称号是[%s{FFFFFF}]\n更换一次称号需要3000金币\n输入null清除称号\n颜色请使用{}自行填充", PlayerInfo[playerid][Designation]);
    else format(string, sizeof(string), "您目前暂无称号\n设置一次称号需要3000金币");
    Dialog_Show(playerid, Dialog_Designation, DIALOG_STYLE_INPUT, "我的称号", string, "确定", "取消");
    return 1;
}
CMD:motto(const playerid, const params[]) {
    new string[128];
    if(!isnull(PlayerInfo[playerid][Tail])) format(string, sizeof(string), "{FFFFFF}您现在的小尾巴是[%s{FFFFFF}]\n更换一次小尾巴需要3000金币\n输入null清除小尾巴\n颜色请使用{}自行填充", PlayerInfo[playerid][Tail]);
    else format(string, sizeof(string), "您目前暂无小尾巴\n设置一次称号需要3000金币");
    Dialog_Show(playerid, Dialog_Tail, DIALOG_STYLE_INPUT, "我的小尾巴", string, "确定", "取消");
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
        format(msg, sizeof msg, "[系统*]%s(%d) 进入了碰碰车 /ppc", GetName(playerid), playerid);
    } else {
        p_PPC[playerid] = 0;
        OnPlayerSpawn(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        format(msg, sizeof msg, "[系统*]%s(%d) 离开了碰碰车", GetName(playerid), playerid);
        if(PlayerInfo[playerid][NoCrash]) DisableRemoteVehicleCollisions(playerid, true);
    }
    SendClientMessageToAll(Color_White, msg);
    return 1;
}
CMD:anim(const playerid, const cmdtext[]) { //动作脚本
    new tmp[128], idx;
    tmp = strtok(cmdtext, idx);
    if(isnull(tmp)) {
        new string[227];
        format(string, sizeof(string), "/anim [ID] 按F清除动作\n1.尿尿 2.蹲下抱头 3.躺下1 4.坐下 5.躺下2 6.躺下3\n7.躺下4 8.躺下修车 9.靠墙1 10.靠墙2 11.抽烟\n12.未知13.跳舞1 14.跳舞2 15.跳舞3 16.跳舞4 \n17.打太极 18.坐下19.投降 20.坚持(拿枪/指向) 21.假死");
        Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "动作帮助", string, "OK", "");
        return 1;
    }
    new id = strval(tmp);
    ClearAnimations(playerid); //清除原先动作
    SetPlayerSpecialAction(playerid, 0); //清除特殊动作包括飞行器？
    Action_Play(playerid, id);
    return 1;
}
CMD:mynetstats(const playerid, const cmdtext[]) {
    new stats[256];
    GetPlayerNetworkStats(playerid, stats, sizeof(stats)); // get your own networkstats
    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "我的 当前网络状态", stats, "Okay", "");
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
    //2020.1.12 修复soundstop无法停止歌曲
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
    return 1;
}
CMD:moveme(const playerid, const cmdtext[]) {
    SetPlayerCameraPos(playerid, 0, 0, 0);
    SetPlayerCameraLookAt(playerid, 0, 0, 0);
    TogglePlayerSpectating(playerid, true);
    InterpolateCameraPos(playerid, 2488.533, -1675.285, 17, 1000.0, 1000.0, 40.0, 30000, CAMERA_MOVE);
    SCM(playerid, Color_White, "测试镜头1");
    InterpolateCameraLookAt(playerid, 2488.533, -1675.285, 17, 1000.0, 1000.0, 40.0, 30000, CAMERA_MOVE);
    SCM(playerid, Color_White, "测试镜头2");
    //Move the player's camera from point A to B in 10000 milliseconds (10 seconds).
    return 1;
}
CMD:kill(const playerid, const cmdtext[]) {
    new Float:Health;
    GetPlayerHealth(playerid, Health);
    if(!Health) return SendClientMessage(playerid, Color_White, "[系统]生命值为空,好像出错了,请等待重生或下车尝试");
    if(PlayerInfo[playerid][tvzt]) { //如果玩家处于TV状态 必须让他先退出TV再自杀 不然会出BUG
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
CMD:s(const playerid, const cmdtext[]) { //保存要传送到的坐标
    GetPlayerPos(playerid, PlayerInfo[playerid][SavePos][0], PlayerInfo[playerid][SavePos][1], PlayerInfo[playerid][SavePos][2]);
    PlayerInfo[playerid][SaveInterior] = GetPlayerInterior(playerid);
    splp[playerid] = 1;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), PlayerInfo[playerid][SavePos][3]);
    else GetPlayerFacingAngle(playerid, PlayerInfo[playerid][SavePos][3]);
    SCM(playerid, 0xFFFFFFAA, "[保存坐标]当前坐标已保存, 输入/l返回该坐标");
    return 1;
}
CMD:sp(const playerid, const cmdtext[]) return cmd_s(playerid, cmdtext); //保存要传送到的坐标
CMD:l(const playerid, const cmdtext[]) { //传送到保存的坐标
    if(splp[playerid] != 1) return SCM(playerid, 0xFFFF00AA, "[传送坐标]请先使用/s进行保存坐标"); //当玩家没有保存坐标的话会提示先保存
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

CMD:lp(const playerid, const cmdtext[]) return cmd_l(playerid, cmdtext); //传送到保存的坐标 代码复用
// CMD:stunt(const playerid, const cmdtext[]) {
//     new tmp[8];
//     if(sscanf(cmdtext, "s[8]", tmp)) return SCM(playerid, Color_White, "[系统]/stunt on开启 off关闭特技显示");
//     if(strcmp(tmp, "on", true) == 0) {
//         EnableStuntBonusForPlayer(playerid, 1);
//         SCM(playerid, Color_White, "[系统] 已开启特技奖励显示.");
//     } else {
//         EnableStuntBonusForPlayer(playerid, 0);
//         SCM(playerid, Color_White, "[系统] 已关闭特技奖励显示.");
//     }
//     return 1;
// }

CMD:xiufu(const playerid, const cmdtext[]) { //当玩家卡住的时候，输入这个指令可以修复。这个功能很像
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    SetPlayerPos(playerid, X, Y, Z + 2.8);
    return 1;
}
CMD:skin(const playerid, const cmdtext[]) {
    new skinid;
    if(sscanf(cmdtext, "d", skinid)) return ShowModelSelectionMenu(playerid, skinlist, "Select Skin");
    if(skinid < 0 || skinid > 311) return SCM(playerid, Color_White, "[换肤] 错误的皮肤ID.");
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
    SCM(playerid, Color_White, "[换肤] 换肤成功.");
    return 1;
}
CMD:hf(const playerid, const cmdtext[]) return cmd_skin(playerid, cmdtext);
CMD:sz(const playerid, const cmdtext[]) {
    OnPlayerSettings(playerid);
    return 1;
}
CMD:wdsz(const playerid, const cmdtext[]) return cmd_sz(playerid, cmdtext);
stock OnPlayerSettings(const playerid) {
    Dialog_Show(playerid, PlayerInfoDialog, DIALOG_STYLE_LIST, "我的设置", "安全中心\n我的装扮\n我的家具\n我的爱车\n我的颜色\n我的称号\n我的小尾巴\n个性化设置", "设置", "取消");
    return 1;
}
CMD:fxq(const playerid, const cmdtext[]) { //当玩家输入/fxq的时候 给玩家飞行器   飞行器
    SetPlayerSpecialAction(playerid, 2);
    return 1;
}
CMD:jetpack(const playerid, const cmdtext[]) { //当玩家输入/fxq的时候 给玩家飞行器   飞行器
    SetPlayerSpecialAction(playerid, 2);
    return 1;
}
CMD:weather(const playerid, const cmdtext[]) {
    new tweather;
    if(sscanf(cmdtext, "i", tweather)) return SCM(playerid, Color_LightBlue, "[天气]用法:/tianqi [天气ID] 范围为0~255 其中0~20为正常ID"); //当玩家输入错指令的时候
    if(tweather < 0 || tweather > 256) return SCM(playerid, Color_LightBlue, "[天气]ID错误，范围为0~255"); //当玩家输入错指令的时候
    SetPlayerWeather(playerid, tweather);
    PlayerInfo[playerid][tWeather] = tweather;
    new str[128];
    format(str, sizeof(str), "[天气]你将自己的天气设置为 \"%d\"", tweather);
    SCM(playerid, Color_LightBlue, str); //告诉玩家他把天气设置成多少
    return 1;
}
CMD:tianqi(const playerid, const cmdtext[]) return cmd_weather(playerid, cmdtext);
//更换时间
CMD:time(const playerid, const cmdtext[]) {
    new hour, minute;
    if(sscanf(cmdtext, "ii", hour, minute)) return SCM(playerid, Color_LightBlue, "[时间] /time 时 分 小时为0~24,分为0~59");
    if(hour < 0 || hour > 24) return SCM(playerid, Color_LightBlue, "[时间] /time 时 分 小时为0~24,分为0~59");
    if(minute < 0 || minute > 59) return SCM(playerid, Color_LightBlue, "[时间] /time 时 分 小时为0~24,分为0~59");
    SetPlayerTime(playerid, hour, minute);
    PlayerInfo[playerid][tHour] = hour;
    PlayerInfo[playerid][tMinute] = minute;
    new str[90];
    format(str, sizeof(str), "[时间] 你将自己的时间设置为 %02d:%02d ", hour, minute);
    SCM(playerid, Color_LightBlue, str);
    return 1;
}
CMD:shijian(const playerid, const cmdtext[]) return cmd_time(playerid, cmdtext);
CMD:wuqi(const playerid, const cmdtext[]) return Dialog_Show(playerid, weapons, DIALOG_STYLE_LIST, "武器菜单", "小刀\n棒球杆\n普通手枪\n消音手枪\n沙漠之鹰\n散弹猎枪\n短管散弹枪\n战斗散弹枪\nTec-9式微冲\n伍兹冲锋枪\nMP5微型冲锋枪\nAK-47自动步枪\nM4自动步枪\n小型狙击枪\n瞄准镜型狙击枪\n火箭筒\n热源追踪型火箭筒(RPG)\n喷火器\n手榴弹\n烟雾弹\n啤酒瓶\n遥控定时炸弹\n涂鸦瓶\n灭火器\n超级宇宙纳米无敌激光炮", "刷出", "关闭");
CMD:f(const playerid, const cmdtext[]) {
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, 0xAA3333AA, "[交通工具] 错误：你不在车上");
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, Color_Orange, "[交通工具] 你不是司机!");
    new Float:POS[3];
    new Float:ZAngle;
    GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
    GetVehicleZAngle(GetPlayerVehicleID(playerid), ZAngle);
    SCM(playerid, Color_White, "[交通工具] 你翻正了车辆！");
    SetVehiclePos(GetPlayerVehicleID(playerid), POS[0], POS[1], POS[2] + 2);
    SetVehicleZAngle(GetPlayerVehicleID(playerid), ZAngle);
    return 1;
}
//倒计时
CMD:count(const playerid, const cmdtext[]) return cmd_djs(playerid, cmdtext);
CMD:daojishi(const playerid, const cmdtext[]) return cmd_djs(playerid, cmdtext);
CMD:djs(const playerid, const cmdtext[]) {
    // new count;
    // if(sscanf(cmdtext, "i", count)) count = 6; //如果玩家没有输入秒数 默认6-1 = 5秒
    // if(count > 30) return SendClientMessage(playerid, 0xFFFF00AA, "[倒计时]单次时间不可超过30s");
    // if(CountDown == -1) {
    //     new string[128];
    //     format(string, sizeof(string), "[倒计时] 由 %s (%d) 发起的倒计时开始", GetName(playerid), playerid);
    //     SCMALL(0xFFFF00AA, string);
    //     CountDown = count;
    //     SetTimer("countdown", 1000, 0);
    //     return 1;
    // } 
    // else return SCM(playerid, Color_Red, "[倒计时] 错误:倒计时正在进行");
    if(Count[playerid]) return SCM(playerid, Color_Red, "[倒计时] 错误:倒计时正在进行");
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
//修复一次车
CMD:fix(const playerid, const cmdtext[]) {
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_White, " 错误:你不在车上");
    RepairVehicle(GetPlayerVehicleID(playerid));
    SCM(playerid, Color_Orange, "[交通工具] 你的车已修复");
    return 1;
}
CMD:dcar(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AutoFix]) {
        SCM(playerid, Color_Orange, "[交通工具] 你关闭了车辆无敌，再次输入/dcar开启");
        PlayerInfo[playerid][AutoFix] = 0;
    } else {
        SCM(playerid, Color_Orange, "[交通工具] 你已经开启了车辆无敌，再次输入/dcar关闭");
        PlayerInfo[playerid][AutoFix] = 1;
    }
    return 1;
}
CMD:autofix(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AutoFix]) {
        SCM(playerid, Color_Orange, "[交通工具] 你关闭了车辆无敌，再次输入/dcar开启");
        PlayerInfo[playerid][AutoFix] = 0;
    } else {
        SCM(playerid, Color_Orange, "[交通工具] 你已经开启了车辆无敌，再次输入/dcar关闭");
        PlayerInfo[playerid][AutoFix] = 1;
    }
    return 1;
}
CMD:jls(const playerid, const cmdtext[]) { //当玩家输入/jls的时候 给玩家一个降落伞
    GivePlayerWeapon(playerid, 46, 1);
    SCM(playerid, Color_LightBlue, "你获得了一个降落伞");
    return 1;
}
CMD:c(const playerid, const cmdtext[]) //刷车
{
    if(GetPlayerCreditpoints(playerid) <= 90) return SendClientMessage(playerid, Color_Yellow, "[系统]您的游戏信誉分过低,请健康游戏,将会自动补回");
    // printf("%s", cmdtext);
    new carcmd[128], str[128], idx;
    carcmd = strtok(cmdtext, idx);
    if(!strlen(carcmd)) {
        SCM(playerid, Color_LightBlue, "  ————刷车帮助————");
        SCM(playerid, Color_LightBlue, " /c [车辆ID]来刷车，车辆ID为400-611");
        SCM(playerid, Color_LightBlue, " /cc 颜色代码 颜色代码 更换车辆颜色");
        SCM(playerid, Color_LightBlue, " /f 翻车 /c kick 踢人 /c wode 刷出你刷过的车");
        SCM(playerid, Color_LightBlue, " /c lock 锁车 /c chepai 更换车牌 /c list图片刷车 /c 3d显示/隐藏3D速度表");
        return 1;
    }
    if(strcmp(carcmd, "list", true) == 0) {
        Dialog_Show(playerid, Dialog_SpawnVehicle, DIALOG_STYLE_LIST, "------------刷车列表-------", "\n跑车\n警车\n飞机\n摩托\n船\n越野\n拖车\n货车\n火车及玩具车\n民政车\n其他车", "确定", "取消");
    }
    if(strcmp(carcmd, "kick", true) == 0) {
        if(PlayerInfo[playerid][BuyID] == 0) return SCM(playerid, Color_Orange, "[交通工具]你都没车, 踢什么人?");
        new ren = 0, i;
        for (i = 0; i < MAX_PLAYERS; i++)
            if(IsPlayerConnected(i) && GetPlayerVehicleID(i) == PlayerInfo[playerid][BuyID] && IsPlayerInAnyVehicle(playerid) == 1 && (i > playerid || i < playerid)) {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(i, x, y, z);
                SetPlayerPos(i, x, y, z + 5);
                format(str, sizeof(str), "[交通工具] 该车现在属于 %s , 已经上锁.", GetName(i));
                SCM(i, Color_Orange, str);
                ren = 1;
            }
        if(ren == 0) SCM(playerid, Color_Orange, "[交通工具]你车上没人啊, 别乱踢.");
        return 1;
    }
    if(strcmp(carcmd, "wode", true) == 0) {
        if(PlayerInfo[playerid][BuyID] == 0) {
            SCM(playerid, Color_Orange, "[交通工具]你都没车, 叫什么车?");
        } else {
            new Float:POS[3], Float:Angle;
            if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle);
            else GetPlayerFacingAngle(playerid, Angle);
            GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            if(IsPlayerInAnyVehicle(playerid)) SetPlayerPos(playerid, POS[0], POS[1], POS[2]);
            // for (new i; i < MAX_PLAYERS; i++) //说实话没看懂写这句话到底是图个啥
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
        if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_White, "[交通工具] 错误:你不在车上");
        new tmp[128];
        new color1, color2;
        tmp = strtok(cmdtext, idx);
        if(!strlen(tmp)) return SCM(playerid, Color_White, "[交通工具] 格式:/cc 颜色 颜色");
        color1 = strval(tmp);
        tmp = strtok(cmdtext, idx);
        color2 = strval(tmp);
        if(color1 < 0 || color1 > 255) return SCM(playerid, Color_White, "[交通工具] 错误颜色代码，车辆颜色代码为0-255"); {
            ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
            SCM(playerid, Color_White, "[交通工具] 你更换了车辆的颜色！");
        }
    }
    if(strcmp(carcmd, "lock", true) == 0) //锁车
    {
        if(PlayerInfo[playerid][BuyID] == 0) return SCM(playerid, Color_White, "[交通工具]你都没车, 锁什么车?");
        if(PlayerInfo[playerid][CarLock] == 0) {
            PlayerInfo[playerid][CarLock] = 1;
            SCM(playerid, Color_White, "[交通工具]你的车已上锁");
        } else {
            PlayerInfo[playerid][CarLock] = 0;
            SCM(playerid, Color_White, "[交通工具]你的车已解锁");
        }
        return 1;
    }
    if(strcmp(carcmd, "chepai", true) == 0) //好像用不了。。。。。。
    {
        new tmp[128];
        tmp = strtok(cmdtext, idx);
        if(!strlen(tmp)) return SCM(playerid, Color_White, "[交通工具] 用法:/c chepai 要设置的车牌");
        if(strlen(tmp) > 10) return SCM(playerid, Color_White, "[交通工具] 错误:只能输入5位汉字或10位英文字母");
        if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][BuyID]) return SCM(playerid, Color_White, "[交通工具] 错误:你不在自己的载具上");
        SetVehicleNumberPlate(PlayerInfo[playerid][BuyID], tmp);
        SCM(playerid, Color_White, "[交通工具] 更换车牌成功");
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
    if(strcmp(carcmd, "3d", true) == 0)
    {
        if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_White, "[交通工具]你还没有在任何一辆车上哦");
        if(PlayerInfo[playerid][BuyID] == 0) return SCM(playerid, Color_White, "[交通工具]看起来你好像还没有车");
        new vehicleid = GetPlayerVehicleID(playerid);
        if(CarInfo[vehicleid][ID] != 0)
        {
            if(CarInfo[vehicleid][UsersID] != PlayerInfo[playerid][ID]) return SCM(playerid, Color_White, "[交通工具]这辆爱车不属于你哦");
        }
        else
        {
            if(GetPlayerVehicleID(playerid) != PlayerInfo[playerid][BuyID]) return SCM(playerid, Color_White, "[交通工具] 错误:你不在自己的载具上");
        }
        if(PlayerInfo[playerid][tdEnabled]){
            tdSpeedo_Toggle(playerid,0);
            SCM(playerid, Color_White, "[交通工具]已隐藏3D速度表");
            return 1;
        }
        tdSpeedo_Toggle(playerid,1);
        SCM(playerid, Color_White, "[交通工具]已显示3D速度表");
        return 1;
    }
    new car;
    car = strval(carcmd);
    if(car < 400 || car > 611) return SCM(playerid, Color_White, "[交通工具] 车辆ID必须在{FFFFFF}400-611之间！");
    SpawnVehicle(playerid, car);
    //2020.1.12 16:20变动
    // new Float:x, Float:y, Float:z;
    // GetPlayerPos(playerid, x, y, z);
    // SetPlayerPos(playerid, x, y, z);
    // SetTimerEx("SpawnVehicle", 300, false, "ii", playerid, car);
    return 1;
}
CMD:cc(const playerid, const cmdtext[]) { //更换玩家载具颜色
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_White, "[交通工具] 错误:你不在车上");
    new color1, color2;
    if(sscanf(cmdtext, "ii", color1, color2)) return SCM(playerid, Color_White, "[交通工具] 格式:/cc 颜色 颜色");
    if(color1 < 0 || color1 > 255) return SCM(playerid, Color_White, "[交通工具] 错误颜色代码，车辆颜色代码为0-255"); {
        ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
        SCM(playerid, Color_White, "[交通工具] 你更换了车辆的颜色！");
    }
    return 1;
}

// CMD:ww(const playerid, const cmdtext[]) { //2020.3.9新增
//     // 2020.3.15修复进入专属世界不会把载具放进去的问题
//     if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), playerid + 1);
//     SetPlayerVirtualWorld(playerid, playerid + 1);
//     SCM(playerid, Color_Orange, "[系统] 你进入了你的专属世界.");
//     for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//         if(IsPlayerConnected(i)) {
//             if(PlayerInfo[i][tvid] == playerid && i != playerid) {
//                 SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(playerid));
//                 SetPlayerInterior(i, GetPlayerInterior(playerid));
//                 if(IsPlayerInAnyVehicle(i)) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
//                 else PlayerSpectatePlayer(i, playerid);
//                 SCM(i, Color_Orange, "[TV]:对方切换了世界，自动追踪观看.");
//             }
//         }
//     }
//     return 1;
// }
CMD:pos(const playerid, const cmdtext[]) {
    new Float:x, Float:y, Float:z, str[128];
    GetPlayerPos(playerid, x, y, z);
    format(str, 128, "[系统] 你目前的坐标为 X:%f, Y:%f, Z:%f", x, y, z);
    SCM(playerid, Color_LightBlue, str);
    if(IsPlayerInAnyVehicle(playerid)) {
        new Float:angle = 0.0;
        GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);
        format(str, 128, "[系统] 你的车辆Z角度为%f", angle);
        SCM(playerid, Color_LightBlue, str);
    } else {
        new Float:angle = 0.0;
        GetPlayerFacingAngle(playerid, angle);
        format(str, 128, "[系统] 你的人物朝向角度为%f", angle);
        SCM(playerid, Color_LightBlue, str);
    }
    return 1;
}
CMD:wudi(const playerid, const cmdtext[]) { //玩家无敌
    if(!PlayerInfo[playerid][enableInvincible]) {
        SCM(playerid, 0x0FFF00FF, "[无敌]你开启了无敌状态,再次输入/wudi关闭");
        SetPlayerHealth(playerid, 999999999);
        PlayerInfo[playerid][enableInvincible] = 1;
    } else {
        SCM(playerid, 0x0FFF00FF, "[无敌]你关闭了无敌状态,再次输入/wudi开启");
        SetPlayerHealth(playerid, 100);
        PlayerInfo[playerid][enableInvincible] = 0;
    }
    return 1;
}
CMD:hys(const playerid, const cmdtext[]) { //车辆变色龙
    if(PlayerInfo[playerid][hys]) {
        PlayerInfo[playerid][hys] = false;
        SendClientMessage(playerid, Color_White, "[系统*]关闭车辆自动换色");
    } else {
        PlayerInfo[playerid][hys] = true;
        SendClientMessage(playerid, Color_White, "[系统*]开启车辆自动换色");
    }
    return 1;
}
CMD:infobj(const playerid, const cmdtext[]) { //继承dylan时代兰草乡村的警灯
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, Color_Announcement, "[infobj] 你不在车中!");
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
        SCM(playerid, Color_Announcement, "[infobj] 你给车辆添加了INFOBJ");
    } else {
        dinfobj[playerid] = 0;
        DestroyDynamicObject(jd[playerid]); //销毁警灯
        DestroyDynamicObject(wy[playerid]); //销毁尾翼
        // DestroyObject(jd[playerid]);
        // DestroyObject(wy[playerid]);
        SCM(playerid, Color_Announcement, "[infobj] 你给车辆删去了INFOBJ");
    }
    return 1;
}
CMD:vmake(const playerid, const cmdtext[]) { //玩家创建坐标
    if(PlayerInfo[playerid][Score] < 30) return SCM(playerid, 0xFFFF00FF, "[传送] 为防止玩家过度建立传送点，需时间分达到30分以上才可创建.");
    if(PlayerInfo[playerid][Cash] < 30) return SCM(playerid, 0xFFFF00FF, "[传送] 需要30金币创建一次传送点.");
    new tmp[48];
    // tmp = strtok(cmdtext, idx);
    if(sscanf(cmdtext, "s[48]", tmp)) return SCM(playerid, 0xFFFF00FF, "[传送] 用法:/vmake [传送昵称,不用带'/'] 例如/vmake sf");
    if(strlen(tmp) >= 48) return SCM(playerid, 0xFFFF00FF, "[传送] 名字过长……仅支持48位英文/数字或24位中文");
    if(make_findgo(tmp) != -1) return SCM(playerid, 0xFFFF00FF, "[传送] 该传送点已经存在了.");
    new sb = make_getindex();
    if(sb == -1) return SCM(playerid, 0xFFFF00FF, "[传送] 传送点已达到上限.");
    pVmakePos(playerid, sb, tmp);
    return 1;
}
CMD:vsmake(const playerid, const cmdtext[]) { //管理员创建系统坐标
    if(PlayerInfo[playerid][AdminLevel] < 4) return 0;
    if(PlayerInfo[playerid][Cash] < 1000) return SCM(playerid, 0xFFFF00FF, "[传送] 需要1000金币创建一次系统传送点.");
    new tmp[48], describe[48];
    if(sscanf(cmdtext, "s[48]s[48]", tmp, describe)) return SCM(playerid, 0xFFFF00FF, "[传送] 用法:/vsmake [传送昵称,不用带'/'] [描述<不可带空格,否则会被吞>] 例如/vsmake sf SF机场");
    if(strlen(tmp) >= 48) return SCM(playerid, 0xFFFF00FF, "[传送] 名字过长……仅支持48位英文/数字或32位中文");
    if(strlen(describe) >= 48) return SCM(playerid, 0xFFFF00FF, "[传送] 描述过长……仅支持48位英文/数字或32位中文");
    if(strfind(describe, "{", true) != -1 || strfind(describe, " ", true) != -1 || strfind(describe, "}", true) != -1) {
        SCM(playerid, 0xFFFF00FF, "[传送] 描述中不可带空格等特殊字符");
        return 1;
    }
    if(strfind(describe, "[", true) != -1 || strfind(describe, "]", true) != -1) {
        SCM(playerid, 0xFFFF00FF, "[传送] 描述中不可带空格等特殊字符");
        return 1;
    }
    if(make_Sysfindgo(tmp) != -1) return SCM(playerid, 0xFFFF00FF, "[传送] 该系统传送点已经存在了.");
    new sb = make_sysgetindex();
    if(sb == -1) return SCM(playerid, 0xFFFF00FF, "[传送] 系统传送点已达到上限.");
    pVmakeSysPos(playerid, sb, tmp, describe);
    new str[96];
    format(str, sizeof(str), "[管理员] %s 创建了系统传送点 %s. ", GetName(playerid), tmp);
    SCMToAdmins(Color_AdminMessage, str);
    GivePlayerCash(playerid, -1000);
    return 1;
}

//玩家请求传送tpa
CMD:tpa(const playerid, const cmdtext[]) {
    new id, tmp[128], idx;
    tmp = strtok(cmdtext, idx);
    if(strcmp(tmp, "ban", true) == 0) {
        if(tpaB[playerid] == 3) {
            tpaB[playerid] = 0;
            SCM(playerid, Color_White, "[tp]您已关闭tpa请求，如需开启请再次输入!");
            return 1;
        }
        tpaB[playerid] = 3;
        SCM(playerid, Color_White, "[tp]您已开启tpa请求，如需关闭请再次输入!");
        return 1;
    }
    if(sscanf(cmdtext, "i", id)) return SCM(playerid, 0x99FFFFAA, "[tp] 请使用:/tpa ID");
    if(IsPlayerNPC(id)) return SCM(playerid, 0x99FFFFAA, "[tp] 不能tpa到NPC身边");
    if(PlayerInfo[id][Login] != true) return SCM(playerid, 0x99FFFFAA, "[tp] 对方尚未上线！");
    if(tpaB[id] == 1) return SCM(playerid, 0x99FFFFAA, "[tp] {FFA8FF}对方正在考虑别人的传送请求.");
    if(tpaB[id] == 2) return SCM(playerid, 0x99FFFFAA, "[tp] {FFA8FF}正在请求传送到其他玩家身边.");
    if(tpaB[id] == 3) return SCM(playerid, 0x99FFFFAA, "[tp] {FFA8FF}对方已经屏蔽了传送请求信息.");
    if(playerid == id) return SCM(playerid, Color_White, "[tp] 你不能tpa你自己");
    tpaid[playerid] = id;
    tpaid[id] = playerid;
    tpaB[id] = 1;
    tpaB[playerid] = 2;
    format(tmp, sizeof(tmp), "[tp] 你请求传送到 {FFFFFF}%s(%d)身边,请等待回复.", GetName(id), id);
    SCM(playerid, 0x99FFFFAA, tmp);
    format(tmp, sizeof(tmp), "[tp] 一个TPA请求来自 %s(%d) /ta同意 /td 拒绝", GetName(playerid), playerid);
    SCM(id, 0x99FFFFAA, tmp);
    SCM(id, 0x99FFFFAA, "[tp] 如需{00FF80}开启{FFFF00}/{FF0000}取消{FFFFFF}屏蔽模式,/tpa ban");
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
            return SendClientMessage(playerid, 0x99FFFFAA, "对方处于赛车世界,不能接受TP");
            //2020.2.20新增
        }
        GetPlayerPos(playerid, x, y, z);
        if(IsPlayerInAnyVehicle(tpaid[playerid])) {
            GetVehicleZAngle(GetPlayerVehicleID(tpaid[playerid]), Angle);
        } else GetPlayerFacingAngle(tpaid[playerid], Angle);
        if(IsPlayerInAnyVehicle(tpaid[playerid])) {
            SetVehiclePos(GetPlayerVehicleID(tpaid[playerid]), x + 3, y + 1, z);
            LinkVehicleToInterior(GetPlayerVehicleID(tpaid[playerid]), GetPlayerInterior(tpaid[playerid]));
            SetVehicleZAngle(GetPlayerVehicleID(tpaid[playerid]), Angle);
            SCM(playerid, 0x99FFFFAA, "[tp] 你成功接受了tpa请求");
            SCM(tpaid[playerid], 0x99FFFFAA, "[tp] 你已传送到Ta身边，如果Ta是在小世界，请私聊Ta.");
            tpaB[playerid] = 0;
            tpaB[id] = 0;
            KillTimer(tpatime[playerid]);
            KillTimer(tpatime[id]);
            tpaid[playerid] = -1;
            tpaid[id] = -1;
        } else {
            SetPlayerPos(tpaid[playerid], x + 3, y + 1, z);
            SetPlayerFacingAngle(tpaid[playerid], Angle);
            SCM(playerid, 0x99FFFFAA, "[tp] 你成功接受了tpa请求");
            SCM(tpaid[playerid], 0x99FFFFAA, "[tp] 你已传送到Ta身边，如果Ta是在小世界，请私聊Ta.");
            KillTimer(tpatime[playerid]);
            KillTimer(tpatime[id]);
            tpaB[playerid] = 0;
            tpaB[id] = 0;
            tpaid[playerid] = -1;
            tpaid[id] = -1;
        }
    } else {
        SCM(playerid, 0x99FFFFAA, "[tp] 你当前没有tpa接受请求");
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
        SCM(playerid, Color_Red, "[tp] 你拒绝了对方请求!");
        SCM(tpaid[playerid], Color_Red, "[tp] 对方拒绝了你的请求!");
        KillTimer(tpatime[playerid]);
        KillTimer(tpatime[id]);
    } else {
        SCM(playerid, Color_Red, "[tp] 暂时没有传送请求!");
        KillTimer(tpatime[playerid]);
        KillTimer(tpatime[id]);
        tpaB[playerid] = 0;
        tpaB[id] = 0;
        tpaid[playerid] = -1;
        tpaid[id] = -1;
    }
    return 1;
}
//开启/关闭显示玩家名字
// CMD:name(const playerid, const cmdtext[]) {
//     new tmp[128];
//     if(sscanf(cmdtext, "s[128]", tmp)) return SCM(playerid, Color_White, "[系统]/name on开启 off关闭");
//     if(strcmp(tmp, "off", true) == 0) {
//         for (new i = GetPlayerPoolSize(); i >= 0; i--) 
//         {
//             ShowPlayerNameTagForPlayer(playerid, i, false);
//         }
//         SCM(playerid, Color_White, "[系统] 已隐藏其他玩家名字.");
//         return 1;
//     }
//     if(strcmp(tmp, "on", true) == 0) {
//         // for (new i = GetPlayerPoolSize(); i != -1; --i) {
//         for (new i = GetPlayerPoolSize(); i >= 0; i--) {
//             ShowPlayerNameTagForPlayer(playerid, i, true);
//         }
//         SCM(playerid, Color_White, "[系统] 已显示其他玩家名字.");
//         return 1;
//     }
//     return 1;
// }
//玩家观战系统
CMD:tv(const playerid, const cmdtext[]) {
    new tmp[128];
    if(sscanf(cmdtext, "s[128]", tmp)) {
        SCM(playerid, Color_Orange, "[TV] |____________TV监视器___________|");
        SCM(playerid, Color_Orange, "[TV] |使用:/tv [ID] 监视玩家          |");
        SCM(playerid, Color_Orange, "[TV] |提示:/tv off  关闭监视          |");
        return 1;
    }
    if(strcmp(tmp, "off", true) == 0) {
        if(!PlayerInfo[playerid][tvzt]) return SCM(playerid, Color_Orange, "[TV]:错误！你没有在TV状态下！");
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
            PlayerTextDrawHide(playerid, p_record[PlayerInfo[playerid][tvid]]);
        }
        Race_HideCp(playerid);
        TogglePlayerSpectating(playerid, false);
        SetPlayerVirtualWorld(playerid, 0);
        SCM(playerid, Color_Orange, "[TV] 你关闭了TV.");
        PlayerInfo[playerid][tvzt] = false;
        PlayerInfo[playerid][tvid] = playerid;
        return 1;
    }
    new id = strval(tmp);
    if(id == playerid) return SCM(playerid, Color_Orange, "[TV]:你不能观看你自己!");
    if(!IsPlayerNPC(id) && !IsPlayerConnected(id)) return SCM(playerid, Color_Orange, "[TV]:错误!对方未登录");
    if(PlayerInfo[id][tvzt]) return SCM(playerid, Color_Orange, "[TV]:对方正处于观战状态!");
    for (new a = 0; a <= 21; a++) {
        //TextDrawHideForPlayer(playerid, velo[playerid][a]);//2020.1.12改
        PlayerTextDrawHide(playerid, velo[PlayerInfo[playerid][tvid]][a]);
        // TextDrawHideForPlayer(playerid, velo[playerid][a]); //隐藏玩家自己的速度表 理论上上面那句话也没问题 如果出了问题再取消注释
    }
    if(PlayerInfo[playerid][speedoMeter]) {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawShow(playerid, velo[id][a]); //显示玩家观看对象的速度表
        }
    }
    if(!PlayerInfo[playerid][tvzt]) SCM(playerid, Color_Orange, "[TV] 提示:'/tv off' 关闭电视机");
    PlayerTextDrawHide(playerid, CpTextDraw[PlayerInfo[playerid][tvid]]);
    PlayerTextDrawHide(playerid, Time[PlayerInfo[playerid][tvid]]);
    PlayerTextDrawHide(playerid, Top[PlayerInfo[playerid][tvid]]);
    PlayerTextDrawHide(playerid, p_record[PlayerInfo[playerid][tvid]]);
    if(pRaceing[id]) {
        PlayerTextDrawShow(playerid, CpTextDraw[id]);
        PlayerTextDrawShow(playerid, Time[id]);
        PlayerTextDrawShow(playerid, Top[id]);
        PlayerTextDrawShow(playerid, p_record[id]);
        Race_ShowCp(playerid, GameRace[id][rgameid], GameRace[id][rgamecp]);
    }
    TogglePlayerSpectating(playerid, true);
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
    SetPlayerInterior(playerid, GetPlayerInterior(id));
    PlayerInfo[playerid][tvzt] = true; //设置玩家TV状态为真
    PlayerInfo[playerid][tvid] = id;
    if(IsPlayerInAnyVehicle(id)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
    else PlayerSpectatePlayer(playerid, id);
    return 1;
}



//好像当时参考的是7F的管理员脚本
CMD:adminhelp(const playerid, const cmdtext[]) {
    if(!PlayerInfo[playerid][AdminLevel]) return 0;
    Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员指令大全", "LV1\nLV2\nLV3\nLV4\nLV5\nLV?", "确定", "返回");
    new str[96];
    format(str, sizeof(str), "[管理员] %s 使用了 /AdminHelp. ", GetName(playerid));
    SCMToAdmins(Color_AdminMessage, str);
    return 1;
}
CMD:goto(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new str[128], Float:x, Float:y, Float:z, id;
    if(sscanf(cmdtext, "i", id)) return SCM(playerid, Color_Red, "[系统] 错误玩家ID!");
    if(!PlayerInfo[id][Login]) return SCM(playerid, Color_Red, "[系统] 错误该玩家未登录.");
    format(str, sizeof(str), "[管理员] %s 使用了 /Goto. ", GetName(playerid));
    SCMToAdmins(Color_AdminMessage, str);
    GetPlayerPos(id, x, y, z);
    if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z + 0.35);
    else SetPlayerPos(playerid, x, y, z + 0.35);
    AdminCommandRecord(playerid, "goto", str);
    return 1;
}
CMD:get(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new id, str[128], Float:x, Float:y, Float:z;
    if(sscanf(cmdtext, "i", id)) return SCM(playerid, Color_Red, "[系统] 错误玩家ID!");
    if(IsPlayerConnected(id) == 0) return SCM(playerid, Color_Red, "[系统] 错误玩家ID!");
    if(PlayerInfo[id][Login] == false) return SCM(playerid, Color_Red, "[系统] 错误该玩家未登录.");
    if(pRaceing[id]) return SendClientMessage(playerid, 0x99FFFFAA, "对方处于赛车世界,不能Get");
    format(str, sizeof(str), "[管理员] %s 使用了 Get. ", GetName(playerid));
    SCMToAdmins(Color_AdminMessage, str);
    GetPlayerPos(playerid, x, y, z);
    if(IsPlayerInAnyVehicle(id)) SetVehiclePos(GetPlayerVehicleID(id), x, y, z + 0.35);
    else SetPlayerPos(id, x, y, z + 0.35);
    return 1;
}
CMD:givecash(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 4)) return 0;
    new id, cash, reason[64], str[96];
    if(sscanf(cmdtext, "iis[64]", id, cash, reason)) return SCM(playerid, Color_Red, "[系统] 用法:/giveplayercash [玩家ID] [金钱] [原因]");
    if(PlayerInfo[id][Login] == false) return SCM(playerid, Color_Red, "[系统] 错误该玩家未登录.");
    if(cash < 1 || cash > 2000) return SCM(playerid, Color_Red, "[系统] 金钱数量超过上限.");
    format(str, sizeof(str), "[系统]%s(LV%d) 给了玩家 %s (%d金钱),原因:%s", GetName(playerid), PlayerInfo[playerid][AdminLevel], GetName(id), cash, reason);
    SCMALL(Color_Red, str);
    format(str, sizeof(str), "[管理员] %s 使用了命令 GivePlayerCash. ", GetName(playerid));
    SCMToAdmins(Color_AdminMessage, str);
    AdminCommandRecord(playerid, "GivePlayerCash", reason);
    GivePlayerCash(id, cash);
    return 1;
}
CMD:showname(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 4)) return 0;
    if(NPCNameShow) {
        for (new i = 0; i < sizeof(textid); i++) {
            DestroyDynamic3DTextLabel(textid[i]);
        }
        NPCNameShow = false;
        SendClientMessage(playerid, Color_Green, "[提示:] NPC名称显示已关闭.");
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
        SendClientMessage(playerid, Color_Green, "[提示:] NPC名称显示已开启.");
    }
    return 1;
}
CMD:kick(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new id, reason[64], str[128];
    if(sscanf(cmdtext, "is[64]", id, reason)) return SCM(playerid, Color_Red, "[系统] 用法:/kick [玩家ID] [原因]");
    if(IsPlayerConnected(id) == 0 || IsPlayerNPC(id)) return SCM(playerid, Color_Red, "[系统] 错误玩家ID!或要T出的是NPC");
    // SetTimerEx("KickEx", 200, false, "i", id);
    DelayedKick(id);
    format(str, sizeof(str), "[系统]%s(LV%d) 把 %s 踢出了服务器,原因:%s", GetName(playerid), PlayerInfo[playerid][AdminLevel], GetName(id), reason);
    SCMALL(Color_Red, str);
    format(str, sizeof(str), "[管理员] %s 使用了命令 Kick. ", GetName(playerid));
    SCMToAdmins(Color_AdminMessage, str);
    AdminCommandRecord(playerid, "Kick", reason);
    return 1;
}
CMD:reset(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 5)) return 0;
    new pname[24], pPassWord[16];
    if(sscanf(cmdtext, "s[24]s[64]", pname, pPassWord)) return SCM(playerid, Color_Red, "[系统] 用法:/reset 用户名 密码");
    if(strlen(pPassWord) > 16 || strlen(pPassWord) < 6) return SCM(playerid, Color_Red, "[系统] 密码长度错误,建议6~16位");
    if(strcmp(pname, GetName(playerid), true) == 0) return SCM(playerid, Color_Red, "[系统] 不允许重置自己的账户,如需更改请前往安全设置");
    if(!AccountCheck(pname)) return SCM(playerid, Color_Red, "[系统] 您想重置的用户不存在");
    OnPlayerResetPassword(playerid, pname, pPassWord);
    new str[96];
    format(str, sizeof(str), "[管理员] %s 使用了重置了%s的账户密码. ", GetName(playerid), pname);
    SCMToAdmins(Color_AdminMessage, str);
    AdminCommandRecord(playerid, "resetPassWord", str);
    return 1;
}
CMD:gmx(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 5)) return 0;
    SCMALL(Color_Red, "[系统] 即将刷新服务器，正在保存玩家数据中...");
    SendRconCommand("gmx");
    return 1;
}
CMD:jail(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 1)) return 0;
    new id, reason[64];
    if(sscanf(cmdtext, "is[64]", id, reason)) return SCM(playerid, Color_Red, "[系统] 用法:/jail [玩家ID] [原因]");
    if(IsPlayerConnected(id) == 0) return SCM(playerid, Color_Red, "[系统] 错误玩家ID!");
    if(PlayerInfo[id][JailSeconds] > 0) return SCM(playerid, Color_Red, "[系统] 该玩家已在监狱中!");
    PlayerInfo[id][JailSeconds] = 60;
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    new msg[128];
    mysql_format(g_Sql, msg, sizeof(msg), "UPDATE `users` SET `JailSeconds` = %d WHERE `Name` = '%e'", 60, GetName(id));
    mysql_pquery(g_Sql, msg);
    format(msg, sizeof(msg), "[系统] %s (LV%d)把 %s 关进了监狱,稍后自动放出,原因:%s", GetName(playerid), PlayerInfo[playerid][AdminLevel], GetName(id), reason);
    SCMALL(Color_Red, msg);
    SCM(id, Color_Red, "[系统] 为了不影响其他玩家正常游戏,您以受到管理员惩罚,1分钟后将放出监狱!");
    format(msg, sizeof(msg), "[管理员] %s 使用了命令 Jail. ", GetName(playerid));
    SCMToAdmins(Color_AdminMessage, msg);
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
        SendClientMessage(playerid, Color_White, "[系统]:你关闭了地图模型,再次输入开启");
    } else {
        PlayerInfo[playerid][displayObject] = 1;
        // Streamer_UpdateEx(playerid, 0.0, 0.0, -50000.0);
        // Streamer_UpdateEx(playerid, pX, pY, pZ);
        Streamer_UpdateEx(playerid, 0, 0, -50000);
        Streamer_ToggleItemUpdate(playerid, 0, 1);
        SendClientMessage(playerid, Color_White, "[系统]:你开启了地图模型,再次输入关闭");
    }
    return 1;
}
CMD:giveadmin(const playerid, const cmdtext[]) {
    if(!IsPlayerAdmin(playerid)) return 0;
    new level, name[64];
    if(sscanf(cmdtext, "s[64]i", name, level)) return SCM(playerid, Color_Red, "[系统] 用法:/giveadmin [玩家昵称] [GM等级]");
    if(AccountCheck(name)) {
        new msg[128];
        if(level < 1 || level > 5) return SCM(playerid, Color_Red, "[系统] GM等级有效范围为1-5级");
        mysql_format(g_Sql, msg, sizeof(msg), "UPDATE `users` SET AdminLevel = %d WHERE `Name` = '%e'", level, name);
        mysql_pquery(g_Sql, msg);
        format(msg, sizeof(msg), "[系统] %s 升级 %s 为 GM{FFFF00}%d级", GetName(playerid), name, level);
        for (new i = GetPlayerPoolSize(); i >= 0; i--) { //2020.2.9修复 //2020.2.27再次更新
            if(strcmp(GetName(i), name, true) == 0) {
                PlayerInfo[i][AdminLevel] = level;
                break;
            }
        }
        // PlayerInfo[playerid][AdminLevel] = level; //2020.2.9发现问题 不应该是playerid 问题是也没给id啊
        SCMALL(Color_Red, msg);
        AdminCommandRecord(playerid, "GiveAdmin", "给GM");
        return 1;
    } else {
        SCM(playerid, Color_Red, "[系统] 该玩家昵称不存在!");
    }
    return 1;
}
CMD:unadmin(const playerid, const cmdtext[]) {
    if(!IsPlayerAdmin(playerid)) return 0;
    new tmp[128];
    if(sscanf(cmdtext, "s[128]", tmp)) return SCM(playerid, Color_Red, "[系统] 用法:/unadmin [玩家昵称]");
    if(AccountCheck(tmp)) {
        new msg[256];
        mysql_format(g_Sql, msg, sizeof(msg), "UPDATE `users` SET `AdminLevel` = 0 where `Name` = '%e'", tmp);
        mysql_pquery(g_Sql, msg);
        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
            if(strcmp(GetName(i), tmp, true) == 0) PlayerInfo[i][AdminLevel] = 0;
            break;
        }
        format(msg, sizeof(msg), "[系统] %s 取消了 %s的GM", GetName(playerid), tmp);
        SCMALL(Color_Red, msg);
        AdminCommandRecord(playerid, "UnGiveAdmin", "取消GM");
    } else {
        SCM(playerid, Color_Red, "[系统] 该玩家昵称不存在!");
    }
    return 1;
}
CMD:ban(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 2)) return 0;
    Dialog_Show(playerid, Ban_Choose, DIALOG_STYLE_INPUT, "Ban", "{FFFFFF}请输入:{33CCCC}要封杀的玩家{FF0000}名字", "确定", "取消");
    return 1;
}
CMD:unban(const playerid, const cmdtext[]) {
    if(!(PlayerInfo[playerid][AdminLevel] >= 2)) return 0;
    Dialog_Show(playerid, Ban_Choose + 3, DIALOG_STYLE_INPUT, "Ban", "{FFFFFF}请输入:{33CCCC}要解封的玩家{FF0000}名字", "确定", "取消");
    return 1;
}

//家具系统
CMD:creategoods(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AdminLevel] < 4) return SendClientMessage(playerid, Color_White, "[家具系统]:你的管理员权限等级不足.");
    //Create String to store in local values
    new modelid, seprice, Float:x, Float:y, Float:z;
    if(sscanf(cmdtext, "ii", modelid, seprice)) return SendClientMessage(playerid, Color_White, "[家具系统]:{FF0000}/creategoods{37FF00} [objid] [价格]");
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
    format(tester, sizeof(tester), "[家具系统]你创建了服务器[ID %d ]的家具 [Objid %d][价格 %d]", GID, GOODS[GID][GoodObjid], GOODS[GID][GoodPrize]);
    SendClientMessage(playerid, Color_Furniture, tester);
    //Save it
    SaveGoods(GID);
    return 1;
}
CMD:delgoods(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AdminLevel] < 4) return SendClientMessage(playerid, Color_White, "[家具系统]:你的管理员权限等级不足.");
    new deid;
    if(sscanf(cmdtext, "i", deid)) return SendClientMessage(playerid, Color_White, "[家具]{FF0000}/delgoods{37FF00} [ID]");
    if(deid < 0) return SendClientMessage(playerid, Color_White, "[家具]{FF0000} ID不可为负数!");
    if(GOODS[deid][GoodTaken] != 1) return SendClientMessage(playerid, Color_White, "[家具]错误的*家具*ID");
    new tester[125];
    format(tester, sizeof(tester), "[家具]你已经删除了家具ID[%d] OBJID[%d]", deid, GOODS[deid][GoodObjid]);
    DelGoods(deid); //2020.2.11修复 原作者语句顺序的问题 导致OBJID一直是0 因为删除后OBJID那个数组就被清0了
    SendClientMessage(playerid, Color_Furniture, tester);
    return 1;
}
CMD:gogoods(const playerid, const cmdtext[]) {
    // new gid, tmp[128]; //create string to store values
    new gid;
    if(sscanf(cmdtext, "i", gid)) return SendClientMessage(playerid, Color_White, "[家具]{FF0000}/gogoods{37FF00} [ID]");
    if(GOODS[gid][GoodTaken] != 1) return SendClientMessage(playerid, Color_White, "[家具]错误！家具ID不存在！");
    // gid = strval(tmp);
    // GOODS[gid][OrderId] = strval(tmp); //2020.2.9?0?4?0?7?0?0?0?7gogoods?0?8?ě?0?4?ě
    //create float
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(GOODS[gid][OrderId], x, y, z);
    SetPlayerPos(playerid, x, y, z);
    SetPlayerVirtualWorld(playerid, GOODS[gid][WID]);
    new tester[125];
    format(tester, sizeof(tester), "[家具]你已经传送到了家具ID %d  %d", gid, GOODS[gid][OrderId]);
    SendClientMessage(playerid, Color_Furniture, tester);
    return 1;
}
CMD:resetgoods(const playerid, const cmdtext[]) {
    if(PlayerInfo[playerid][AdminLevel] < 4) return SendClientMessage(playerid, Color_White, "[家具系统]:你的管理员权限等级不足.");
    new count = 0;
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if(GOODS_STATUS[i] == true) {
            ResetGoods(playerid, i);
            count++;
        }
    }
    new tester[125];
    format(tester, sizeof(tester), "[家具]所有家具 %d 都被重置了", count);
    SendClientMessage(playerid, Color_Furniture, tester);
    return 1;
}
CMD:mygoods(const playerid, const cmdtext[]) {
    new GOODS_LIST[1000], title[128], tocount, youcount;
    strcat(GOODS_LIST, "{80FF80}[物品ID]\t[物品名称]\t[物品价格]\n");
    for (new i = 0; i < MAX_GOODS; i++) {
        if(GOODS[i][GoodTaken] == 1) {
            tocount++;
            if(!strcmp(GOODS[i][GoodOwner], GetName(playerid), true)) {
                new var [125];
                youcount++;
                //format(GOODS_LIST,sizeof(GOODS_LIST),"\n{80FF80}%s			%d\n",GOODS[i][GoodName],i);
                format(var, sizeof(var), "ID: %d\t{80FF80}%s\t%d\n", i, GOODS[i][GoodName], GOODS[i][GoodPrize]);
                strcat(GOODS_LIST,var);
            }
        }
    }
    format(title, sizeof(title), "{80FFFF}我的物品 - {80FF80}%d{80FFFF}个 服务器共{80FF80}%d{80FFFF}个 占{80FF80}%d%", youcount, tocount, floatround(youcount * 100.0 / tocount));
    Dialog_Show(playerid, GODIOG_LIST, DIALOG_STYLE_TABLIST_HEADERS, title, GOODS_LIST, "编辑", "关闭");
    return 1;
}
CMD:wdjj(const playerid, const cmdtext[]) return cmd_mygoods(playerid, cmdtext);
CMD:resetowner(const playerid, const cmdtext[]) {
    new gid; //create string to store values
    if(sscanf(cmdtext, "i", gid)) return SendClientMessage(playerid, Color_White, "[家具]{FF0000}/resetowner{37FF00} [ID]");
    SellGoodsToSYS(playerid, gid);
    return 1;
}
CMD:goodshelp(const playerid, const cmdtext[]) {
    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_LIST, "{FF80C0}家具{80FF80}帮助", "{C0C0C0}查看我的物品{FF0000}/mygoods或/wdjj\n{C0C0C0}传送物品{FF0000}/gogoods{C0C0C0}\n操作物品请按{FF0000}Y{C0C0C0}键", "关闭", "");
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
    if(GetPlayerCreditpoints(playerid) <= 90) 
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x+3, y+2, z+1.2);
        SendClientMessage(playerid, Color_Yellow, "[系统]您的游戏信誉分过低,请健康游戏,将会自动补回");
        return 1;
    }
    new Float:x, Float:y, Float:z;
    //2020.2.21改用新反作弊 CarTroll 我又改回来了…… 刷车太慢了
    GetVehiclePos(vehicleid, x, y, z);
    if(!IsPlayerInRangeOfPoint(playerid, 25.0, x, y, z) && !IsPlayerNPC(playerid)) {
        for (new i = 0; i < sizeof npcCars; i++) {
            if(vehicleid == npcCars[i]) return 1;
        }
        FuckAnitCheat(playerid, "喷车/吸车/外挂抢车", 3);
        // 2020.2.28发现误封原因 如果在上NPC车的一瞬间NPC切了地方就会被误封 就得判断上的车是不是NPC的 如果不是 那就封
        return 1;
    }

    // if(GetPlayerVehicleID(vehicleid) != PlayerInfo[playerid][BuyID]){
    //     for (new i = GetPlayerPoolSize(); i >= 0; i--) 
    //     {
    //         if(IsPlayerConnected(i) && PlayerInfo[i][CarLock] && PlayerInfo[i][BuyID] == vehicleid && i!=playerid){
    //             SendClientMessage(playerid, Color_White, "[交通工具] 载具已上锁");
    //             RemovePlayerFromVehicle(playerid);
    //         }
    //         return 1;
    //     }
    //     new msg[64];
    //     format(msg, sizeof(msg), "[交通工具]这辆载具不是你的哦，想要拥有这一辆吗？输入/c %d",vehicleid);
    //     return SendClientMessage(playerid, Color_White, msg);
    // }
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid) { //当玩家离开载具且玩家是赛车系统时，则判定为需要重生
    if(pRaceing[playerid]) {
        new Float:pPos[3];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        SetPlayerPos(playerid, pPos[0] + 2, pPos[1] + 1.5, pPos[2] + 0.5);
        return Dialog_Show(playerid, RACE_RESPAWNDIALOG, DIALOG_STYLE_MSGBOX, "重生系统 By YuCarl77", "检测到您在赛车中下车了,是否需要重生?\n如想当乘客请点否.", "是", "否");
    }
    if(p_PPC[playerid]) {
        return SetPlayerHealth(playerid, -1.0);
    }

    //临时放到statechange那边了 可能更可靠一点吧个鬼啊  不能那么写
    // if(pRaceing[playerid])
    // {
    //     ReSpawningText[playerid] = TextDrawCreate(307.333374, 127.362937, "重生中...");
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
    //     if(GameRace[playerid][rgamecp] - 1 <= 0) Race_GetCp(raid, 1, trcp);//如果是第一个点的话就重生到第一个点，不然会是负数
    //     else Race_GetCp(raid, GameRace[playerid][rgamecp] - 1, trcp);
    //     ReSpawnRaceVehicle(playerid);//2020.1.12改，提升重生效率
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
                format(str, sizeof(str), "[爱车] 该爱车正在出售中,价格:%d 是否购买?", CarInfo[vehicleid][Value]);
                Dialog_Show(playerid, AC_BUY, DIALOG_STYLE_MSGBOX, "[购买爱车]", str, "是", "否");
                // SCM(playerid,Color_ACColor,str);
            } else {
                if(CarInfo[vehicleid][UsersID] == PlayerInfo[playerid][ID]) {
                    if(PlayerInfo[playerid][tdEnabled]) tdSpeedo_Toggle(playerid, 1);
                    SCM(playerid, Color_ACColor, "[爱车] 欢迎回到你的爱车.");
                    AddVehicleComponent(vehicleid, 1010);
                } else {
                    if(CarInfo[vehicleid][Lock]) {
                        new Float:x, Float:y, Float:z;
                        GetPlayerPos(playerid, x, y, z);
                        SetPlayerPos(playerid, x, y, z);
                        SetVehiclePos(vehicleid, CarInfo[vehicleid][CarX], CarInfo[vehicleid][CarY], CarInfo[vehicleid][CarZ]);
                        SendClientMessage(playerid, Color_ACColor, "[爱车]这辆车已经上锁了");
                        return 1;
                    }
                    new str[128];
                    format(str, sizeof(str), "[爱车] 载具ID:%s(%d) 价格:%d 金币 拥有者:UID %d", VehicleNames[GetVehicleModel(vehicleid) - 400], GetVehicleModel(vehicleid), CarInfo[vehicleid][Value], CarInfo[vehicleid][UsersID]);
                    SCM(playerid, Color_ACColor, str);
                    if(CarInfo[vehicleid][SellValue] != 0) {
                        format(str, sizeof(str), "[爱车] 该载具正在出售中,价格:%d 是否购买？", CarInfo[vehicleid][SellValue]);
                        // SCM(playerid,Color_ACColor,str);
                        Dialog_Show(playerid, AC_BUY, DIALOG_STYLE_MSGBOX, "[购买爱车]", str, "是", "否");
                    }
                }
            }
            return 1;
        }
        if(vehicleid == PlayerInfo[playerid][BuyID]) {
            AddVehicleComponent(vehicleid, 1010);
            if(PlayerInfo[playerid][tdEnabled]) tdSpeedo_Toggle(playerid, 1);
            for (new i = GetPlayerPoolSize(); i >= 0; i--) { //响应TV和本身自己 上车显示 下车隐藏
                if(IsPlayerConnected(i)) {
                    if(PlayerInfo[i][tvid] == playerid) {
                        // for (new a = 0; a < 22; a++) {
                        //     TextDrawShowForPlayer(i, velo[playerid][a]);
                        // }
                        if(i != playerid) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid)); //出问题删这
                    }
                    // 好像是这个引起的崩溃
                    // if(i != playerid) PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
                }
            }
            if(PlayerInfo[playerid][CarLock]) return SendClientMessage(playerid, Color_Green, "[载具]老板欢迎, 你的车已上锁");
        } else {
            for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                if(IsPlayerConnected(i) && vehicleid == PlayerInfo[i][BuyID] && PlayerInfo[i][CarLock]) {
                    new Float:X, Float:Y, Float:Z, tmp[64];
                    GetPlayerPos(playerid, X, Y, Z);
                    SetPlayerPos(playerid, X, Y, Z + 0.5);
                    format(tmp, sizeof(tmp), "[载具]这辆车是%s的并且已经上锁了哦..", GetName(i));
                    SendClientMessage(playerid, Color_Green, tmp);
                    // return 1;
                }
            }
        }
    }
    if(newstate == PLAYER_STATE_ONFOOT) {
        if(PlayerInfo[playerid][tdEnabled]) tdSpeedo_Toggle(playerid, 0);
        // if(pRaceing[playerid]) SetPlayerHealth(playerid, -1.0);//如果在赛道中下车就自杀复位
        for (new i = GetPlayerPoolSize(); i >= 0; i--) { //响应TV和本身自己 上车显示 下车隐藏
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
        format(msg, 128, "[赛车]赛道[%s]检查点:%i/%i", Race[raid][rname], EditRace[playerid][rtestcp], Race[raid][rcps]);
        SendClientMessage(playerid, Color_Race, msg);
        PlayerPlaySound(playerid, 1056, pX, pY, pZ);
        if(EditRace[playerid][rtestcp] == Race[raid][rcps]) {
            format(msg, 128, "[赛车]赛道[%s]已完成", Race[raid][rname]);
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
            if(playerid == RaceHouse[GameRace[playerid][rgameid]][rplayerid]) format(msg, 128, "[赛车] 您是房主,可输入指令/r s开始比赛~");
            else format(msg, 128, "[赛车]请耐心等待比赛开始..");
            SendClientMessage(playerid, Color_Race, msg);
            return 1;
        }
        if(RaceHouse[GameRace[playerid][rgameid]][rstate] == 1) {
            new msg[128];
            format(msg, 128, "[赛车]比赛正在倒计时,请做好准备!");
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
                Race_GetCp(raid, GameRace[playerid][rgamecp] + 1, p2); //没判断是否CP点>=最后一个cp点 不然返回应该是3个0 这样子在最后一个点会被判定为G
                x = floatabs(p1[rcpx] - p2[rcpx]);
                y = floatabs(p1[rcpy] - p2[rcpy]);
                z = floatabs(p2[rcpz] - p2[rcpz]);
                distance = sqrt(x * x + y * y + z * z); //x*x+y*y+z*z
                // if(GameRace[playerid][rgamecp]+1==Race[raid][rcps]) distance=GetPlayerDistanceFromPoint(playerid,p2[rcpx],p2[rcpy],p2[rcpz]);
                if(GetSpeed(playerid) < 0.01 && distance > 20.0) {
                    new ss = Race_GetCp_Scripts(p1[rcpid]); //返回当前CP点有几个高级CP函数，如果是0的话 就直接封; 如果p2还封的话就是p1了
                    if(!ss) {
                        return FuckAnitCheat(playerid, "赛车红点传送", 0); //反作弊m0d等红点传送 2020.2.20升级 防止误封
                    } else {
                        if(Race_CheckPlayerCheat(ss, p1[rcpid])) return FuckAnitCheat(playerid, "赛车红点传送", 0);
                    }
                }
            }
            format(msg, 128, "检 查 点 / ~p~%i~w~/~y~%i", GameRace[playerid][rgamecp], Race[raid][rcps]);
            PlayerTextDrawSetString(playerid, CpTextDraw[playerid], msg);
            PlayerTextDrawShow(playerid, CpTextDraw[playerid]);
            GetPlayerPos(playerid, pX, pY, pZ);
            for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                if(IsPlayerConnected(i) && PlayerInfo[i][tvid] == playerid && PlayerInfo[i][tvzt]) PlayerPlaySound(i, 1056, pX, pY, pZ);
            }
            //2020.2.11修复没声音

            PlayerPlaySound(playerid, 1056, pX, pY, pZ);
            //如果玩家的CP点等于这个赛道的总CP数 也就是说玩家到了终点
            if(GameRace[playerid][rgamecp] == Race[raid][rcps]) { //2020.1.13修改
                //如果rtop也就是在房间内是第一名且房间人数 > 1 也就是还有其他玩家的话
                if(GetPlayerState(playerid) == 2) {
                    // PlayerInfo[playerid][Cash] += rand;
                    new time[3];
                    new tickracetime = GetTickCount() - GameRace[playerid][rtime];
                    // 获取曾经的个人记录时间
                    new rand;
                    if(Race[raid][rcps] < 10) {
                        rand = random(80);
                    } else if(Race[raid][rcps] < 20) {
                        rand = random(800) + 300;
                    } else rand = random(1500) + 300;
                    if(time[1] == 0 && time[2] < 50) {
                        rand = random(80);
                    }
                    new p_record_time = Race_GetPlayerRecord(playerid,Race[raid][rid]);
                    // 如果从来没跑过或者是这一次比之前的个人记录快
                    if(p_record_time==-1 || tickracetime<p_record_time)
                    {
                        rand+=random(50); //突破个人记录加金币和经验值
                        SendClientMessage(playerid, Color_Race, "[赛车] 恭喜你刷新了此赛道个人记录!");
                    }
                    // 插入个人记录
                    Race_InsertRecord(playerid, Race[raid][rid], tickracetime);
                    // ms2time(time, GetTickCount() - GameRace[playerid][rtime]);

                    GivePlayerCash(playerid, rand);
                    // if(level>201) level = 201;
                    new Float:randExp;
                    if(Race[raid][rcps] < 10) {
                        randExp = PlayerInfo[playerid][plevel]*(random(20)+10)-(PlayerInfo[playerid][plevel]-1) * random(10);
                    } else if(Race[raid][rcps] < 20) {
                        randExp = PlayerInfo[playerid][plevel]*(random(30)+15)-(PlayerInfo[playerid][plevel]-1) * random(10);
                    } else randExp = PlayerInfo[playerid][plevel]*random(50)+10-(PlayerInfo[playerid][plevel]-1) * random(10);
                    if(time[1] == 0 && time[2] < 50) {
                        randExp = PlayerInfo[playerid][plevel]*(random(20)+10)-(PlayerInfo[playerid][plevel]-1) * random(10);
                    }
                    randExp*=exp_multiple;
                    // 方便一键控制全服经验活动

                    GivePlayerExp(playerid, randExp);
                    ms2time(time, tickracetime);
                    format(msg, 128, "[赛车] %s 完成了赛道[%s],耗时%d:%d:%d [%s秒] (小组第%i) 获得 %d 金币 %.0f 经验", GetName(playerid), Race[raid][rname], time[0], time[1], time[2], MsToS(tickracetime), RaceHouse[GameRace[playerid][rgameid]][rtop], rand, randExp); //完成后显示他的排名
                    // format(msg, 128, "[赛车] %s 完成了赛道[%s],耗时%d:%d:%d [%s秒] (小组第%i) 获得 %d 金币", GetName(playerid), Race[raid][rname], time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime]), RaceHouse[GameRace[playerid][rgameid]][rtop], rand); //完成后显示他的排名
                    SendClientMessageToAll(Color_Race, msg);
                    printf("%s", msg);
                    RaceHouse[GameRace[playerid][rgameid]][rtop]++; //那么接下来的人的排名就会+1
                    // KillTimer(jishu[playerid]);
                    // //									KillTimer(playerrank[GameRace[playerid][rgameid]]);
                    // TextDrawDestroy(Time[playerid]);
                    // TextDrawDestroy(Top[playerid]);
                    new top = Race_Game_End(playerid, raid, tickracetime);
                    // new top = Race_Game_End(playerid, raid, GetTickCount() - GameRace[playerid][rtime]);
                    pRaceing[playerid] = 0;
                    if(top != -1) {
                        format(msg, 128, "[赛车] 恭喜 %s 登上了赛道 %s 的排行榜 {FFFF00}No.%i! 祝贺Ta!", GetName(playerid), Race[raid][rname], top + 1);
                        SendClientMessageToAll(Color_Race, msg);
                        printf("%s", msg);
                        pHouseid[playerid] = -1;
                    }
                }
                //如果说他是第一 且 总人数  > 1
                // KillTimer(RaceHouse[GameRace[playerid][rgameid]][playerrank]);//这句话在这可能有些问题 1个人好像是没必要启用这个的.. 
                // 放在delete和race quit那里了 应该会触发的吧 
                if(RaceHouse[GameRace[playerid][rgameid]][rtop] == 2) //因为上面已经++了
                {
                    //包括玩家本身 以及观战他的都收到win胜利
                    new time[3];
                    ms2time(time, GetTickCount() - GameRace[playerid][rtime]);
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && PlayerInfo[i][tvid] == playerid || GameRace[i][rgameid] == GameRace[playerid][rgameid]) {
                            format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED 1ST \n~y~%d:%d:%d [%s second]", GetName(playerid), time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //完成后显示他的排名
                            GameTextForPlayer(i, msg, 5000, 3);
                        }
                    }
                    if(RaceHouse[GameRace[playerid][rgameid]][rps] > 1) {
                        for (new i = 0; i < 6; i++) {
                            if(RaceHouse[GameRace[playerid][rgameid]][rplayers][i] == playerid) { //找到玩家在的槽位
                                RaceHouse[GameRace[playerid][rgameid]][rplayers][i] = INVALID_PLAYER_ID;
                                break; //把这个槽位清零
                            }
                        }
                        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                            if(IsPlayerConnected(i) && i != playerid) {
                                if(GameRace[i][rgameid] == GameRace[playerid][rgameid]) GameTextForPlayer(i, "~w~玩家已冲线！你还有20秒时间，请抓紧!", 1000, 3);
                                // else GameTextForPlayer(playerid, "~w~您已冲线！请等待其他玩家冲线，请抓紧!", 1000, 3);Race_Game_Quit(playerid);
                            }
                        }
                        RaceHouse[GameRace[playerid][rgameid]][rtimes] = 20;
                        RaceHouse[GameRace[playerid][rgameid]][rendcount] = SetTimerEx("RaceGameEndCount", 1000, true, "i", GameRace[playerid][rgameid], playerid);
                    }
                } else {
                    //包括玩家本身 以及观战他的都收到finished完成
                    new time[3];
                    ms2time(time, GetTickCount() - GameRace[playerid][rtime]);
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && PlayerInfo[i][tvid] == playerid || GameRace[i][rgameid] == GameRace[playerid][rgameid]) {
                            //或同一个房间内的人 (检测房间人数是否>1) 也显示那个人完成了
                            if(RaceHouse[GameRace[playerid][rgameid]][rtop] == 3) {
                                format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED 2ND \n~y~%d:%d:%d [%s second]", GetName(playerid), time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //完成后显示他的排名
                            } else if(RaceHouse[GameRace[playerid][rgameid]][rtop] == 4) {
                                format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED 3RD \n~y~%d:%d:%d [%s second]", GetName(playerid), time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //完成后显示他的排名
                            } else {
                                format(msg, 128, "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s FINISHED %dTH \n~y~%d:%d:%d [%s second]", GetName(playerid), RaceHouse[GameRace[playerid][rgameid]][rtop], time[0], time[1], time[2], MsToS(GetTickCount() - GameRace[playerid][rtime])); //完成后显示他的排名
                            }
                            GameTextForPlayer(i, msg, 5000, 3);
                            //2020.3.26改 仿youtube的某个赛道显示
                        }
                        // 2020.3.25发现问题 修改playerid为i
                    }
                }
                Race_ShowGameDialog(playerid, raid); //2020,2,10修改 原本是在这的
                new tmp = GameRace[playerid][rgameid];
                Race_Game_Quit(playerid);
                // Race_ShowGameDialog(i, raid); //改到了这里并直接取消tv
                if(RaceHouse[tmp][rps] == 0) //检查房间内是否还有人 有的话就检查是否还有人观战
                {
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && PlayerInfo[i][Login]) {
                            if(PlayerInfo[i][tvid] == playerid && i != playerid) //如果房间没人了 他还在观战则弹窗是否需要继续观看
                            {
                                AntiCommand[i] = 0;
                                CallRemoteFunction("OnPlayerCommandText", "is", i, "/tv off");
                                // OnPlayerCommandText(i, "/tv off");
                                // ShowPlayerDialog(i, RACE_MSGBOX, DIALOG_STYLE_MSGBOX, "房间", "对方当前未在赛道中，是否继续观看？", "Yes", "No");
                            }
                        }
                    }
                    //完成比赛后选择弹出dialog选择是否继续观战
                } else {
                    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                        if(IsPlayerConnected(i) && GameRace[i][rgameid] == tmp) { //如果有某个玩家的房间ID等于这个玩家刚退出来的ID则自动观看那个玩家
                            new tmped[16];
                            format(tmped, 16, "/tv %i", i);
                            AntiCommand[i] = 0;
                            CallRemoteFunction("OnPlayerCommandText", "is", playerid, tmped);
                            // OnPlayerCommandText(playerid, tmped);
                            break; //2020.3.28写 不写的话好像有问题 如果有问题再把他移了
                        }
                    }
                }
            } else //如果不是终点的话那就CP点数加1
            {
                GameRace[playerid][rgamecp]++;
                Race_ShowCp(playerid, raid, GameRace[playerid][rgamecp]); //显示CP
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
    //     /*if(newkeys & KEY_FIRE)//切换TV对象
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
    // if(PRESSED(KEY_FIRE) || PRESSED(KEY_ACTION))  旧版写法 编译报029错
    // if(pRaceing[playerid] &&  HOLDING(KEY_CROUCH)){  // C键赛道系统重生
    // // SetTimerEx("KickEx", 100, false, "i", playerid);
    //     RaceReSpawnTextDraw(playerid);
    //     SetTimerEx("ReSpawnRaceVehicle", 1000, false, "i", playerid);
    // }

    // if((newkeys & KEY_FIRE) && !(oldkeys & KEY_FIRE) || (newkeys & KEY_ACTION) && !(oldkeys & KEY_ACTION)) { 2020.2.9取消
    // if((newkeys & KEY_ACTION) && !(oldkeys & KEY_ACTION)) {
    //     if(IsPlayerInAnyVehicle(playerid)) AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
    // }
    if(Attire_Presskey(playerid, newkeys) == 1) return 1;
    if(PlayerEdit[playerid][2] != 0) {
        new Keys, ud, lr;
        GetPlayerKeys(playerid, Keys, ud, lr);
        if(Keys == KEY_LOOK_BEHIND) {
            new str[128];
            format(str, sizeof(str), "左右\n前后\n上下\n前翻\n侧翻\n旋转\n调速\n{FF0000}删除\n状态:%s", TagObjectsState[VehAttachedObject[PlayerEdit[playerid][0]][PlayerEdit[playerid][1]][TagObjects]]);
            Dialog_Show(playerid, CDIALOG_CarZB, DIALOG_STYLE_LIST, "物件编辑", str, "选择", "退出");
        }
        if(Keys == KEY_FIRE) {
            Dialog_Show(playerid, CDIALOG_CarZBEditSave, DIALOG_STYLE_LIST, "物件编辑", "?鸤n?鸤n?鸤n\
                跳出三界外\n不在五行中\n------------------------------\n{FF0000}点我重置该装扮\n------------------------------\n{00FF00}点我保存该装扮\n------------------------------", "保存", "重置");
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
        CreatingCamera(playerid); //调用摄像机 镜头
        if(IsPlayerDeathMatch(playerid)) {
            if(ForbiddenWeap(playerid, 1)) {
                //让玩家离开DM并提示使用禁止使用的武器
                ResetPlayerWeapons(playerid);
                DeathMatch_Leave(playerid);
                Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "你不可使用不允许使用的武器", "确定", "");
                return 1;
            }
        } else {
            //大世界禁止使用这些武器 然后直接没收玩家的所有武器
            if(GetPlayerVirtualWorld(playerid) == 0 && ForbiddenWeap(playerid, 0)) {
                SendClientMessage(playerid, Color_White, "[系统]大世界中禁止使用这些武器");
                ResetPlayerWeapons(playerid);
                return 1;
            }
        }
        if(PlayerInfo[playerid][tvzt]) {
            if(pRaceing[PlayerInfo[playerid][tvid]]) {
                new tmp = GameRace[PlayerInfo[playerid][tvid]][rgameid];
                for (new i = GetPlayerPoolSize(); i >= 0; i--) {
                    if(IsPlayerConnected(i) && i != PlayerInfo[playerid][tvid] && GameRace[i][rgameid] == tmp) { //如果有某个玩家的房间ID等于这个玩家 则切换观看
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
        if(KeyBoards(playerid) == 1) return 1; //按下Y调用公告牌 如果玩家是在搞公告牌的话 那就不往下执行了，不然会炸掉的
        if(config_Nochangeobj == 0) { //PHouse的
            UseChangeObj(playerid);
            // return 1; //加了这个下面家具就读不到了
        }
        if(config_Nomoveobj == 0) { //好像还是Phouse的
            UseMoveObj(playerid);
            //加了这个家具读不到
            // return 1;
        }
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) {
            GOODS_OPRATEID[playerid] = getClosestGOODS(playerid);
            // printf("GET ID = %d", GOODS_OPRATEID[playerid]);
            if(GOODS_STATUS[playerid] == true) return SendClientMessage(playerid, Color_Furniture, "[家具]错误,你正在搬一个物品!");
            if(GOODS[GOODS_OPRATEID[playerid]][Key]) return Dialog_Show(playerid, GODIOG_PASS, DIALOG_STYLE_INPUT, "安全验证程式", "请输入密码", "OK", "取消");

            if(GOODS[GOODS_OPRATEID[playerid]][issale] == true) {
                new string[256];
                format(string, sizeof(string), "{FFFFFF}[物品价格]:{80FF80} %d\n{FFFFFF}[物品ID]:{80FF80}%d\n{FFFFFF}[物品模型ID]:{80FF80}%d\n{FFFF80}確定要买么?", GOODS[GOODS_OPRATEID[playerid]][GoodPrize], GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodObjid]);
                Dialog_Show(playerid, GODIOG_BUY, DIALOG_STYLE_MSGBOX, "{FFFF80}__要买么?__", string, "是", "算了");
            } else {
                // new pname[65];
                // GetPlayerName(playerid, pname, 65);
                if(!strlen((GOODS[GOODS_OPRATEID[playerid]][GoodOwner]))) return Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR>.<", "{FF0000}系统内部错误\n字符串为空!\n有可能此物品数据被损坏\n请联系开发者!\n---->{FFFF80}episodes27@gmail.com", "Close", "");
                if(!strcmp(GOODS[GOODS_OPRATEID[playerid]][GoodOwner], GetName(playerid), true)) {
                    if(GOODS[GOODS_OPRATEID[playerid]][topublic] == true) {
                        new title[285];
                        format(title, 285, "{FFFFFF}物品ID:{80FF80}%d {FFFFFF}主人:{80FF80}%s - {80FFFF}操作菜单", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                        Dialog_Show(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_YES, "选择", "关闭");
                    } else {
                        new title[285];
                        format(title, 285, "{FFFFFF}物品ID:{80FF80}%d {FFFFFF}主人:{80FF80}%s - {80FFFF}操作菜单", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][GoodOwner]);
                        Dialog_Show(playerid, GODIOG_PL, DIALOG_STYLE_LIST, title, PL_CONCENTS_NO, "选择", "关闭");
                    }
                } else {
                    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "{FF0000}ERROR>.<", "{FF0000}这不是你的物品!", "Close", "");
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

public OnRconLoginAttempt(ip[], password[], success) { //rcon登录失败直接封
    if(!success) {
        new cmd[32];
        format(cmd, sizeof(cmd), "banip %s", ip);
        SendRconCommand(cmd);
    }
    return 1;
}

public OnPlayerUpdate(playerid) { //放下家具
    GetPlayerFPS(playerid);
    if(GOODS_STATUS[playerid] == true && TAKEDOWN_STATUS[playerid] == false) {
        new up_dw, lf_rg, o_keys;
        GetPlayerKeys(playerid, o_keys, up_dw, lf_rg);
        if(o_keys == KEY_FIRE) {
            Dialog_Show(playerid, GODIOG_TAKEDOWN, DIALOG_STYLE_MSGBOX, "{FFFF80}物品操作", "{FFFF80}放下物品?", "放下", "取消");
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
    if(!PlayerInfo[id][Login]) return SendClientMessage(playerid, Color_White, "对方好像还没有登录..");
    new msgs[32], msg[512];
    if(PlayerInfo[id][AdminLevel]) format(msgs, sizeof(msgs), "[管理员LV%d]%s的信息", PlayerInfo[id][AdminLevel], GetName(id));
    else format(msgs, sizeof(msgs), "%s的信息", GetName(id));
    new year, month, day, hour, minute, second;
    new nextlevel = PlayerInfo[id][plevel] * 144;
    new racing_cut = Race_GetPlayerRecordCut(id);

    TimestampToDate(PlayerInfo[id][regdate], year, month, day, hour, minute, second, 8);
    format(msg, sizeof(msg), "UID:%d", PlayerInfo[id][ID]);
    format(msg, sizeof(msg), "%s\n等级:%d(%s)\n经验:%d/%d", msg, PlayerInfo[id][plevel], GetPlayerLevelName(id), PlayerInfo[id][exp], nextlevel);
    format(msg, sizeof(msg), "%s\n皮肤:%d", msg, PlayerInfo[id][Skin]);
    format(msg, sizeof(msg), "%s\n金币:%d", msg, PlayerInfo[id][Cash]);
    if(!strcmp(PlayerInfo[id][Designation], "null", false)) format(msg, sizeof(msg), "%s\n称号:%s", msg, PlayerInfo[id][Designation]);
    if(!strcmp(PlayerInfo[id][Tail], "null", false)) format(msg, sizeof(msg), "%s\n座右铭:%s", msg, PlayerInfo[id][Tail]);
    format(msg, sizeof(msg), "%s\n在线时间:%d(分)", msg, PlayerInfo[id][Score]);
    // new level = GetPlayerLevel(id);
    // if(PlayerInfo[playerid][plevel]>201) format(msg, sizeof(msg), "%s\n等级:201\t%s\t%d/--\n比赛次数:%d\n最近比赛", msg, GetPlayerLevelName(playerid), PlayerInfo[id][exp], racing_cut);
    format(msg, sizeof(msg), "%s\n\n比赛次数:%d\n最近比赛", msg, racing_cut);
    if(strcmp(PlayerInfo[id][Team], "null", false)) format(msg, sizeof(msg), "%s\n团队:%s", msg, PlayerInfo[id][Team]);
    format(msg, sizeof(msg), "%s\n注册日期:%d-%d-%d %02d:%02d:%02d", msg, year, month, day, hour, minute, second);
    
    format(msg, sizeof(msg), "%s\n信誉分:{00FF00}%d", msg, GetPlayerCreditpoints(id));
    if(GetPlayerCreditpoints(id)<=80) format(msg, sizeof(msg), "%s\n信誉分:{FFFF00}%d", msg, GetPlayerCreditpoints(id));
    if(GetPlayerCreditpoints(id)<=50) format(msg, sizeof(msg), "%s\n信誉分:{FF0000}%d", msg, GetPlayerCreditpoints(id));
    SelectRecentlyClicked[playerid] = id;
    // printf("%s", PlayerInfo[id][regdate]);
    Dialog_Show(playerid, ClickPlayer, DIALOG_STYLE_LIST, msgs, msg, "确定", "");
    //2020.2.11修改为LIST样式
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

function CountDown(playerid) {
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
//         GameTextForAll("~g~GO~r~!~n~~g~GO~r~!~n~~g~GO~r~!", 1000, 3); //当计时开启后 屏幕中出现的字体。
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
function SpawnVehicle(playerid, car) {  //刷车 产生车辆的时候
    new str[128];
    new Float:pos[3], Float:Angle;
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    //获取玩家所在的坐标
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), Angle); //如果玩家在车里就取出当前车所处在的角度
    else GetPlayerFacingAngle(playerid, Angle); //如果不在车里就获取玩家朝向的角度

    // 判断玩家是否已经有过一辆车了，有过的话就把玩家放到车外然后删除原来的车
    if(PlayerInfo[playerid][CreateCar] == 1) SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    DestroyVehicle(PlayerInfo[playerid][BuyID]);
    PlayerInfo[playerid][CreateCar] = 0;

    PlayerInfo[playerid][BuyID] = CreateVehicle(car, pos[0], pos[1], pos[2], 0.0, random(128), random(128), 60); //60是延迟，如果蹦了的话就改大一点
    SetVehicleVirtualWorld(PlayerInfo[playerid][BuyID], GetPlayerVirtualWorld(playerid));
    //设置载具的世界为玩家的世界
    PutPlayerInVehicle(playerid, PlayerInfo[playerid][BuyID], 0);
    //把玩家放到车里面
    //PlayerInfo[playerid][pVehicleEnteColor_Red] = GetPlayerVehicleID(playerid);
    PlayerInfo[playerid][CreateCar] = 1;
    PlayerInfo[playerid][CarLock] = 0;

    SetVehicleZAngle(PlayerInfo[playerid][BuyID], Angle); //设置车辆的角度为之前玩家所在的车辆角度
    LinkVehicleToInterior(PlayerInfo[playerid][BuyID], GetPlayerInterior(playerid));
    AddVehicleComponent(PlayerInfo[playerid][BuyID], 1010); //给车一个氮气
    if(!pRaceing[playerid]) { //如果玩家不在赛道中换车的话就提示这个 因为赛道会有cveh
        format(str, sizeof(str), "[交通工具]刷车成功，输入/cc 可换颜色，车辆模型(%s[%d])", VehicleNames[car - 400], car);
        SCM(playerid, Color_White, str);
    }
    for (new i = GetPlayerPoolSize(); i >= 0; i--) { //响应TV和本身自己 上车显示 下车隐藏
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

stock ReSpawnRaceVehicle(playerid) { //赛道重生
    // TextDrawHideForPlayer(playerid, ReSpawningText[playerid]); //隐藏重生中的显示
    new raid = RaceHouse[GameRace[playerid][rgameid]][rraceid];
    new trcp[racecptype];
    Race_GetCp(raid, GameRace[playerid][rgamecp] - 1, trcp);
    if(GameRace[playerid][rgamecp] - 1 <= 0) Race_GetCp(raid, 1, trcp);
    SetPlayerPos(playerid, trcp[rcpx], trcp[rcpy], trcp[rcpz]);
    if(PlayerInfo[playerid][BuyID] != 0) //如果玩家有车的话重生车
    {
        SetVehiclePos(PlayerInfo[playerid][BuyID], trcp[rcpx], trcp[rcpy], trcp[rcpz]);
        SetVehicleZAngle(PlayerInfo[playerid][BuyID], trcp[rcpa]); //2020.1.12写 修复 赛道CP点重生后车辆的朝向角度不是CP点的朝向角度
        SetVehicleVirtualWorld(PlayerInfo[playerid][BuyID], 6666 - GameRace[playerid][rgameid]);
        PutPlayerInVehicle(playerid, PlayerInfo[playerid][BuyID], 0);
        LinkVehicleToInterior(PlayerInfo[playerid][BuyID], GetPlayerInterior(playerid));
        AddVehicleComponent(PlayerInfo[playerid][BuyID], 1010); //给车一个氮气
    }
    return 1;
}

function MinuteTimer() { //分钟计时器
    //时间分 玩家的时间总共多少 在离线时计入DB数据库
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(PlayerInfo[i][Login] == true) {
            if(PlayerInfo[i][bantotal]!=0)  //如果被封禁次数不为0
            {
                new rand = random(2); //取随机数
                if(rand) GiveCreditpoints(i,-1); // 根据信誉分算法自动执行
            }
            PlayerInfo[i][Score] = PlayerInfo[i][Score] + 1;
            SetPlayerScore(i, PlayerInfo[i][Score]);
            PlayerInfo[i][Cash] = PlayerInfo[i][Cash] + random(30);
            // 给经验
            new rand = random(2);
            if(rand)
            {
                new Float:randExp;
                randExp=PlayerInfo[i][plevel]*(random(10)+10)-(PlayerInfo[i][plevel]-1) * random(5);
                randExp*=exp_multiple;
                // printf("%f",randExp);
                GivePlayerExp(i, randExp, 0);
            }
        }
    }
    Common_Running_QA(); //执行问答
    return 1;
}

stock GetName(const playerid) {
    new GPlayerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, GPlayerName, sizeof(GPlayerName));
    return GPlayerName;
}

// forward UpdatePlayerIni(playerid); //更新玩家资料
function OnPlayerLogin(playerid, inputtext[]) { //玩家登录
    if(PlayerInfo[playerid][LoginAttempts] >= 3) 
    {
        Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "登陆", "你被请出了服务器！原因:你输入的密码错误次数{FF0000}过多!", "确定", "");
        // SetTimerEx("KickEx", 100, false, "i", playerid);
        DelayedKick(playerid);
        return 1;
    }
    new Salted_Key[65];
    
    SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], Salted_Key, 65); //本来65
    if(strcmp(Salted_Key, PlayerInfo[playerid][Password],true) == 0) {
        for (new i = 0; i <= 7; i++) {
            TextDrawHideForPlayer(playerid, Screen[i]);
        }
        for (new i = GetPlayerPoolSize(); i >= 0; i--) {
            ShowPlayerNameTagForPlayer(playerid, i, true);
        }
        cache_set_active(PlayerInfo[playerid][Cache_ID]);
        new Checked = AssignPlayerData(playerid);
        cache_delete(PlayerInfo[playerid][Cache_ID]);
        PlayerInfo[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
        KillTimer(PlayerInfo[playerid][LoginTimer]);
        PlayerInfo[playerid][LoginTimer] = -1;

        if(Checked)
        {
            PlayerInfo[playerid][Login] = true;
            // printf("[玩家]%s(%d) 已登陆.", GetName(playerid), playerid);
            new string[128];
            format(string, sizeof(string), "[系统]:%s (%d) 进入了服务器 ^^^", GetName(playerid), playerid);
            SCMALL(Color_LightBlue, string);
            SetPlayerColor(playerid, PlayerColors[random(200)]); //设置玩家小地图颜色
			// SetSpawnInfo(playerid, NO_TEAM, 0, Player[playerid][X_Pos], Player[playerid][Y_Pos], Player[playerid][Z_Pos], Player[playerid][A_Pos], 0, 0, 0, 0, 0, 0);
            new rand = random(sizeof BirthPointInfo);
            SetSpawnInfo(playerid, NO_TEAM, PlayerInfo[playerid][Skin], BirthPointInfo[rand][0], BirthPointInfo[rand][1], BirthPointInfo[rand][2], BirthPointInfo[rand][3], 0, 0, 0, 0, 0, 0);
            SpawnPlayer(playerid); //让玩家出生
            PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0); //停止播放音乐
            new temp[512];
            format(temp, sizeof(temp), "有一天人们厌倦了现在的快餐文化游戏，才猛然回想到当年的青春岁月\n那是那么天真，那么热血，那么傻\n我们是一支团队，可现在就是一盘散沙\n他们一定会想到，已经表演完一生才能的SAMP\n也只能被快餐文化游戏笼罩着，直到老去\n致那年一起努力飙车的我们\n每个人的生活现状不同，每个人的经济条件也不同\n只希望人生难得一场,珍惜彼此，最终都能过上幸福生活\n欢迎回家！善始善终，勿忘初心\n指令大部分都是老玩家熟悉的，/help查看指令\nB站账号:RaceSpeedTime 希望您能观看一次av16412914");
            Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "一封来自[R_ST]Hygen的信", temp, "我们爱SAMP", "");
            CheckPlayerEmailEd(playerid);
        }
        return 1;
    }
    PlayerInfo[playerid][LoginAttempts]++;
    new string[128];
    format(string, sizeof(string), "{FF0000}密码错误！{00FFFF}你还有{80FF80}%d次{00FFFF}机会登陆!", 4 - PlayerInfo[playerid][LoginAttempts]);
    // ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "登陆", string, "登陆", "关闭");
    Dialog_Show(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "登陆", string, "登陆", "关闭");
    // db_free_result(uf);
    return 1;
}

function OnPlayerRegister(playerid, inputtext[]) //玩家注册
{
    if(AccountCheck(GetName(playerid))) //2020.3.29修复这个严重的BUG
    {
        SCM(playerid, Color_Red, "[系统]注册帐号时发生错误,可能该帐号已经存在,请重新上线");
        // SetTimerEx("KickEx", 100, false, "i", playerid);
        DelayedKick(playerid);
        return 1;
    }
    // if(strfind(inputtext, "123", true) != -1 || strfind(inputtext, "456", true) != -1) {
    //     Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "注册", "请不要输入类似带有{22DD22}123等{FFFFFF}简单的密码!\n请在下方输入密码进行{22DD22}注册..\n本服采用散列技术,请放心注册", "注册", "退出");
    //     return 1;
    // }
    new msg[256], string[160], temp[64 + 1];
    for (new i = 0; i < 11; i++) {
        PlayerInfo[playerid][Salt][i] = random(25) + 97;
    }
    SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], temp, sizeof temp);
    mysql_format(g_Sql, msg, sizeof(msg), "INSERT INTO  `users` (`Name`,`Password`,`Salt`,`RegDate`) VALUES ('%e','%e','%e','%d')", GetName(playerid), temp, PlayerInfo[playerid][Salt], gettime());
    mysql_pquery(g_Sql, msg);
    format(PlayerInfo[playerid][Password], 65, temp);
    // 邮箱验证的初始化注册用户数据
    // 后期优化下，全局依赖uid,合并数据库，把用户数据库从db全部改到mysqlR41版本（大工程）
    // new Query2[256];
    // format(string, sizeof string, "INSERT INTO `players` (`name`,`code`,`email`,`yz`) VALUES('%s',0,0,0)", GetName(playerid));
    // mysql_free_result(mysql_query(string));
    // mysql_pquery(g_Sql, "INSERT INTO `players` (`name`,`code`,`email`,`yz`) VALUES('%s',0,0,0)", GetName(playerid));
    // printf(Query2);


    format(string, sizeof(string), "注册成功\n帐号: %s\n 密码: %s\n{FF0000}请牢记帐号密码.", GetName(playerid), inputtext);
    Dialog_Show(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "登陆", string, "登陆", "关闭");
    return 1;
}
function OnPlayerReloadRegister(playerid, inputtext[]) //重新注册
{
    // if(strfind(inputtext, "123", true) != -1 || strfind(inputtext, "qwerty", true) != -1 || strfind(inputtext, "456", true) != -1 || strfind(inputtext, "789", true) != -1) {
    //     Dialog_Show(playerid, PlayerPassWordChange, DIALOG_STYLE_INPUT, "{FFFF00}安全中心", "{9AFF9A}欢迎!\n请在下面输入密码来完成修改!\n请牢记您的账号密码!\n已采用散列技术，无需担心数据泄露", "确定", "取消");
    //     return 1;
    // }
    new temp[65]; // 散列技术生成散列码
    for (new i = 0; i < 11; i++) {
        PlayerInfo[playerid][Salt][i] = random(25) + 97;
    }
    // PlayerInfo[playerid][Salt][10] = 0;
    SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], temp, 65); //规定65固定
    new msg[256];
    mysql_format(g_Sql, msg, sizeof(msg), "UPDATE `users` SET `Password` = '%e',`Salt` = '%e' WHERE `Name` = '%e'", temp, PlayerInfo[playerid][Salt], GetName(playerid));
    mysql_pquery(g_Sql, msg);
    format(msg, sizeof(msg), "[系统]:帐号 :%s 密码 :%s\n{FF0000}请牢记帐号密码.\n请重新登录", GetName(playerid), inputtext);
    SendClientMessage(playerid, Color_White, msg);
    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", msg, "确定", "");
    // SetTimerEx("KickEx", 100, false, "i", playerid);
    DelayedKick(playerid);
    return 1;
}
stock OnPlayerResetPassword(const playerid, const changeidName[], const inputtext[]) { //管理员重置玩家密码 当玩家丢失时可使用
    new temp[65], pSalt[12]; // 散列技术生成散列码
    for (new i = 0; i < 11; i++) {
        pSalt[i] = random(25) + 97;
    }
    SHA256_PassHash(inputtext, pSalt, temp, 65); //规定65固定
    new msg[256];
    mysql_format(g_Sql, msg, sizeof(msg), "UPDATE `users` SET `Password` = '%e',`Salt` = '%e' WHERE `Name` = '%e'", temp, pSalt, changeidName);
    mysql_pquery(g_Sql, msg);
    format(msg, sizeof(msg), "[系统]:您重置了帐号:%s 密码:%s\n请联系对方重新登录并修改密码", changeidName, inputtext);
    SendClientMessage(playerid, Color_White, msg);
    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", msg, "确定", "");
    return 1;
}

stock AssignPlayerData(playerid) {
    cache_get_value_name_int(0, "BanTime", PlayerInfo[playerid][BanTime]);
    cache_get_value_name_int(0, "BanReason", PlayerInfo[playerid][BanReason]);
    
    
    // 获取经验值

    //db_get_field(uf,2,Race[i][rpassword],32);

    if(PlayerInfo[playerid][BanTime]) { //判断玩家是否被封禁 如果被封禁时间到现在<0就可以解封了否则就提示被封踢出
        if(PlayerInfo[playerid][BanTime] - gettime() > 0) {
            new day[4];
            UnixToDate(day, PlayerInfo[playerid][BanTime] - gettime());
            new msg[256];
            format(msg, sizeof(msg), "原因:系统检测到你最近使用第三方辅助严重影响了游戏公平性,Code violation #%d\n请检查您的游戏是否含有不允许使用的CLEO等作弊器\n待解封时间:%d天 %d时 %d分 %d秒", PlayerInfo[playerid][BanReason], day[0], day[1], day[2], day[3]);
            Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "[系统] 与服务器断开连接", msg, "确定", "");
            DelayedKick(playerid);
            return false;
        }
        PlayerInfo[playerid][BanTime] = 0;
        PlayerInfo[playerid][BanReason] = 0;
        new query[128];
        mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `BanTime` = '0',`BanReason` = '-1' WHERE `Name` = '%e'", GetName(playerid));
        mysql_pquery(g_Sql, query);
    }

    cache_get_value_name_int(0, "Yzwrong", PlayerInfo[playerid][yzwrong]);
    cache_get_value_name_int(0, "YzBanTime", PlayerInfo[playerid][yzbantime]);
    if(PlayerInfo[playerid][yzbantime] - gettime() < 21600000) { //邮箱验证时间的问题，如果一天超过了6次验证就会封24小时的验证
        PlayerInfo[playerid][yzwrong] = 0;
        PlayerInfo[playerid][yzbantime] = 0;
    }
    cache_get_value_name_int(0, "ID", PlayerInfo[playerid][ID]);
    cache_get_value_name_int(0, "AdminLevel", PlayerInfo[playerid][AdminLevel]);
    cache_get_value_name_int(0, "Skin", PlayerInfo[playerid][Skin]);
    cache_get_value_name_int(0, "Score", PlayerInfo[playerid][Score]);
    cache_get_value_name_int(0, "Cash", PlayerInfo[playerid][Cash]);
    cache_get_value_name_int(0, "JailSeconds", PlayerInfo[playerid][JailSeconds]);
    cache_get_value_name_int(0, "RegDate", PlayerInfo[playerid][regdate]);
    cache_get_value_name(0, "Designation", PlayerInfo[playerid][Designation], 19);
    cache_get_value_name(0, "Tail", PlayerInfo[playerid][Tail], 33);
    cache_get_value_name_int(0, "exp", PlayerInfo[playerid][exp]);
    cache_get_value_name_int(0, "pLevel", PlayerInfo[playerid][plevel]);
    cache_get_value_name_int(0, "tHour", PlayerInfo[playerid][tHour]);
    cache_get_value_name_int(0, "tMinute", PlayerInfo[playerid][tMinute]);
    cache_get_value_name_int(0, "tWeather", PlayerInfo[playerid][tWeather]);
    cache_get_value_name_int(0, "displayObject", PlayerInfo[playerid][displayObject]);
    cache_get_value_name_int(0, "NoCrash", PlayerInfo[playerid][NoCrash]);
    cache_get_value_name_int(0, "speedoMeter", PlayerInfo[playerid][speedoMeter]);//玩家速度表
    cache_get_value_name_int(0, "AutoFix", PlayerInfo[playerid][AutoFix]);//自动修车
    cache_get_value_name_int(0, "AutoFlip", PlayerInfo[playerid][AutoFlip]);//自动翻正
    cache_get_value_name_int(0, "enableInvincible", PlayerInfo[playerid][enableInvincible]);//玩家无敌状态
    cache_get_value_name_int(0, "netStats", PlayerInfo[playerid][netStats]);//玩家开启/关闭网络参数
    cache_get_value_name_int(0, "bantotal", PlayerInfo[playerid][bantotal]);//被封禁次数，用于计算信誉分;
    if(GetPlayerCreditpoints(playerid) <= 90) SendClientMessage(playerid, Color_White, "[系统]您的信誉分有点低了,请保持健康游戏,自动增长!");
    // 读取玩家设置中保存的一些参数
    SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
    SetPlayerTime(playerid, PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute]); //玩家时间
    SetPlayerWeather(playerid, PlayerInfo[playerid][tWeather]);
    if(!PlayerInfo[playerid][displayObject]) {
        Streamer_UpdateEx(playerid, 0, 0, -50000);
        Streamer_ToggleItemUpdate(playerid, 0, 0);
    }
    if(PlayerInfo[playerid][NoCrash]) DisableRemoteVehicleCollisions(playerid, true); //玩家屏蔽车辆碰撞
    InitializationVelo(playerid); //初始化速度表
    if(!PlayerInfo[playerid][speedoMeter]) {
        for (new a = 0; a <= 21; a++) {
            PlayerTextDrawHide(playerid, velo[playerid][a]);
        }
    }
    if(PlayerInfo[playerid][enableInvincible]) SetPlayerHealth(playerid, 999999999); //玩家无敌状态
    InitializationNetWork(playerid); //初始化网络参数

    format(pemail[playerid], MAX_EMAIL_LENGTH, "-1");
    Race_OnPlayerConnect(playerid);
    tdSpeedo_Connect(playerid); //初始化3D速度表
    team_OnPlayerLogin(playerid);
    Camera_OnPlayerConnect(playerid);
    DeathMatch_PlayerLogin(playerid);
    Initialize_pWorld(playerid);
    PHouse_PlayerLogin(playerid); //初始化PHouse的Area
    HouseSellPlayerInitialize(playerid); //不知道 好像是PHouse里初始化sellto和buyit的
    Attire_ReadData(playerid); //读取玩家装扮数据
    Boards_OnPlayerConnect(playerid); //初始化公告牌
    Cars_OnPlayerConnect(playerid); //爱车玩家调整的默认参数
    Tele_OnPlayerLogin(playerid); //玩家查看传送列表时的初始化页数
    EnableStuntBonusForPlayer(playerid, 1); //关闭特效奖励显示
    GivePlayerMoney(playerid, 99999999);
    //Race_OnPlayerConnect(playerid); 2020.1.13改到onplayerconnect
    //可能会导致数据错乱
    PlayerInfo[playerid][showStunt] = 1;
    PlayerInfo[playerid][showName] = 1;
    PlayerColorPage[playerid] = 1; //玩家修改颜色的菜单默认第一页
    PlayerInfo[playerid][hys] = false; //默认玩家车辆换颜色关闭
    PlayerInfo[playerid][lastZpos] = 0; //上一秒的Z轴坐标 用于反载具数据异常作弊
    // PlayerInfo[playerid][lastVehSpeed] = 0; //上一秒的车速 用于反载具数据异常作弊

    SelectHousePage[playerid] = 1; //玩家选择房子的页面默认是1
    splp[playerid] = 0; //玩家是否使用了/sp的状态判断
    PlayerInfo[playerid][AFKTimes] = 0; //玩家挂机时间初始化0秒 用于检测玩家是否在赛道中挂机
    PlayerInfo[playerid][yssyjsq] = -1;
    return true;
}



// 已全局适配easydialog,放弃原有的dialogresponse
// public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
//     return 1;
// }


// 速度表和TV观战的速度表相关设定
function updateSpeedometer() {
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i) && PlayerInfo[i][Login]) 
        {
            tdSpeedo_Update(i, GetSpeed(i));
            if(PlayerInfo[i][speedoMeter])
            {
                new string[32];
                // format(string, sizeof(string), "%03d", GetSpeed(i));
                format(string, sizeof(string), "%03d", GetSpeed(PlayerInfo[i][tvid]));
                PlayerTextDrawSetString(i, velo[i][1], string);
                // switch (GetSpeed(i)) {
                switch (GetSpeed(PlayerInfo[i][tvid])) {
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
                for (new a = 1; a <= 21; a++) {
                    PlayerTextDrawShow(i, velo[i][a]); //drawcolor必须得重新show才会刷新  而速度不用 所以这里要这么写
                }
                // // 2020.3.29注释 如果有问题取消回去
                // for (new j = GetPlayerPoolSize(); j >= 0; j--) {
                //     if(IsPlayerConnected(j)) {
                //         if(PlayerInfo[j][tvid] == i && PlayerInfo[j][speedoMeter]) {
                //             for (new a = 1; a <= 21; a++) {
                //                 PlayerTextDrawShow(j, velo[i][a]); //drawcolor必须得重新show才会刷新  而速度不用 所以这里要这么写
                //             }
                //         }
                //     }
                // }
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
				format(msg, sizeof(msg), "速度:%.1f km/h",GetSpeed(PlayerInfo[i][tvid]));//原仿兰草的速度表
				TextDrawSetString(Speedtextdraw[PlayerInfo[i][tvid]], msg);	
				}
			}*/


function tpaTimer(playerid) {
    if(tpaB[playerid] == 1) {
        SCM(playerid, Color_White, "[tp]你在1分钟内没有接受传送请求,该条传送请求失效");
    }
    if(tpaB[playerid] == 2) {
        SCM(playerid, Color_White, "[tp]对方在1分钟内没有接受你的传送请求,该条传送请求失效.");
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
            SendClientMessage(playerid, Color_White, "[皮肤] 已更新您的皮肤.");
            SetPlayerSkin(playerid, modelid);
            PlayerInfo[playerid][Skin] = modelid;
        } else SendClientMessage(playerid, Color_White, "[皮肤] 您已取消更换皮肤.");
        return 1;
    }
    return 1;
}

function SecondsTimer() {
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

        format(str, sizeof(str), "hostname [RST团队]缅怀逝者，致敬英雄 %02d:%02d:%02d", hour, minute, second);
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
        format(str, sizeof(str), "hostname [RST团队]距离%d还有 %02d:%02d:%02d", n, hour, minute, second);
        SendRconCommand(str);
        if(hour == 23 && minute == 59) {
            format(str, sizeof(str), "[新年]距离%d还有 %02d:%02d:%02d", n, hour, minute, second);
            SendClientMessageToAll(Color_White, str);
            if(second + 1 == 0) {
                format(str, sizeof(str), "[新年]再见%d,你好%d", n, n + 1);
                SendClientMessageToAll(Color_White, str);
                SendClientMessageToAll(Color_White, "一片好运来，两串爆竹响，散发好运气，四方来财气，五福升高空，六六都顺心，齐来迎新年，八方收和气，久久享福祉。");
            }
        }
    }
    if(day == 1 && y == 1) {
        new hour, minute, second;
        gettime(hour, minute, second);
        new str[90];
        format(str, sizeof(str), "hostname [RST]RST团队祝福大家新年快乐! %02d:%02d:%02d", hour, minute, second);
        SendRconCommand(str);
    }
    for (new i = GetPlayerPoolSize(); i >= 0; i--) {
        if(IsPlayerConnected(i)) {
            if(IsPlayerNPC(i)) {
                if(gettime() - PlayerInfo[i][nitro] >= 15) //每15秒给玩家一个氮气 原来的氮气算法
                {
                    AddVehicleComponent(GetPlayerVehicleID(i), 1010);
                    PlayerInfo[i][nitro] = gettime();
                }
            }
            if(PlayerInfo[i][Login] == true) {
                updatePlayerNetWorkState(i); //更新网络参数
                if(PlayerInfo[i][JailSeconds] != 0) { //如果玩家被监禁，那个时间就慢慢减
                    PlayerInfo[i][JailSeconds]--;
                    if(PlayerInfo[i][JailSeconds] <= 0) {
                        PlayerInfo[i][JailSeconds] = 0; //等于0了就放出来，更新DB数据库
                        // SetSpawnInfo(i, NO_TEAM, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
                        SpawnPlayer(i);
                        new query[128];
                        mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET JailSeconds = 0 WHERE `Name` = '%e'", GetName(i));
                        mysql_pquery(g_Sql, query);
                    } else {
                        SetPlayerPos(i, 1607.480, 1670.444, 10.549);
                    }
                }
                if(PlayerInfo[i][Yztime]) { //大概是邮箱验证的时间，如果不为0的话就一直减到0
                    PlayerInfo[i][Yztime]--;
                    if(PlayerInfo[i][Yztime] <= 0) {
                        PlayerInfo[i][Yztime] = 0;
                    }
                }
                running_PPC(i);
                Attire_Preview_Range(i); //装备预览范围 超出了就自动卸了
                AntiCommand[i] = 0; //玩家的过度发言重置0
                //PlayerInfo[i][pLastCheck] = GetTickCount(); 
                //如果说GetTickCount() > pLastCheck+2000的话说明玩家挂机 2000指2秒里玩家都没更新的话 但是不能放在这里判断
                //或者说再开个定时器去减那个lastcheck
                if(GetPlayerState(i) == PLAYER_STATE_DRIVER) //如果玩家在车上的话
                {
                    new VehID = GetPlayerVehicleID(i);
                    // pACEdit[playerid]是玩家的爱车ID 如果是-1的话就没有爱车
                    //   不对 应该是pACEdit[i][gotoId]
                    if(VehID == PlayerInfo[i][BuyID] || VehID == CarInfo[pACEdit[i]][GotoID]) {
                        if(gettime() - PlayerInfo[i][nitro] >= 15) //每15秒给玩家一个氮气 原来的氮气算法
                        {
                            AddVehicleComponent(VehID, 1010);
                            PlayerInfo[i][nitro] = gettime();
                        }
                        if(PlayerInfo[i][hys]) ChangeVehicleColor(VehID, random(256), random(256)); //如果玩家开了换颜色则自动换车辆颜色
                        // 检测车辆是否翻转 By Babul https://forum.sa-mp.com/member.php?u=64500
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
                                SendClientMessage(i, Color_White, "[系统]你开启了车辆自动翻正功能,翻转成功，可在/sz关闭");
                                GameTextForPlayer(i, "~w~vehicle ~g~fl~h~ip~h~pe~h~d", 2000, 4);
                            }
                        }
                        //赛车中载具数据异常反作弊 By:[R_ST]Hygen
                        if(pRaceing[i]) { //如果玩家在赛车中 并且在车中 2020.2.23新增 不然的话会误封  //玩家暂停状态的话要忽略算法 不然很浪费资源
                            if(IsPlayerInAnyVehicle(i)) {
                                new Float:VehPosX, Float:VehPosY, Float:VehPosZ;
                                GetVehiclePos(VehID, VehPosX, VehPosY, VehPosZ);
                                //2020.3.15新增 ---开始
                                new Float:secondsxyz;
                                secondsxyz = GetPlayerDistanceFromPoint(i, PlayerInfo[i][lastXMoved], PlayerInfo[i][lastYMoved], PlayerInfo[i][lastZMoved]);
                                //每秒跟上一秒的距离 如果过大则至少数据异常 用来防瞬移
                                new Float:difference = VehPosZ - PlayerInfo[i][lastZpos];
                                if(difference <= -1.0) difference *= -1; //取两次Z轴高度差的绝对值
                                if(difference <= 3) {
                                    if(secondsxyz >= 79.333333) {
                                        if(GameRace[i][rgamecp] > 1 && PlayerInfo[i][lastVehSpeed]) { //2020.3.17写了一句lastVehSpeed  不然好像重生会误封
                                            if(!IsModelAPlane(VehID)) {
                                                if(GetSpeed(i) >= 225 || GetSpeed(i) <= 90) {
                                                    //如果玩家开的车不是飞机的话
                                                    //2020.4.3新增 速度是否大于223.123再进行判断 或 速度太低瞬移  防止因ping太容易炸的问题
                                                    new trcp[racecptype];
                                                    Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                                    new ss = Race_GetCp_Scripts(trcp[rcpid]); //返回当前CP点有几个高级CP函数，如果是0的话 就直接封;
                                                    // new Float:health;
                                                    // GetPlayerHealth(i, health);
                                                    if(!ss) {
                                                        return FuckAnitCheat(i, "新版反瞬移测试1", 11);
                                                    } else {
                                                        if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "新版反瞬移测试2", 11);
                                                    }
                                                }
                                            } else //不然的话就用飞机的最大每秒移动距离来计算
                                            {
                                                if(secondsxyz >= 89.333333) {
                                                    new trcp[racecptype];
                                                    Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                                    new ss = Race_GetCp_Scripts(trcp[rcpid]); //返回当前CP点有几个高级CP函数，如果是0的话 就直接封;
                                                    if(!ss) {
                                                        return FuckAnitCheat(i, "新版反瞬移测试3", 11);
                                                    } else {
                                                        if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "新版反瞬移测试4", 11);
                                                    }
                                                    return 1;
                                                }
                                            }
                                        }
                                    }
                                    if(secondsxyz <= 0.001 && GameRace[i][rgamecp] > 1) { //检测是否挂机  挂机时间太长的话 退出赛道
                                        PlayerInfo[i][AFKTimes]++;
                                        if(PlayerInfo[i][AFKTimes] >= 45) {
                                            Race_Game_Quit(i);
                                            Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "资源节省", "挂机时间过长,将您移出赛道", "收到", "");
                                            return 1;
                                        }
                                    }
                                }
                                PlayerInfo[i][lastXMoved] = VehPosX;
                                PlayerInfo[i][lastYMoved] = VehPosY;
                                PlayerInfo[i][lastZMoved] = VehPosZ;
                                //2020.3.15新增 ---结尾

                                //绝对值
                                //如果高度不高且... 因为MTA赛道误封率太高了 MTA赛道还是建议采用上面的反作弊方法
                                if(VehPosZ < 300.0 && !IsModelAPlane(VehID) && GetSpeed(i) >= 233.456 && difference <= 0.1987) { //如果是一秒内高度偏差太大也不行
                                    if(GameRace[i][rgamecp] > 1) {
                                        new trcp[racecptype];
                                        Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                        new ss = Race_GetCp_Scripts(trcp[rcpid]); //返回当前CP点有几个高级CP函数，如果是0的话 就直接封;
                                        // new Float:health;
                                        // GetPlayerHealth(i, health);
                                        if(!ss) {
                                            if(GameRace[i][rgamecp] > 2) {
                                                //如果上一个点也不是高级CP点那么直接微加速 随便写写的 微加速要拿瞬时速度去写 就定一个计时器速度很快很快 
                                                // update也行 反正就是去减他上一次检测的速度如果太夸张了 直接封就好了
                                                Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 2, trcp);
                                                ss = Race_GetCp_Scripts(trcp[rcpid]);
                                                if(!ss) {
                                                    Race_Game_Quit(i);
                                                    Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:10", "确定", "");
                                                    // FuckAnitCheat(i,"双高级CP可能微加速",10);
                                                    return 1;
                                                } else {
                                                    return 1;
                                                }
                                            }
                                            Race_Game_Quit(i);
                                            Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:10", "确定", "");
                                            return 1;
                                            // FuckAnitCheat(i,"可能微加速",10);
                                        }
                                    } else if(GameRace[i][rgamecp] == 1) {
                                        Race_Game_Quit(i);
                                        Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:10", "确定", "");
                                        return 1;
                                        // FuckAnitCheat(i,"首个CP速异常",10);
                                    }
                                    return 1;
                                }
                                if(VehPosZ > PlayerInfo[i][lastZpos] && GetSpeed(i) > 290 && difference >= 25.0 && GameRace[i][rgamecp] > 1) { //如果是一秒内高度偏差太大也不行
                                    new trcp[racecptype];
                                    Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                    new ss = Race_GetCp_Scripts(trcp[rcpid]); //返回当前CP点有几个高级CP函数，如果是0的话 就直接封;
                                    // new Float:health;
                                    // GetPlayerHealth(i, health);
                                    if(!ss) {
                                        return FuckAnitCheat(i, "赛道中载具+Z轴高度和速度异常", 1);
                                    } else {
                                        if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "赛道中载具+Z轴高度和速度异常", 1);
                                    }
                                }
                                if(difference <= 3 && GameRace[i][rgamecp] > 1) { //如果两个Z轴坐标相减的绝对值  < 4 的话
                                    //如果上一秒的车速比这次低，且这一秒减去上一秒的值差太大 例一秒的速度多了70码 而且 z轴没什么变化
                                    // 也就是说玩家在几乎没改变高度的情况下车速能瞬间提升去，那么基本上就是数据或者CLEO等异常
                                    if((PlayerInfo[i][lastVehSpeed] >= 0 && PlayerInfo[i][lastVehSpeed] < GetSpeed(i) && !IsModelAPlane(VehID) && GetSpeed(i) - PlayerInfo[i][lastVehSpeed] >= 104.0) || (PlayerInfo[i][lastVehSpeed] >= 85 && PlayerInfo[i][lastVehSpeed] < GetSpeed(i) && GetSpeed(i) - PlayerInfo[i][lastVehSpeed] >= 75) || (GetSpeed(i) > 266 && !IsModelAPlane(VehID)) || (GetSpeed(i) > 290 && IsModelAPlane(VehID))) {
                                        //判断玩家的CP点是否是高级CP点，如果不是则封杀
                                        // 应该是可以检测载具数据异常 / 微加速 / 车辆最高时速改变
                                        new trcp[racecptype];
                                        Race_GetCp(RaceHouse[GameRace[i][rgameid]][rraceid], GameRace[i][rgamecp] - 1, trcp);
                                        new ss = Race_GetCp_Scripts(trcp[rcpid]); //返回当前CP点有几个高级CP函数，如果是0的话 就直接封;
                                        if(!ss) {
                                            return FuckAnitCheat(i, "赛道中载具+Z轴高度和速度异常", 2);
                                        } else {
                                            if(Race_CheckPlayerCheat(ss, trcp[rcpid])) return FuckAnitCheat(i, "赛道中载具+Z轴高度和速度异常", 1);
                                        }
                                    }
                                }
                                PlayerInfo[i][lastZpos] = VehPosZ; //记录这一秒的Z轴
                                PlayerInfo[i][lastVehSpeed] = GetSpeed(i); //记录这一秒的车速
                            }
                        }
                    }
                    if(PlayerInfo[i][AutoFix] && p_PPC[i] == 0 && GetPlayerVehicleID(i)) RepairVehicle(GetPlayerVehicleID(i)); //如果玩家开了自动修车切不在碰碰车则修车
                } else //玩家没在车上的时候的状态
                {
                    if(pRaceing[i] && GetPlayerState(i) == PLAYER_STATE_ONFOOT) //在赛车中但是不在车上
                    {
                        new Float:pPos[3], Float:secondsxyz;
                        GetPlayerPos(i, pPos[0], pPos[1], pPos[2]);
                        secondsxyz = GetPlayerDistanceFromPoint(i, PlayerInfo[i][lastXMoved], PlayerInfo[i][lastYMoved], PlayerInfo[i][lastZMoved]);
                        if(secondsxyz <= 0.001 && GameRace[i][rgamecp] > 1) { //检测是否挂机  挂机时间太长的话 退出赛道
                            PlayerInfo[i][AFKTimes]++;
                            if(PlayerInfo[i][AFKTimes] >= 45) {
                                Race_Game_Quit(i);
                                Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "资源节省", "挂机时间过长,将您移出赛道", "收到", "");
                                return 1;
                            }
                        }
                        PlayerInfo[i][lastXMoved] = pPos[0];
                        PlayerInfo[i][lastYMoved] = pPos[1];
                        PlayerInfo[i][lastZMoved] = pPos[2];
                        // printf("%f", secondsxyz);
                        new Float:difference = pPos[2] - PlayerInfo[i][lastZpos];
                        PlayerInfo[i][lastZpos] = pPos[2];
                        if(difference <= -1.0) difference *= -1; //取两次Z轴高度差的绝对值
                        if(difference <= 1.55) {
                            if(GetSpeed(i) > 48.00 || secondsxyz > 13.00) {
                                Race_Game_Quit(i);
                                Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:13.1", "确定", "");
                                return 1;
                            }
                        } else // if(difference>=3)
                        {
                            if(secondsxyz > 61.33) {
                                Race_Game_Quit(i);
                                Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:13.2", "确定", "");
                                return 1;
                            }
                        }
                        return 1;
                    }
                    if(IsPlayerDeathMatch(i) && DeathMatch_Game[i][g_anticheat]) { //2020.3.31写 如果有问题直接取消掉
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
                            if(difference <= -1.0) difference *= -1; //取两次Z轴高度差的绝对值
                            if(difference <= 1.55) {
                                if(GetSpeed(i) > 48.00 || secondsxyz > 13.00) {
                                    DeathMatch_Leave(i);
                                    Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:13.1", "确定", "");
                                    return 1;
                                }
                            } else // if(difference>=3)
                            {
                                if(secondsxyz > 61.33) {
                                    DeathMatch_Leave(i);
                                    Dialog_Show(i, MessageBox, DIALOG_STYLE_MSGBOX, "[系统]", "数据异常,请稍后尝试 Code:13.2", "确定", "");
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
        FuckAnitCheat (i, "空中移动");
    }
}*/

// 可能会比较占用网络 算了
// public OnVehicleDamageStatusUpdate(vehicleid, playerid) //0.3a的函数，当车辆损伤时如果开了自动修复则修复
// {
//     if(PlayerInfo[playerid][AutoFix] && p_PPC[playerid] == 0) RepairVehicle(vehicleid);
//     return 1;
// }

/*stock GetRaceGameFinishList(playerid)
{
	if(pRaceing[playerid]=0 && GameRace[playerid][rgameid]]==kiven)
	{
 		new string[512];
		format(string,sizeof(string),"%s\n%s (%d:%d:%d) 第%i名",string,PlayerName[playerid],time[0],time[1],time[2],RaceHouse[GameRace[playerid][rgameid]][rtop]);
		ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX,"赛车战绩",string,"确定","");
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
        format(str, sizeof(str), "%s 使用了命令 %s 原因:%s,时间:%d/%d/%d %d:%d:%d,IP:%s\r\n", GetName(playerid), command, text, n, y, day, h, m, s, ip);
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
        format(str, sizeof(str), "%s因%s被系统封杀 %d/%d/%d %d:%d:%d,IP:%s\r\n", GetName(playerid), text, n, y, day, h, m, s, ip);
        pfwrite(hFile, str);
        fclose(hFile);
    }
    DelayedKick(playerid); //延迟T出玩家
    return 1;
}
stock PlayerTextRecord(const text[]) { //记录玩家文字
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
stock PlayerCommandRecord(const text[]) { //记录玩家命令
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
    // violationCode -1:正常账号 0:红点传送 1:Z轴异常 2:载具数据异常 3:吸车喷车 999:管理员封杀 7:Fakekilling 8:CarSpam 10:直线微加速 997 多号未登录攻击
    new msgs[256];
    // new t=3600;
    new t = gettime() + 600;
    // new t = gettime() + 86400 * 7; 默认7天 太久了
    if(PlayerInfo[playerid][bantotal] > 0 && PlayerInfo[playerid][bantotal] <= 100) GiveCreditpoints(playerid, 10);
    mysql_format(g_Sql, msgs, sizeof(msgs), "UPDATE `users` SET `BanTime` = %d,`BanReason` = %d,`bantotal` = %d WHERE `Name` = '%e'", t, violationCode, PlayerInfo[playerid][bantotal], GetName(playerid));
    mysql_pquery(g_Sql, msgs);
    
    format(msgs, sizeof(msgs), "[系统] 玩家:%s 使用第三方辅助严重影响了游戏公平性,Code violation #%d 被反作弊封杀了! ", GetName(playerid), violationCode);
    SCMALL(Color_Red, msgs);
    format(msgs, sizeof(msgs), "原因:系统检测到你最近疑似使用第三方辅助严重影响了游戏公平性,Code violation #%d\n道路千万条 安全第一条\n行车不规范 亲人两行泪\n您的信誉分降至%d\n请检查您的游戏是否含有不允许使用的CLEO等作弊器\n解封时间:0天 0时 10分 0秒,人工无法干预", violationCode, GetPlayerCreditpoints(playerid));
    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "[系统] 与服务器断开连接", msgs, "确定", "");
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
// public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
//     if(playertextid == LetterForYou[playerid][3]) {
//         for (new i; i < 4; i++) {
//             PlayerTextDrawDestroy(playerid, LetterForYou[playerid][i]);
//         }
//         CancelSelectTextDraw(playerid);
//         SendClientMessage(playerid, 0xFFFFFFAA, "谢谢你曾来过GTA:SAMP");
//         if(GetPlayerScore(playerid) < 120) {
//             SendClientMessage(playerid, Color_White, "[系统]检测到您游戏时长未满120分钟，自动打开帮助提示");
//             AntiCommand[playerid] = 0;
//             OnPlayerCommandText(playerid, "/help");
//         }
//         return 1;
//     }
//     return 0;
// }

stock Action_Play(const playerid, const aid) {
    if(aid < 1 || aid > 21) return SCM(playerid, Color_White, "[动作] 你输入的动作ID不存在.");
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
    while (IsModelAPlane(p_ppcCar[playerid]) || IsModelASpecial(p_ppcCar[playerid]) || IsModelABoat(p_ppcCar[playerid])) { //增加判定是否是飞机 是的话就不刷
        DestroyVehicle(p_ppcCar[playerid]);
        veh = random(200) + 400;
        p_ppcCar[playerid] = CreateVehicle(veh, PPC_SpawnPos[rand][ppX], PPC_SpawnPos[rand][ppY], PPC_SpawnPos[rand][ppZ], 0, -1, -1, 60);
    }
    //随机0~211之间的数字 + 400 即车辆ID为400~611
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
        // if(z >= 233 && z<=270 && GetSpeed(playerid)>399) { //这种算法太垃圾了 如果被R也会
        //     FuckAnitCheat(playerid, "碰碰车车速异常");
        //     return 1;
        // }
        if(z < 150 || z > 260) return PPC_Veh(playerid);
        //如果玩家的高度< 150 那就是掉下去了  太高也拉回
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

            format(string, sizeof(string), "{80FF80}物品正在售卖...\n{FFFFFF}[物品ID]:{80FF80} %d\n{FFFFFF}[随机顺序ID]:{80FF80} %d\n{FFFFFF}[模型ID]:{80FF80} %d\n{FFFFFF}[价格]:{80FF80} %d\n{FFFFFF}按{80FF80}Y{FFFFFF}操作", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid], GOODS[GOODS_OPRATEID[playerid]][GoodPrize]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, Color_White, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        } else {
            format(string, sizeof(string), "{80FF80}%s\n{FFFFFF}[主人]:{80FF80} %s\n{FFFFFF}[物品ID]:{80FF80} %d\n{FFFFFF}[随机顺序ID]:{80FF80} %d\n{FFFFFF}[模型ID]:{80FF80} %d\n{FFFFFF}按{80FF80}Y{FFFFFF}操作", GOODS[GOODS_OPRATEID[playerid]][GoodName], GOODS[GOODS_OPRATEID[playerid]][GoodOwner], GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, Color_White, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
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

            format(string, sizeof(string), "{80FF80}物品正在售卖...\n{FFFFFF}[物品ID]:{80FF80} %d\n{FFFFFF}[随机顺序ID]:{80FF80} %d\n{FFFFFF}[模型ID]:{80FF80} %d\n{FFFFFF}[价格]:{80FF80} %d\n{FFFFFF}按{80FF80}Y{FFFFFF}操作", GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid], GOODS[GOODS_OPRATEID[playerid]][GoodPrize]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, Color_White, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        } else {
            format(string, sizeof(string), "{80FF80}%s\n{FFFFFF}[主人]:{80FF80} %s\n{FFFFFF}[物品ID]:{80FF80} %d\n{FFFFFF}[随机顺序ID]:{80FF80} %d\n{FFFFFF}[模型ID]:{80FF80} %d\n{FFFFFF}按{80FF80}Y{FFFFFF}操作", GOODS[GOODS_OPRATEID[playerid]][GoodName], GOODS[GOODS_OPRATEID[playerid]][GoodOwner], GOODS_OPRATEID[playerid], GOODS[GOODS_OPRATEID[playerid]][OrderId], GOODS[GOODS_OPRATEID[playerid]][GoodObjid]);
            GOODS[GOODS_OPRATEID[playerid]][Good3DTextLabel] = CreateDynamic3DTextLabel(string, Color_White, GOODS[GOODS_OPRATEID[playerid]][GoodX], GOODS[GOODS_OPRATEID[playerid]][GoodY], GOODS[GOODS_OPRATEID[playerid]][GoodZ], 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1, GOODS[GOODS_OPRATEID[playerid]][WID]);
        }
        SaveGoods(GOODS_OPRATEID[playerid]);
    }
    return 1;
}


// 2020.3.21新增  从5F直接搬过来的 玩家传送时等待一会让OBJ先加载

stock DynUpdateStart(const playerid) {
    TogglePlayerControllable(playerid, false); // Freeze
    new string[64];
    format(string, sizeof(string), "~g~Objects~n~~r~Loading");
    GameTextForPlayer(playerid, string, 3000, 6);
    PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
    SetTimerEx("DynUpdateEnd", 2000, 0, "i", playerid);
    return 1;
}
function DynUpdateEnd(playerid) {
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


stock Race_CheckPlayerCheat(const ss, const tempcpid) { //赛道高级CP反作弊
    new tmp[128], script[RACE_CP_MAX_FUNCTION], idx;
    new flag;
    for (new i = 0; i < ss; i++) {
        flag = false;
        Race_GetCp_Script(tempcpid, i, script);
        format(script, RACE_CP_MAX_FUNCTION, "%s", script);
        tmp = strtok(script, idx); //tmp取出函数的名字
        if(Race_Cp_Script_Check(tmp) != -1) {
            //如果某个CP点列表里的高级函数 除了特定的会影响反作弊的函数
            // 其他的函数 返回true 如果整个for下来 只要有一个是会影响反作弊判断的 最终导向false
            // 如果整个for判断完了还是true 那就是挂了     
            if(!strcmp(tmp, "time", false)) flag = true;
            if(!strcmp(tmp, "weather", false)) flag = true;
            if(!strcmp(tmp, "msg", false)) flag = true;
            if(!strcmp(tmp, "fix", false)) flag = true;
            if(!strcmp(tmp, "damage", false)) flag = true;
            // 如果以后写了新的函数并且是不影响反作弊的函数就要往里面加
        }
        idx = 0;
    }
    if(flag) return 1;
    return 0; //返回0意味着玩家没作弊
}




CMD:yssy(const playerid, const cmdtext[]) { //延时摄影 by KiVen & YuCarl77
    // if() //如果玩家已经在延时摄影则不允许终止
    // 如果玩家掉线了的时候判断是否在延时摄影 如果是则杀死计时器
    if(PlayerInfo[playerid][yssyjsq] != -1) return SendClientMessage(playerid, Color_White, "[延时]你正在进行延时摄影");
    // KillTimer(PlayerInfo[playerid][yssyjsq]);
    new endminute, endseconds, howlong;
    if(sscanf(cmdtext, "iii", endminute, endseconds, howlong)) return SendClientMessage(playerid, Color_White, "[延时]请输入结束 /yssy 时 分 多长秒数");
    if(endminute > 24 || endminute < 0) return SendClientMessage(playerid, Color_White, "[延时]错误的小时");
    if(endseconds > 60 || endseconds < 0) return SendClientMessage(playerid, Color_White, "[延时]错误的分钟");
    if(howlong > 300 || howlong < 3) return SendClientMessage(playerid, Color_White, "[延时]时间不可低于3秒且不可大于5分钟");
    new howlonginterval = min_test(PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute], endminute, endseconds);
    // if(endminute < PlayerInfo[playerid][tHour]) endminute+=24;
    PlayerInfo[playerid][yssym] = endseconds; //PlayerInfo[playerid][tMinute];//endseconds;
    PlayerInfo[playerid][yssyh] = endminute; //PlayerInfo[playerid][tHour];//endminute;
    PlayerInfo[playerid][yssyjsq] = SetTimerEx("SetPlayerYssyJisuan", 20, true, "ii", playerid, howlonginterval / howlong);
    // 设置玩家的延时摄影状态为真

    //如果玩家在延时摄影的状态则杀死计时器
    return 1;
}

function SetPlayerYssyJisuan(playerid, howlong) {
    //上面给的100毫秒 越低越平滑 但是也要根据时间长度去计算每执行的频率应该给多少分钟每执行频率
    //假设总时长420秒 然后玩家说要3秒后到达420秒 那么就得要每秒7分钟 每100毫秒就是0.7分钟
    // PlayerInfo[playerid][yssym]=PlayerInfo[playerid][yssym]+(howlong/10);
    PlayerInfo[playerid][tMinute] = PlayerInfo[playerid][tMinute] + (howlong / 50);
    if(PlayerInfo[playerid][tMinute] >= 60) {
        PlayerInfo[playerid][tMinute] = 0; //分钟归0
        PlayerInfo[playerid][tHour]++; //小时加1
        if(PlayerInfo[playerid][tHour] >= 24) {
            PlayerInfo[playerid][tHour] = 0; //小时归凌晨
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
    //         SendClientMessage(playerid, Color_White, "[延时]延时结束啦");
    //         KillTimer(PlayerInfo[playerid][yssyjsq]);
    //         PlayerInfo[playerid][yssyjsq]=-1;
    //         // 设置玩家延时摄影状态为假
    //     }
    // }
    // if(hour>=PlayerInfo[playerid][tHour] && minute>= PlayerInfo[playerid][tMinute])
    if(hour >= PlayerInfo[playerid][yssyh] && minute >= PlayerInfo[playerid][yssym]) {
        SendClientMessage(playerid, Color_White, "[延时]延时结束啦");
        KillTimer(PlayerInfo[playerid][yssyjsq]);
        PlayerInfo[playerid][yssyjsq] = -1;
        // 设置玩家延时摄影状态为假
    }
    return 1;
}


stock min_test(sh, sm, eh, em) //开始时，分，结束时，分 返回结束时间
{
    new min_count, hour, minute;
    if(eh < sh) {
        sh = sh - 12;
        eh = eh + 12; //反过来
    }
    hour = (eh - sh) * 60; //其实是游戏里的分  //结束的小时减去开始的小时 其实即使分钟 1分钟 =60秒就是几分钟*60秒
    minute = (em - sm); //其实是游戏里的秒
    if(hour < 0) hour *= -1; //取绝对值 避免结束时间比开始时间小
    if(minute < 0) minute *= -1; //取绝对值
    min_count = hour + minute; //返回的是秒数 
    printf("%d", min_count);
    //反正这个是计算从原本的时间到想要的时间 在原来的时间线上需要多少秒

    // if(sh < eh)//判断开始时是不是大于结束时，就是晚上到第二天早上这种
    // {
    //     sh = sh - 12;
    //     eh = eh + 12;//反过来
    // }
    // min_count = (sh - eh) * 60;//算出小时的间的分钟
    // if(sm > em) min_count += sm - em; 
    // else min_count -= em -sm;
    //就是分钟，大于就是要减 小宇就是要要加
    return min_count;
}
Dialog:HelpSystem(playerid, response, listitem, inputtext[]){
    if(response == 1) {
        new msg[128], idx;
        msg = strtok(inputtext, idx);
        if(!strcmp(msg, "声音篇")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "声音篇", "/sound1~7 听SAMP自带的音乐，这些音乐均有在SAMP赛道档案馆使用哦 例如/sound1\n/soundstop 停止播放音乐", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "赛车系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "赛车系统", "游玩赛道\n编辑赛道", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "个性化设置")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "个性化设置", "/mynetstats 对话框详细网络状态\n/sz 个人设置\n/tianqi 设置自己的天气\n/time 设置自己的时间\n/skin或/hf 更换自己的人物皮肤\n/kgobj 开启或关闭OBJ模型的显示\n/kgname 开启或关闭其他玩家的名字\n/name on/off 开启/关闭其他玩家的名字\n/stunt on/off 开启/关闭屏幕中下方的特技显示", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "日常操作")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "个性化设置", "/pm id 私聊 例如/pm 1\n/xiufu 当人物被卡住的时候可尝试使用该命令哦\n/fxq 刷出一个喷气背包\n/jls刷出一个降落伞，开启快乐的跳伞之旅\n/wuqi 刷出武器，不建议对着其他玩家开枪哦，一般拍视频或娱乐等其他用途使用\n/count或/djs 倒计时，在小范围的附近玩家都可收到你发起的倒计时后，可以一起配合拍视频或飙车等\n/wudi 开启人物无敌\n/ppc 一起畅玩碰碰车吧", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "载具相关")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "载具相关", "/c [车辆ID]来刷车，车辆ID为400-611\n/cc 颜色代码 颜色代码 更换车辆颜色 例如/cc 0 0 \n/c ti 没经过同意就上我车？把他弄出去\n/c wode 不小心把车弄丢了，或走远了，召唤出之前刷出来过的车\n/c suo 锁车 \n/c chepai\n/fix 修复一次你的车辆\n/dcar开启/关闭载具无敌\n/f 翻车时使用.（赛道系统中请使用/kill或下车重生）\n/infobj 警灯和尾翼\n/hys 变色龙", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "世界操作")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "世界操作", "/w 回到大世界，所有玩家默认都在这个世界\n/w id 进入特定的世界\n可以和小伙伴一起去'小世界'里拍摄视频，一起玩耍且不被他人打扰", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "观看玩家")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "观看玩家", "/tv 玩家id 例如/tv 1\n/tv off 关闭观看玩家", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "坐标/传送")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "坐标/传送", "/sp或/s保存目前所处的位置\n/lp或/l传送到之前保存的位置\n/vmake建立一个坐标 格式为/vmake 坐标名(规范英文) 比如vmake ldz\n/telemenu查看所有系统传送点\n即创建了一个名为ldz的坐标下次即可使用/ldz传送\n/tpa发送一个传送请求给玩家 比如/tpa playerid\n/ta接受其他玩家给你发来的请求\n/td拒绝其他玩家给你发来的请求\n/tpa ban屏蔽tpa请求，再次输入关闭", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "管理员指令大全")) {
            if(!PlayerInfo[playerid][AdminLevel]) return SendClientMessage(playerid, Color_White, "[系统]你还不是管理员哦~");
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员指令大全", "LV1\nLV2\nLV3\nLV4\nLV5\nLV?", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "房产系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "房产系统", "房产日常操作\n房产管理员操作", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "家具系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "家具系统", "家具日常操作\n家具管理员操作", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "装扮系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "装扮系统", "/wdzb或/sz查看我的装扮\n/buyattire购买装扮\n装扮购买点/yyk\n购买后不能退回金币", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "广告牌系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "广告牌系统", "在广告牌附近按Y可操作广告牌,可回收金币\n/board buy购买广告牌.\n/board list 查看广告牌列表\n/board goto id传送到广告牌", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "爱车系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "爱车系统", "目前爱车只能由管理员创造./cars buy 可购买爱车 /cars list 查看爱车列表\n /aczb 爱车装扮 /wdac 我的爱车\n", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "团队系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "团队系统", "创建团队/t create 团队列表/t list\n我的团队/t wode或/wdtd\n拉取队友/t get 传送到队员/t goto\n/t invite邀请玩家加入团队\n列表式操作\n团队用户等级分为0,1,2\n0为成员,1为管理员,2为创始者\n管理员可拉取其他玩家为团队成员\n创始者比管理员多一个转让和解散权限", "确定", "返回");
            return 1;
        }
        if(!strcmp(msg, "相机系统")) {
            Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "相机系统", "/cam打开相机\n通过鼠标左键进行创建,比较简单,就不进行详细介绍了", "确定", "返回");
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
            case 0:{ //请求传送
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/tpa ban");
                ShowCustomSettings(playerid);
                // OnPlayerCommandText(playerid, "/tpa ban");
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 1:{ //人物无敌
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/wudi");
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 2:{ //车辆无敌
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/dcar");
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 3:{ //开关OBJ
                AntiCommand[playerid] = 0;
                CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/kgobj");
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
                // break;
            }
            case 4:{ //
                if(PlayerInfo[playerid][AutoFlip]) {
                    PlayerInfo[playerid][AutoFlip] = 0;
                    SendClientMessage(playerid, Color_White, "[系统]车辆自动翻正已关闭");
                } else {
                    PlayerInfo[playerid][AutoFlip] = 1;
                    SendClientMessage(playerid, Color_White, "[系统]车辆自动翻正已开启");
                }
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 5:{ //屏蔽碰撞
                if(PlayerInfo[playerid][NoCrash]) {
                    PlayerInfo[playerid][NoCrash] = 0;
                    DisableRemoteVehicleCollisions(playerid, false);
                    SendClientMessage(playerid, Color_White, "[系统]屏蔽碰撞已关闭");
                } else {
                    PlayerInfo[playerid][NoCrash] = 1;
                    DisableRemoteVehicleCollisions(playerid, true);
                    SendClientMessage(playerid, Color_White, "[系统]屏蔽碰撞已开启");
                }
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 6:{ //速度表
                cmd_sdb(playerid, "");
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
                return 1;
            }
            case 7:{
                if(PlayerInfo[playerid][netStats]) {
                    SendClientMessage(playerid, Color_White, "[系统]网络参数已隐藏");
                    for (new i = 0; i <= 10; i++) {
                        PlayerTextDrawHide(playerid, PlayerText:network_txtdraw[playerid][i]);
                    }
                    PlayerInfo[playerid][netStats] = false;
                } else {
                    SendClientMessage(playerid, Color_White, "[系统]网络参数已显示");
                    for (new i = 0; i <= 10; i++) {
                        PlayerTextDrawShow(playerid, PlayerText:network_txtdraw[playerid][i]);
                    }
                    PlayerInfo[playerid][netStats] = true;
                }
                ShowCustomSettings(playerid);
                // AntiCommand[playerid] = 0;
                // CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
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
                    SCM(playerid, Color_White, "[系统] 已隐藏其他玩家名字.");
                    PlayerInfo[playerid][showName] = 0;
                    ShowCustomSettings(playerid);
                    return 1;
                }
                for (new i = GetPlayerPoolSize(); i >= 0; i--) 
                {
                    ShowPlayerNameTagForPlayer(playerid, i, true);
                }
                SCM(playerid, Color_White, "[系统] 已显示其他玩家名字.");
                PlayerInfo[playerid][showName] = 1;
                ShowCustomSettings(playerid);
                return 1;
            }
            case 9:
            {
                if(PlayerInfo[playerid][showStunt])
                {
                    EnableStuntBonusForPlayer(playerid, 0);
                    SCM(playerid, Color_White, "[系统] 已关闭特技奖励显示.");
                    PlayerInfo[playerid][showStunt] = 0;
                    ShowCustomSettings(playerid);
                    return 1;
                }
                EnableStuntBonusForPlayer(playerid, 1);
                SCM(playerid, Color_White, "[系统] 已开启特技奖励显示.");
                PlayerInfo[playerid][showStunt] = 1;
                ShowCustomSettings(playerid);
                return 1;
            }
            case 10:{ //时间
                Dialog_Show(playerid, PlayerInfo_Time, DIALOG_STYLE_INPUT, "时间设置", "请输入时间,格式:时 分,例如5 30", "确认", "取消");
                // break;
                return 1;
            }
            case 11:{ //天气
                Dialog_Show(playerid, PlayerInfo_Weather, DIALOG_STYLE_INPUT, "天气设置", "0-LA极睛\n1-LA晴\n2-LA极晴雾\n3-LA晴雾\n4-LA阴\n5-SF晴\n6-SF极睛\n7-SF阴\n8-SF雨\n9-SF雾\n10-LV晴\n11-LV热睛\n12-LV阴\n13-乡村极睛\n14-乡村晴\n15-乡村阴\n16-乡村雨\n17-沙漠极睛\n18-沙漠睛\n19-沙漠沙尘暴\n20-水下（绿，雾\n请输入天气，格式:整形 例如12", "确认", "取消");
                return 1;
            }
        }
        return 1;
    }
    // ShowCustomSettings(playerid);
    AntiCommand[playerid] = 0;
    CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
    return 1;
}


stock tdSpeedo_Connect(const playerid) {
    PlayerInfo[playerid][tdSpeed] = INVALID_OBJECT_ID;
    PlayerInfo[playerid][tdEnabled] = 0;
    // gTickCount[playerid] = 0;
}

stock tdSpeedo_Disconnect(const playerid) {
    DestroyDynamicObject(PlayerInfo[playerid][tdSpeed]);
}

stock tdSpeedo_Update(const playerid, Float:velocity) {
    if(!PlayerInfo[playerid][tdEnabled]) return 1;
    // if(!IsPlayerInAnyVehicle(playerid)) {
    //     tdSpeedo_Toggle(playerid, 0);
    //     return 1;
    // } else 
    if(!IsPlayerNPC(playerid)) {
        new speedText[48];
        format(speedText, 48, "%03.0f KMH", velocity);
        SetDynamicObjectMaterialText(PlayerInfo[playerid][tdSpeed], 0, speedText, OBJECT_MATERIAL_SIZE_512x256, "Arial", 52, false, Color_White, 0, OBJECT_MATERIAL_TEXT_ALIGN_RIGHT);
    }
    return 1;
}

stock tdSpeedo_Toggle(const playerid, const activate) {
    if(activate) {
        if(PlayerInfo[playerid][tdEnabled]) return 1;
        new vid = GetPlayerVehicleID(playerid);
        new vmod = GetVehicleModel(vid);
        PlayerInfo[playerid][tdSpeed] = CreateDynamicObject(19482, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, playerid, 200.0);
        new Float:vX, Float:vY, Float:vZ;
        GetVehicleModelInfo(vmod, VEHICLE_MODEL_INFO_SIZE, vX, vY, vZ);
        if(vX < 1.5) vX = 1.5;
        AttachDynamicObjectToVehicle(PlayerInfo[playerid][tdSpeed], vid, vX - 1.75, -1.0, -0.6, 0.0, 0.0, -110.0);
        Streamer_Update(playerid);
        PlayerInfo[playerid][tdEnabled] = 1;
		return 1;
    }
    if(PlayerInfo[playerid][tdSpeed] != INVALID_OBJECT_ID) {
        DestroyDynamicObject(PlayerInfo[playerid][tdSpeed]);
        PlayerInfo[playerid][tdSpeed] = INVALID_OBJECT_ID;
    }
    PlayerInfo[playerid][tdEnabled] = 0;
    return 1;
}

stock ShowCustomSettings(const playerid)
{
    new tpaState[32], wdState[32], fixState[32], objShow[32], autoflip[32], time[32], tweather[32], pbpz[32], sdb[32], net[32];
    new showName_[32], showStunt_[32], tmp[384];
    if(tpaB[playerid] == 3) format(tpaState, sizeof(tpaState), "接受玩家传送消息:{00FF00}开");
    else format(tpaState, sizeof(tpaState), "接受玩家传送消息:{FF0000}关");

    if(PlayerInfo[playerid][enableInvincible]) format(wdState, sizeof(wdState), "伪无敌状态:{00FF00}开");
    else format(wdState, sizeof(wdState), "伪无敌状态:{FF0000}关");

    if(PlayerInfo[playerid][AutoFix]) format(fixState, sizeof(fixState), "自动修车:{00FF00}开");
    else format(fixState, sizeof(fixState), "自动修车:{FF0000}关");

    if(!PlayerInfo[playerid][displayObject]) format(objShow, sizeof(objShow), "OBJ显示:{FF0000}关");
    else format(objShow, sizeof(objShow), "OBJ显示:{00FF00}开");

    if(PlayerInfo[playerid][AutoFlip]) format(autoflip, sizeof(autoflip), "车辆翻正:{00FF00}开");
    else format(autoflip, sizeof(autoflip), "车辆翻正:{FF0000}关");

    if(PlayerInfo[playerid][NoCrash]) format(pbpz, sizeof(pbpz), "屏蔽碰撞:{00FF00}开");
    else format(pbpz, sizeof(pbpz), "屏蔽碰撞:{FF0000}关");

    if(PlayerInfo[playerid][speedoMeter]) format(sdb, sizeof(sdb), "速度表:{00FF00}开");
    else format(sdb, sizeof(sdb), "速度表:{FF0000}关");

    if(PlayerInfo[playerid][netStats]) format(net, sizeof(net), "网络参数:{00FF00}开");
    else format(net, sizeof(net), "网络参数:{FF0000}关");

    if(PlayerInfo[playerid][showName]) format(showName_, sizeof(showName_), "玩家名称:{00FF00}开");
    else format(showName_, sizeof(showName_), "玩家名称:{FF0000}关");

    if(PlayerInfo[playerid][showStunt]) format(showStunt_, sizeof(showStunt_), "特效奖励:{00FF00}开");
    else format(showStunt_, sizeof(showStunt_), "特效奖励:{FF0000}关");

    format(time, sizeof(time), "我的时间:%02d:%02d", PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute]);
    format(tweather, sizeof(tweather), "我的天气:%d", PlayerInfo[playerid][tWeather]);
    format(tmp, sizeof(tmp), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s", tpaState,wdState,fixState,objShow,autoflip,pbpz,sdb,net,showName_,showStunt_,time,tweather);
    // format(tmp, sizeof(tmp), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",tpaState,?wdState,?fixState,?objShow,?autoflip,?pbpz,?sdb,?net,?showName_, showStunt_, time,?tweather);
    Dialog_Show(playerid, CustomSettings, DIALOG_STYLE_LIST, "个性化设置", tmp, "确认", "返回");
}

Dialog:helpMessageBox(playerid, response, listitem, inputtext[]){
    if(!response) {
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/help");
        return 1;
        // OnPlayerCommandText(playerid, "/help");
    }
    new msg[128], idx;
    msg = strtok(inputtext, idx);
    if(!strcmp(msg, "LV1")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员LV1", "监狱:/jail\n踢出:/kick传送:/goto\n拉人:/get\n赛道编辑/r edit", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "LV2")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员LV2", "(解封)封杀:/(un)ban\n禁用载具:/jyzj", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "LV3")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员LV3", "图标变色:/acolor(暂不可用)", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "LV4")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员LV4", "奖励金钱:/givecash\n/creategoods 创建家具\n/delgoods删除家具 /board delete 删除广告牌\n/attire 创建装扮 /cars create 创建爱车\n/selectnpc 传送NPC /showname 关闭或显示NPC名字", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "LV5")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员LV5", "刷新服务器:/gmx\n创建系统传送点:/vsmake\n/houseedit 房产编辑 /attire装扮 /reset重置用户密码", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "LV?")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "管理员LV?", "给予玩家GM:/admin\n取消给予玩家GM:/undmin", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "房产日常操作")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "房产系统", "/house goto 可传送至房屋.\n/house buy 可购买房屋.\n/house sell 可出售房屋.\n/house text 可更改简介.\n/house list 可查看房屋列表.\n/house glist 可查看房屋权限列表.\n/house adp 可给予房屋操作权限.\n/house rdp 可移除房屋操作权限.\n/house gdp 可查看房屋操作权限.\n/house sellto 可出售给指定他人.\n/house buyit 可接受他人发来的卖方申请", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "房产管理员操作")) {
        SendClientMessage(playerid, Color_White, "[系统] 请输入/houseedit");
        return 1;
    }
    if(!strcmp(msg, "家具日常操作")) {
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/goodshelp");
        // OnPlayerCommandText(playerid, "/goodshelp");
        return 1;
    }
    if(!strcmp(msg, "家具管理员操作")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "家具管理员系统", "/creategoods 创建家具\n/delgoods删除家具\n/resetgoods 重置家具", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "游玩赛道")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "赛车系统", "[赛车] 帮助:/r s (赛道名),开启/开始比赛,赛道名可省略\n[赛车] 帮助:/r j,加入比赛\n[赛车] 帮助:/r l,离开比赛\n[赛车] 帮助:/r page 页数,跳转到你想要的页数\n[赛车] 帮助:/r create,创建赛道\n[赛车] 帮助:/r edit,编辑赛道帮助\n赛道系统中翻车请下车或/kill重生", "确定", "返回");
        return 1;
    }
    if(!strcmp(msg, "编辑赛道")) {
        Dialog_Show(playerid, helpMessageBox, DIALOG_STYLE_LIST, "赛车系统", "如不是管理员则只可编辑自己创建的赛道\n[赛车]帮助:/r edit [赛道名] [赛道编辑密码],编辑赛道\n[赛车]帮助:/r edit q 退出编辑模式\n[赛车]帮助:/r edit cpsize,设置/查看当前编辑cp的尺寸\n[赛车]帮助:/r edit d,界面操作\n[赛车]帮助:/r edit cp,在当前位置放置一个cp点\n[赛车]帮助:/r edit trg,查看触发说明", "确定", "返回");
        return 1;
    }
    return 1;
}
Dialog:Dialog_Register(playerid, response, listitem, inputtext[]) {
    if(!response) return Kick(playerid);
    if(!strlen(inputtext)) return Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "注册", "该帐号还没有被{22DD22}注册{FFFFFF},请输入密码进行{22DD22}注册..", "注册", "退出");
    if(strlen(inputtext) < 6 || strlen(inputtext) > 16) return Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "注册", "{FFFFFF}请输入密码进行{22DD22}注册{FFFFFF},密码必须为{22DD22}6-16位之间!.", "注册", "退出");
    if(!IsValidPassword(inputtext)) return Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "注册", "该帐号还没有被注册,请输入密码进行注册.", "注册", "退出");
    OnPlayerRegister(playerid, inputtext);
    return 1;
}
Dialog:Dialog_Login(playerid, response, listitem, inputtext[]) {
    if(!response) {
        // ShowPlayerDialog(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
        // return 1;
        return Kick(playerid); //没登录的话然后弹出玩家安全中心 并且只留找回密码的入口
    }
    if(!strlen(inputtext)) return Dialog_Show(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "登录", "{00FFFF}你的账号已注册\n{00FFFF}请在下面输入你的密码.你还有{80FF80}3次机会{00FFFF}输入密码", "登录", "退出");
    OnPlayerLogin(playerid, inputtext);
    return 1;
}
Dialog:weapons(playerid, response, listitem, inputtext[]) {
    if(GetPlayerCreditpoints(playerid) <= 90) return SendClientMessage(playerid, Color_Yellow, "[系统]您的游戏信誉分过低,请健康游戏,将会自动补回");
    if(response == 1) {
        switch (listitem) {
            case 0:{
                GivePlayerWeapon(playerid, 4, 1);
                return 1;
            }
            case 1:{
                GivePlayerWeapon(playerid, 5, 1);
                return 1;
            }
            case 2:{
                GivePlayerWeapon(playerid, 22, 5000);
                return 1;
            }
            case 3:{
                GivePlayerWeapon(playerid, 23, 5000);
                return 1;
            }
            case 4:{
                GivePlayerWeapon(playerid, 24, 5000);
                return 1;
            }
            case 5:{
                GivePlayerWeapon(playerid, 25, 5000);
                return 1;
            }
            case 6:{
                GivePlayerWeapon(playerid, 26, 5000);
                return 1;
            }
            case 7:{
                GivePlayerWeapon(playerid, 27, 5000);
                return 1;
            }
            case 8:{
                GivePlayerWeapon(playerid, 32, 5000);
                return 1;
            }
            case 9:{
                GivePlayerWeapon(playerid, 28, 5000);
                return 1;
            }
            case 10:{
                GivePlayerWeapon(playerid, 29, 5000);
                return 1;
            }
            case 11:{
                GivePlayerWeapon(playerid, 30, 5000);
                return 1;
            }
            case 12:{
                GivePlayerWeapon(playerid, 31, 5000);
                return 1;
            }
            case 13:{
                GivePlayerWeapon(playerid, 33, 5000);
                return 1;
            }
            case 14:{
                GivePlayerWeapon(playerid, 34, 5000);
                return 1;
            }
            case 15:{
                GivePlayerWeapon(playerid, 35, 5000);
                return 1;
            }
            case 16:{
                GivePlayerWeapon(playerid, 36, 5000);
                return 1;
            }
            case 17:{
                GivePlayerWeapon(playerid, 37, 5000);
                return 1;
            }
            case 18:{
                GivePlayerWeapon(playerid, 16, 5000);
                return 1;
            }
            case 19:{
                GivePlayerWeapon(playerid, 17, 5000);
                return 1;
            }
            case 20:{
                GivePlayerWeapon(playerid, 18, 5000);
                return 1;
            }
            case 21:{
                GivePlayerWeapon(playerid, 39, 5000);
                GivePlayerWeapon(playerid, 40, 1);
                return 1;
            }
            case 22:{
                GivePlayerWeapon(playerid, 41, 5000);
                return 1;
            }
            case 23:{
                GivePlayerWeapon(playerid, 42, 5000);
                return 1;
            }
            case 24:{
                GivePlayerWeapon(playerid, 38, 5000);
                return 1;
            }
        }
    }
    return 1;
}
Dialog:MessageBox(playerid, response, listitem, inputtext[]) {
    return 1;
}
Dialog:Dialog_Tail(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(PlayerInfo[playerid][Cash] < 3000) return SendClientMessage(playerid, Color_White, "[小尾巴]您的金币不足3000");
        if(strlen(inputtext) < 4 || strlen(inputtext) > 32) {
            SendClientMessage(playerid, Color_White, "[小尾巴]长度异常,范围为2~16个汉字,4~32个其他字符");
            return cmd_motto(playerid, "");
        }
        if(strfind(inputtext, "\\", true) != -1 || strfind(inputtext, " ", true) != -1 || strfind(inputtext, "[", true) != -1 || strfind(inputtext, "]", true) != -1) {
            SendClientMessage(playerid, Color_White, "[小尾巴]不需要带[],不允许使用空格,\\等符号");
            return cmd_motto(playerid, "");
        }
        if(strfind(inputtext, "管理", true) != -1 || strfind(inputtext, "GM", false) != -1 || strfind(inputtext, "admin", false) != -1) {
            SendClientMessage(playerid, Color_White, "[小尾巴]您不可使用管理员等相关前缀");
            return cmd_motto(playerid, "");
        }
        if(strcmp(inputtext, "null", false) == 0) {
            format(PlayerInfo[playerid][Tail], 33, "");
            SendClientMessage(playerid, Color_White, "[小尾巴]清除成功!");
            return 1;
        }
        new placeholder;
        for (new i = 0; i < sizeof InvalidWords; i++) //屏蔽词自动变*
        {
            placeholder = strfind(inputtext, InvalidWords[i], true);
            if(placeholder != -1) return SendClientMessage(playerid, Color_White, "[小尾巴]存在不允许使用的名称");
        }
        format(PlayerInfo[playerid][Tail], 33, inputtext);
        GivePlayerCash(playerid, -3000);
        SendClientMessage(playerid, Color_White, "[小尾巴]更换成功!");
    }
    return 1;
}
Dialog:Dialog_Designation(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(PlayerInfo[playerid][Cash] < 3000) return SendClientMessage(playerid, Color_White, "[称号]您的金币不足3000");
        if(strfind(inputtext, "{", true) == 0 && strfind(inputtext, "}", true) == 7) //判断是否有设置颜色 有的话长度不能超过5个汉字
        {
            if(strlen(inputtext) < 2 || strlen(inputtext) > 18) {
                SendClientMessage(playerid, Color_White, "[称号]称号长度异常,范围为1~5个汉字,2~10个其他字符");
                return cmd_wdch(playerid, "");
            }
        } else {
            if(strlen(inputtext) < 2 || strlen(inputtext) > 10) {
                SendClientMessage(playerid, Color_White, "[称号]称号长度异常,范围为1~5个汉字,2~10个其他字符");
                return cmd_wdch(playerid, "");
            }
        }
        if(strfind(inputtext, "\\", true) != -1 || strfind(inputtext, " ", true) != -1 || strfind(inputtext, "[", true) != -1 || strfind(inputtext, "]", true) != -1) {
            SendClientMessage(playerid, Color_White, "[称号]称号不需要带[],不允许使用空格,\\等符号");
            return cmd_wdch(playerid, "");
        }
        if(strfind(inputtext, "管理", true) != -1 || strfind(inputtext, "GM", false) != -1 || strfind(inputtext, "admin", false) != -1) {
            SendClientMessage(playerid, Color_White, "[称号]您不可使用管理员等相关前缀");
            return cmd_wdch(playerid, "");
        }
        if(strcmp(inputtext, "null", false) == 0) {
            format(PlayerInfo[playerid][Designation], 19, "");
            SendClientMessage(playerid, Color_White, "[称号]清除成功!");
            return 1;
        }
        new placeholder;
        for (new i = 0; i < sizeof InvalidWords; i++) //屏蔽词自动变*
        {
            placeholder = strfind(inputtext, InvalidWords[i], true);
            if(placeholder != -1) return SendClientMessage(playerid, Color_White, "[称号]称号中存在不允许使用的名称");
        }
        format(PlayerInfo[playerid][Designation], 19, inputtext);
        GivePlayerCash(playerid, -3000);
        SendClientMessage(playerid, Color_White, "[称号]更换称号成功!");
    }
    return 1;
}
Dialog:Dialog_SpawnVehicle(playerid, response, listitem, inputtext[]) {
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
Dialog:ClickPlayer(playerid, response, listitem, inputtext[]) {
    if(!response) return 1;
    new idx, tmp[128];
    tmp = strtok(inputtext, idx);
    if(strcmp(tmp, "最近比赛") == 0) {
        // 列举比赛时间 赛道名 记录 几月几号的时候
        // 然后上一页和下一页
        Race_ShowRecentlyRacing(playerid, SelectRecentlyRacePage[playerid], SelectRecentlyClicked[playerid]);
        return 1;
    }
    return 1;
}
// 最近100场比赛
Dialog:RecentlyRacing(playerid, response, listitem, inputtext[]) {
    if(!response) return 1;
    new idx, tmp[128];
    tmp = strtok(inputtext, idx);
    if(strcmp(tmp, "上一页") == 0) {
        new mxpage = GetMaxPage(Race_GetPlayerRecordCut(playerid));
        if(SelectRecentlyRacePage[playerid] == 1 || SelectRecentlyRacePage[playerid] == mxpage) return Race_ShowRecentlyRacing(playerid, 1, SelectRecentlyClicked[playerid]);
        SelectRecentlyRacePage[playerid]--;
        Race_ShowRecentlyRacing(playerid, SelectRecentlyRacePage[playerid], SelectRecentlyClicked[playerid]);
        return 1;
    }
    if(strcmp(tmp, "下一页") == 0) {
        new mxpage = GetMaxPage(Race_GetPlayerRecordCut(playerid));
        if(SelectRecentlyRacePage[playerid] == 5 || SelectRecentlyRacePage[playerid] == mxpage) return Race_ShowRecentlyRacing(playerid, mxpage, SelectRecentlyClicked[playerid]);
        SelectRecentlyRacePage[playerid]++;
        Race_ShowRecentlyRacing(playerid, SelectRecentlyRacePage[playerid], SelectRecentlyClicked[playerid]);
        return 1;
    }
    SendClientMessage(playerid, Color_White, "[举报]正在开发中...");
    return 1;
}

stock Race_ShowRecentlyRacing(const playerid, const page, const clickedplayerid) //为指定玩家显示最近比赛记录,page表示页数
{
    new DBResult:rf, s, msg[128], string[1200];
    // format(msg, sizeof msg, "SELECT `p_record`,`rid`,`finish_time` FROM `Race_record` WHERE `uid` = %d ORDER BY `finish_time` DESC LIMIT %d,%d", PlayerInfo[clickedplayerid][ID], (page-1)*20, page * 20);
    format(msg, sizeof msg, "SELECT `p_record`,`rid`,`finish_time` FROM `Race_record` WHERE `uid` = %d ORDER BY `finish_time` DESC LIMIT 100", PlayerInfo[clickedplayerid][ID]);
    rf = db_query(Racedb, msg);
    s = db_num_rows(rf);
    if(s == 0) return SendClientMessage(playerid, Color_White, "[系统]暂无任何记录");
    new title[64];
    format(title, sizeof(title), "{0088FF}最近比赛%d/%d页",page, GetMaxPage(s));
    format(string, sizeof(string), "上一页", string);
    // for (new i = 0; i < s; i++) {
    new cutPage = page * 20;
    if(cutPage > s) cutPage = s;
    for (new i = (page - 1) * 20; i < cutPage; i++) {
        // 获取比赛完成时间tick
        db_get_field_assoc(rf, "p_record", msg, sizeof(msg));
        new tick = strval(msg);
        new time[3];
        ms2time(time, tick);
        db_get_field_assoc(rf, "rid", msg, sizeof(msg));
        new ridtemp = strval(msg);
        db_get_field_assoc(rf, "finish_time", msg, sizeof(msg));
        new finish_time = strval(msg);
        // db_free_result(rf);

        new year, month, day, hour, minute, second;
        TimestampToDate(finish_time, year, month, day, hour, minute, second, 8);

        new DBResult:rf_two;
        format(msg, sizeof msg, "SELECT `rname` FROM `Race` WHERE `rid` = %d", ridtemp);
        rf_two = db_query(Racedb, msg);
        new rnametemp[32];
        db_get_field_assoc(rf_two, "rname", rnametemp, sizeof(rnametemp));
        db_free_result(rf_two);

        format(string, sizeof(string), "%s\n%d\t%s\t%02d:%02d:%02d [%s秒]\t%d-%d-%d %02d:%02d:%02d", string, i, rnametemp, time[0], time[1], time[2], MsToS(tick), year, month, day, hour, minute, second);
        // for (new i = (page - 1) * 20; i < page * 20; i++) {
        //     format(string, sizeof(string), "%s\n赛道名 %s\t\t记录 %02d:%02d:%02d [%s秒]\t\t完成日期 %d-%d-%d %02d:%02d:%02d", string, rnametemp, time[0], time[1], time[2], MsToS(tick), year, month, day, hour, minute, second);
        // }
        db_next_row(rf);
    }
    db_free_result(rf);
    format(string, sizeof(string), "%s\n下一页", string);
    Dialog_Show(playerid, RecentlyRacing, DIALOG_STYLE_LIST, title, string, "举报", "关闭");
    return 1;
}


function OnLoginTimeout(playerid)
{
    PlayerInfo[playerid][LoginTimer] = -1;
    if(!PlayerInfo[playerid][Login])
    {
        Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "登陆", "你被请出了服务器！原因:超时未登录!", "确定", "");
        DelayedKick(playerid);
    }
	return 1;
}

stock DelayedKick(const playerid, const time = 500)
{
	SetTimerEx("_KickPlayerDelayed", time, false, "d", playerid);
	return 1;
}

Dialog:PlayerInfo_ChangeName(playerid, response, listitem, inputtext[]) {
    if(response) {
        if(PlayerInfo[playerid][Cash] < 6000) return SendClientMessage(playerid, Color_White, "[系统]您的账户余额不足6000,不足够用于改名");
        if(strlen(inputtext) < 4 || strlen(inputtext) > 24) return SendClientMessage(playerid, Color_White, "[系统]用户名长度错误");
        new placeholder;
        for (new i = 0; i < sizeof InvalidWords; i++) //屏蔽词自动变*
        {
            placeholder = strfind(inputtext, InvalidWords[i], true);
            if(placeholder != -1) {
                SendClientMessage(playerid, Color_White, "[系统]不可使用非法用户名");
                return 1;
            }
        }
        if(strfind(inputtext, "{", true) != -1 || strfind(inputtext, "}", true) != -1) {
            return SendClientMessage(playerid, Color_White, "[系统]用户名不可带有{}");
        }
        new flag = false;
        for (new i = 0; i < strlen(inputtext); i++) {
            if((inputtext[i] >= 48 && inputtext[i] <= 57) || (inputtext[i] >= 65 && inputtext[i] <= 125)) flag = true;
            else flag = false;
        }
        if(!flag) return SendClientMessage(playerid, Color_White, "[系统]用户名由[0-9a-Z_]组成");
        // 只要判断是否有重名的，没有就直接根据UID UPDATE用户名就可以了
        if(AccountCheck(inputtext)) return SendClientMessage(playerid, Color_White, "[系统]这个用户名已经被人使用了哦");
        new name[25];
        format(name, sizeof name, GetName(playerid));
        for (new i = 0; i < MAX_SELL; i++) {
            if(mk_strcmp(p_Sell[i][sell_player], name) == 0) ChangeSellPlayer(i, inputtext); // 检查玩家有没有房子 有的话房子名字全转移了
        }
        for (new i = 0; i < loadcount; i++) { // 检查玩家有没有家具 有的话家具转移
            if(mk_strcmp(GOODS[i][GoodOwner], name) == 0) {
                format(GOODS[i][GoodOwner], 65, inputtext);
                format(GOODS[i][GoodName], 125, "%s 的物品", inputtext);
                UpdateGoods3dtextlabel(i);
                SaveGoods(i);
            }
        }
        new query[128];
        mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `Name` = '%e' WHERE `ID` = %d", inputtext, PlayerInfo[playerid][ID]);
        mysql_pquery(g_Sql, query);
        GivePlayerCash(playerid, -6000);
        SetPlayerName(playerid, inputtext);
        SendClientMessage(playerid, Color_White, "[系统]更换用户名成功");
    }
    return 1;
}
Dialog:PlayerInfoDialog(playerid, response, listitem, inputtext[]) {
    if(response == 1) {
        switch (listitem) {
            case 0:{ //我的邮箱
                // if(!strcmp(msg, "我的邮箱")) {
                if(PlayerInfo[playerid][yzwrong] >= 6) {
                    new msgs[512];
                    new t = gettime() + 86400;
                    mysql_format(g_Sql, msgs, sizeof(msgs), "UPDATE `users` SET `YzBantime` = %d where `Name` = '%e'", t, GetName(playerid));
                    mysql_pquery(g_Sql, msgs);
                    Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "您验证次数过多,请明天再来尝试!", "确定", "");
                    return 1;
                } else {
                    Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
                }
                return 1;
                // break;
            }
            case 1:{ //装扮
                ShowPlayerAttireDialog(playerid);
                return 1;
            }
            case 2:{ //家具
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
                ShowCustomSettings(playerid);
                return 1;
            }
        }
        return 1;
    }
    return 1;
}
Dialog:PlayerSafeCenter(playerid, response, listitem, inputtext[]) {
    if(!response) {
        if(!PlayerInfo[playerid][Login]) {
            // ShowPlayerDialog(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
            Kick(playerid);
            return 1;
        }
        AntiCommand[playerid] = 0;
        CallRemoteFunction("OnPlayerCommandText", "is", playerid, "/sz");
        return 1;
    }
    switch (listitem) {
        case 0:{
            Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
            return 1;
        }
        case 1:{
            if(PlayerInfo[playerid][Yztime] != 0) {
                Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
            }
            if(PlayerInfo[playerid][yzwrong] >= 6) {
                new Query[128];
                new t = gettime() + 86400;
                mysql_format(g_Sql, Query, sizeof(Query), "UPDATE `users` SET `YzBantime` = %d WHERE `Name` = '%e'", t, GetName(playerid));
                mysql_pquery(g_Sql, Query);
                Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "您验证次数过多,请明天再来尝试!", "确定", "");
                return 1;
            }
            if(strcmp(pemail[playerid], "-1") == 0) {
                Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "暂时验证!", "确定", "");
                return 1;
            }
            new Query[128];
            mysql_format(g_Sql, Query, sizeof(Query), "SELECT * FROM `users` WHERE `name` = '%e'", GetName(playerid));
            mysql_pquery(g_Sql, Query, "OnEmailResendQuery", "ds", playerid, inputtext);
            return 1;
        }
        case 2:{
            new Query[128];
            mysql_format(g_Sql, Query, sizeof(Query), "SELECT * FROM `users` WHERE `name` = '%e'", GetName(playerid));
            mysql_pquery(g_Sql, Query, "OnEmailSettingQuery", "d", playerid);
            return 1;
        }
        case 3:{
            if(strcmp(pemail[playerid], "-1") == 0) {
                Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "暂时不支持验证!", "确定", "");
                return 1;
            }
            if(PlayerInfo[playerid][yzmode] == 1) {
                Dialog_Show(playerid, PlayerPassChangeCAPTCHA, DIALOG_STYLE_LIST, "安全和邮箱", "\n请选择↓↓↓↓↓\n输入验证码", "确定", "取消");
                return 1;
            }
            Dialog_Show(playerid, EmailCAPTCHA, DIALOG_STYLE_INPUT, "安全和邮箱", "{FFFFFF}请输入:{33CCCC}验证码", "确定", "取消");
            return 1;
        }
        case 4:{
            if(PlayerInfo[playerid][yzwrong] >= 3) {
                SCM(playerid, Color_White, "[系统]请不要短时间内重复设置邮箱!");
                return 1;
            }
            if(PlayerInfo[playerid][Yztime] != 0) {
                SCM(playerid, Color_White, "[系统]请不要短时间内重复设置邮箱!");
                return 1;
            }
            new query[128];
            mysql_format(g_Sql, query, sizeof(query), "SELECT * FROM `users` WHERE `name` = '%e'", GetName(playerid));
            mysql_pquery(g_Sql, query, "OnPlayerChangePassQuery", "d", playerid);
            return 1;
        }
        case 5:{
            if(!PlayerInfo[playerid][Login]) return Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
            Dialog_Show(playerid, PlayerInfo_ChangeName, DIALOG_STYLE_INPUT, "{FFFF00}安全系统", "请输入您要修改成的用户名\n不可使用中文名、敏感词等字符,如失误造成账号遗失由自己负责\nUID终身不变,修改一次用户名需6000金币", "确定", "取消");
            return 1;
        }
    }
    return 1;
}
Dialog:PlayerInfo_Weather(playerid, response, listitem, inputtext[]) {
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
Dialog:PlayerInfo_Time(playerid, response, listitem, inputtext[]) {
    if(response == 1) {
        new str[32], temp[32], thour[128], tminute[128], hour, minute, idx;
        format(temp, 32, "%s", inputtext);
        thour = strtok(temp, idx);
        hour = strval(thour);
        tminute = strtok(temp, idx);
        minute = strval(tminute);
        if(hour < 0 || hour > 24) return SCM(playerid, Color_LightBlue, "[时间] /time 时 分 小时为0~24,分为0~59");
        if(minute < 0 || minute > 59) return SCM(playerid, Color_LightBlue, "[时间] /time 时 分 小时为0~24,分为0~59");
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
Dialog:PlayerEmailSet(playerid, response, listitem, inputtext[]) {
    if(response == 1) {
        if(strfind(inputtext, "@", true) == -1) {
            Dialog_Show(playerid, PlayerEmailSet, DIALOG_STYLE_INPUT, "安全和邮箱", "{FFFF00}您输入的邮箱账号格式有误\n{33CCCC}请在下面输入您的邮箱进行验证", "确定", "取消");
            return 1;
        }
        if(strlen(inputtext) < 5 || strlen(inputtext) > 48) 
        {
            Dialog_Show(playerid, PlayerEmailSet, DIALOG_STYLE_INPUT, "安全和邮箱", "{FFFF00}您输入的邮箱账号长度错误,支持5~48位\n请在下面输入您的邮箱进行验证", "确定", "取消");
            return 1;
        }
        new query[128];
        mysql_format(g_Sql, query, sizeof(query), "SELECT `email` FROM `users` WHERE `email` = '%e'", inputtext);
        mysql_pquery(g_Sql, query, "UpdateEmailQuery", "ds", playerid, inputtext);
        return 1;
    }
    Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
    return 1;
}
Dialog:EmailCAPTCHA(playerid, response, listitem, inputtext[]) {
    if(response == 1) {
        new query[128];
        mysql_format(g_Sql, query, sizeof(query), "SELECT * FROM `users` WHERE `name` = '%e'", GetName(playerid));
        mysql_pquery(g_Sql, query, "On_CAPTCHA_Query", "ds", playerid,inputtext);
        return true;
    }
    Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
    return true;
}

Dialog:PlayerPassWordChange(playerid, response, listitem, inputtext[]) {
    if(response == 1) {
        if(!strlen(inputtext)) return Dialog_Show(playerid, PlayerPassWordChange, DIALOG_STYLE_INPUT, "{FFFF00}安全中心", "{9AFF9A}欢迎!\n请在下面输入密码来完成修改!\n请牢记您的账号密码!\n已采用散列技术，无需担心数据泄露", "确定", "取消");
        if(strlen(inputtext) < 6 || strlen(inputtext) > 16) Dialog_Show(playerid, PlayerPassWordChange, DIALOG_STYLE_INPUT, "{FFFF00}邮箱验证系统", "{FFFFFF}验证成功!请输入6-16位的{FFFF00}新密码！", "确定", "取消");
        // new query[256];
        // mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `yz` = 1,`email` ='%e' WHERE `name` = '%e'", pemail[playerid], GetName(playerid));
        // mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `email` ='%e' WHERE `name` = '%e'", pemail[playerid], GetName(playerid));
        // mysql_pquery(g_Sql, query);
        OnPlayerReloadRegister(playerid, inputtext);
    }
    Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
    return 1;
}

Dialog:PlayerPassChangeCAPTCHA(playerid, response, listitem, inputtext[]) {
    if(response == 1) {
        new query[128];
        mysql_format(g_Sql, query, sizeof(query), "SELECT * FROM `users` WHERE `name` = '%e'", GetName(playerid));
        mysql_pquery(g_Sql, query, "On_CAPTCHA_PChange_Query", "ds", playerid, inputtext);
        return 1;
    }
    Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
    return 1;
}

function OnEmailResendQuery(playerid, inputtext[])
{
    if(cache_num_rows()) {
        new yz,string[128];
        cache_get_value_name_int(0, "yz", yz);
        if(yz == 1) 
        {
            Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "你已设置邮箱保护,若账号密码遗忘可用邮箱找回!", "确定", "");
            return 1;
        }
        format(string, sizeof(string), "127.0.0.1/email.php?name=%s&email=%s", GetName(playerid), inputtext);
        HTTP(playerid, HTTP_GET, string, "", "MyHttpResponseEX");
        mysql_format(g_Sql, string, sizeof(string), "UPDATE `users` SET `email` = '%e' WHERE `name` = '%e'", inputtext, GetName(playerid));
        mysql_pquery(g_Sql, string);
        format(pemail[playerid], MAX_EMAIL_LENGTH, "%s", inputtext);
        PlayerInfo[playerid][Yztime] = 60;
        PlayerInfo[playerid][yzwrong]++;
        Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", "\n请选择↓↓↓↓↓\n重新发送(需要60秒后)\n设置邮箱\n输入验证码\n修改密码\n修改用户名", "确定", "取消");
        SendClientMessage(playerid, Color_White, "系统:如果收不到验证请尝试更换其他邮箱,否则频繁更换会被禁止验证1天!");
    }
    // //这个else新写的 因为他默认是注册的时候才插入数据 而在此功能之前已经注册的是没有数据的 所以需要插入一次数据 
    // // 2020.3.29补 如果有问题移掉
    // else 
    // {
    //     new Query2[256];
    //     format(Query2, 256, "INSERT INTO `players` (`name`,`code`,`email`,`yz`) VALUES('%s',0,0,0)", GetName(playerid));
    //     mysql_query(Query2);
    //     mysql_free_result();
    // }
    return true;
}
function OnEmailSettingQuery(playerid)
{
    if(cache_num_rows() != 0) {
        new yz;
        cache_get_value_name_int(0, "yz", yz);
        if(yz == 1) 
        {
            Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "你已设置邮箱保护,若账号密码遗忘可用邮箱找回!", "确定", "");
            return true;
        }
    }
    if(PlayerInfo[playerid][Yztime]) Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", MailDialogContent, "确定", "取消");
    else Dialog_Show(playerid, PlayerEmailSet, DIALOG_STYLE_INPUT, "安全和邮箱", "{FFFFFF}请输入:{33CCCC}你的邮箱", "确定", "取消");
    return true;
}
function OnPlayerChangePassQuery(playerid)
{
    if(cache_num_rows() != 0) {
        new yz,string[128];
        cache_get_value_name_int(0, "yz", yz);
        if(yz == 1) 
        {
            cache_get_value_name(0, "email", pemail[playerid], MAX_EMAIL_LENGTH);
            format(string, sizeof(string), "127.0.0.1/email.php?name=%s&email=%s", GetName(playerid), pemail[playerid]);
            HTTP(playerid, HTTP_GET, string, "", "MyHttpResponseEX");
            
            mysql_format(g_Sql, string, sizeof(string), "UPDATE `users` SET `email` = '%e' WHERE `name` = '%e'", pemail[playerid], GetName(playerid));
            mysql_pquery(g_Sql, string);

            PlayerInfo[playerid][Yztime] = 60;
            PlayerInfo[playerid][yzmode] = 1;
            format(pemail[playerid], MAX_EMAIL_LENGTH, "%s", pemail[playerid]);
            Dialog_Show(playerid, PlayerPassChangeCAPTCHA, DIALOG_STYLE_LIST, "安全和邮箱", "\n请选择↓↓↓↓↓\n输入验证码", "确定", "取消");
            return true;
        }
        // Dialog_Show(playerid, MessageBox, DIALOG_STYLE_MSGBOX, "系统", "你还没设置邮箱保护!请先设置!", "确定", "");
        // 2020.2.28 取消机制 没设置保护邮箱一样支持修改密码
        SCM(playerid, Color_White, "[系统]您还未设置安全邮箱,建议设置邮箱以方便找回");
        Dialog_Show(playerid, PlayerPassWordChange, DIALOG_STYLE_INPUT, "{FFFF00}安全系统", "{9AFF9A}欢迎!\n请在下面输入密码来完成修改!\n请牢记您的账号密码!\n已采用散列技术，无需担心数据泄露", "确定", "取消");
        return true;
    }
    return false;
}
function UpdateEmailQuery(playerid, inputtext[])
{
    if(cache_num_rows()) 
    {
        Dialog_Show(playerid, PlayerEmailSet, DIALOG_STYLE_INPUT, "安全和邮箱", "{FFFF00}您输入的邮箱账号{FF0000}已被注册{FFFF00}\n{33CCCC}请在下面输入您的邮箱进行验证", "确定", "取消");
        return 1;
    }
    new string[256];
    format(string, sizeof(string), "127.0.0.1/email.php?name=%s&email=%s", GetName(playerid), inputtext);
    HTTP(playerid, HTTP_GET, string, "", "MyHttpResponseEX");

    mysql_format(g_Sql, string, sizeof(string), "UPDATE `users` SET `email` = '%e' WHERE `name` = '%e'", inputtext, GetName(playerid));
    mysql_pquery(g_Sql, string);

    format(pemail[playerid], MAX_EMAIL_LENGTH, "%s", inputtext);
    PlayerInfo[playerid][Yztime] = 60;
    Dialog_Show(playerid, PlayerSafeCenter, DIALOG_STYLE_LIST, "安全和邮箱", "\n请选择↓↓↓↓↓\n重新发送(需要60秒后)\n设置邮箱\n输入验证码\n修改密码\n修改用户名", "确定", "取消");
    return 1;
}

function On_CAPTCHA_Query(playerid, inputtext[])
{
    if(cache_num_rows())
    {
        cache_get_value_name(0, "code", pcode[playerid]);
        if(strcmp(pcode[playerid], inputtext, true) == 0) {
            new query[256];
            mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `yz` = 1,`email` ='%e' WHERE `name` = '%e'", pemail[playerid], GetName(playerid));
            mysql_pquery(g_Sql, query);
            SendClientMessage(playerid, Color_White, "[系统]恭喜您,邮箱验证成功!");
            format(pemail[playerid], MAX_EMAIL_LENGTH, "-1");
            PlayerInfo[playerid][yzwrong] = 0;
            PlayerInfo[playerid][yzmode] = 0;
            return true;
        } 
        Dialog_Show(playerid, EmailCAPTCHA, DIALOG_STYLE_INPUT, "邮箱验证系统", "验证码输入错误\n请在下面输入您的验证进行验证", "确定", "取消");
        PlayerInfo[playerid][yzwrong]++;
        return true;
    }
    return true;
}

function On_CAPTCHA_PChange_Query(playerid, inputtext[])
{
    if(cache_num_rows()) 
    {
        cache_get_value_name(0, "code", pcode[playerid], MAX_PCODE_LENGTH);
        if(strcmp(pcode[playerid], inputtext, true) == 0) {
            Dialog_Show(playerid, PlayerPassWordChange, DIALOG_STYLE_INPUT, "{FFFF00}邮箱验证系统", "{FFFFFF}验证成功!请输入{FFFF00}新密码！", "确定", "取消");
            PlayerInfo[playerid][yzwrong] = 0;
            PlayerInfo[playerid][yzmode] = 0;
            return 1;
        }
        Dialog_Show(playerid, PlayerPassChangeCAPTCHA, DIALOG_STYLE_INPUT, "{FFFF00}邮箱验证系统", "验证码输入错误\n请在下面输入您的验证进行验证", "确定", "取消");
        PlayerInfo[playerid][yzwrong]++;
        return 1;
    }    
    return true;
}

stock CheckPlayerEmailEd(playerid) {
    // 这些是邮箱保护  
    new Query[128];
    mysql_format(g_Sql, Query, sizeof(Query), "SELECT * FROM `users` WHERE `name` = '%e'", GetName(playerid));
    mysql_pquery(g_Sql, Query, "IsPlayerEmailed", "d", playerid);
}

function IsPlayerEmailed(playerid)
{
    if(cache_num_rows() != 0) {
        new yz;
        cache_get_value_name_int(0, "yz", yz);
        if(yz == 1) SCM(playerid, Color_White, "[系统]你已设置邮箱保护,若账号密码遗忘可用邮箱找回!使用/sz可以打开界面");
        else SCM(playerid, Color_White, "[系统]你还未设置邮箱保护,若账号密码遗忘可用邮箱找回!使用/sz可以打开界面");
    }
    return true;
}

function OnPlayerDataLoaded(playerid, race_check) {
    /*	race condition check:
        player A connects -> SELECT query is fired -> this query takes very long
        while the query is still processing, player A with playerid 2 disconnects
        player B joins now with playerid 2 -> our laggy SELECT query is finally finished, but for the wrong player

        what do we do against it?
        we create a connection count for each playerid and increase it everytime the playerid connects or disconnects
        we also pass the current value of the connection count to our OnPlayerDataLoaded callback
        then we check if current connection count is the same as connection count we passed to the callback
        if yes, everything is okay, if not, we just kick the player
    */
    if (race_check != g_MysqlRaceCheck[playerid]) return Kick(playerid);
    for (new i = 0; i <= 7; i++) {
        TextDrawShowForPlayer(playerid, Screen[i]);
    }
    // InterpolateCameraPos(playerid, random(6000) - 3000, random(6000) - 3000, random(120) + 50, random(6000) - 3000, random(6000) - 3000, random(120) + 50, 60000, CAMERA_MOVE);
    // new rand = random(sizeof(randSounds));
    // PlaySoundForPlayer(playerid, randSounds[rand]);
    new string[128];
    if(cache_num_rows() > 0)
    {
        // we store the password and the salt so we can compare the password the player inputs
        // and save the rest so we won't have to execute another query later
        cache_get_value(0, "Password", PlayerInfo[playerid][Password], 65);
        cache_get_value(0, "Salt", PlayerInfo[playerid][Salt], 12);
        
        new last_login_timestamp;
        cache_get_value_name_int(0, "LastLogin", last_login_timestamp);
        new year, month, day, hour, minute, second;
        TimestampToDate(last_login_timestamp, year, month, day, hour, minute, second, 8);
        // saves the active cache in the memory and returns an cache-id to access it for later use
        PlayerInfo[playerid][Cache_ID] = cache_save();

        format(string, sizeof(string), "欢迎,您的账号已注册\n请在下方输入密码登陆\n最后一次在线时间 %d-%d-%d %02d:%02d:%02d", year, month, day, hour, minute, second);
        Dialog_Show(playerid, Dialog_Login, DIALOG_STYLE_PASSWORD, "RaceSpeedTime团队官方服务器", string, "登录", "退出");

        // from now on, the player has 30 seconds to login
        PlayerInfo[playerid][LoginTimer] = SetTimerEx("OnLoginTimeout", 90 * 1000, false, "d", playerid);
    }
    else
    {
        Dialog_Show(playerid, Dialog_Register, DIALOG_STYLE_PASSWORD, "RaceSpeedTime团队官方服务器", "请在下方输入密码来完成注册!\n请牢记您的账号名字!\n已采用散列技术，无需担心数据泄露", "注册", "退出");
    }
    return 1;    
}



UpdatePlayerData(playerid, reason)
{
	if (PlayerInfo[playerid][Login] == false) return 0;

	// if the client crashed, it's not possible to get the player's position in OnPlayerDisconnect callback
	// so we will use the last saved position (in case of a player who registered and crashed/kicked, the position will be the default spawn point)
	// if (reason == 1)
	// {
	// 	GetPlayerPos(playerid, Player[playerid][X_Pos], Player[playerid][Y_Pos], Player[playerid][Z_Pos]);
	// 	GetPlayerFacingAngle(playerid, Player[playerid][A_Pos]);
	// }
	
	// new query[145];
	// mysql_format(g_SQL, query, sizeof query, "UPDATE `players` SET `x` = %f, `y` = %f, `z` = %f, `angle` = %f, `interior` = %d WHERE `id` = %d LIMIT 1", Player[playerid][X_Pos], Player[playerid][Y_Pos], Player[playerid][Z_Pos], Player[playerid][A_Pos], GetPlayerInterior(playerid), Player[playerid][ID]);
	// mysql_tquery(g_SQL, query);
    
    for (new a = 0; a <= 21; a++) {
        PlayerTextDrawDestroy(playerid, velo[playerid][a]);
    }
    for (new i = 0; i <= 10; i++) 
    {
        PlayerTextDrawDestroy(playerid, PlayerText:network_txtdraw[playerid][i]);
    }
    new query[512], saveinfo[512];
    strins(saveinfo, "UPDATE `users` SET `AdminLevel`=%d,`Skin`=%d,`Score`=%d,`Cash`=%d,`JailSeconds`=%d,`Yzwrong`=%d,`YzBantime`=%d,`LastLogin`='%d',`Designation`='%s',`Tail`='%s' WHERE `Name` = '%e'", strlen(saveinfo));
    // format(msg, sizeof(msg), "", PlayerInfo[playerid][AdminLevel], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Score], PlayerInfo[playerid][Cash], PlayerInfo[playerid][JailSeconds], PlayerInfo[playerid][yzwrong], PlayerInfo[playerid][yzbantime], string, GetName(playerid));
    mysql_format(g_Sql, query, sizeof(query), saveinfo, PlayerInfo[playerid][AdminLevel], PlayerInfo[playerid][Skin], PlayerInfo[playerid][Score], PlayerInfo[playerid][Cash], PlayerInfo[playerid][JailSeconds], PlayerInfo[playerid][yzwrong], PlayerInfo[playerid][yzbantime], gettime(), PlayerInfo[playerid][Designation], PlayerInfo[playerid][Tail], GetName(playerid));
    mysql_pquery(g_Sql, query);

    // 保存玩家设置
    mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `tWeather`= %d,`tHour`= %d,`tMinute`= %d,`NoCrash`= %d,`AutoFlip`= %d WHERE `Name` = '%e'", PlayerInfo[playerid][tWeather], PlayerInfo[playerid][tHour], PlayerInfo[playerid][tMinute], PlayerInfo[playerid][NoCrash], PlayerInfo[playerid][AutoFlip], GetName(playerid));
    mysql_pquery(g_Sql, query);
    mysql_format(g_Sql, query, sizeof query, "UPDATE `users` SET `displayObject`= %d,`speedoMeter`= %d,`AutoFix`= %d,`enableInvincible`= %d, `netStats`=%d WHERE `Name` = '%e'", PlayerInfo[playerid][displayObject], PlayerInfo[playerid][speedoMeter], PlayerInfo[playerid][AutoFix], PlayerInfo[playerid][enableInvincible], PlayerInfo[playerid][netStats], GetName(playerid));
    mysql_pquery(g_Sql, query);

    // 经验值
    mysql_format(g_Sql, query, sizeof query, "UPDATE `users` SET `exp`= %d, `pLevel` = %d where `Name` = '%e'", PlayerInfo[playerid][exp], PlayerInfo[playerid][plevel], GetName(playerid));
    mysql_pquery(g_Sql, query);

    HouseSellPlayerInitialize(playerid); //不知道 好像是PHouse里初始化sellto和buyit的
    if(dinfobj[playerid] == 1) {
        DestroyDynamicObject(jd[playerid]); //销毁警灯
        DestroyDynamicObject(wy[playerid]); //销毁尾翼
        dinfobj[playerid] = 0; //2020.1.12 理论修复infobj重新上线后没后清除上一个玩家的问题
    }
    if(PlayerInfo[playerid][CreateCar] == 1) {
        DestroyVehicle(PlayerInfo[playerid][BuyID]);
        PlayerInfo[playerid][CreateCar] = 0;
    }
    //TpCheck[playerid] = 0;
    if(p_ppcCar[playerid]) DestroyVehicle(p_ppcCar[playerid]);
    PlayerInfo[playerid][BuyID] = 0;
    PlayerInfo[playerid][CarLock] = 0;
    PlayerInfo[playerid][lastZpos] = 0; //上一秒的Z轴坐标 用于反载具数据异常作弊
    PlayerInfo[playerid][lastVehSpeed] = 0; //上一秒的车速 用于反载具数据异常作弊
    Cleantpa(playerid);
    tdSpeedo_Disconnect(playerid);
    Race_OnPlayerDisconnect(playerid); //玩家下线后赛车系统处理
    PHouse_OnPlayerDisconnect(playerid); //玩家下线后房屋系统处理
    Boards_OnPlayerDisconnect(playerid); //玩家下线后公告牌的处理
    DeathMatch_OnPlayerDisconnect(playerid); //DM下线后的处理
    Camera_OnPlayerDisConnect(playerid);//摄像机下线后的处理
    if(PlayerInfo[playerid][yssyjsq] != -1) KillTimer(PlayerInfo[playerid][yssyjsq]);
    // DestroyDynamic3DTextLabel(NoDieTime[playerid]); //删除无敌时间的3D文字
    // TextDrawDestroy(ReSpawningText[playerid]);
    // Delete3DTextLabel(NoDieTime[playerid]);
    for (new i = GetPlayerPoolSize(); i >= 0; i--) { //如果这个玩家下线，有人在观看他，那么对应的观看他的人应该关闭tv
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
                SendClientMessage(i, Color_Orange, "[TV]:对方下线了，取消TV.");
            }
        }
    }


    //家具下线保存
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
    new Reasons[][] = {
        "(掉线)",
        "(正常退出)",
        "(Kick/Ban)"
    };
    // printf("[玩家]%s(%d)离开了服务器,原因:[%s].", GetName(playerid), playerid, Reasons[reason]);
    new string[128];
    format(string, sizeof(string), "[系统]:%s (%d) 离开了服务器 (%s) ^^^", GetName(playerid), playerid, Reasons[reason]);
    SCMALL(Color_LightBlue, string);
    // SendDeathMessage(playerid, playerid, 201);
    SendDeathMessage(INVALID_PLAYER_ID, playerid, 201);
	return 1;
}
// 初始化玩家表
stock SetupPlayerTable()
{
    new string[2048];
    strins(string, "CREATE TABLE IF NOT EXISTS `users`  (", strlen(string));
    strins(string, "`ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,", strlen(string));
    strins(string, "`Name` varchar(24),", strlen(string));
    strins(string, "`Password` char(64),", strlen(string));
    strins(string, "`Salt` char(11),", strlen(string));
    strins(string, "`AdminLevel` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`Skin` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`Score` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`Cash` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`JailSeconds` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`BanTime` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`BanReason` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`Yzwrong` int(11) NULL DEFAULT 0,", strlen(string));
    strins(string, "`YzBanTime` int(11) NULL DEFAULT 0,", strlen(string));
    strins(string, "`RegDate` varchar(33) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`LastLogin` varchar(33) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`Designation` varchar(19) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`Tail` varchar(33) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`tHour` int(11) NOT NULL DEFAULT 12,", strlen(string));
    strins(string, "`tMinute` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "`NoCrash` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`AutoFlip` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`displayObject` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`speedoMeter` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`AutoFix` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`enableInvincible` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`tWeather` int(11) NOT NULL DEFAULT 10,", strlen(string));
    strins(string, "`netStats` int(11) NOT NULL DEFAULT 1,", strlen(string));
    strins(string, "`exp` int(11) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`pLevel` int(11) NULL DEFAULT 1,", strlen(string));
    strins(string, "`code` varchar(5) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`email` varchar(48) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`yz` varchar(2) NULL DEFAULT NULL,", strlen(string));
    strins(string, "`bantotal` int(11) NOT NULL DEFAULT 0,", strlen(string));
    strins(string, "PRIMARY KEY (`ID`),", strlen(string));
    strins(string, "UNIQUE INDEX `Name`(`Name`));", strlen(string));
    mysql_pquery(g_Sql, string);
	return 1;
}


static stock ReSetAllPlayerPass() {
    // 因为数据库Salt大改，并且曾经存在BUG，所以只临时使用

    new cuts, Cache:result = mysql_query(g_Sql, "SELECT * FROM `users`");
    cuts = cache_num_rows();
    for(new i = 0; i < cuts; i++)
    {
        new pID;
        cache_get_value_name_int(i, "ID", pID);
        new temp[65], pSalt[12]; // 散列技术生成散列码
        for (new j = 0; j < 11; j++) {
            pSalt[j] = random(25) + 97;
        }
        SHA256_PassHash("123456", pSalt, temp, 65); //规定65固定
        new query[256];
        mysql_format(g_Sql, query, sizeof(query), "UPDATE `users` SET `Password` = '%e',`Salt` = '%e' WHERE `ID` = %d", temp, pSalt, pID);
        mysql_pquery(g_Sql, query); 
    }
    cache_delete(result);
    printf("重置完毕");
}



function MyHttpResponseEX(index, response_code, sData[]) {
    new buffer[128];
    new h, m, s, y, day, d;
    new msg[128];
    if(response_code == 200) {
        gettime(h, m, s);
        getdate(y, day, d);
        format(msg, 128, "[安全]验证码已经成功发送到你的邮箱,请查看邮箱进行验证[%d.%d.%d][%d:%d:%d]", y, day, d, h, m, s);
        // format(msg, 128, "邮件发送成功[%d.%d.%d][%d:%d:%d]", y, day, d, h, m, s);
        SendClientMessage(index, Color_White, msg);
        return 1;
    } 
    format(buffer, sizeof(buffer), "[安全]邮件发送失败,错误代码[%d]", response_code);
    SendClientMessage(index, Color_White, buffer);
    return 1;
}