if GetLocale() == "zhTW" then
  local _, core = ...;
  local MonDKP = core.MonDKP;
  
  core.BossList = {
    MC = {
      "魯西弗隆", "瑪格曼達", "基赫納斯",
      "加爾", "迦頓男爵", "沙斯拉爾", "薩弗隆先驅者", 
      "『焚化者』古雷曼格", "管理者埃克索圖斯", "拉格納羅斯"
    },
    BWL = {
      "狂野的拉佐格爾", "墮落的瓦拉斯塔茲", "幼龍領主勒西雷爾",
      "費爾默", "埃博諾克", "弗萊格爾", "克洛瑪古斯", 
      "奈法利安"
    },
    AQ = {
      "預言者斯克拉姆", "戰地衛士沙爾圖拉", "不屈的范克里斯",
      "哈霍蘭公主", "雙子帝王", "克蘇恩", 
      "異種蠍皇族", "維希度斯", "奧羅"
    },
    NAXX = {
      "阿努比瑞克漢", "大寡婦費琳娜", "梅克絲娜",
      "『瘟疫使者』諾斯", "『不潔者』海根", "憎恨者", 
      "講師拉祖維斯", "『收割者』高希", "四騎士",
      "縫補者", "葛羅巴斯", "古魯斯", "泰迪斯",
      "薩菲隆", "科爾蘇加德"
    },
    ZG = {
      "Mandokir 勳爵", "加赫扎蘭卡", "哈克卡爾", "高普瑞特西卡爾", "高優先順序 Venoxis", "高普里斯特斯 - 阿洛克克",
      "高優先順序 Jeklik", "黑克瑟島", "高普里斯特斯 - 馬爾利", "瘋狂邊緣"
    },
    AQ20 = {
      "『狩獵者』阿亞米斯", "『暴食者』布魯", "拉賈克斯將軍", "庫林納克斯", "莫阿姆", "『無疤者』奧斯里安"
    },
    ONYXIA = {"奧妮克希亞"},
    WORLD = {
      "艾索雷苟斯", "卡札克領主", "艾莫莉絲", "雷索", "伊索德雷", "泰拉爾"
    }
  }
  
  core.ZoneList = {
    "熔火之心", "黑翼之巢", "安其拉神廟", "納克薩瑪斯", "祖爾格拉布", "安琪拉遺址", "奧妮西亞的巢穴", "世界老闆"
  }

  core.L = {
    Player                = "球員",
    Class                 = "類",
    TotalDKP              = "DKP 總計",
    EntriesShown          = "顯示的條目",
    Filters               = "過濾 器",
    AdjustDKP             = "調整 DKP",
    ManageDKP             = "管理 DKP 清單",
    DefaultSettings       = "預設設置",
    LootHistory           = "搶劫歷史",
    DKPHistory            = "DKP 歷史",
    Manage                = "管理",
    Options               = "選項",
    AdjustDesc            = "從左側選擇單個玩家（Shift+按一下多個玩家），或按一下下面的\"選擇所有可見\"並輸入要調整的量。\n\n範圍可以通過\"僅顯示 Raid\"在下方或\"篩檢程式\"選項卡上進行調整。",
    ReasonForAdjustment   = "調整原因",
    SelectReason          = "選擇原因",
    OnTimeBonus           = "準時獎金",
    BossKillBonus         = "老闆殺戮獎勵",
    RaidCompletionBonus   = "團隊完成獎勵",
    NewBossKillBonus      = "新老闆殺戮獎勵",
    CorrectingError       = "修正誤差",
    DKPAdjust             = "DKP調整",
    UnexcusedAbsence      = "無故缺席",
    Other                 = "其他",
    FirstKill             = "第一次殺戮",
    EnterOtherReasonHere  = "在此處輸入其他原因",
    Points                = "點數",
    WeeklyDKPDecay        = "每週dkp衰减",
    ApplyDecay            = "應用衰退",
    AppDecayTTDesc        = "您希望以每週衰减的管道减少DKP條目的DKP量。這應該是一個正數。如果未在下麵選擇“僅選定玩家”，則它將應用於所有條目。",
    AppDecayTTWarn        = "警告：無法撤銷。",
    AddNegValues          = "添加到負值",
    AddNegTTDesc          = "勾選後，任何DKP為負的玩家的債務都會减少上述百分比。其他的都减少了百分之以上。如果不加控制，則處於負面的玩家不會受到衰退的影響。",
    AddNegTTWarn          = "此核取方塊僅影響負DKP玩家的上述衰减行為。",
    SelPlayersOnly        = "僅選定玩家",
    SelPlayersTTDesc      = "將上述dkp衰减應用於dkp錶上的|cffff000只有|r選定玩家",
    SelPlayersTTWarn      = "對超過閾值的玩家應用衰减很有用。",
    WeeklyDecayTTDesc     = "您希望以每週衰减的管道减少DKP條目的DKP量。這應該是一個正數。如果未在下麵選擇“僅選定玩家”，則它將應用於所有條目。",
    WeeklyDecayTTWarn     = "警告：無法撤銷。",
    WeeklyDecay           = "周衰變",
    AdjustDKPTTDesc       = "將以上條目應用於DKP錶中選定的所有玩家。",
    AdjustDKPTTWarn       = "此條目將廣播給你的公會中的所有線上玩家。",
    PointsTTDesc          = "在DKP錶中輸入分配給選定玩家的DKP數量。預設值可以在下麵的“選項”選項卡中更改。",
    PointsTTWarn          = "使用負數從選定的玩家中移除dkp。",
    Reason                = "原因",    
    ReasonTTDesc          = "選擇DKP調整的原因。如果選擇了“boss kill bonus”或“new boss kill bonus”，則會創建一個額外的下拉清單來選擇區域和boss。“其他”將創建一個文字方塊，供您輸入自定義原因。",
    ReasonTTWarn          = "當一個老闆被殺，合適的區域和老闆會自動為你選擇。",
    WARNING               = "警告",
    OutdateModifyWarn     = "您正試圖修改過時的dkp錶。這可能會無意中損壞具有最新錶的官員的數據。\n\n確實要這樣做嗎？",
    YES                   = "是的",
    NO                    = "不",
    OK                    = "好啊",
    PlayerReasonValidate  = "未選擇玩家或原因",
    PlayerValidate        = "未選擇玩家",
    OtherReasonValidate   = "未選擇其他原因",
    RaidDKPAdjustBy       = "RAID DKP調整者",
    DKPAdjustBy           = "DKP調整人",
    ForReason             = "有原因的",
    ForPlayers            = "對於以下玩家",
    RaidTimerBonusConfirm = "您確定要將準時獎金應用於此突襲嗎？",
    RaidResume            = "突襲已經恢復！",
    RaidStart             = "RAID計時器已啟動！",
    RaidPause             = "RAID已在暫停",
    PauseRaid             = "暫停RAID",
    PauseRaidTTDesc       = "如果領導决定暫停計時器以進行中斷，則會暫停raid計時器。",
    PauseRaidTTWarn       = "可通過按一下“繼續RAID”繼續。",
    IncrementInvalidWarn  = "增量是無效數位。",
    Interval              = "間隔",    
    AwardInterval         = "獎勵間隔",
    AwardIntervalTTDesc   = "時間間隔（以分鐘為組織）您希望將dkp授予整個raid。",
    AwardIntervalTTWarn   = "輸入60將在每小時上方的“獎勵”欄位中獎勵RAID（和待機，如果在下麵選中的話）丹麥克朗。",
    AwardBonus            = "獎勵獎金",
    AwardBonusTTDesc      = "每次滿足以下間隔時給予RAID的DKP量。",
    GiveOnTimeBonus       = "按時發放獎金",
    GiveOnTimeTTDesc      = "選擇此選項將在初始化RAID時為RAID中的每個人（以及待機狀態，如果在下麵選擇）授予“按時”獎勵。",
    GiveEndBonus          = "年終獎",
    GiveEndBonusTTDesc    = "選擇此選項將在您結束RAID時為RAID中的每個人（以及待機狀態，如果在下麵選擇）授予“RAID完成”獎勵。",
    IncludeStandby        = "包括備用",
    IncludeStandbyTTDesc  = "選擇此選項將在所有自動DKP分發版中包括備用清單。",
    IncludeStandbyTTWarn  = "通過在DKP錶中選擇不在RAID中的玩家創建待機清單，按右鍵>管理待機清單>將所選玩家添加到待機清單。",
    EndCurRaidConfirm     = "您確定要結束當前的RAID嗎？",
    RaidTimerConclude     = "RAID計時器在",
    InitRaid              = "初始化RAID",
    InitRaidTTDesc        = "開始raid計時器，根據上面給出的時間增量授予dkp。這可以由團隊中的任何人員初始化，但只有團隊領導在符合檢查條件時才會授予DKP獎勵。",
    InitRaidTTWarn        = "這是廣播給所有突擊隊員的。每個軍官都有一個計時器，但只有突擊隊長會授予獎勵。如果某個事件（離線、重新加載等）導致領隊遺失計時器，請將RAID領隊交給另一個仍在運行計時器的軍官，以防止中斷。",
    TimerWarning          = "警告：請確保您的DKP獎金參數設置正確。這些值可以在上面的“間隔”和“獎金”框中設定，也可以在下麵的“選項”選項卡中設定所有“默認DKP獎勵值”。建議您設定這些值，並在使用之前通過“DKP模式”視窗（可使用“/DKP模式”或“選項”選項卡中的按鈕訪問）將其廣播給所有軍官。",
    NotInRaid             = "你不是在突擊隊。",
    EntrySelected         = "選定的條目",
    EntriesSelected       = "選定的條目",
    AreYouSure            = "你確定你願意",
    DKPToFollowing        = "DKP發給以下玩家",
    ConfirmDecay          = "你確定你想腐爛嗎",
    DKPEntriesBy          = "DKP條目依據",
    RaidTimer             = "RAID計時器",
    TimeElapsed           = "比賽進行時間",
    BonusAwarded          = "獎勵",
    ContinueRaid          = "繼續RAID",
    TimeIntervalBonus     = "時間間隔獎金",
    RaidEnded             = "RAID結束",
    RaidPaused            = "RAID已暫停",
    TotalDKPAward         = "授予的丹麥克朗總額",
    EndRaid               = "結束RAID",
    LootHistInst1         = "按住SHIFT鍵並按一下以連結項目\nAlt鍵並按一下以連結行",
    LootHistInst2         = "右擊可編輯條目",
    LootHistInst3         = "按右鍵可删除條目",
    OODLogSync            = "廣播了一個過時的戰利品歷史錶。這會對你的戰利品歷史錶造成不可逆轉的傷害。你願意接受嗎？",
    OODDKPHistoryEntry    = "已廣播來自過期的DKP歷史錶的條目。這會對你的DKP歷史錶造成不可挽回的傷害。你願意接受嗎？",
    OODDKPHistoryTable    = "已廣播過時的DKP歷史錶。這會對你的DKP歷史錶造成不可挽回的傷害。你願意接受嗎？",
    OODLootHistoryDelete  = "已從過時的戰利品歷史記錄錶中删除項目。這可能會導致删除錶中的錯誤項。你願意接受嗎？",
    OODLootTableItem      = "試圖從過期的戰利品錶更新項目。這會對你的DKP錶造成不可挽回的傷害。你願意接受嗎？",
    OODDKPHistoryDelete   = "試圖從過期的DKP歷史記錄錶中删除項。這會對你的DKP錶造成不可挽回的傷害。你願意接受嗎？",
    OODDKPTableBroadcast  = "廣播了一個過時的dkp錶。這會對你的DKP錶造成不可挽回的傷害。你願意接受嗎？",


    InPartyRaid           = "在派對/團隊中",
    PositionReset         = "窗口位置重置",
    NotInGuild            = "不在公會",
    NoGuild               = "無公會",
    NoteTooLong           = "公會領導人的公開說明過長。註釋截斷以適合DKP表時間戳。 （最多31個字符）",
    InvalidTimer          = "無效的計時器",
    InvalidTargetPlayer   = "無法獎勵物品。無效的目標玩家",
    InvalidItemCost       = "無法獎勵物品。無效的商品費用",
    InvalidItemLink       = "無法獎勵物品。無效的項目鏈接",
    ConfirmAward          = "您確定要授予",
    To                    = "至",
    For                   = "對於",
    DKP                   = "DKP",
    NoPermission          = "您無權訪問該功能。",
    SlashCommandList      = "斜杠命令列表",
    DKPLaunch             = "啟動DKP窗口",
    HelpInfo              = "顯示幫助信息",
    DKPResetPos           = "重置DKP窗口位置/大小",
    DKPLockout            = "顯示每個團隊大小的下一次重置（3天，5天和7天鎖定）",
    CreateRaidTimer       = "創建Raid計時器（僅限官員）（例如/ dkp計時器120 Pizza Break！）",
    OpenBidWindowHelp     = "打開出價窗口（僅限官員）（例如/ dkp出價[項目鏈接]）",
    PlayerCost            = "玩家費用[項目鏈接]",
    DKPAwardHelp          = "手動獎勵項目（僅限官員）（例如/ dkp獎勵roeshambo 100 [項目鏈接]）",
    DKPModesHelp          = "打開“ DKP模式”窗口（僅限官員）",
    DKPExportHelp         = "打開窗口，將所有DKP信息導出為HTML，CSV或XML。 （更多的導出實現方式將會出現）",
    WhisperCmdsHelp       = "耳語命令（致指定人員）",
    Value                 = "值",
    BidHelp               = "打開競標時對當前項目的競標。",
    PlayerName            = "選手姓名",
    DKPCmdHelp            = "返回當前的DKP（或<玩家名稱>的DKP）",
    Version               = "版",
    CreatedMaintain       = "由...創建和維護",
    Loaded                = "已加載",
    PlayerRecords         = "球員記錄",
    LootHistRecords       = "戰利品歷史記錄和",
    DKPHistRecords        = "dkp歷史記錄",
    Use                   = "採用",
    SubmitBugs            = "尋求幫助並提交任何錯誤",
    Days                  = "天",
    Day                   = "天",
    Hours                 = "小時",
    Hour                  = "小時",
    Minutes               = "分鐘",
    Minute                = "分鐘",
    ResetsIn              = "重設",
    RecentHistoryFor      = "最近的歷史",
    LifetimeEarned        = "終身獲得",
    LifetimeSpent         = "花費的生命",
    NoPlayerInStandby     = "備用組中沒有玩家。",
    NoPartyOrRaid         = "您沒有參加聚會或突襲。",
    NoCoreRaidTeam        = "您的核心團隊中沒有玩家。",
    MultipleSelect        = "多項選擇",
    InviteSelected        = "邀請參加突襲",
    SelectAll             = "全選",
    Views                 = "觀看次數",
    TableViews            = "表格檢視",
    ViewRaid              = "查看團隊",
    ViewStandby           = "查看待機列表",
    ViewRaidStandby       = "查看突襲和待機",
    ViewCoreRaid          = "查看核心攻略",
    ViewAll               = "查看全部",
    ClassFilter           = "類過濾器",
    ManageLists           = "管理清單",
    ManageStandby         = "管理備用清單",
    AddToStandby          = "將選定的玩家添加到待機列表",
    RemoveFromStandby     = "從待機列表中刪除選定的玩家",
    ClearStandby          = "清除備用​​清單",
    ManageCoreList        = "管理核心攻略列表",
    Invite                = "邀請",
    ToRaid                = "突襲",
    Remove                = "去掉",
    FromStandbyList       = "從待機列表",
    Add                   = "加",
    ToStandbyList         = "到待機列表",
    Close                 = "關",
    DKPStatus             = "DKP狀態",
    AllTables             = "您所有的表格目前都在",
    UpToDate              = "最新",
    OutOfDate             = "過時的",
    OneTableOOD           = "您的一個或多個表當前",
    RequestTablesOfficer  = "向官員索要更新的表格。",
    CurrNotInGuild        = "您目前不在行會中。 DKP狀態無法查詢。",
    SelectBoss            = "選擇老闆",
    SelectAllVisible      = "選擇所有可見",
    Selected              = "已選",
    All                   = "所有",
    Bonus                 = "獎金",
    RollNotAccepted       = "您的申請不被接受。你只有",
    OnlyOneRollWarn       = "只能接受一卷！",
    ErrorProcessing       = "錯誤處理命令",
    BidCancelled          = "您的出價已被取消。",
    NotSubmittedBid       = "您尚未提交投標。",
    InvalidPlayer         = "無效的播放器。 DKP表中未列出您。",
    YourBidOf             = "您的出價",
    DKPWasAccepted        = "DKP被接受",
    BidWasAccepted        = "您的出價已被接受。",
    BidDeniedMinBid       = "競標被拒絕！低於最低出價",
    BidDeniedNegative     = "競標被拒絕！您的DKP處於負面狀態",
    BidDeniedOnlyHave     = "競標被拒絕！你只有",
    BidDeniedNoValue      = "競標被拒絕！沒有給出出價的價值。",
    BidDeniedExceedMax    = "競標被拒絕！您的出價超出了最高出價",
    BidDeniedInvalid      = "競標被拒絕！收到無效的出價。",
    NoBidInProgress       = "尚無投標",
    CurrentlyHas          = "目前有",
    DKPAvailable          = "提供DKP",
    PlayerNotFound        = "找不到該玩家。",
    Use                   = "採用",
    ToBid                 = "投標",
    YouCurrentlyHave      = "您目前有",
    BidDeniedFilter       = "競標被拒絕！",
    BidAcceptedFilter     = "您的出價已被接受。",
    OR                    = "要么",
    With                  = "與",
    TakingBidsOn          = "競標",
    DKPMinBid             = "DKP最低競標價格",
    ToBidUse              = "競標使用",
    ToSend                = "發送",
    ToWithdrawBid         = "撤回出價。",
    RollFor               = "爭取",
    ToBidRollRange        = "出價使用/ random。您的預期範圍可以在DKP表上看到，也可以通過使用",
    NoMinBidOrItem        = "沒有最低出價和/或要競標的商品！",
    NoItemOrItemCost      = "沒有項目費用和/或項目可以競標！",
    EndBidding            = "結束競標",
    StartBidding          = "開始競標",
    InvalidBossName       = "老闆名稱無效",
    Error                 = "錯誤",
    AwardItemTo           = "獎勵項目",
    On                    = "上",
    Congrats              = "恭喜",
    TenSecondsToBid       = "還剩10秒競標！",
    BiddingClosed         = "招標截止！",
    RemoveEntry           = "刪除條目",
    ClosedBidInProgress   = "投標窗口已關閉，正在進行投標！輸入/ dkp bid以重新打開當前的出價會話。",
    Item                  = "項目",
    MinimumBid            = "最低競標價格",
    MinBidTTDesc          = "可接受的最低出價。",
    MinBidTTWarn          = "可以在“選項”選項卡中設置默認值。",
    MinBidTTExt           = "如果輸入的值不是“選項”中設置的值，則將為該特定項目存儲該自定義值。",
    Custom                = "自訂",
    CustomMinBid          = "自定義最低出價",
    CustomMinBidTTDesc    = "您已為此項目設置了自定義最低出價。取消選中此框可使用此項目類型的標准出價（在“選項”標籤中設置）。",
    CustomMinBidTTWarn    = "在未選中此選項的情況下開始出價會從數據庫中刪除自定義的最低出價值。",
    BidTimer              = "出價計時器",
    BidTimerTTDesc        = "此項目的競標時間將持續幾秒鐘。",
    BidTimerTTWarn        = "可以在“選項”選項卡中設置默認值。",
    Seconds               = "秒",
    StartBiddingTTDesc    = "開始為當前項目出價。僅在運行時接受投標。",
    StartBiddingTTWarn    = "競標持續時間可以在“競標計時器”框中設置。為項目啟動第二次投標會話不會清除先前的投標（如果有人最後一秒截標，則可以使用）。",
    ClearBidWindow        = "清除視窗",
    ClearBidWindowTTDesc  = "從窗口清除所有項目信息和已提交的投標。",
    Bid                   = "出價",
    PlayerRoll            = "玩家名冊",
    ExpectedRoll          = "預期滾動",
    ItemCost              = "物品成本",
    ItemCostTTDesc        = "DKP向玩家收取物品費用。",
    LootHistoryUpdateComp = "戰利品歷史記錄更新已完成。",
    DKPHistoryUpdateComp  = "DKP歷史記錄更新已完成。",
    MinBidValuesReceived  = "收到的最低出價",
    ReloadUIForSettings   = "已更新DKP定義。您是否希望重新加載UI以反映這些更改？",
    DKPDataUpdatedBy      = "DKP數據庫更新者",
    LootHistCastComp      = "戰利品歷史廣播完成",
    DKPHistCastComp       = "DKP歷史廣播已完成",
    UnauthUpdate1         = "嘗試廣播修改過的表格。他不是您列入白名單的人員的一部分。",
    UnauthUpdate2         = "嘗試廣播修改過的表格。他不是您公會的指定官員。",
    DKPBroadcasted        = "廣播的DKP數據庫",
    BCastLootHist         = "廣播戰利品歷史",
    BCastDKPHist          = "廣播DKP歷史記錄",
    Load                  = "加載",
    More                  = "更多",
    ConfirmDeleteEntry1   = "您確定要刪除該條目嗎",
    DeleteEntryRefundConf = "受此條目影響的任何DKP都將從列出的每個玩家中退款/刪除。",
    DeleteDKPEntry        = "刪除DKP條目",
    MinBidDescription     = "使用最低出價值，所有廣告位（或單個項目）都被分配了最小值。 \n\nEx：|cffa335ee|Hitem:16865::::::::120:577::::::|h[Breastplate of Might]|h|r下降，且最低出價為50 DKP。每個想要的玩家都通過一個打開的通道（在下面選擇）發送“！bid 50”（或更高），而不超過其可用的DKP（除非激活了低於零的DKP）。出價最高的玩家將獲勝，並被收取最低DKP值或第二高出價者提交的值。閱讀工具提示以獲取更多信息。",
    StaticDescription     = "使用靜態項目值時，所有插槽（或單個項目）都分配有靜態值。每個需要該項目的玩家（帶有！bid）都將提交一個出價，並且具有最高可用DKP的玩家獲勝。成本值選項為\"Integer \"或\"Percent \"。\n\nEx：|cffa335ee|Hitem:19143::::::::120:577::::::|h[Flameguard Gauntlets]|h|r下降，靜態值為50 DKP。每個想要的玩家都通過一個打開的通道（在下面選擇）使用\"！bid \"。具有最高可用DKP的播放器獲勝，並收取該靜態值。閱讀工具提示以獲取更多信息。",
    RollDescription       = "使用基於滾動的出價，您可以使用多個參數選項。您可以在下面選擇計劃使用的捲筒類型。您設置的選項將不會成為接受或拒絕滾動的參數。而是會在出價窗口中顯示預期的滾動值以供審核。您可以右鍵單擊其滾動條，如果滾動條不符合正確的參數，則將其刪除。",
    ZeroSumDescription    = "使用零和DKP，項目可以具有靜態值，也可以被投標。 當玩家贏得某物品的競標價格或成本時，該DKP將從其中扣除，並在團隊中平均分配。 建議通過“ DKP取整”選項使用小數位，因為取整的整數可能會導致通貨膨脹或DKP丟失。 這將分發9點以上的成本\n\nEX：|cffa335ee|Hitem:18824::::::::120:577::::::|h[Magma Tempered Boots]|h|r滴和 的靜態費用為30 DKP。 玩家A通過擁有最多的DKP（或由平局領導酌情分配（如果平局）分配）來贏得競標，並且其DKP減少30。然後，每個突襲成員獲得0.75 DKP。",
    MinBidValuesHead      = "最低競標價格",
    StaticItemValuesHead  = "靜態項目值",
    RollBiddingHead       = "基於卷的出價",
    ZeroSumHead           = "零和",
    DKPModes              = "DKP模式",
    DKPModesTTDesc        = "在出價窗口中選擇要使用的DKP模式。選擇時，模式說明將顯示在上方。選擇模式後重新加載。",
    Static                = "靜態的",
    ZeroSumItemCost       = "零和項目成本",
    ZeroSumItemCostTTDesc = "選擇您要使用的物料成本類型。靜態為物料指定了成本。雖然最低出價允許玩家在設置最低出價閾值的同時提交定義成本的出價。",
    BidMethod             = "競價方式",
    DKPRounding           = "DKP舍入",
    DKPRoundingTTDesc     = "設置您希望在DKP系統中使用的小數位數。零將表示整數（無小數點）",
    OpenChannels          = "公開頻道",
    Whisper               = "耳語",
    Raid                  = "襲擊",
    Guild                 = "公會",
    CommandChannels       = "命令通道",
    CommandChannelsTTDesc = "選擇要打開的通道，以接收！bid和！dkp命令。您可以選擇三個的任意組合打開。無論通道是什麼，所有收到的命令都會以低聲回應。",
    FirstBidder           = "第一投標人",
    SecondBidder          = "第二投標人",
    CostAutoUpdate        = "費用自動更新",
    CostAutoUpdateTTDesc  = "選擇您希望在投標過程中將物料成本自動更新為的價格。\n\n|CFFFF0000第一投標人|r：這會將投標窗口底部的物料成本更新為最高投標人。\n\n|CFFFF0000第二投標人|r：這會將投標窗口底部的項目成本更新為第二高的投標人，或者如果只有一個投標人，則將最低投標值更新。\ n \ n費用總是可以隨時編輯。",
    CostAutoUpdateValue   = "費用自動更新值",
    ArtificialInflation   = "人工通脹",
    ArtInflatTTDesc       = "分配給每個玩家的DKP的TOP積分，在各個玩家之間分配。銀行價值除後，此值將添加到他們的收入DKP中。",
    Inflation             = "通貨膨脹",
    Integer               = "整數",
    Percent               = "百分",
    ItemCostTypes         = "物料成本類型",
    ItemCostTypesTTDesc   = "選擇用於物料成本的值的類型（玩家為物料支付的價格）；整數或百分比。這些值在\"Options\"選項卡中設置。\n\n|CFFFF0000整數|r：項目成本為整數（小數點以下四捨五入為\" DKP舍入\"指示的小數位）。例如：100 DKP。\n\n|CFFFF0000百分|r：物品成本是獲勝玩家總DKP的百分比。例如：玩家有1000 DKP，物品費用為20％。因此，該玩家的物品費用為200 DKP。",
    MaximumBid            = "最高出價",
    MaximumBidTTDesc      = "這是允許的最高出價。 如果玩家試圖出價高於此值，則其出價將被拒絕。 如果您不希望有最大值，則設置為0。",
    SubZeroBidding        = "零以下出價",
    SubZeroBiddingTTDesc  = "如果玩家沒有足夠的DKP或出價高於可用的DKP（取決於模式設置），則允許其出價。\n\n|cffff0000最低出價值|r：允許玩家出價高於他們的dkp，最高 \n\n|cffff0000其他|r：允許最高出價（設置如下）。\n\n|cffff0000其他|r：即使項目費用超出了其可用的DKP，也允許玩家提交出價。",
    Enabled               = "已啟用",
    Disabled              = "殘障人士",
    AllowNegativeBidders  = "允許負競價者",
    AllowNegativeBidTTDesc= "如果玩家的DKP當前為負數，則允許其出價。",
    RollSettings          = "紙捲設置",
    MinimumRoll           = "最小滾動",
    MinimumRollTTDesc     = "設置要使用的最小捲紙。",
    Min                   = "敏",
    Max                   = "馬克斯",
    MaximumRoll           = "最大滾動",
    MaximumRollTTDesc     = "設置要使用的最大卷數。保留空白可使用玩家最大DKP作為最大擲骰數。",
    MaximumRollTTWarn     = "如果未選中“使用百分比”，則最大DKP僅保留空白。如果選中，請使用100％。",
    UsePercForRolls       = "使用滾動百分比",
    UsePercRollsTTDesc    = "將上述擲骰範圍轉換為玩家DKP的百分比。 IE：擁有1000 dkp的玩家，且將上述值設置為70％-100％將會使用\n/隨機700-1000",
    UsePercRollsTTWarn    = "如果選中此選項，請僅使用0到100之間的數字。",
    AddToMaxRoll          = "添加到最大卷",
    AddToMaxRollTTDesc    = "將預定值添加到最大滾動。",
    AddToMaxRollTTWarn    = "例如：如果您希望玩家的最大擲骰數是他們的最大DKP + 500（上面設置了1-MaxDKP的範圍），那麼擁有80 DKP的玩家將期望/隨機1-580。",
    InvalidRollRange      = "您設置了無效的滾動範圍。請修改您的設置。",
    AreYouSureBroadcast   = "您確定要廣播DKP模式設置嗎？",
    DKPModeSentConf       = "已發送DKP模式設置",
    BroadcastSettings     = "廣播設置",
    BroadcastSetTTDesc    = "廣播所有與DKP相關的設置，包括上述DKP模式參數以及項目值和獎勵值（在選項中設置）。",
    DKPModesFooter        = "如果對此窗口進行了任何更改，將重新加載您的UI | cffff0000MUST | r。如果重新加載未完成，您將收到錯誤消息。窗口關閉時，系統會提示您這樣做。",
    InvalidRollParam      = "您設置了無效的滾動參數。請修改您的設置。",
    ReloadUIConfirm       = "為了使這些設置生效，我們需要重新加載您的UI。您現在要這樣做嗎？",
    AlreadyAssigned       = "該項目已經分配給該玩家。",
    AreYouSureReassign    = "您確定要重新分配嗎",
    ThisWillRefund        = "這將退還",
    AndChargeItTo         = "並充電到",
    Won                   = "韓元",
    ReassignSelected      = "重新分配給選定的球員",
    TooManyPlayersSelect  = "選擇的玩家過多。",
    NoPlayersSelected     = "未選擇任何玩家轉移戰利品。",
    WonBy                 = "贏了",
    In                    = "在",
    Off                   = "關",
    Load50More            = "加載50更多...",
    Added                 = "添加",
    Players               = "玩家",
    NotAnOfficer          = "不是官員。您只能在行會設置中添加具有“編輯主管注意”權限的等級。",
    WhiteListBroadcasted  = "白名單廣播",
    AddRaidMembers        = "添加團隊成員",
    AddRaidMembersTTDesc  = "將公會中的所有團隊成員添加到DKP表中。",
    AddRaidMembersConfirm = "您確定要向DKP表添加缺少的RAID成員嗎？",
    AddRemDKPTableEntries = "添加/刪除DKP表條目",
    RemoveSelectedEntries = "刪除所選條目",
    RemSelEntriesTTDesc   = "從DKP表中刪除選定的播放器。該玩家的所有引用將保留（DKP歷史記錄和戰利品歷史記錄），但其名稱將顯示為灰色。",
    RemSelEntriesTTWarn   = "警告：此操作是永久性的。",
    ConfirmRemoveSelect   = "您確定要刪除嗎",
    NoEntriesSelected     = "未選擇任何條目。",
    ResetPrevDKP          = "重設上一個DKP",
    ResetPrevDKPTTDesc    = "將先前的DKP計數器重置為其當前DKP（每個播放器當前DKP旁邊的灰色小+/-數字）。這不會以任何方式影響功能。只是自上次重置以來每個玩家的收入/花費的參考。",
    ResetPrevDKPTTWarn    = "建議定期重設（每週，每月等）。這是QOL功能，不會影響功能。",
    ResetPrevConfirm      = "您確定要重置以前的DKP嗎？",
    RankList              = "排名表",
    RankListTTDesc        = "選擇一個等級，然後單擊\"添加公會成員\"以將所選等級的所有公會成員添加到DKP表中。",
    SelectRank            = "選擇等級",
    AddGuildDKPTable      = "將公會添加到DKP表",
    AddGuildDKPTableTT    = "添加所選等級的所有公會成員，但這些公會成員尚未包含在DKP表中。",
    AddGuildConfirm       = "您確定要添加所有行列成員嗎？",
    OrAbove               = "或以上？",
    NoRankSelected        = "未選擇等級。",
    AddTargetToDKPTable   = "將目標添加到DKP表",
    AddTargetTTDesc       = "將您當前的目標（如果有玩家）添加到DKP表中。與所有其他選項不同，這不需要將目標包含在行會中。",
    ConfirmAddTarget      = "您確定要添加嗎",
    ToDKPList             = "到DKP列表？",
    NoPlayerTargeted      = "沒有玩家目標。",
    WhiteListHeader       = "白名單設置|CFF444444（僅領導人）（Alpha|r \n\n強烈建議您僅在希望限制哪些警官需要權限的情況下才使用此白名單設置。如果您希望所有人員都具有權限，請完全忽略此設置功能。請謹慎使用。 （如果應用這些設置會導致問題，請使用文本編輯器打開 \\WTF\\Accounts\\ACCOUNT_NAME\\SavedVariables\\MonolithDKP.lua文件，然後刪除底部附近的MonDKP_Whitelist表。）",
    SetWhitelist          = "設置白名單",
    SetWhitelistTTDesc1   = "將DKP表中的選定人員添加到白名單中。白名單用於|cffff0000限制|r有權修改DKP值的人員。",
    SetWhitelistTTDesc2   = "在未選擇任何玩家的情況下使用此選項將清除您的白名單。",
    SetWhitelistTTWarn    = "只有軍官才能被列入白名單。此選項專門用於限制在此插件中哪些軍官具有軍官權限。如果您希望所有官員都獲得許可，請將白名單留空。",
    ConfirmWhitelist      = "您確定要將選定的球員添加到白名單中嗎？",
    ConfirmWhitelistClear = "您確定要清除白名單嗎？",
    ViewWhitelistBtn      = "查看白名單",
    ViewWhitelistTTDesc   = "在您的DKP列表中選擇所有列入白名單的人員。",
    WhitelistEmpty        = "您的白名單是空的。",
    SendWhitelist         = "發送白名單",
    SendWhitelistTTDesc   = "向所有人員廣播您的白名單。",
    SendWhitelistTTWarn   = "建議您在所有人員都在線時執行此操作。如果某位官員沒有收到此白名單，則他們將具有全部官員權限。但是，他們將無法將其信息廣播給其他人員。如果他們嘗試，您將收到通知。如果您收到該通知，則發送白名單及其權限將被刪除。",
    BroadcastDKPTableConf = "您確定要廣播所有表嗎？這不會將您的表與其他人合併。它將用您的確切副本完全覆蓋整個行會表。",
    BcastLootTableConf    = "您確定要廣播“戰利品歷史記錄”表嗎？",
    LootHistUpdateProg    = "戰利品歷史記錄更新中",
    DKPHistUPdateProg     = "DKP歷史記錄更新正在進行中",
    BcastDKPHistConf      = "您確定要廣播DKP歷史記錄表嗎？",
    BroadcastHeader       = "如果DKP歷史記錄或戰利品歷史記錄表大於100個條目，由於暴雪實施了防洪措施，將需要一些時間來廣播它們。 2500個條目最多可能需要3-5分鐘。廣播之間請間隔1-2秒，以允許同時更新。 “廣播DKP表”應該相對即時。所有廣播都是GUILD範圍的（出價/突擊計時器例外，僅限RAID）。",
    BCastDKPTableBtn      = "廣播DKP表",
    BcastLootHistBtn      = "廣播戰利品歷史",
    BcastDKPHistBtn       = "廣播DKP歷史記錄",
    DefaultDKPAwardValues = "默認DKP獎勵值",
    DKPModesTTDesc2       = "配置將使用的DKP系統類型。每種模式下的高度可變性。",
    DKPModesTTWarn        = "如果更改任何設置，則必須重新加載您的界面。關閉時，系統會提示您這樣做。否則會導致錯誤。",
    OnTimeBonusTTDesc     = "獎金，因為準時出席。",
    BossKillBonusTTDesc   = "殺死老闆可獲得的獎金。",
    RaidCompleteBonusTT   = "獎勵給參加完工團隊的每個人。",
    NewBossKillTTDesc     = "升級突襲期間首次上司殺死的獎勵。",
    UnexcusedTTDesc       = "對突襲無故缺席的處罰。",
    UnexcusedTTWarn       = "應為負數。",
    DecayPercentage       = "衰減百分比",
    DecayPercentageTTDesc = "減少所有DKP值以進行常規衰減的百分比。",
    DecayPercentageTTWarn = "不是負數。",
    DecayAmount           = "衰減量",
    DefaultMinBidValues   = "預設最低競標價格",
    DefaultItemCosts      = "默認物料成本",
    DKPPrice              = "DKP價格",
    PercentCost           = "成本百分比",
    Head                  = "頭",
    Neck                  = "頸部",
    Shoulders             = "護肩",
    Cloak                 = "披風",
    Chest                 = "胸部",
    Bracers               = "護腕",
    Hands                 = "手",
    Belt                  = "帶",
    Legs                  = "腿部",
    Boots                 = "靴子",
    Rings                 = "戒指",
    Trinket               = "飾品",
    Range                 = "範圍",
    Other                 = "其他",
    OneHanded             = "一隻手",
    OneHandedWeapons      = "單手武器",
    TwoHanded             = "雙手的",
    TwoHandedWeapons      = "雙手武器",
    OffHand               = "副手",
    OffHandItems          = "副手物品",
    ForHeadSlot           = "用於頭部插槽項目。",
    ForNeckSlot           = "用於頸項。",
    ForShoulderSlot       = "用於肩槽物品。",
    ForBackSlot           = "用於後插槽項目。",
    ForChestSlot          = "用於胸口物品。",
    ForWristSlot          = "用於腕槽物品。",
    ForHandSlot           = "用於手動插槽項目。",
    ForWaistSlot          = "用於腰圍物品。",
    ForLegSlot            = "用於腿槽物品。",
    ForFeetSlot           = "用於腳槽物品。",
    ForFingerSlot         = "用於手指插槽項目。",
    ForTrinketSlot        = "用於飾品插槽項目。",
    ForOneHandSlot        = "單手武器。",
    ForTwoHandSlot        = "雙手武器。",
    ForOffHandSlot        = "用於副手物品（盾牌，施法者副手）。",
    ForRangeSlot          = "用於範圍插槽物品（弓，槍，魔杖，遺物）。",
    ForOtherSlot          = "適用於所有其他不屬於上述類別的物品（頭部，心臟，獵人之葉等​​）",
    MinBidValuesSent      = "最低出價已發送",
    BcastMinBidConfirm    = "您確定要向所有人員廣播最低出價設置嗎？",
    BcastValues           = "廣播值",
    BcastValuesTTDesc     = "將高於最低出價的價格廣播給所有人員。這還將在出價窗口中廣播為特定項目設置的所有自定義值。",
    BcastValuesTTWarn     = "當前值不會被覆蓋。接收此廣播將更新已設置的值或添加不存在的值。他們可能具有的任何未發送的值將保持不變。",
    BidTimerDefaultTTDesc = "出價計時器的默認時間（以秒為單位）。",
    TTHistoryCount        = "工具提示歷史記錄計數",
    TTHistoryCountTTDesc  = "工具提示中列出的戰利品/ dkp歷史記錄條目數。",
    LootHistoryLimit      = "戰利品歷史限制",
    LootHistLimitTTDesc   = "存儲的最大戰利品歷史記錄條目。",
    LootHistLimitTTWarn   = "警告：如果將其減少到當前存儲的條目數以下，則最早的將被刪除以達到限制。",
    DKPHistoryLimit       = "DKP歷史記錄限制",
    DKPHistLimitTTDesc    = "存儲的最大DKP歷史記錄條目。",
    DKPHistLimitTTWarn    = "警告：如果將其減少到當前存儲的條目數以下，則最早的將被刪除以達到限制。",
    TimerSize             = "計時器大小",
    TimerSizeTTDesc       = "投標/突擊計時器的規模。",
    TimerSizeTTWarn       = "可以通過單擊\"移動出價計時器\"並將其拖動到所需位置來調整位置。",
    MonDKPScaleSize       = "整體式DKP秤尺寸",
    MonDKPScaleSizeTTDesc = "Monolith DKP窗口的比例。單擊\"保存設置\"以將大小更改為設置值。",
    MonDKPScaleSizeTTWarn = "如果使用另一個修改UI比例的插件（例如TukUI，ElvUI等），則保存後可能需要/ reload。",
    MainGUISize           = "主GUI大小",
    SuppressNotifications = "Supress插件通知",
    SuppressNotifyTTDesc  = "隱藏所有附加消息，使其不會顯示在聊天框中。",
    SuppressNotifyTTWarn  = "廣播更新仍將被接收。",
    NotificationsLikeThis = "這樣的通知現在",
    Hidden                = "隱",
    Visible               = "可見",
    SuppressBidWhisp      = "Supress競價耳語",
    SupressBidWhispTTDesc = "在進行投標時，抑制與投標有關的傳入和傳出耳語。",
    SupressBidWhispTTWarn = "所有其他與非出價相關的耳語仍將顯示。",
    BidWhispAreNow        = "競價耳語現在",
    InvalidMinBidEntry    = "的最低出價無效",
    InvalidOptionEntry    = "在無效的選項輸入",
    PleaseUseNums         = "請使用數字。",
    DefaultSetSaved       = "默認設置已保存。",
    MoveBidTimer          = "移動出價計時器",
    MoveMe                = "感動我！",
    HideBidTimer          = "隱藏出價計時器",
    Among                 = "其中",
    PlayersForReason      = "玩家原因",
    NotInRaidParty        = "您沒有參加團隊聚會。",
    ZeroSumBank           = "零和銀行",
    Boss                  = "老闆",
    ZeroSumBalance        = "零和余額",
    ZeroSumBalanceTTDesc  = "購買戰利品後，自動累積所有由突襲者花費的DKP，以進行分發。",
    Balance               = "平衡",
    DistributeDKP         = "分發DKP",
    DistributeAllDKPConf  = "將DKP分發給團隊中的所有玩家？",
    NoPointsToDistribute  = "沒有要分發的點。",
    DistrubuteBanked      = "在當前老闆的掠奪完成後，將銀行化DKP平均分配給所有團隊成員。",
    IncludeStandbyList    = "包括備用清單",
    IncStandbyListTTDesc  = "在分發中的待機列表中包括播放器。",
    IncStandbyListTTWarn  = "這將給團隊中的玩家帶來較小的價值。",
    LootBanked            = "戰利品銀行",
    AllClasses            = "所有課程",
    RemoveEntries         = "刪除條目",
    ResetPrevious         = "重設上一個",
    AddGuildMembers       = "添加公會成員",
    AddTarget             = "添加目標",
    NotInRaidFilter       = "不突襲",
    Online                = "線上",
    OnlyPartyRaid         = "只有派對或突襲",
    ManuallyDenied        = "已被拒絕。",
    UsePercentage         = "使用百分比",
    RollRange             = "橫滾範圍",
    AwardItem             = "獎勵項目",
    SaveSettings          = "保存設置",
    ConfAward             = "確認獎項",
    Zone                  = "區",
    Confirm               = "確認",
    Cancel                = "取消",
    GenDKPTable           = "生成DKP表",
    GenDKPHist            = "生成DKP歷史記錄",
    GenLootHist           = "生成戰利品歷史",
    OutOfDateAnnounce     = "您的Monolith DKP版本已過時。請更新Curse / Twitch或WoWInterface，以確保沒有兼容性問題。",
    ClickQueryGuild       = "單擊以查詢該行會，以查找哪些\n在線的軍官具有更新的表。",
    TableQueryHeader      = "公會DKP表狀態",
    TableQuerySent        = "查詢公會DKP表狀態",
    TableQueryUTD         = "最新",
    TableQueryOOD         = "過時的",
    TableQueryOfficer     = "人員表狀態（在線）",
    TableQueryNonOfficer  = "非辦公人員表狀態（在線）",
    None                  = "沒有",
    YourTablesAreCurr     = "您的桌子目前",
    ContactOfficer        = "請與上方顯示為“最新”的人員聯繫，以更新您的表格。",
    TotalMonDKPUsers      = "MonDKP用戶總數",
    Spec                  = "專業化",
    Rank                  = "秩",
    CurrentlySyncing      = "您當前正在同步表。請等待直到完成以繼續。",
    BcastCompleted        = "所有廣播均已完成。",
    DontShow              = "此版本不再顯示。",
    BlockOODBroadcast     = "您不能廣播過期的表。這樣做將導致不可恢復的數據丟失。如果您絕對肯定您擁有最新數據，則從行會負責人的公開註釋中刪除標籤即可解決此問題。",
    BestPractices         = "最佳實踐：最好在每個人劃入區域後，在襲擊開始時（或如果有新玩家加入），使用“管理”選項卡底部的按鈕讓一名軍官（具有最新的表）廣播所有數據。 （分區可能會中斷廣播）。只有一名軍官需要這樣做。之後，每個創建的條目將單獨廣播。除了使每個人都坐在同一張桌子上之外，出於任何原因都不需要全表廣播。完整廣播不會合併表。它會用您的確切副本完全覆蓋行會表中的每個人。還建議您在每個dkp / loot會話之後/重新加載UI，以將數據提交到SavedVariables文件。如果您不重新加載就進行了一次完整的突襲，最後崩潰或斷開連接，則所有已應用的數據都將丟失。每個老闆之後重新加載可以幫助防止這種情況。此外，在其他人員離線時編輯表（授予DKP或刪除條目以測試插件），儘管具有完全相同的數據，也會使它們的表過時。如果發生這種情況，請從“公會領袖”公共筆記中刪除{MonDKP=#####}標記以重置時間戳。",
    NameNotFound          = "在DKP數據庫中找不到您的名字。",
    YourBid               = "您的出價",
    NoSpecReported        = "沒有規格報告",
    Protection            = "防護",
    Holy                  = "神聖",
    Retribution           = "懲戒",
    Shadow                = "暗影",
    Restoration           = "恢復",
    Balance               = "平衡",
    Feral                 = "野性戰鬥",
    Elemental             = "元素",
    Enhancement           = "增強",
    Role                  = "角色",
    NoRoleDetected        = "未檢測到角色",
    Tank                  = "罐",
    MeleeDPS              = "近戰DPS",
    RangeDPS              = "射程DPS",
    CasterDPS             = "腳輪DPS",
    Healer                = "治癒者",
    Search                = "搜索",
    SearchDesc            = "過濾DKP列表。搜索名稱，類或角色。",

    ChangeLog1            = "- 現在，將鼠標懸停在狀態指示器上而不是在聊天中時，表狀態查詢結果將顯示在工具提示中。",
    ChangeLog2            = "- 將下拉菜單添加到DKP表的中心列，並帶有顯示等級，類別或規格的選項。該列仍可按所選數據排序（僅類別和等級）",
    ChangeLog3            = "- 查詢桌子狀態（單擊左下角的狀態指示器）還將返回每個玩家規格，以供“規格”下拉菜單使用。每個播放器都必須具有v1.5.2或更高版本才能運行。",
    ChangeLog4            = "- 查詢中包含的行，顯示行會中有多少個玩家正在使用插件（顯示為人員）。",
    ChangeLog5            = "- 修正了玩家死亡記錄並帶有暴民殺死的錯誤，可與獎勵確認窗口中的下拉菜單一起使用。",
    ChangeLog6            = "- 將“管理”選項卡中的手動廣播按鈕濃縮為一個按鈕。同時也阻止了廣播時進行的任何更改，因為如果您的歷史記錄表很大，這可能需要一兩分鐘的時間，這樣做會導致串擾損壞表。強制一起廣播所有表將​​有助於減少或消除條目丟失的可能性。廣播結束後，系統將提示您確認。廣播進行期間，請勿分區或登錄。",
    ChangeLog7            = "- 從視圖團隊切換到查看全部時，更正了錯誤",
    ChangeLog8            = "- 用於廣播從DKP歷史記錄和戰利品歷史記錄中刪除條目的重寫過程。這有望減少神秘消失的發生。",
    ChangeLog9            = "- 糾正了不在DKP列表中的某人嘗試滾動時使用滾動出價的錯誤",
    ChangeLog10           = "",
  }
end