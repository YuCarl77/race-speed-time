//�ʴ�ϵͳ

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

	ʹ�ø�����֤����������������Ȩ�ޣ���ѣ��κ��˿��Եõ����������������ĵ���һ��������
	���Ҿ�Ӫ�����������κ����ƣ����������Ƶ�ʹ�á����ơ��޸ġ��ϲ������桢���С����Ŵ���֤�顢���߳��۸������Ŀ�����Ȩ����
	ͬʱ���������Щ�������û�������ЩȨ����ʹ����������������  
	
	���ϵİ�Ȩ֪ͨ��Ȩ��֪ͨӦ�ð��������и������Ŀ����л�������������������ʵ�����С�
	
	�������������������ṩ��û���κ���ʽ�ĵ�������������ȷ�ػ��߰����ģ�������Щ���ǲ�����ҵ���ʵĵ��������ơ�
	�ʺ�һ���ض�����;���Ҳ����ַ������ߺͰ�Ȩ���������κγ��϶�ʹ�ø������漰���κ�Ҫ���𺦻����������ζ���Ӧ����
	�����������������û���ֻ�Ǻ�ͬ��ʽ��������Ȩ����������ʽ�������������������÷�Χ�ڡ������������ϵ����������ʹ�û�����������������������Ϊ��  
	=====================================   
*/

//  �����ң����ڿ�Դ��д��лǰ�����˵����������֮���١�
//  �����޸���5F��Prace,PHouse,Goods�ȿ�Դ �ر���л��[Ghost]Rui ushio_p [Ghost]Dylan
//  �¾����ɾ�������Դ,������:[ITC]dyq  [ITC]fangye  [ITC]Super_wlc [ITC]RR_LXD  mk124  Shindo(aka. ssh)  vvg, yezizhu(aka. yzz)
//  �ر���л ryddawn ������OBJָ����[Fire]KiVen JoshenKM
//  �ر���л GoodsSys Episodes KiVen juse
//  �ر���л GTAUN GTABBS 
// RST�Ŷӷ�����������Ҫ��[R_ST]Hygen��YuCarl77���쵼


#define MAX_QA		100
#define QAPosition  "QA/questionAnswer.cfg"

enum qatype {
    Questions[256],
        Answers[256]
};
new QA_Info[MAX_QA][qatype], QA_Count, QA_Timer[4];
stock Initialize_QA() {
    for (new i = 0; i < MAX_QA; i++) {
        format(QA_Info[i][Questions], 2, "0");
        format(QA_Info[i][Answers], 2, "0");
    }
    QA_Count = 0; //�ʴ�������
    QA_Timer[0] = 0; //���������˶��ٷ���
    QA_Timer[1] = 2; //������һ���ʴ� ���1����
    QA_Timer[2] = 0; //���㵽�ڼ���������
    QA_Timer[3] = 0; //�����ʴ� 1 = ��, 0 = ��
    print("[��ʾ]�ʴ�ϵͳ��ʼ��");
    if(fexist(QAPosition) == 1) {
        new File:m = fopen(QAPosition, io_read), info[256], msg[256], idx = 0;
        while (fread(m, info)) {
            msg = strtok(info, idx);
            if(mk_strcmp(msg, "qa") == 0) Common_AddQA(info);
            idx = 0;
        }
        fclose(m);
        printf("[�ʴ�]������[%d/%d]���ʴ�.", QA_Count, MAX_QA);
    } else {
        printf("δ�ҵ��ʴ�ϵͳ(questionAnswer.cfg from questionAnswer.inc)");
    }
}
stock Common_AddQA(const info[]) {
    new id = -1;
    for (new i = 0; i < MAX_QA; i++) {
        if(strlen(QA_Info[i][Questions]) < 2) {
            id = i;
            i = MAX_QA + 1;
        }
    }
    if(id == -1) {
        printf("�ʴ��Ѵﵽ����(MAX_QA from questionAnswer.inc)");
    }
    new msg[512], idx;
    msg = strtok(info, idx);
    // printf("%s", strtok(info, idx));
    new question[256];
    question = strtok(info, idx);
    new answer[256];
    answer = strtok(info, idx);
    format(QA_Info[id][Questions], 256, question);
    format(QA_Info[id][Answers], 256, answer);
    printf("[�ʴ�]����%s? ��[%s]",QA_Info[id][Questions],QA_Info[id][Answers]);
    QA_Count++;
}
stock Common_Running_QA() {
    if(QA_Count == 0) return 1;
    QA_Timer[0]++;
    if(QA_Timer[0] >= QA_Timer[1]) {
        QA_Timer[0] = 0;
        // if(QA_Timer[2] >= QA_Count - 1) {
        if(QA_Timer[2] >= QA_Count) { //����1�Ļ�����鲻�����һ���� 2020.3.2.1014�����޸�
            QA_Timer[2] = 0;
        }
        else  {
            new msg[256];
            format(msg, sizeof msg, "[С��ʾ] ��һ��[%s]? �� [%s]", QA_Info[QA_Timer[2]][Questions],QA_Info[QA_Timer[2]][Answers]);
            SendClientMessageToAll(0x22DDB8C8, msg);
            // 2020.3.1 �������������ʴ�֧��С��ʾ�� �޸����ʴ��Ƶ��
            // QA_Timer[2]++; ԭ���ǰ�˳������ ����ֱ�����
            QA_Timer[2] = random(QA_Count); //������Qa_Count+1�� ���������0?�����������Ҫȥ����
            QA_Timer[3] = 1;
            format(msg, sizeof msg, "[�������] %s?", QA_Info[QA_Timer[2]][Questions]);
            SendClientMessageToAll(0x22DDB8C8, msg);
        }
    }
    return 1;
}
stock Common_Answer_QA(const playerid, const answer[]) {
    if(QA_Timer[3] == 1 && mk_strcmp(answer, QA_Info[QA_Timer[2]][Answers],false) == 0) {
        QA_Timer[3] = 0;
        new msg[256], money = random(300);
        PlayerInfo[playerid][Cash] += money;
        format(msg, sizeof msg, "[�������] ��ϲ %s(%d) �ش���ȷ. {00FF40}$%d", GetName(playerid), playerid, money);
        SendClientMessageToAll(Color_Yellow, msg);
    }
}