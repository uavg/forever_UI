local cvars = {
	profanityFilter = "0",
	scriptErrors = "1",
	buffDurations = "1",
	autoLootDefault = "1",
	lootUnderMouse = "1",
	autoSelfCast = "1",
--	cameraDistanceMaxFactor = "3.4",
--  cameraDistanceMaxZoomFactor = "2.6",
	screenshotQuality = "7",
	cameraSmoothStyle = "0",
	chatStyle = "im",
	autoDismountFlying = "0",
	alwaysCompareItems = "1",
	lossOfControl = "1",
	--gameTip = ""0"",

	showTimestamps = "none",
	UnitNameNPC = "1",
	guildMemberNotify = "1",
	autoQuestProgress = "1",
	UnitNameFriendlyPlayerName =  "1",
	UnitNameFriendlyPetName = "0",
	UnitNameFriendlyGuardianName = "0",
	UnitNameFriendlyTotemName = "0",
	UnitNameEnemyPlayerName =  "1",
	UnitNameEnemyPetName =  "1",
	UnitNameEnemyGuardianName =  "0",
	UnitNameEnemyTotemName = "1",
	autoquestwatch = "1",
	taintLog = "1",
	showTutorials = "0",
	showNPETutorials = "0",
	nameplateShowSelf = "0",

	calendarShowWeeklyHolidays = "0",
	--TargetPriorityAllowAnyOnScreen = "0",
	nameplateShowFriendlyNPCs = "0",

	enableFloatingCombatText = "0",
	floatingCombatTextFloatMode_v2 = "1",

	breakUpLargeNumbers = "1",

	-- Controls
	synchronizeConfig   = "1",

	}

	local f = CreateFrame("Frame")
	f:RegisterEvent("PLAYER_LOGIN")
	f:SetScript("OnEvent", function()
		ChangeChatColor("CHANNEL4", 255/255, 255/255 ,150/255)

		-- Enable classcolor automatically on login and on each character without doing /configure each time
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
		ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")

	local skipped = {}
	for cvar, value in pairs(cvars) do
		local current = C_CVar.GetCVar(cvar)
		if current == nil then
			table.insert(skipped, cvar)
		elseif current ~= value then
			local _, _, _, _, locked, secure, readOnly = C_CVar.GetCVarInfo(cvar)
			if locked or secure or readOnly then
				table.insert(skipped, cvar)
			elseif not C_CVar.SetCVar(cvar, value) then
				print("!iCatCaddy: Could not set CVar " .. cvar)
			end
		end
	end
	if #skipped > 0 then
		table.sort(skipped)
		print("!iCatCaddy: Skipped unavailable or protected CVars: " .. table.concat(skipped, ", "))
	end
end)
