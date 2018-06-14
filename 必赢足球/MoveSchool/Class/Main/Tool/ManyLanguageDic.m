//
//  ManyLanguageDic.m
//  Main
//
//  Created by yuhongtao on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//  重写set方法来得到最新的不是懒加载

#import "ManyLanguageDic.h"

static ManyLanguageDic *manyLanguageDic = nil;

@implementation ManyLanguageDic
+ (ManyLanguageDic *)sharedManager
{
    static ManyLanguageDic *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


-(NSDictionary *)tabbarDic{
    _tabbarDic=@{
                 
                 //  3 热点   0 课程  1 互动    2 我的
                 @"0" :  @[@"课程",@"互动",@"我的",@"热点"],
                 @"1" :  @[@"Course",@"Interaction",@"My",@"Hotspots"],
                 @"2" :  @[@"커리큘럼",@"인터랙션",@"나의",@"인기"],
                 @"3" :  @[@"カリキュラム",@"インタラクテブ",@"私の",@"ホット"],
                 @"4" :  @[@"Cursus",@"Interactie",@"Mijn",@"Hotspots"]
                 };
    
    return _tabbarDic;
}



-(NSDictionary *)hotTabbarDic{
    
    _hotTabbarDic=@{
                    @"首页" :  @{@"0":@"首页",@"1":@"HomePage",@"2":@"홈",@"3":@"トップページ",@"4":@"HomePage"},
                    @"互动" :  @{@"0":@"互动",@"1":@"Interaction",@"2":@"인터랙션",@"3":@"インタラクテブ",@"4":@"Interactie"},
                    @"我的" :  @{@"0":@"我的",@"1":@"My",@"2":@"나의",@"3":@"私の",@"4":@"Mijn"},
                    @"发现" :  @{@"0":@"发现",@"1":@"Find",@"2":@"발견",@"3":@"発見",@"4":@"Find"},
                    };
    
    return _hotTabbarDic;
}

-(NSDictionary *)refreshDic{
    
    _refreshDic=@{
                  @"下拉可以刷新" :  @{@"0":@"下拉可以刷新",@"1":@"Pull down to refresh",@"2":@"드롭 다운 새로 고칠 수 있다",@"3":@"プルダウンをプルダウンて更新することができます",@"4":@"- kan opfrissen."},
                  @"松开立即刷新" :  @{@"0":@"松开立即刷新",@"1":@"Interaction",@"2":@"인터랙션",@"3":@"インタラクテブ",@"4":@"Interactie"},
                  @"正在刷新数据中..." :  @{@"0":@"正在刷新数据中...",@"1":@"Undo immediate refresh",@"2":@"놓다, 즉시 새로 고침",@"3":@"すぐに更新して",@"4":@"Maak onmiddellijk."},
                  @"正在加载更多的数据..." :  @{@"0":@"正在加载更多的数据...",@"1":@"Loading more data...",@"2":@"더 많은 데이터를 불러오는 중...",@"3":@"もっと多くのデータをロードしている…",@"4":@"- meer gegevens..."},
                  @"已经全部加载完毕" :  @{@"0":@"已经全部加载完毕",@"1":@"Has been fully loaded",@"2":@"이미 모두 불러오기 완료",@"3":@"もう全部アドインして",@"4":@"Al geladen."},
                  };
    
    return _refreshDic;
}

-(NSDictionary *)introduceDic{
    
    _introduceDic=@{
                    @"0":@"网易足球（www.ydxt.com）是北京智同体科技有限公司的产品，我们以培养企业岗位技能人才为己任，立志让每一家企业都有网易足球，为企业用户提供贴心周到的服务。网易足球，专注于企业移动学习三大板块业务：移动学习平台建设、精品微课开发、社群学习运营服务。现有成熟产品：网易足球（PC端+APP+H5）、2000余门Flash精品微课、近100个项目化社群学习运营服务专案，为1000余家企业、培训机构提供移动学习服务。",
                    @"1":@"ydxt.com is committed to providing its global customers with professional online training services and systematic training solutions that offer a promised enjoyable learning experience and help users obtain a broad range of knowledge. Taking advantage of its rich experiences in finance industry and the advanced internet technologies, the company aims to foster an ecological circle  for coaching sustainable learning capacities by integrating resources of high-quality programs and lecturers, encouraging users to improve through knowledge sharing and mutual learning, and adopting a concept of community learning and crowd innovation.",
                    @"2":@"거노버(ydxt.com)는 글로벌 고객들을 위하여 전문화 된 온라인 교육 서비스 및 체계적인 교육 솔루션을 제공하는 데 주력하고 있습니다. 풍부한 금융 업계의 경험과 선진적인 인터넷 기술을 기반으로 거노버는 가장 우수한 커리큘럼 자원과 강사 자원을 집결하여, 모든 사용자들이 나눔에 참여하고 서로 도우면서 성장하며, 그룹 스터디를 통하여 구성원들이 함께 만들어 나가는 이념으로, 지속적인 스터디 능력을 갖춘 금융 교육 생태권을 만들어 내고자 합니다.",
                    @"3":@"「ydxt」（ydxt.com）は世界中のお客様にプロのオンライントレーニングサービス及びシステム化の育成解決案を提供する。喜びを感じて歌い、話したことを厳守し、学んでから知識が豊になるという理念に従って、金融業界での豊な経験と先進的なインターネット技術を生かし、「iglobalview」に一番いいカリキュラムの資源、講師の資源を集まり、ユーザー一人ひとりが分かちあい、互いに成長できるように励ます。コミュニティで勉強、共に創造する理念を利用して、持続的に勉強できる金融育成のコミュニティを作る。",
                    @"4":@"ydxt (ydxt.com)  is toegewijd om haar wereldwijde klanten met professionele online opleidingsdiensten en systematische training oplossingen die bieden een beloofde aangenaam leerervaring en helpen gebruikers verkrijgen een breed scala aan kennis.Voordeel halend uit haar rijke ervaringen in de financiële sector en de geavanceerde internet-technologieën, het bedrijf beoogt te bevorderen van een ecologische cirkel van financiële opleiding voor duurzame leren capaciteiten coaching door de integratie van de middelen van kwalitatief hoogstaande programma's en docenten, moedigen gebruikers te verbeteren door het delen van kennis en het wederzijds leren, en de vaststelling van een concept van Gemeenschap leren en innovatie in de menigte."
                    };
    
    return _introduceDic;
}

#pragma mark 往下根据字符串查询
-(NSDictionary *)hotTypeDic{
    
    _hotTypeDic=@{
                  @"课程" :  @{@"0":@"课程",@"1":@"Course",@"2":@"커리큘럼",@"3":@"カリキュラム",@"4":@"Cursus"},
                  @"学习" :  @{@"0":@"学习",@"1":@"Study",@"2":@"학습",@"3":@"勉強する",@"4":@"Leren"},
                  @"直播" :  @{@"0":@"直播",@"1":@"Live telecast",@"2":@"생방송",@"3":@"生中継",@"4":@"Wonen televisie-uitzending"},
                  @"讲师" :  @{@"0":@"讲师",@"1":@"Lecturer",@"2":@"강사",@"3":@"講師",@"4":@"Docent"},
                  @"问卷" :  @{@"0":@"问卷",@"1":@"Questionnaire",@"2":@"설문",@"3":@"アンケート",@"4":@"Vragenlijst"},
                  @"沙龙" :  @{@"0":@"沙龙",@"1":@"Salon",@"2":@"모임",@"3":@"生サロン",@"4":@"Salon"},
                  @"专题" :  @{@"0":@"专题",@"1":@"Special topic",@"2":@"토픽",@"3":@"特定のテーマ",@"4":@"Speciale onderwerp"},
                  @"资讯" :  @{@"0":@"资讯",@"1":@"Information",@"2":@"뉴스",@"3":@"ニュース",@"4":@"Informatie"},
                  @"考试" :  @{@"0":@"考试",@"1":@"Test",@"2":@"시험",@"3":@"テスト",@"4":@"Test"},
                  @"圈子" :  @{@"0":@"圈子",@"1":@"Circle",@"2":@"서클",@"3":@"コミュニティ",@"4":@"Cirkel"},
                  @"问答" :  @{@"0":@"问答",@"1":@"Questions and answers",@"2":@"Q&A",@"3":@"質疑応答",@"4":@"Vragen en antwoorden"},
                  @"圈子回复" :  @{@"0":@"圈子回复",@"1":@"Circle reply",@"2":@"서클 답장",@"3":@"コミュニティの返事",@"4":@"Cirkel antwoord"},
                  @"总共" :  @{@"0":@"总共",@"1":@"Tota",@"2":@"모두",@"3":@"計",@"4":@"Total"},
                  @"剩余" :  @{@"0":@"剩余",@"1":@"and",@"2":@"s이며, 아직 사용이 가능한",@"3":@"殘り",@"4":@"en"},
                  @"可用" :  @{@"0":@"可用",@"1":@"remaining and available",@"2":@"가 남아 있습니다",@"3":@"が使える",@"4":@"resterende en beschikbaar"}
                  };
    
    return _hotTypeDic;
}
-(NSDictionary *)mineMuneDic{
    
    _mineMuneDic=@{
                   @"我的学习" :  @{@"0":@"我的学习",@"1":@"My learning",@"2":@"나의 스터디",@"3":@"私の勉強",@"4":@"Trainingen"},
                   @"我的课件" :  @{@"0":@"我的课件",@"1":@"My learning",@"2":@"나의 스터디",@"3":@"私の勉強",@"4":@"Trainingen"},
                   @"我的消息" :  @{@"0":@"我的消息",@"1":@"My learning",@"2":@"나의 스터디",@"3":@"私の勉強",@"4":@"Trainingen"},
                   @"我的考试" :  @{@"0":@"我的考试",@"1":@"My test",@"2":@"나의 시험",@"3":@"私のテスト",@"4":@"Mijn test"},
                   @"我的收藏" :  @{@"0":@"我的收藏",@"1":@"My favorite",@"2":@"나의 즐겨찾기",@"3":@"私のコレクション",@"4":@"Mijn favoriet"},
                   @"我的下载" :  @{@"0":@"我的下载",@"1":@"My download",@"2":@"나의 다운로드",@"3":@"私のダウンロード",@"4":@"Mijn download"},
                   @"我的事业部" :  @{@"0":@"我的事业部",@"1":@"My business department",@"2":@"나의 사업부",@"3":@"私の事業部",@"4":@"Mijn business afdeling"},
                    @"会员服务" :  @{@"0":@"会员服务",@"1":@"VIP service",@"2":@"VIP 서비스",@"3" : @"VIPサービス",@"4":@"De VIP - service"},
                   
                   @"我的定制" :  @{@"0":@"我的定制",@"1":@"My customization",@"2":@"나의 맞춤제작",@"3":@"私のオーダーメイド",@"4":@"Mijn aanpassing"},
                   @"学习地图" :  @{@"0":@"学习地图",@"1":@"Learning map",@"2":@"스터디 맵",@"3":@"勉強の地図",@"4":@"Leren van de kaa"},
                   @"我的地图" :  @{@"0":@"我的地图",@"1":@"Learning map",@"2":@"스터디 맵",@"3":@"勉強の地図",@"4":@"Leren van de kaa"},
                   @"我是讲师" :  @{@"0":@"我是讲师",@"1":@"I am a lecturer",@"2":@"나는 강사입니다",@"3":@"私は講師だ",@"4":@"Ik ben een docent"},
                   @"问卷" :  @{@"0":@"我的问卷",@"1":@"My vote",@"2":@"나의 설문",@"3":@"私のアンケート",@"4":@"Mijn stem"},
                   @"设置" :  @{@"0":@"设置",@"1":@"Setup",@"2":@"설정",@"3":@"セッティング",@"4":@"Setup"},
                   @"我的问卷" :  @{@"0":@"我的问卷",@"1":@"My vote",@"2":@"나의 설문",@"3":@"私のアンケート",@"4":@"Mijn stem"},
                   //
                   @"打卡" :  @{@"0":@"打卡",@"1":@"Punch card",@"2":@"타임 레코더 체크",@"3":@"サインイン",@"4":@"Ponskaart"},
                   @"积分" :  @{@"0":@"积分",@"1":@"Points",@"2":@"포인트",@"3":@"ポイント",@"4":@"Punten"},
                   @"证书" :  @{@"0":@"证书",@"1":@"Certificate",@"2":@"증서",@"3":@"証明書",@"4":@"Certificaat"},
                   @"登录" :  @{@"0":@"登录",@"1":@"Login",@"2":@"로그인",@"3":@"ログイン",@"4":@"Login"},
                   @"已打卡" :  @{@"0":@"已打卡",@"1":@"Card punched",@"2":@"타임 레코더 체크 완료",@"3":@"サインイン済み",@"4":@"Kaart geperforeerd"},
                   @"企业标签" :  @{@"0":@"企业标签",@"1":@"Company label",@"2":@"기업 라벨",@"3":@"企業のラベル",@"4":@"Bedrijf label"},
                   @"兴趣标签" :  @{@"0":@"兴趣标签",@"1":@"Interest label",@"2":@"취미 라벨",@"3":@"趣味のラベル",@"4":@"Belang label"},
                   @"语言标签" :  @{@"0":@"语言标签",@"1":@"Language label",@"2":@"언어 라벨",@"3":@"言語のラベル",@"4":@"Talenlabel"},
                   @"编辑" :  @{@"0":@"编辑",@"1":@"Edit",@"2":@"편집",@"3":@"編集",@"4":@"Bewerken"},
                   @"完成" :  @{@"0":@"完成",@"1":@"Complete",@"2":@"완료",@"3":@"完成",@"4":@"Voltooien"},
                   @"添加" :  @{@"0":@"添加",@"1":@"Add",@"2":@"추가",@"3":@"追加",@"4":@"Toevoegen"},
                   @"全选" :  @{@"0":@"全选",@"1":@"Select all",@"2":@"전체선택",@"3":@"すべてを選ぶ",@"4":@"Alles selecteren"},
                   @"删除" :  @{@"0":@"删除",@"1":@"Delete",@"2":@"삭제",@"3":@"削除",@"4":@"Verwijderen"},
                   
                   };
    
    
    return _mineMuneDic;
    
}



-(NSDictionary *)hotDic{
    
    _hotDic=@{
              @"谁在看" :  @{@"0":@"谁在看",@"1":@"Viewer",@"2":@"누가 보고 있을까",@"3":@"誰が見ているのか",@"4":@"Viewer"},
              @"相关推荐" :  @{@"0":@"相关推荐",@"1":@"Relevant recommendation",@"2":@"관련 추천",@"3":@"関連するお薦め",@"4":@"Aanbeveling van de relevante"},
              @"热点" :  @{@"0":@"热点",@"1":@"Hotspots",@"2":@"인기",@"3":@"ホット",@"4":@"Hotspots"},
              @"申请日期" :  @{@"0":@"申请日期",@"1":@"Date of application",@"2":@"신청 날짜를",@"3":@"申請期日",@"4":@"De datum van de aanvraag"},
              @"从手机相册选择" :  @{@"0":@"从手机相册选择",@"1":@"Date of application",@"2":@"신청 날짜를",@"3":@"申請期日",@"4":@"De datum van de aanvraag"},
              @"姓名" :  @{@"0":@"姓名",@"1":@"Full name",@"2":@"이름",@"3":@"氏名",@"4":@"De naam"},
              @"PTT认证" :  @{@"0":@"PTT认证",@"1":@"PTT certification",@"2":@"PTT 인증",@"3":@"ＰＴＴ認証",@"4":@"De PTT - certificering"},
              @"TTT认证" :  @{@"0":@"TTT认证",@"1":@"TTT certification",@"2":@"TTT 인증",@"3":@"TTT認証",@"4":@"De TTT - certificering"},
              @"申请授权与课程" :  @{@"0":@"申请授权与课程",@"1":@"Application authorization and course",@"2":@"신청 인증 및 과정",@"3":@"授権と課程を申請する",@"4":@"De aanvraag van een vergunning en cursussen"},
              @"需求与建议" :  @{@"0":@"需求与建议",@"1":@"Requirements and recommendations",@"2":@"수요와 제안",@"3":@"需要と提案",@"4":@"De eisen en aanbevelingen"},
              @"您可以在此上传作品和证书" :  @{@"0":@"您可以在此上传作品和证书",@"1":@"Je kan hier werken en certificaten.",@"2":@"이 작품 및 인증서를 업로드할 수 있습니다.",@"3":@"作品と証明書をアップロードすることができます",@"4":@"Je kan hier werken en certificaten"},
              @"点击上传照片" :  @{@"0":@"点击上传照片",@"1":@"Click upload photos",@"2":@"탭 업로드 사진",@"3":@"写真をアップロードして",@"4":@"Klik op de foto 's uploaden."},
              @"（1寸照）" :  @{@"0":@"（1寸照）",@"1":@"(1 inches)",@"2":@"(한 치 사진)",@"3":@"（1寸）（1インチ）",@"4":@"(1) Volgens)"},
              @"请选择" :  @{@"0":@"请选择",@"1":@"Please select",@"2":@"선택하십시오.",@"3":@"選択してください",@"4":@"Kies"},
              @"请选择您的最高学历" :  @{@"0":@"请选择您的最高学历",@"1":@"Please choose your highest degree",@"2":@"인기",@"3":@"あなたの最高学歴を選択してください",@"4":@"Kies je het hoogste niveau van het onderwijs"},
              @"请选择通过认证通过时间" :  @{@"0":@"请选择通过认证通过时间",@"1":@"Please choose to pass the certification through time",@"2":@"인증 통해 통해 시간을 선택하십시오.",@"3":@"認証通過時間を選択してください",@"4":@"Kies de certificering door de tijd"},
              @"请填写您的授课类型和范围（限100字内）" :  @{@"0":@"请填写您的授课类型和范围（限100字内）",@"1":@"Please fill in the type and scope of your classes (within 100 words)",@"2":@"작성해 주십시오. 당신의 강의 종류와 범위 (제한 100 자 안에)",@"3":@"誰が見ているのか",@"4":@"Vul je - les - en reikwijdte (minder dan 100 personen)"},
              @"最多只能上传9张图片" :  @{@"0":@"最多只能上传9张图片",@"1":@"(up to 9 pictures)",@"2":@"(최대 9 장 사진)",@"3":@"（最大9枚の写真）",@"4":@"(maximaal 9 foto 's)"},
              @"《智同体讲师管理办法》" :  @{@"0":@"《智同体讲师管理办法》",@"1":@"”Lecturer Ampang insurance management measures“",@"2":@"《 잘 다스려 안정시키다 보험 강사 관리 방법 >",@"3":@"『管理弁法』智同体保険講師",@"4":@"De maatregelen voor het beheer van een verzekering."},
              @"同意" :  @{@"0":@"同意",@"1":@"Agree",@"2":@"동의",@"3":@"同意し",@"4":@"Toestemming"},
              @"申请讲师" :  @{@"0":@"申请讲师",@"1":@"Application lecturer",@"2":@"신청 강사",@"3":@"講師を申請する",@"4":@"Voor de docent"},
              
              @"取消" :  @{@"0":@"取消",@"1":@"Cancel",@"2":@"취소",@"3":@"キャンセル",@"4":@"Annuleren"},
              
              @"从相册选取" :  @{@"0":@"从相册选取",@"1":@"Choose from album",@"2":@"앨범에서 선택",@"3":@"写真アルバムから選ぶ",@"4":@"Album kiezen"},
              @"拍照" :  @{@"0":@"拍照",@"1":@"Take photo",@"2":@"촬영",@"3":@"写真を撮る",@"4":@"Foto nemen"},
              @"您未通过，不能选择日期" :  @{@"0":@"您未通过，不能选择日期",@"1":@"You did not pass, can not choose the date",@"2":@"당신 아직 통해 못 날짜를 선택하다",@"3":@"あなたが通過していないから、日付を選択できない",@"4":@"Je kan niet door de keuze van het tijdstip."},
              @"已通过" :  @{@"0":@"已通过",@"1":@"Already passed",@"2":@"이미 통과하였습니다",@"3":@"すでにパスした",@"4":@"Reeds is verstreken"},
              @"未通过" :  @{@"0":@"未通过",@"1":@"Failed to pass",@"2":@"통과하지 못했습니다",@"3":@"まだパスしていない",@"4":@"Niet doorgeven"},
              
              @"小学及以下" :  @{@"0":@"小学及以下",@"1":@"Primary school and below",@"2":@"초등학교 및 이하",@"3":@"小学校及び以下",@"4":@"De lagere school en onder"},
              @"初中" :  @{@"0":@"初中",@"1":@"Junior middle school",@"2":@"중학교",@"3":@"中学校",@"4":@"De middelbare school"},
              
              @"技校｜中专｜职高" :  @{@"0":@"技校｜中专｜职高",@"1":@"Technical school, secondary vocational school.",@"2":@"중등 기술학교 ｜ ｜ 실업고",@"3":@"専門学校｜中等専門学校｜職業高校",@"4":@"In de middelbare technische school."},
              
              @"高中" :  @{@"0":@"高中",@"1":@"high school",@"2":@"고등학교",@"3":@"高校",@"4":@"De middelbare school"},
              @"大专" :  @{@"0":@"大专",@"1":@"College",@"2":@"대전",@"3":@"短大",@"4":@"College"},
              @"本科" :  @{@"0":@"本科",@"1":@"Universitair",@"2":@"학부",@"3":@"本科",@"4":@"Universitair"},
              @"硕士" :  @{@"0":@"硕士",@"1":@"En van Dr.",@"2":@"석사",@"3":@"修士",@"4":@"Meester"},
              @"博士及以上" :  @{@"0":@"博士及以上",@"1":@"Doctor and above",@"2":@"박사 및 이상",@"3":@"博士と以上",@"4":@"En van Dr."},
              @"《关于课件资料所有权及肖像权的授权承诺书》" :  @{@"0":@"《关于课件资料所有权及肖像权的授权承诺书》",@"1":@"On the authorization of the courseware material ownership and the portrait right",@"2":@"《 课件 자료 소유권 및 초상권 관한 인증 각서는 》",@"3":@"「コースウェアの資料の所有及び肖像権の授権承諾書」について",@"4":@"De gegevens betreffende de educatieve software en de eigendom van het portret van die verbintenis"},
              };
    
    
    //小学及以下",@"初中",@"技校｜中专｜职高",@"高中", @"大专",@"本科", @"硕士",@"博士及以上
    
    return _hotDic;
    
}

-(NSDictionary *)courseDic{
    
    _courseDic=@{
                 @"学习至" :  @{@"0":@"学习至",@"1":@"Learning to",@"2":@"학습 ~",@"3":@"学習する",@"4":@"Het leren van tot en met"},
                 @"课程" :  @{@"0":@"课程",@"1":@"Course",@"2":@"커리큘럼",@"3":@"カリキュラム",@"4":@"Cursus"},
                 @"继续观看" :  @{@"0":@"继续观看",@"1":@"Continue to watch",@"2":@"계속 볼",@"3":@"観覧し続ける",@"4":@"Blijven kijken"},
                 @"请输入要搜索的关键词" :  @{@"0":@"请输入要搜索的关键词",@"1":@"Please enter keywords for the search",@"2":@"검색하려는 키워드를 입력해 주세요",@"3":@"検索するキーワードをご入力ください",@"4":@"Voer trefwoorden in om te zoeken"},
                 @"专题" :  @{@"0":@"专题",@"1":@"Special topic",@"2":@"토픽",@"3":@"特定のテーマ",@"4":@"Speciale onderwerp"},
                 @"直播" :  @{@"0":@"直播",@"1":@"Live telecast",@"2":@"생방송",@"3":@"生中継",@"4":@"Wonen televisie-uitzending"},
                 @"沙龙" :  @{@"0":@"沙龙",@"1":@"Salon",@"2":@"모임",@"3":@"生サロン",@"4":@"Salon"},
                 @"直播" :  @{@"0":@"直播",@"1":@"Live telecast",@"2":@"생방송",@"3":@"生中継",@"4":@"Wonen televisie-uitzending"},
                 @"热门课程" :  @{@"0":@"热门课程",@"1":@"Hot courses",@"2":@"인기 커리큘럼",@"3":@"人気カリキュラム",@"4":@"Hete cursussen"},
                 @"猜你喜欢" :  @{@"0":@"猜你喜欢",@"1":@"Guess you like",@"2":@"인기 커리큘럼",@"3":@"人気カリキュラム",@"4":@"Denk dat u als"},
                 @"换一换" :  @{@"0":@"换一换",@"1":@"Switch",@"2":@"바꾸기",@"3":@"切り替える",@"4":@"Schakelaar"},
                 @"请输入课程名称" :  @{@"0":@"请输入课程名称",@"1":@"Please enter the course name",@"2":@"수업 이름을 입력하십시오.",@"3":@"授業の名称を入力して下さい",@"4":@"Gelieve de naam"},
                 @"热门搜索" :  @{@"0":@"热门搜索",@"1":@"Hot search",@"2":@"인기 검색",@"3":@"検索されてる話題のワード",@"4":@"Hete zoeken"},
                 @"搜索历史" :  @{@"0":@"搜索历史",@"1":@"Search history",@"2":@"검색 기록",@"3":@"歴史を検索する",@"4":@"De zoek geschiedenis"},
                 @"取消" :  @{@"0":@"取消",@"1":@"Cancel",@"2":@"취소",@"3":@"キャンセル",@"4":@"Annuleren"},
                 @"课程列表" :  @{@"0":@"课程列表",@"1":@"Course list",@"2":@"수업 목록",@"3":@"レッスンリスト",@"4":@"Lijst van opleidingen"},
                 @"包含课程" :  @{@"0":@"包含课程",@"1":@"Included courses",@"2":@"포함된 커리큘럼",@"3":@"カリキュラムを含む",@"4":@"カリキュラムを含む"},
                 @"相关专题" :  @{@"0":@"相关专题",@"1":@"Relevant special topics",@"2":@"관련 토픽",@"3":@"関連する特定のテーマ",@"4":@"Relevante speciale onderwerpen"},
                 @"简介" :  @{@"0":@"简介",@"1":@"Summary",@"2":@"소개",@"3":@"紹介",@"4":@"Samenvatting"},
                 @"评论" :  @{@"0":@"评论",@"1":@"Comments",@"2":@"코멘트",@"3":@"コメント",@"4":@"Selecteer de vriend"},
                 @"产品" :  @{@"0":@"产品",@"1":@"Related products",@"2":@"관련 제품",@"3":@"関連製品",@"4":@"Aanverwante producten"},
                 @"评论课程" :  @{@"0":@"评论课程",@"1":@"Review course",@"2":@"평론 과정",@"3":@"評論課程",@"4":@"Opmerkingen van studieprogramma 's"},
                 @"学习" :  @{@"0":@"学习",@"1":@"Learn",@"2":@"학습",@"3":@"勉強",@"4":@"Leren"},
                 @"直播详情" :  @{@"0":@"直播详情",@"1":@"Live details",@"2":@"방송 정보",@"3":@"生放送の詳細",@"4":@"- gegevens"},
                 @"清除历史记录" :  @{@"0":@"清除历史记录",@"1":@"Clear history",@"2":@"과거 기록",@"3":@"歴史記録をクリアする",@"4":@"Uit de geschiedenis"},
                 @"最新消息" :  @{@"0":@"最新消息",@"1":@"Latest news",@"2":@"최신 소식",@"3":@"最新ニュース",@"4":@"Het laatste nieuws"},
                 @"搜索列表" :  @{@"0":@"搜索列表",@"1":@"Search list",@"2":@"검색 목록",@"3":@"検索リスト",@"4":@"Het zoeken van de lijst"},
                 
                 };
    
    
    return _courseDic;
}
-(NSDictionary *)exchangeDic{
    
    _exchangeDic=@{
                   @"互动" :  @{@"0":@"互动",@"1":@"Interaction",@"2":@"인터랙션",@"3":@"インタラクティブ",@"4":@"Interactie"},
                   @"学习圈" :  @{@"0":@"学习圈",@"1":@"Learning circle",@"2":@"스터디 서클",@"3":@"ラーニングサークル",@"4":@"Leren cirkel"},
                   @"问答" :  @{@"0":@"问答",@"1":@"Questions and answers",@"2":@"Q&A",@"3":@"質疑応答",@"4":@"Vragen en antwoorden"},
                   @"荣誉榜" :  @{@"0":@"荣誉榜",@"1":@"Honor list",@"2":@"영예 순위",@"3":@"名誉ランキング",@"4":@"Ere lijst"},
                   @"新的朋友" :  @{@"0":@"新的朋友",@"1":@"Add friend",@"2":@"친구 추가",@"3":@"友人を追加する",@"4":@"Voeg vriend toe"},
                   @"群聊" :  @{@"0":@"群聊",@"1":@"Group chat",@"2":@"그룹채팅",@"3":@"グループチャット",@"4":@"Groeps-chat"},
                   @"搜索" :  @{@"0":@"搜索",@"1":@"Search",@"2":@"검색",@"3":@"検索",@"4":@"Zoeken"},
                   @"评论" :  @{@"0":@"评论",@"1":@"comment",@"2":@"평론",@"3":@"評論",@"4":@"Opmerkingen"},
                   @"赞" :  @{@"0":@"赞",@"1":@"Fabulous",@"2":@"칭찬하다",@"3":@"賛",@"4":@"Voor"},
                   @"取消" :  @{@"0":@"取消",@"1":@"cancel",@"2":@"취소",@"3":@"キャンセル",@"4":@"De afschaffing van"},
                   
                   };
    return _exchangeDic;
}
-(NSDictionary *)MineDic{
    
    _MineDic=@{
               @"群聊" :  @{@"0":@"群聊",@"1":@"Group chat",@"2":@"그룹채팅",@"3":@"グループチャット",@"4":@"Groeps-chat"},
               @"扫一扫" :  @{@"0":@"扫一扫",@"1":@"Scan",@"2":@"스캔",@"3":@"スキャンしてみる",@"4":@"Scan"},
               @"加好友" :  @{@"0":@"加好友",@"1":@"Add friend",@"2":@"친구 추가",@"3":@"友人を追加する",@"4":@"Voeg vriend toe"},
               @"您目前还不是讲师,立即" :  @{@"0":@"您目前还不是讲师,立即",@"1":@"You are not a lecturer at present, immediately",@"2":@"당신은 현재 아직 안 강사, 즉시",@"3":@"あなたはまだ講師ではありません、すぐに",@"4":@"Je hebt nog niet de instructeur, onmiddellijk"},
               @"申请成为讲师" :  @{@"0":@"申请成为讲师",@"1":@"Lecturer application",@"2":@"강사 신청",@"3":@"講師に申し込む",@"4":@"Docent toepassing"},
               @"讲师申请" :  @{@"0":@"讲师申请",@"1":@"Lecturer application",@"2":@"강사 신청",@"3":@"講師に申し込む",@"4":@"Docent toepassing"},
               @"你的申请，正在审批中" :  @{@"0":@"你的申请，正在审批中",@"1":@"Your application is under examination and approval.",@"2":@"너 지금 승인 신청을 중",@"3":@"あなたの申請、審査認可中です",@"4":@"Uw aanvraag is in afwachting van de goedkeuring"},
               @"你被禁用讲师" :  @{@"0":@"你被禁用讲师",@"1":@"Your instructor is disabled",@"2":@"너 비활성화됨 강사",@"3":@"あなたは禁止されている講師",@"4":@"Je uitgeschakeld."},
               @"很遗憾，没有通过" :  @{@"0":@"很遗憾，没有通过",@"1":@"I am sorry that I did not pass",@"2":@"유감스럽지만 안 통해",@"3":@"とても殘念、通らない",@"4":@"Helaas, niet door de"},
               @"待学课程" :  @{@"0":@"待学课程",@"1":@"Course to be studied",@"2":@"진학을 대기하다 과정",@"3":@"学課程",@"4":@"In afwachting van cursussen"},
               @"门课程" :  @{@"0":@"门课程",@"1":@"courses",@"2":@"과목",@"3":@"扉課程",@"4":@"cursussen"},
               };
    return _MineDic;
}

-(NSDictionary *)SettingDic{
    
    _SettingDic=@{
                  @"设置" :  @{@"0":@"设置",@"1":@"Setup",@"2":@"설정",@"3":@"セッティング",@"4":@"Setup"},
                  @"设置成功" :  @{@"0":@"设置成功",@"1":@"Set success",@"2":@"설치 성공",@"3":@"成功を設定する",@"4":@"Succes"},
                  @"建议重启app" :  @{@"0":@"建议重启app",@"1":@"Proposed restart app",@"2":@"건의를 다시 app",@"3":@"再起動するapp提案",@"4":@"De voorgenomen hervatting van app."},
                  @"这一刻的想法..." :  @{@"0":@"这一刻的想法...",@"1":@"This moment of thought...",@"2":@"이 순간 생각...",@"3":@"この時の考え方は…",@"4":@"Op dit moment denkt..."},
                  @"上传学习圈" :  @{@"0":@"上传学习圈",@"1":@"Upload learning circle",@"2":@"업로드 학습 서클",@"3":@"学習の勉強にアップロードする",@"4":@"Upload leren."},
                  @"发布内容不能为空" :  @{@"0":@"发布内容不能为空",@"1":@"Release content can not be empty",@"2":@"발표 내용을 못 비어",@"3":@"リリース内容は空っぽにならない",@"4":@"De inhoud is niet leeg."},
                  @"发送" :  @{@"0":@"发送",@"1":@"Send out",@"2":@"보내기",@"3":@"送信",@"4":@"Stuur"},
                  @"发布" :  @{@"0":@"发布",@"1":@"Release",@"2":@"게시",@"3":@"リリース",@"4":@"Bekendmaking"},
                  @"全部" :  @{@"0":@"全部",@"1":@"all",@"2":@"전부",@"3":@"全部",@"4":@"Alle"},
                  @"可见人员" :  @{@"0":@"可见人员",@"1":@"Visible personnel",@"2":@"가시 인원",@"3":@"可視人員",@"4":@"Het personeel"},
                  @"添加图片（最多可添加9张图片）" :  @{@"0":@"添加图片（最多可添加9张图片）",@"1":@"Add pictures (up to 9 pictures can be added)",@"2":@"사진 추가하기 (최대 수 9 장 사진 추가)",@"3":@"画像を添加する（最多と9枚の画像を添加する）",@"4":@"De toevoeging van foto 's (maximaal 9 foto toevoegen)"},
                  @"感谢您的意见与建议" :  @{@"0":@"感谢您的意见与建议",@"1":@"Thank you for your comments and suggestions",@"2":@"당신의 의견을 및 제안 드립니다",@"3":@"ご意見とアドバイスありがとうございます。",@"4":@"Ik dank u voor uw opmerkingen en aanbevelingen"},
                  @"意见反馈" :  @{@"0":@"意见反馈",@"1":@"Feedbacks",@"2":@"의견 피드백",@"3":@"ご意見とご返事",@"4":@"Feedback"},
                  @"密码修改" :  @{@"0":@"密码修改",@"1":@"Alter password",@"2":@"비밀번호 수정",@"3":@"パスワードを修正する",@"4":@"Wachtwoord wijzigen"},
                  @"语言设置" :  @{@"0":@"语言设置",@"1":@"Language setup",@"2":@"언어 설정",@"3":@"言語のセッティング",@"4":@"Taal instelling"},
                  @"推送设置" :  @{@"0":@"消息推送",@"1":@"News push",@"2":@"메시지 푸시",@"3":@"ニュースをプッシュする",@"4":@"Nieuws-push"},
                  @"分享APP" :  @{@"0":@"分享APP",@"1":@"Share APP",@"2":@"APP 공유",@"3" : @"アプリを分かち合う",@"4":@"Aandeel APP"},
                  @"会员服务" :  @{@"0":@"会员服务",@"1":@"VIP service",@"2":@"VIP 서비스",@"3" : @"VIPサービス",@"4":@"De VIP - service"},
                  @"清除缓存" :  @{@"0":@"清除缓存",@"1":@"Delete cache",@"2":@"캐시 비우기",@"3":@"キャッシュメモリーを消去する",@"4":@"Cache verwijderen"},
                  @"帮助反馈" :  @{@"0":@"帮助反馈",@"1":@"Help feedback",@"2":@"도움 피드백",@"3":@"援助のフィードバックを助ける",@"4":@"Help."},
                  @"关于我们" :  @{@"0":@"关于我们",@"1":@"About us",@"2":@"우리에 관하여",@"3":@"私たちについて",@"4":@"Informatie"},
                  @"语言选择" :  @{@"0":@"语言选择",@"1":@"Language setup",@"2":@"언어 설정",@"3":@"言語のセッティング",@"4":@"Taal instelling"},
                  @"网易足球" :  @{@"0":@"网易足球",@"1":@"Iglobalview",@"2":@"거노버",@"3":@"「iglobalview」",@"4":@"Iglobalview"},
                  @"意见与反馈" :  @{@"0":@"意见与反馈",@"1":@"Comments and feedbacks",@"2":@"의견 및 피드백",@"3":@"ご意見とご返事",@"4":@"Opmerkingen en feedback"},
                  @"意见反馈" :  @{@"0":@"意见反馈",@"1":@"Feedbacks",@"2":@"의견 피드백",@"3":@"ご意見とご返事",@"4":@"Feedback"},
                  @"重置密码" :  @{@"0":@"重置密码",@"1":@"Reset password",@"2":@"비밀번호 초기화",@"3":@"パスワードをリセットする",@"4":@"Reset wachtwoord"},
                  @"手机找回" :  @{@"0":@"手机找回",@"1":@"Mobile phone retrieval",@"2":@"휴대전화 되찾기",@"3":@"携帯で取り戻す",@"4":@"Mobiele telefoon ophalen"},
                  @"邮箱找回" :  @{@"0":@"邮箱找回",@"1":@"Email retrieval",@"2":@"이메일 되찾기",@"3":@"メールアドレスで取り戻す",@"4":@"E-mail ophalen"},
                  @"获取激活码" :  @{@"0":@"获取激活码",@"1":@"Get activation code",@"2":@"인증코드 획득",@"3":@"アクティベートコードを取得する",@"4":@"Activeringscode"},
                  @"请输入手机号码" :  @{@"0":@"请输入手机号码",@"1":@"Please enter mobile phone number",@"2":@"휴대전화 번호를 입력해 주세요",@"3":@"携帯番号をご入力ください",@"4":@"Voer het GSM-nummer"},
                  @"请输入激活码" :  @{@"0":@"请输入激活码",@"1":@"Please enter password",@"2":@"비밀번호를 입력해 주세요",@"3":@"パスワードをご入力ください",@"4":@"Voer de code van de activering"},
                  @"请输入密码(6-16位数字或字母)" :  @{@"0":@"请输入密码(6-16位数字或字母)",@"1":@"Please enter password (6-16 digits or letters)",@"2":@"(6~16자리 숫자 또는 문자로 된) 비밀번호를 입력해 주세요",@"3":@"パスワードをご入力ください（6-16桁の数字またはアルファベット）",@"4":@"Voer wachtwoord (6-16 cijfers of letters)"},
                  
                  @"6-16位数字或字母" :  @{@"0":@"6-16位数字或字母",@"1":@"6-16 digits or letters",@"2":@"6~16자리 숫자 또는 문자로 된",@"3":@"6-16桁の数字またはアルファベット",@"4":@"6-16 cijfers of letters"},
                  
                  
                  @"立即发送邮件" :  @{@"0":@"立即发送邮件",@"1":@"Send mail immediately",@"2":@"즉시 이메일 전송하기",@"3":@"直ちにメールを送る",@"4":@"Direct mail verzenden"},
                  @"输入有误" :  @{@"0":@"输入有误",@"1":@"Input error",@"2":@"잘못된 입력",@"3":@"入力ミス",@"4":@"Verkeerd"},
                  @"未收到返回信息" :  @{@"0":@"未收到返回信息",@"1":@"No return message received",@"2":@"아직 받지 복귀 정보",@"3":@"戻り情報",@"4":@"Terug naar de informatie nog niet ontvangen"},
                  @"输入有误" :  @{@"0":@"输入有误",@"1":@"Input error",@"2":@"잘못된 입력",@"3":@"入力ミス",@"4":@"Verkeerd"},
                  @"未收到返回信息" :  @{@"0":@"未收到返回信息",@"1":@"No return message received",@"2":@"아직 받지 복귀 정보",@"3":@"戻り情報",@"4":@"Terug naar de informatie nog niet ontvangen"},
                  @"请输入邮箱" :  @{@"0":@"请输入邮箱",@"1":@"Please enter email",@"2":@"이메일 또는 휴대전화 번호를 입력해 주세요",@"3":@"メールアドレスまたは携帯番号をご入力ください",@"4":@"Voer e-mail of GSM-nummer"},
                  @"发送成功" :  @{@"0":@"发送成功",@"1":@"Sending succeeded",@"2":@"전송 성공",@"3":@"送った",@"4":@"Geslaagde verzenden"},
                  @"发送失败" :  @{@"0":@"发送失败",@"1":@"Sending failed",@"2":@"전송 실패",@"3":@"送れなかった",@"4":@"Verzenden mislukt"},
                  @"请输入正确邮箱" :  @{@"0":@"请输入正确邮箱",@"1":@"Please enter correct email address",@"2":@"정확한 이메일 주소를 입력해 주세요. 필수 입력 항목입니다.",@"3":@"正しいメールアドレスをご入力ください。必須項目",@"4":@"Voer de juiste e-mailadres"},
                  @"重置密码成功" :  @{@"0":@"重置密码成功",@"1":@"Reset password success",@"2":@"암호 초기화 성공",@"3":@"パスワードのリセット成功を成功",@"4":@"- wachtwoord succes"},
                  @"找回密码邮件已发送到您的邮箱" :  @{@"0":@"找回密码邮件已发送到您的邮箱",@"1":@"Retrieve the password message has been sent to your mailbox",@"2":@"비밀번호 메일 이미 다 당신의 메일 보내기",@"3":@"パスワードのメールはあなたのメールに送信されている",@"4":@"Het bericht is al verzonden naar het wachtwoord van uw e - mailadres"},
                  @"邮箱不存在！" :  @{@"0":@"邮箱不存在！",@"1":@"Email address does not exist!",@"2":@"이메일 주소가 존재하지 않습니다!",@"3":@"メールアドレスのアカウントがすでに存在している",@"4":@"E-mailadres bestaat niet!"},
                  @"手机号码不存在" :  @{@"0":@"手机号码不存在",@"1":@"Mobile phone number does not exist",@"2":@"휴대전화 번호가 존재하지 않습니다",@"3":@"携帯番号が存在しない",@"4":@"GSM-nummer bestaat niet"},
                  @"邮箱已存在" :  @{@"0":@"邮箱已存在",@"1":@"Email account already exists",@"2":@"이메일 계정이 이미 존재합니다",@"3":@"メールアドレスが存在しない",@"4":@"E-mailaccount bestaat al"},
                  
                  @"手机号已存在" :  @{@"0":@"手机号已存在",@"1":@"Email address does not exist!",@"2":@"핸드폰 번호 이미 존재합니다.",@"3":@"携帯電話号はすでに存在している",@"4":@"De telefoon is er."},
                  
                  @"发送请求失败" :  @{@"0":@"发送请求失败",@"1":@"Email address does not exist!",@"2":@"송신 요구 실패",@"3":@"失敗を請求する",@"4":@"Het verzenden van verzoeken niet"},
                  @"请输入注册邮箱" :  @{@"0":@"请输入注册邮箱",@"1":@"Please enter your registered email address",@"2":@"이메일 주소가 존재하지 않습니다!",@"3":@"登録メールボックスに入力して下さい",@"4":@"Voer een e - mailadres"},
                  @"邮箱不存在！" :  @{@"0":@"邮箱不存在！",@"1":@"Email address does not exist!",@"2":@"이메일 주소가 존재하지 않습니다!",@"3":@"メールアドレスが存在しない",@"4":@"E-mailadres bestaat niet!"},
                  @"验证码错误" :  @{@"0":@"验证码错误",@"1":@"Verification code error",@"2":@"인증 코드 오류",@"3":@"検証コードエラー",@"4":@"De code is er controle"},
                  @"请输入正确的邮箱地址" :  @{@"0":@"请输入正确的邮箱地址",@"1":@"Please enter a valid email address",@"2":@"정확한 이메일 주소를 입력하십시오.",@"3":@"正しいメールアドレスを入力して下さい",@"4":@"Geef het juiste adres."},
                  
                  };
    return _SettingDic;
}
-(NSDictionary *)logoutDic{
    
    _logoutDic=@{
                 @"退出登录" :  @{@"0":@"退出登录",@"1":@"Log out",@"2":@"로그인에서 나가기",@"3":@"ログアウト",@"4":@"Uitloggen"},
                 @"退出登录成功" :  @{@"0":@"退出登录成功",@"1":@"Log out succeeded",@"2":@"로그인에서 나가기 성공",@"3":@"更新ログアウト",@"4":@"Uitloggen geslaagd"},
                 @"推送设置" :  @{@"0":@"消息推送",@"1":@"News push",@"2":@"메시지 푸시",@"3":@"ニュースをプッシュする",@"4":@"Nieuws-push"},
                 @"分享APP" :  @{@"0":@"分享APP",@"1":@"Share APP",@"2":@"APP 공유",@"3" : @"アプリを分かち合う",@"4":@"Aandeel APP"},
                 @"清除缓存" :  @{@"0":@"清除缓存",@"1":@"Delete cache",@"2":@"캐시 비우기",@"3":@"キャッシュメモリーを消去する",@"4":@"Cache verwijderen"},
                 @"帮助反馈" :  @{@"0":@"帮助反馈",@"1":@"Feedbacks",@"2":@"의견 피드백",@"3":@"ご意見とご返事",@"4":@"Feedback"},
                 @"关于我们" :  @{@"0":@"关于我们",@"1":@"About us",@"2":@"우리에 관하여",@"3":@"私たちについて",@"4":@"Informatie"}
                 };
    return _logoutDic;
}
-(NSDictionary *)loginDic{
    
    _loginDic=@{
                @"用户登录" :  @{@"0":@"用户登录",@"1":@"User log in",@"2":@"사용자 로그인",@"3":@"ユーザーのログイン",@"4":@"Gebruiker inloggen"},
                @"欢迎登录网易足球" :  @{@"0" : @"   欢迎登录网易足球", @"1" : @"You are welcome to log in YDXT", @"2" : @"거노버에 로그인하신 것을 YDXT",@"3" : @"「YDXT」へようこそ。",@"4" : @"U bent van harte welkom om in YDXT te loggen"},
                @"手机号/邮箱/工号" :  @{@"0":@"手机号/邮箱/工号",@"1":@"Please enter mobile phone number / email/Job number",@"2":@"휴대전화 번호/이메일을 입력해 주세요/공번",@"3":@"携帯番号/メールアドレスをご入力ください/職員番号",@"4":@"Voer het GSM-nummer / email/Projectnummer"},
                @"请输入密码" :  @{@"0":@"请输入密码",@"1":@"Please enter password",@"2":@"비밀번호를 입력해 주세요",@"3" : @"パスワードをご入力ください",@"4":@"Geef wachtwoord"},
                @"记住密码" :  @{@"0":@"记住密码",@"1":@"Remember password",@"2":@"비밀번호 저장",@"3":@"パスワードを覚える",@"4":@"Wachtwoord onthouden"},
                @"登录" :  @{@"0":@"登录",@"1":@"Login",@"2":@"로그인",@"3":@"빠른 회원가입",@"4":@"Login"},
                @"快速注册" :  @{@"0":@"快速注册",@"1":@"Quick registration",@"2":@"우리에 관하여",@"3":@"迅速登録",@"4":@"Snelle registratie"},
                @"社交账号登录" :  @{@"0":@"社交账号登录",@"1":@"Social media account login",@"2":@"커뮤니티 계정 로그인",@"3":@"他のコミュニティのアカウントでログイン",@"4":@"Login van de rekening van de sociale media"},
                @"请输入注册邮箱" :  @{@"0":@"请输入注册邮箱",@"1":@"Please enter your registered email address",@"2":@"이메일 주소가 존재하지 않습니다!",@"3":@"登録メールボックスに入力して下さい",@"4":@"Voer een e - mailadres"},
                @"确定" :  @{@"0":@"确定",@"1":@"Confirm",@"2":@"확정",@"3":@"確かめる",@"4":@"Bevestigen"},
                @"取消" :  @{@"0":@"取消",@"1":@"Cancel",@"2":@"취소",@"3":@"キャンセル",@"4":@"Annuleren"},
                @"找回密码" :  @{@"0":@"找回密码",@"1":@"Retrieve password",@"2":@"비밀번호 되찾기",@"3":@"パスワードを取り戻す",@"4":@"Wachtwoord opvragen"},
                @"请输入正确的邮箱" :  @{@"0":@"请输入正确的邮箱",@"1":@"Please enter correct email address",@"2":@"정확한 이메일을 입력해 주세요",@"3":@"正しいメールアドレスをご入力ください",@"4":@"Voer de juiste e-mailadres"},
                @"邮件已发送至您的邮箱，请注意查收!" :  @{@"0":@"邮件已发送至您的邮箱，请注意查收!",@"1":@"Mail has been sent to your email address. Please check!",@"2":@"이메일을 이미 귀하의 이메일 주소로 전송하였습니다. 확인 바랍니다!",@"3":@"メールアドレスまでメールを送った。ご査収ください",@"4":@"Mail is verstuurd naar uw e-mailadres. Gelieve te controleren!"},
                @"输入不正确" :  @{@"0":@"输入不正确",@"1":@"Incorrect input",@"2":@"입력 정확하지 않다",@"3":@"入力は正しくありません。",@"4":@"- niet de juiste"},
                @"登录成功" :  @{@"0":@"登录成功",@"1":@"Login success",@"2":@"로그인 성공",@"3":@"ログイン成功",@"4":@"Succesvolle login"},
                @"网络卡顿或用户密码错误" :  @{@"0":@"密码错误",@"1":@" password error",@"2":@" 암호가 잘못되었습니다",@"3":@"ネーパスワード誤り",@"4":@" of De fout wachtwoord."},
                @"您还未登录或登录超时，请登录!" :  @{@"0":@"您还未登录或登录超时，请登录!",@"1":@"You have not logged in or the account has expired. Please log in!",@"2":@"귀하는 아직 로그인을 하지 않았거나 계정이 이미 만기되었습니다. 로그인해 주세요!",@"3":@"まだログインしていないまたはアカウントの期限が切れたので、ログインしてください。",@"4":@"U bent niet ingelogd of de account is verlopen. Meld u aan!"},
                @"无访问权限" :  @{@"0":@"无访问权限",@"1":@"No access",@"2":@"접근 권한이 없다.",@"3":@"アクセス権限",@"4":@"Geen toegang"},
                @"邮箱未激活" :  @{@"0":@"邮箱未激活",@"1":@"Mailbox not activated",@"2":@"메일박스 질의에",@"3":@"郵便箱郵便箱",@"4":@"E - mail niet geactiveerd."},
                @"帐号已经冻结" :  @{@"0":@"帐号已经冻结",@"1":@"Account has been frozen",@"2":@"계좌번호 이미 동결",@"3":@"アカウントはすでに凍結して",@"4":@"De rekening is bevroren"},
                @"登录失败" :  @{@"0":@"登录失败",@"1":@"Login failed",@"2":@" 로그인 실패",@"3":@"ログイン失敗",@"4":@"Geen teken van"},
                @"取消登录" :  @{@"0":@"取消登录",@"1":@"Cancel login",@"2":@" 취소 로그인",@"3":@"ログインを取り消して",@"4":@"- de afschaffing van"},
                @"登录失败，网络错误" :  @{@"0":@"登录失败，网络错误",@"1":@"Login failed, network error",@"2":@"로그인 실패, 네트워크 오류",@"3":@"ログイン失敗、ネットワークエラー",@"4":@"Geen teken van het netwerk van fouten,"},
                @"是" :  @{@"0":@"是",@"1":@"YES",@"2":@"네",@"3":@"は",@"4":@"Is"},
                @"否" :  @{@"0":@"否",@"1":@"NO",@"2":@"안",@"3":@"否",@"4":@"Neen"},
                @"提示" :  @{@"0":@"提示",@"1":@"Prompt",@"2":@"팁",@"3":@"ヒント",@"4":@"Tip"},
                
                
                
                
                };
    return _loginDic;
}
-(NSDictionary *)tipDic{
    
    _tipDic=@{
              @"上传成功" :  @{@"0":@"上传成功",@"1":@"Log out",@"2":@"로그인에서 나가기",@"3":@"ログアウト",@"4":@"Uitloggen"},
              @"网络错误" :  @{@"0":@"网络错误",@"1":@"Log out succeeded",@"2":@"로그인에서 나가기 성공",@"3":@"更新ログアウト",@"4":@"Uitloggen geslaagd"},
              @"没有填写职位" :  @{@"0":@"没有填写职位",@"1":@"News push",@"2":@"메시지 푸시",@"3":@"ニュースをプッシュする",@"4":@"Nieuws-push"},
              @"没有选择TTT认证时间" :  @{@"0":@"没有选择TTT认证时间",@"1":@"Share APP",@"2":@"APP 공유",@"3" : @"アプリを分かち合う",@"4":@"Aandeel APP"},
              @"没有有选择PTT认证时间" :  @{@"0":@"没有有选择PTT认证时间",@"1":@"Delete cache",@"2":@"캐시 비우기",@"3":@"キャッシュメモリーを消去する",@"4":@"Cache verwijderen"},
              @"没有选择TTT认证" :  @{@"0":@"没有选择TTT认证",@"1":@"Feedbacks",@"2":@"의견 피드백",@"3":@"ご意見とご返事",@"4":@"Feedback"},
              @"没有选择PTT认证" :  @{@"0":@"没有选择PTT认证",@"1":@"About us",@"2":@"우리에 관하여",@"3":@"私たちについて",@"4":@"Informatie"},
              
              @"没有选择学历" :  @{@"0":@"没有选择学历",@"1":@"Share APP",@"2":@"APP 공유",@"3" : @"アプリを分かち合う",@"4":@"Aandeel APP"},
              @"没有上传证书" :  @{@"0":@"没有上传证书",@"1":@"Delete cache",@"2":@"캐시 비우기",@"3":@"キャッシュメモリーを消去する",@"4":@"Cache verwijderen"},
              @"没有头像" :  @{@"0":@"没有头像",@"1":@"Feedbacks",@"2":@"의견 피드백",@"3":@"ご意見とご返事",@"4":@"Feedback"},
              @"必须遵守相关协议才能申请讲师" :  @{@"0":@"必须遵守相关协议才能申请讲师",@"1":@"About us",@"2":@"우리에 관하여",@"3":@"私たちについて",@"4":@"Informatie"}
              };
    return _tipDic;
}
@end
