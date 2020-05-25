local _, core = ...;
local _G = _G;
local MonDKP = core.MonDKP;
local L = core.L;
local waitTable = {};
local waitFrame = nil;
local addon_loaded = false;
local lockouts = CreateFrame("Frame", "LockoutsFrame");

--------------------------------------
-- Slash Command
--------------------------------------
MonDKP.Commands = {
  ["config"] = function()
    if core.Initialized then
      local pass, err = pcall(MonDKP.Toggle)

      if not pass then
        MonDKP:Print(err)
        core.MonDKPUI:SetShown(false)
        StaticPopupDialogs["SUGGEST_RELOAD"] = {
          text = "|CFFFF0000"..L["WARNING"].."|r: "..L["MUSTRELOADUI"],
          button1 = L["YES"],
          button2 = L["NO"],
          OnAccept = function()
            ReloadUI();
          end,
          timeout = 0,
          whileDead = true,
          hideOnEscape = true,
          preferredIndex = 3,
        }
        StaticPopup_Show ("SUGGEST_RELOAD")
      end
    else
      MonDKP:Print("Monolith DKP has not completed initialization.")
    end
  end,
  ["reset"] = MonDKP.ResetPosition,
  ["bid"] = function(...)
    if core.Initialized then
      local item = strjoin(" ", ...)
      MonDKP:CheckOfficer()
      MonDKP:StatusVerify_Update()

      if core.IsOfficer then  
        if ... == nil then
          MonDKP.ToggleBidWindow()
        else
          local itemName,_,_,_,_,_,_,_,_,itemIcon = GetItemInfo(item)
          MonDKP:Print("Opening Bid Window for: ".. item)
          MonDKP:ToggleBidWindow(item, itemIcon, itemName)
        end
      end
      MonDKP:BidInterface_Toggle()
    else
      MonDKP:Print("Monolith DKP has not completed initialization.")
    end 
  end,
  ["repairtables"] = function(...)       -- test new features
    local cmd = ...
    if core.IsOfficer then
      if cmd == "true" then
        MonDKP:RepairTables(cmd)
      else
        MonDKP:RepairTables()
      end
    end
  end,
  ["award"] = function (name, ...)
    if core.IsOfficer and core.Initialized then
      MonDKP:StatusVerify_Update()
      
      if not name or not strfind(name, ":::::") then
        MonDKP:Print(L["AWARDWARNING"])
        return
	  end
      local item = strjoin(" ", ...)
      if not item then return end
      item = name.." "..item;
	  local itemName,_,_,_,_,_,_,_,_,_ = GetItemInfo(item)
	  local cost = 0;
	  local search = MonDKP:Table_Search(MonDKP:GetTable(MonDKP_Player_MinBids, true), itemName)

	  if not search then
		cost = MonDKP:GetMinBid(item)
	  else
		cost = MonDKP:GetTable(MonDKP_Player_MinBids, true)[search[1][1]].minbid;
	  end

	  MonDKP:AwardConfirm(nil, cost, MonDKP_DB.bossargs.LastKilledBoss, MonDKP_DB.bossargs.CurrentRaidZone, item)
    else
      MonDKP:Print(L["NOPERMISSION"])
    end
  end,
  ["lockouts"] = function()
    lockouts:RegisterEvent("UPDATE_INSTANCE_INFO");
    lockouts:SetScript("OnEvent", MonDKP_OnEvent);
    RequestRaidInfo()
  end,
  ["timer"] = function(time, ...)
    if time == nil then
      MonDKP:BroadcastTimer(1, "...")
    else
      local title = strjoin(" ", ...)
      MonDKP:BroadcastTimer(tonumber(time), title)
    end
  end,
  ["export"] = function(time, ...)
    MonDKP:ToggleExportWindow()
  end,
  ["modes"] = function()
    if core.Initialized then
      MonDKP:CheckOfficer()
      if core.IsOfficer then
        MonDKP:ToggleDKPModesWindow()
      else
        MonDKP:Print(L["NOPERMISSION"])
      end
    else
      MonDKP:Print("Monolith DKP has not completed initialization.")
    end
  end,
  ["help"] = function()
    MonDKP:Print(" ");
    MonDKP:Print(L["SLASHCOMMANDLIST"]..":")
    MonDKP:Print("|cff00cc66/dkp|r - "..L["DKPLAUNCH"]);
    MonDKP:Print("|cff00cc66/dkp ?|r - "..L["HELPINFO"]);
    MonDKP:Print("|cff00cc66/dkp reset|r - "..L["DKPRESETPOS"]);
    MonDKP:Print("|cff00cc66/dkp lockouts|r - "..L["DKPLOCKOUT"]);
    MonDKP:Print("|cff00cc66/dkp timer|r - "..L["CREATERAIDTIMER"]);
    MonDKP:Print("|cff00cc66/dkp bid|r - "..L["OPENBIDWINDOWHELP"]);
    MonDKP:Print("|cff00cc66/dkp bid [itemlink]|r - "..L["OPENAUCWINHELP"]);
    MonDKP:Print("|cff00cc66/dkp award [item link]|r - "..L["DKPAWARDHELP"]);
    MonDKP:Print("|cff00cc66/dkp modes|r - "..L["DKPMODESHELP"]);
    MonDKP:Print("|cff00cc66/dkp export|r - "..L["DKPEXPORTHELP"]);
    MonDKP:Print(" ");
    MonDKP:Print(L["WHISPERCMDSHELP"]);
    MonDKP:Print("|cff00cc66!bid (or !bid <"..L["VALUE"]..">)|r - "..L["BIDHELP"]);
    MonDKP:Print("|cff00cc66!dkp (or !dkp <"..L["PLAYERNAME"]..">)|r - "..L["DKPCMDHELP"]);
  end,
};

local function HandleSlashCommands(str)
  if (#str == 0) then
    MonDKP.Commands.config();
    return;
  end  
  
  local args = {};
  for _, arg in ipairs({ string.split(' ', str) }) do
    if (#arg > 0) then
      table.insert(args, arg);
    end
  end
  
  local path = MonDKP.Commands;
  
  for id, arg in ipairs(args) do
    if (#arg > 0) then
      arg = arg:lower();      
      if (path[arg]) then
        if (type(path[arg]) == "function") then
          path[arg](select(id + 1, unpack(args))); 
          return;          
        elseif (type(path[arg]) == "table") then        
          path = path[arg];
        end
      else
        MonDKP.Commands.help();
        return;
      end
    end
  end
end

function MonDKP_wait(delay, func, ...)
	if(type(delay)~="number" or type(func)~="function") then
		return false;
	end
	if(waitFrame == nil) then
		waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
		waitFrame:SetScript("onUpdate",function (self,elapse)
		local count = #waitTable;
		local i = 1;
		while(i<=count) do
			local waitRecord = tremove(waitTable,i);
			local d = tremove(waitRecord,1);
			local f = tremove(waitRecord,1);
			local p = tremove(waitRecord,1);
			if(d>elapse) then
			tinsert(waitTable,i,{d-elapse,f,p});
			i = i + 1;
			else
			count = count - 1;
			f(unpack(p));
			end
		end
		end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end

function DoInit(event, arg1)
	MonDKP:OnInitialize(event, arg1);
	addon_loaded = true;
end

function DoGuildUpdate()
	if IsInGuild() and not core.InitStart then
		GuildRoster()
		core.InitStart = true

		-- Prints info after all addons have loaded. Circumvents addons that load saved chat messages pushing info out of view.
		C_Timer.After(3, function ()
			MonDKP:CheckOfficer()
			MonDKP:SortLootTable()
			MonDKP:SortDKPHistoryTable()
			MonDKP:Print(L["VERSION"].." "..core.MonVersion..", "..L["CREATEDMAINTAIN"].." Kyliee@BloodsailBuccaneers-Classic");
			MonDKP:Print(L["LOADED"].." "..#MonDKP:GetTable(MonDKP_Player_DKPTable, true).." "..L["PLAYERRECORDS"]..", "..#MonDKP:GetTable(MonDKP_Player_Loot, true).." "..L["LOOTHISTRECORDS"].." "..#MonDKP:GetTable(MonDKP_Player_DKPHistory, true).." "..L["DKPHISTRECORDS"]..".");
			MonDKP:Print(L["USE"].." /dkp ? "..L["SUBMITBUGS"].." @ https://github.com/Roeshambo/MonolithDKP/issues");
			MonDKP.Sync:SendData("MonDKPBuild", tostring(core.BuildNumber)) -- broadcasts build number to guild to check if a newer version is available

			if not core.DB.defaults.installed210 then
				core.DB.defaults.installed210 = time(); -- identifies when 2.1.0 was installed to block earlier posts from broadcasting in sync (for now)
				MonDKP_ReindexTables() 					-- reindexes all entries created prior to 2.1 installation in "GuildMaster-EntryDate" format for consistency.
				core.DB.defaults.installed = nil
			end

			local seed
			if #MonDKP:GetTable(MonDKP_Player_DKPHistory, true) > 0 and #MonDKP_Loot > 0 and strfind(MonDKP:GetTable(MonDKP_Player_DKPHistory, true)[1].index, "-") and strfind(MonDKP:GetTable(MonDKP_Player_Loot, true)[1].index, "-") then
				local off1,date1 = strsplit("-", MonDKP:GetTable(MonDKP_Player_DKPHistory, true)[1].index)
				local off2,date2 = strsplit("-", MonDKP:GetTable(MonDKP_Player_Loot, true)[1].index)
				
				if MonDKP:ValidateSender(off1) and MonDKP:ValidateSender(off2) and tonumber(date1) > core.DB.defaults.installed210 and tonumber(date2) > core.DB.defaults.installed210 then
					seed = MonDKP:GetTable(MonDKP_Player_DKPHistory, true)[1].index..","..MonDKP:GetTable(MonDKP_Player_Loot, true)[1].index  -- seed is only sent if the seed dates are post 2.1 installation and the posting officer is an officer in the current guild
				else
					seed = "start"
				end
			else
				seed = "start"
			end

			MonDKP.Sync:SendData("MonDKPQuery", seed) -- requests role and spec data and sends current seeds (index of newest DKP and Loot entries)
		end)
	end
end

function MonDKP_OnEvent(self, event, arg1, ...)

	-- unregister unneccessary events
	if event == "CHAT_MSG_WHISPER" and not core.DB.modes.channels.whisper then
		self:UnregisterEvent("CHAT_MSG_WHISPER")
		return
	end
	if (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER") and not core.DB.modes.channels.raid then
		self:UnregisterEvent("CHAT_MSG_RAID")
		self:UnregisterEvent("CHAT_MSG_RAID_LEADER")
		return
	end
	if event == "CHAT_MSG_GUILD" and not MonDKP_DB.modes.channels.guild and not MonDKP_DB.modes.StandbyOptIn then
		self:UnregisterEvent("CHAT_MSG_GUILD")
		return
	end

	if event == "ADDON_LOADED" then
		if (arg1 ~= "MonolithDKP") then return end
		MonDKP_wait(2.5, DoInit, event, arg1);
		self:UnregisterEvent("ADDON_LOADED")
	elseif event == "BOSS_KILL" then
		MonDKP:CheckOfficer()
		if core.IsOfficer and IsInRaid() then
			local boss_name = ...;

			if MonDKP:Table_Search(core.EncounterList, arg1) then
				MonDKP.ConfigTab2.BossKilledDropdown:SetValue(arg1)

				if MonDKP_DB.modes.StandbyOptIn then
					MonDKP_Standby_Announce(boss_name)
				end

				if MonDKP_DB.modes.AutoAward then
					if not MonDKP_DB.modes.StandbyOptIn and MonDKP_DB.DKPBonus.IncStandby then
						MonDKP:AutoAward(3, MonDKP_DB.DKPBonus.BossKillBonus, MonDKP_DB.bossargs.CurrentRaidZone..": "..MonDKP_DB.bossargs.LastKilledBoss)
					else
						MonDKP:AutoAward(1, MonDKP_DB.DKPBonus.BossKillBonus, MonDKP_DB.bossargs.CurrentRaidZone..": "..MonDKP_DB.bossargs.LastKilledBoss)
					end
				end
			else
				MonDKP:Print("Event ID: "..arg1.." - > "..boss_name.." Killed. Please report this Event ID at https://www.curseforge.com/wow/addons/monolith-dkp to update raid event handlers.")
			end
		elseif IsInRaid() then
			MonDKP_DB.bossargs.LastKilledBoss = ...;
		end
	elseif event == "ENCOUNTER_START" then
		if MonDKP_DB.defaults.AutoLog and IsInRaid() then
			if not LoggingCombat() then
				LoggingCombat(1)
				MonDKP:Print(L["NOWLOGGINGCOMBAT"])
			end
		end
	elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then   		-- logs 15 recent zones entered while in a raid party
		if IsInRaid() and core.Initialized then 					-- only processes combat log events if in raid
			MonDKP:CheckOfficer()
			if core.IsOfficer then
				if not MonDKP:Table_Search(MonDKP_DB.bossargs.RecentZones, GetRealZoneText()) then 	-- only adds it if it doesn't already exist in the table
					if #MonDKP_DB.bossargs.RecentZones > 14 then
						for i=15, #MonDKP_DB.bossargs.RecentZones do  		-- trims the tail end of the stack
							table.remove(MonDKP_DB.bossargs.RecentZones, i)
						end
					end
					table.insert(MonDKP_DB.bossargs.RecentZones, 1, GetRealZoneText())
				end
			end
			if MonDKP_DB.defaults.AutoLog and MonDKP:Table_Search(core.ZoneList, GetRealZoneText()) then
				if not LoggingCombat() then
					LoggingCombat(1)
					MonDKP:Print(L["NOWLOGGINGCOMBAT"])
				end
			end
		end
	elseif event == "CHAT_MSG_WHISPER" then
		MonDKP:CheckOfficer()
		if core.IsOfficer then
			arg1 = strlower(arg1)
			if (core.BidInProgress or string.find(arg1, "!dkp") == 1 or string.find(arg1, "！dkp") == 1) then
				MonDKP_CHAT_MSG_WHISPER(arg1, ...)
			elseif string.find(arg1, "!standby") == 1 and core.StandbyActive then
				MonDKP_Standby_Handler(arg1, ...)
			end
		end
	elseif event == "GUILD_ROSTER_UPDATE" then
		if not addon_loaded then return end
		DoGuildUpdate();
		if IsInGuild() and core.InitStart then
			self:UnregisterEvent("GUILD_ROSTER_UPDATE")
		end
	elseif event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
		MonDKP:CheckOfficer()
		arg1 = strlower(arg1)
		if (core.BidInProgress or string.find(arg1, "!dkp") == 1 or string.find(arg1, "!standby") == 1 or string.find(arg1, "！dkp") == 1) and core.IsOfficer == true then
			MonDKP_CHAT_MSG_WHISPER(arg1, ...)
		end
	elseif event == "UPDATE_INSTANCE_INFO" then
		local num = GetNumSavedInstances()
		local raidString, reset, newreset, days, hours, mins, maxPlayers, numEncounter, curLength;

		if not MonDKP_DB.Lockouts then MonDKP_DB.Lockouts = {Three = 0, Five = 1570032000, Seven = 1569945600} end

		for i=1, num do 		-- corrects reset timestamp for any raids where an active lockout exists
			_,_,reset,_,_,_,_,_,maxPlayers,_,numEncounter = GetSavedInstanceInfo(i)
			newreset = time() + reset + 2 	-- returned time is 2 seconds off

			if maxPlayers == 40 and numEncounter > 1 then
				curLength = "Seven"
			elseif maxPlayers == 40 and numEncounter == 1 then
				curLength = "Five"
			elseif maxPlayers == 20 then
				curLength = "Three"
			end

			if MonDKP_DB.Lockouts[curLength] < newreset then
				MonDKP_DB.Lockouts[curLength] = newreset
			end
		end

		-- Updates lockout timer if no lockouts were found to do so.
		while MonDKP_DB.Lockouts.Three < time() do MonDKP_DB.Lockouts.Three = MonDKP_DB.Lockouts.Three + 259200 end
		while MonDKP_DB.Lockouts.Five < time() do MonDKP_DB.Lockouts.Five = MonDKP_DB.Lockouts.Five + 432000 end
		while MonDKP_DB.Lockouts.Seven < time() do MonDKP_DB.Lockouts.Seven = MonDKP_DB.Lockouts.Seven + 604800 end

		for k,v in pairs(MonDKP_DB.Lockouts) do
			reset = v - time();
			days = math.floor(reset / 86400)
			hours = math.floor(math.floor(reset % 86400) / 3600)
			mins = math.ceil((reset % 3600) / 60)
			
			if days > 1 then days = " "..days.." "..L["DAYS"] elseif days == 0 then days = "" else days = " "..days.." "..L["DAY"] end
			if hours > 1 then hours = " "..hours.." "..L["HOURS"] elseif hours == 0 then hours = "" else hours = " "..hours.." "..L["HOUR"].."." end
			if mins > 1 then mins = " "..mins.." "..L["MINUTES"].."." elseif mins == 0 then mins = "" else mins = " "..mins.." "..L["MINUTE"].."." end

			if k == "Three" then raidString = "ZG, AQ20"
			elseif k == "Five" then raidString = "Onyxia"
			elseif k == "Seven" then raidString = "MC, BWL, AQ40"
			end

			if k ~= "Three" then 	-- remove when three day raid lockouts are added
				MonDKP:Print(raidString.." "..L["RESETSIN"]..days..hours..mins.." ("..date("%A @ %H:%M:%S%p", v)..")")
			end
		end

		self:UnregisterEvent("UPDATE_INSTANCE_INFO");
	elseif event == "CHAT_MSG_GUILD" then
		MonDKP:CheckOfficer()
		if core.IsOfficer then
			arg1 = strlower(arg1)
			if (core.BidInProgress or string.find(arg1, "!dkp") == 1 or string.find(arg1, "！dkp") == 1) and MonDKP_DB.modes.channels.guild then
				MonDKP_CHAT_MSG_WHISPER(arg1, ...)
			elseif string.find(arg1, "!standby") == 1 and core.StandbyActive then
				MonDKP_Standby_Handler(arg1, ...)
			end
		end
	--elseif event == "CHAT_MSG_SYSTEM" then
		--MonoDKP_CHAT_MSG_SYSTEM(arg1)
	elseif event == "GROUP_ROSTER_UPDATE" then 			--updates raid listing if window is open
		if MonDKP.UIConfig and core.MonDKPUI:IsShown() then
			if core.CurSubView == "raid" then
				MonDKP:ViewLimited(true)
			elseif core.CurSubView == "raid and standby" then
				MonDKP:ViewLimited(true, true)
			end
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then 		-- logs last 15 NPCs killed while in raid
		if IsInRaid() then 					-- only processes combat log events if in raid
			local _,arg1,_,_,_,_,_,arg2,arg3 = CombatLogGetCurrentEventInfo();
			if arg1 == "UNIT_DIED" and not strfind(arg2, "Player") and not strfind(arg2, "Pet-") then
				MonDKP:CheckOfficer()
				if core.IsOfficer then
					if not MonDKP:Table_Search(MonDKP_DB.bossargs.LastKilledNPC, arg3) then 	-- only adds it if it doesn't already exist in the table
						if #MonDKP_DB.bossargs.LastKilledNPC > 14 then
							for i=15, #MonDKP_DB.bossargs.LastKilledNPC do  		-- trims the tail end of the stack
								table.remove(MonDKP_DB.bossargs.LastKilledNPC, i)
							end
						end
						table.insert(MonDKP_DB.bossargs.LastKilledNPC, 1, arg3)
					end
				end
			end
		end
	--[[elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then 					-- replaced with above BOSS_KILL event handler
		if IsInRaid() then 					-- only processes combat log events if in raid
			local _,arg1,_,_,_,_,_,_,arg2 = CombatLogGetCurrentEventInfo();			-- run operation when boss is killed
			if arg1 == "UNIT_DIED" then
				MonDKP:CheckOfficer()
				if core.IsOfficer == true then
					if MonDKP:TableStrFind(core.BossList, arg2) then
						MonDKP.ConfigTab2.BossKilledDropdown:SetValue(arg2)
					elseif arg2 == "Flamewalker Elite" or arg2 == "Flamewalker Healer" then
						MonDKP.ConfigTab2.BossKilledDropdown:SetValue("Majordomo Executus")
					elseif arg2 == "Emperor Vek'lor" or arg2 == "Emperor Vek'nilash" then
						MonDKP.ConfigTab2.BossKilledDropdown:SetValue("Twin Emperors")
					elseif arg2 == "Princess Yauj" or arg2 == "Vem" or arg2 == "Lord Kri" then
						MonDKP.ConfigTab2.BossKilledDropdown:SetValue("Bug Family")
					elseif arg2 == "Highlord Mograine" or arg2 == "Thane Korth'azz" or arg2 == "Sir Zeliek" or arg2 == "Lady Blaumeux" then
						MonDKP.ConfigTab2.BossKilledDropdown:SetValue("The Four Horsemen")
					elseif arg2 == "Gri'lek" or arg2 == "Hazza'rah" or arg2 == "Renataki" or arg2 == "Wushoolay" then
						MonDKP.ConfigTab2.BossKilledDropdown:SetValue("Edge of Madness")
					end
				end
			end
		end--]]
	elseif event == "LOOT_OPENED" then
		MonDKP:CheckOfficer();
		if core.IsOfficer then
			if not IsInRaid() and arg1 == false then  -- only fires hook when autoloot is not active if not in a raid to prevent nil value error
				MonDKP_Register_ShiftClickLootWindowHook()
			elseif IsInRaid() then
				MonDKP_Register_ShiftClickLootWindowHook()
			end
			local lootTable = {}
			local lootList = {};

			if IsInRaid() then
				for i=1, GetNumLootItems() do
					if LootSlotHasItem(i) and GetLootSlotLink(i) then
						local _,link,quality = GetItemInfo(GetLootSlotLink(i))
						if quality >= 4 then
							table.insert(lootTable, link)
						end
					end
				end
				local name
				if not UnitIsFriend("player", "target") and UnitIsDead("target") then
					name = UnitName("target")  -- sets bidding window name to current target
				else
					name = core.LastKilledBoss  -- sets name to last killed boss if no target is available (chests)
				end
				lootTable.boss=name
				MonDKP.Sync:SendData("MonDKPBossLoot", lootTable)

				for i=1, #lootTable do
					local item = Item:CreateFromItemLink(lootTable[i]);
					item:ContinueOnItemLoad(function()
						local icon = item:GetItemIcon()
						table.insert(lootList, {icon=icon, link=item:GetItemLink()})
					end);
				end

				MonDKP:LootTable_Set(lootList)
			end
		end
	end
end

function MonDKP:OnInitialize(event, name)		-- This is the FIRST function to run on load triggered registered events at bottom of file
	if (name ~= "MonolithDKP") then return end 

	-- allows using left and right buttons to move through chat 'edit' box
	--[[for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
	end--]]
	
	----------------------------------
	-- Register Slash Commands
	----------------------------------
	SLASH_MonolithDKP1 = "/dkp";
	SLASH_MonolithDKP2 = "/mondkp";
	SlashCmdList.MonolithDKP = HandleSlashCommands;

	--[[SLASH_RELOADUI1 = "/rl"; -- new slash command for reloading UI 				-- for debugging
	SlashCmdList.RELOADUI = ReloadUI;--]]

	SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
	SlashCmdList.FRAMESTK = function()
		LoadAddOn("Blizzard_DebugTools");
		FrameStackTooltip_Toggle();
	end

	if(event == "ADDON_LOADED") then
    	core.Initialized = false
    	core.InitStart = false
    	core.IsOfficer = nil
		C_Timer.After(5, function ()
			core.MonDKPUI = MonDKP.UIConfig or MonDKP:CreateMenu();		-- creates main menu after 5 seconds (trying to initialize after raid frames are loaded)
		end)
    	if not MonDKP_DKPTable then MonDKP_DKPTable = {} end;
		if not MonDKP_Loot then MonDKP_Loot = {} end;
		if not MonDKP_DKPHistory then MonDKP_DKPHistory = {} end;
		if not MonDKP_MinBids then MonDKP_MinBids = {} end;
		if not MonDKP_MaxBids then MonDKP_MaxBids = {} end;
		if not MonDKP_Whitelist then MonDKP_Whitelist = {} end;
		if not MonDKP_Standby then MonDKP_Standby = {} end;
		if not MonDKP_Archive then MonDKP_Archive = {} end;
		if not MonDKP_DB then MonDKP_DB = {} end

		------------------------------------------------
		-- Verify DB Schemas
		------------------------------------------------
		if not VerifyDBSchema(MonDKP_Player_DKPTable) then MonDKP_Player_DKPTable =  UpgradeDBSchema(MonDKP_Player_DKPTable, MonDKP_DKPTable, true, "MonDKP_DKPTable") end;
		if not VerifyDBSchema(MonDKP_Player_Loot) then MonDKP_Player_Loot =  UpgradeDBSchema(MonDKP_Player_Loot, MonDKP_Loot, true, "MonDKP_Loot") end;
		if not VerifyDBSchema(MonDKP_Player_DKPHistory) then MonDKP_Player_DKPHistory =  UpgradeDBSchema(MonDKP_Player_DKPHistory, MonDKP_DKPHistory, true, "MonDKP_DKPHistory") end;
		if not VerifyDBSchema(MonDKP_Player_MinBids) then MonDKP_Player_MinBids =  UpgradeDBSchema(MonDKP_Player_MinBids, MonDKP_MinBids, true, "MonDKP_MinBids") end;
		if not VerifyDBSchema(MonDKP_Player_MaxBids) then MonDKP_Player_MaxBids =  UpgradeDBSchema(MonDKP_Player_MaxBids, MonDKP_MaxBids, true, "MonDKP_MaxBids") end;
		if not VerifyDBSchema(MonDKP_Player_Whitelist) then MonDKP_Player_Whitelist =  UpgradeDBSchema(MonDKP_Player_Whitelist, MonDKP_Whitelist, false, "MonDKP_Whitelist") end;
		if not VerifyDBSchema(MonDKP_Player_Standby) then MonDKP_Player_Standby =  UpgradeDBSchema(MonDKP_Player_Standby, MonDKP_Standby, true, "MonDKP_Standby") end;
		if not VerifyDBSchema(MonDKP_Player_Archive) then MonDKP_Player_Archive =  UpgradeDBSchema(MonDKP_Player_Archive, MonDKP_Archive, true, "MonDKP_Archive") end;
		if not VerifyDBSchema(MonDKP_Player_DB) then MonDKP_Player_DB =  UpgradeDBSchema(MonDKP_Player_DB, MonDKP_DB, false, "MonDKP_DB") end;

		------------------------------------
	    --	Import SavedVariables
	    ------------------------------------
		core.DB 				= MonDKP:GetTable(MonDKP_Player_DB); --Player specific DB
		core.WorkingTable 		= MonDKP:GetTable(MonDKP_Player_DKPTable, true); -- imports full DKP table to WorkingTable for list manipulation
		core.PriceTable			= MonDKP:GetTable(MonDKP_Player_MinBids, true);
		if not core.DB.DKPBonus or not core.DB.DKPBonus.OnTimeBonus then
			core.DB.DKPBonus = {
    			OnTimeBonus = 15, BossKillBonus = 5, CompletionBonus = 10, NewBossKillBonus = 10, UnexcusedAbsence = -25, BidTimer = 30, DecayPercentage = 20, GiveRaidStart = false, IncStandby = false,
    		}
		end
		if not core.DB.defaults or not core.DB.defaults.HistoryLimit then
			core.DB.defaults = {
    			HistoryLimit = 2500, DKPHistoryLimit = 2500, BidTimerSize = 1.0, MonDKPScaleSize = 1.0, supressNotifications = false, TooltipHistoryCount = 15, SupressTells = true,
    		}
    	end
    	if not core.DB.defaults.ChatFrames then 
    		core.DB.defaults.ChatFrames = {}
    		for i = 1, NUM_CHAT_WINDOWS do
				local name = GetChatWindowInfo(i)

				if name ~= "" then
					core.DB.defaults.ChatFrames[name] = true
				end
			end
    	end
		if not core.DB.raiders then core.DB.raiders = {} end
		if not core.DB.MinBidBySlot or not core.DB.MinBidBySlot.Head then
			core.DB.MinBidBySlot = {
    			Head = 70, Neck = 70, Shoulders = 70, Cloak = 70, Chest = 70, Bracers = 70, Hands = 70, Belt = 70, Legs = 70, Boots = 70, Ring = 70, Trinket = 70, OneHanded = 70, TwoHanded = 70, OffHand = 70, Range = 70, Other = 70,
    		}
    	end
    	if not core.DB.MaxBidBySlot or not core.DB.MaxBidBySlot.Head then
			core.DB.MaxBidBySlot = {
    			Head = 0, Neck = 0, Shoulders = 0, Cloak = 0, Chest = 0, Bracers = 0, Hands = 0, Belt = 0, Legs = 0, Boots = 0, Ring = 0, Trinket = 0, OneHanded = 0, TwoHanded = 0, OffHand = 0, Range = 0, Other = 0,
    		}
    	end
		if not core.DB.bossargs then core.DB.bossargs = { CurrentRaidZone = "Molten Core", LastKilledBoss = "Lucifron" } end
		if not core.DB.modes or not core.DB.modes.mode then core.DB.modes = { mode = "Minimum Bid Values", SubZeroBidding = false, rounding = 0, AddToNegative = false, increment = 60, ZeroSumBidType = "Static", AllowNegativeBidders = false } end;
		if not core.DB.modes.ZeroSumBank then core.DB.modes.ZeroSumBank = { balance = 0 } end
		if not core.DB.modes.channels then core.DB.modes.channels = { raid = true, whisper = true, guild = true } end
		if not core.DB.modes.costvalue then core.DB.modes.costvalue = "Integer" end
		if not core.DB.modes.rolls or not core.DB.modes.rolls.min then core.DB.modes.rolls = { min = 1, max = 100, UsePerc = false, AddToMax = 0 } end
		if not core.DB.bossargs.LastKilledNPC then core.DB.bossargs.LastKilledNPC = {} end
		if not core.DB.bossargs.RecentZones then core.DB.bossargs.RecentZones = {} end
		if not core.DB.defaults.HideChangeLogs then core.DB.defaults.HideChangeLogs = 0 end
		if not core.DB.modes.AntiSnipe then core.DB.modes.AntiSnipe = 0 end
		if not core.DB.defaults.CurrentGuild then core.DB.defaults.CurrentGuild = {} end
		if not MonDKP:GetTable(MonDKP_Player_DKPHistory, true).seed then MonDKP:GetTable(MonDKP_Player_DKPHistory, true).seed = 0 end
		if not MonDKP:GetTable(MonDKP_Player_Loot, true).seed then MonDKP:GetTable(MonDKP_Player_Loot, true).seed = 0 end
		if MonDKP:GetTable(MonDKP_Player_DKPTable, true).seed then MonMonDKP:GetTable(MonDKP_Player_DKPTable, true)DKP_DKPTable.seed = nil end


		core.CurrentRaidZone	= core.DB.bossargs.CurrentRaidZone;	-- stores raid zone as a redundency
		core.LastKilledBoss 	= core.DB.bossargs.LastKilledBoss;	-- stores last boss killed as a redundency
		core.LastKilledNPC		= core.DB.bossargs.LastKilledNPC 		-- Stores last 30 mobs killed in raid.
		core.RecentZones		= core.DB.bossargs.RecentZones 		-- Stores last 30 zones entered within a raid party.

		table.sort(core.WorkingTable, function(a, b)
			return a["player"] < b["player"]
		end)
		
		table.sort(core.PriceTable, function(a, b)
			return a["item"] < b["item"]
		end)
		
		MonDKP:StartBidTimer("seconds", nil)						-- initiates timer frame for use

		if MonDKP.BidTimer then MonDKP.BidTimer:SetScript("OnUpdate", nil) end

		-- Debug Test Adding another Team
		if IsInGuild() then
			MonDKP:GetTable(MonDKP_Player_DKPTable)["1"] = {}
			core.WorkingTable = MonDKP:GetTable(MonDKP_Player_DKPTable)["1"];
		end

		if #MonDKP_Loot > core.DB.defaults.HistoryLimit then
			MonDKP:PurgeLootHistory()									-- purges Loot History entries that exceed the "HistoryLimit" option variable (oldest entries) and populates MonDKP_Archive with deleted values
		end
		if #MonDKP_DKPHistory > core.DB.defaults.DKPHistoryLimit then
			MonDKP:PurgeDKPHistory()									-- purges DKP History entries that exceed the "DKPHistoryLimit" option variable (oldest entries) and populates MonDKP_Archive with deleted values
		end
	end
end

function MonDKP:GetTable(dbTable, hasTeams)
	hasTeams = hasTeams or false;

	if IsInGuild() then
		if hasTeams then
			return dbTable[MonDKP:GetRealmName()][MonDKP:GetGuildName()][core.DB.defaults.CurrentTeam];
		else
			return dbTable[MonDKP:GetRealmName()][MonDKP:GetGuildName()];
		end
	else
		return dbTable;
	end
end

function MonDKP:SetTable(dbTable, hasTeams, value)
	hasTeams = hasTeams or false;

	if IsInGuild() then
		if hasTeams then
			dbTable[MonDKP:GetRealmName()][MonDKP:GetGuildName()][core.DB.defaults.CurrentTeam] = value;
		else
			dbTable[MonDKP:GetRealmName()][MonDKP:GetGuildName()] = value;
		end
	else
		dbTable = value;
	end
end

function VerifyDBSchema(dbTable)
	local verified = false;
	--Check to see if the schema node exists. If not, this is 2.1.2 database.
	local retOK, hasInfo = pcall(tableHasKey,dbTable,"dbinfo");

	if (not retOK) or (retOK and not hasInfo) then
		verified = false;
	elseif dbTable.dbinfo.build == core.BuildNumber then
		verified = true;
	end
	return verified;
end

function UpgradeDBSchema(newDbTable, oldDbTable, hasTeams, tableName)

	-- Initialize the Database for a Pre-2.2 Database
	local retOK, hasInfo = pcall(tableHasKey,oldDbTable,"dbinfo");
	if (not retOK) or (retOK and not hasInfo) then
		newDbTable = InitPlayerTable(oldDbTable, hasTeams, tableName)
	end
	
	--Set Prior Build
	newDbTable.dbinfo.priorbuild = newDbTable.dbinfo.build;

	-- Build 20205 (2.2.5) Changes
	if newDbTable.dbinfo.build < 20205 then
		if newDbTable.dbinfo.name == "MonDKP_DB" then
			if IsInGuild() then
				if not MonDKP:GetTable(newDbTable).defaults.CurrentTeam then MonDKP:GetTable(newDbTable).defaults.CurrentTeam = "0" end;
				if not MonDKP:GetTable(newDbTable).teams then MonDKP:GetTable(newDbTable).teams = {} end;
				if not MonDKP:GetTable(newDbTable).teams["0"] then MonDKP:GetTable(newDbTable).teams["0"] = {name=MonDKP:GetGuildName()} end;
			end
		end
	end

	-- Set Current Build Number
	newDbTable.dbinfo.build = core.BuildNumber;
	return newDbTable;
end

function tableHasKey(table,key)
	return table[key] ~= nil;
end

function InitPlayerTable(globalTable, hasTeams, tableName)
	local playerTable = {};

	if IsInGuild() then
		local realmName = MonDKP:GetRealmName();
		local guildName = MonDKP:GetGuildName();

		playerTable[realmName] = {};
		playerTable[realmName][guildName] = {};
		if  not globalTable then
			globalTable = {};
		end
		if hasTeams then
			playerTable[realmName][guildName]["0"] = CopyTable(globalTable);
		else
			playerTable[realmName][guildName] = CopyTable(globalTable);
		end
	end
	playerTable = InitDbSchema(playerTable, tableName);
	return playerTable;
end

function InitDbSchema(dbTable, tableName)
	dbTable["dbinfo"] = {};
	dbTable.dbinfo["build"] = 0;
	dbTable.dbinfo["name"] = tableName;
	dbTable.dbinfo["priorbuild"] = 0;
	dbTable.dbinfo["needsUpgrade"] = false;
	return dbTable;
end

----------------------------------
-- Register Events and Initiallize AddOn
----------------------------------

local events = CreateFrame("Frame", "EventsFrame");
events:RegisterEvent("ADDON_LOADED");
events:RegisterEvent("GROUP_ROSTER_UPDATE");
events:RegisterEvent("ENCOUNTER_START");      -- FOR TESTING PURPOSES.
events:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") -- NPC kill event
events:RegisterEvent("LOOT_OPENED")
events:RegisterEvent("CHAT_MSG_RAID")
events:RegisterEvent("CHAT_MSG_RAID_LEADER")
events:RegisterEvent("CHAT_MSG_WHISPER");
events:RegisterEvent("CHAT_MSG_GUILD")
events:RegisterEvent("GUILD_ROSTER_UPDATE")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("ZONE_CHANGED_NEW_AREA")
events:RegisterEvent("BOSS_KILL")
events:SetScript("OnEvent", MonDKP_OnEvent); -- calls the above MonDKP_OnEvent function to determine what to do with the event