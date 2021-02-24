/*
 /\\\\\\\\\\     /\\\\\\\\\\ /\\\\\\\\\\\\
 \/\\\____/\\\  /\\\_______/ \/___/\\\___/
  \/\\\   \/\\\ \/\\\             \/\\\
   \/\\\\\\\\/   \/\\\\\\\\\\      \/\\\
    \/\\\  \/\\\  \/_______/\\\     \/\\\
     \/\\\   \/\\\         \/\\\     \/\\\
      \/\\\   \/\\\  /\\\\\\\\\/      \/\\\
       \/_/    \/_/  \/_______/        \/_/

       �������Ƿ�Ϊ��PC�ˣ�����GameMode�������䡣
       ���������������Ҫʹ�ñ���Դ�룬�������޸�����mysql��
       �˽ű���غ�����������filterscript���޷���gamemode��ֱ��ʹ��
*/

#include <a_samp>
#include <a_mysql>
// ����mysql�ȷ���������Ϣ
#include <common/services/connect>


new MySQL:g_Android;

// ����������ű�
#define FILTERSCRIPT

public OnFilterScriptInit() {
    print("---------------------------------------------------");
    print("Android Adapter Scripts By RaceSpeedTime,loading...");
    print("---------------------------------------------------");
    // ���Ӱ�׿�������ݿ�
    g_Android = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
    new errno = mysql_errno(g_Android);
    if(g_Android == MYSQL_INVALID_HANDLE || errno != 0) {
        new error[100];
        new rand = random(89999) + 10000;
        new string[64];

        mysql_error(error, sizeof(error), g_Android);
        printf("[ERROR] #%d '%s'", errno, error);
        print("[MySQL]�޷����ӵ�MYSQL������");

        format(string, sizeof(string), "password %d", rand);
        SendRconCommand(string);
        SendRconCommand("hostname [����]RaceSpeedTime���ݿ����ʧ��,����ϵ����Ա");
        SetGameModeText("Error - �����ƶ����쳣");
        return 1;
    }
    return 1;
}

public OnFilterScriptExit() {
    mysql_close(g_Android);
    print("---------------------------------------------------");
    print("Android Adapter Scripts By RaceSpeedTime,unloading...");
    print("---------------------------------------------------");
    return 1;
}


public OnPlayerConnect(playerid) {
    // �����NPC������
    if(IsPlayerNPC(playerid)) return 1;
    // �������ʱ���ͼ��
    SendClientCheck(playerid, 0x48, 0, 0, 2);
    return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata) {
    printf("%d %d", playerid, actionid);
    if(actionid != 0x48) {
        // ��׿�������ƶ���
        new query[96];
        mysql_format(g_Android, query, sizeof(query), "INSERT INTO `compat_android` VALUES (%d)", playerid);
        mysql_pquery(g_Android, query);
        return 1;
    }
    return 1;
}


public OnPlayerDisconnect(playerid) {
    // �����NPC������
    if(IsPlayerNPC(playerid)) return 1;
    // �������ʱ������İ�׿����
    new query[96];
    mysql_format(g_Android, query, sizeof(query), "DELETE FROM `compat_android` WHERE `pid` = %d", playerid);
    mysql_pquery(g_Android, query);
    return 1;
}