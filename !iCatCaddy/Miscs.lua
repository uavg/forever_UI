-- Disable Combat Text Spam
local loaded, reason = C_AddOns.LoadAddOn("Blizzard_CombatText")
if loaded and CombatTextTypeInfo then
	for _, messageType in ipairs({
		"PERIODIC_HEAL", "HEAL_CRIT", "HEAL", "PERIODIC_HEAL_ABSORB",
		"HEAL_CRIT_ABSORB", "HEAL_ABSORB", "DAMAGE_CRIT", "DAMAGE",
		"SPELL_DAMAGE_CRIT", "SPELL_DAMAGE"
	}) do
		CombatTextTypeInfo[messageType] = {}
	end
else
	print("!iCatCaddy: Cannot configure combat text: " .. tostring(reason or "CombatTextTypeInfo unavailable"))
end


----------------------------------------------------------------------
--	Disable sticky chat
----------------------------------------------------------------------

-- These taint if set to anything other than nil
ChatTypeInfo.WHISPER.sticky = nil
ChatTypeInfo.BN_WHISPER.sticky = nil
ChatTypeInfo.CHANNEL.sticky = nil


----------------------------------------------------------------------
--	Combat nameplat
----------------------------------------------------------------------

local enemyNameplates = CreateFrame("Frame")
enemyNameplates:RegisterEvent("PLAYER_LOGIN")
enemyNameplates:RegisterEvent("PLAYER_REGEN_DISABLED")
enemyNameplates:RegisterEvent("PLAYER_REGEN_ENABLED")
enemyNameplates:SetScript("OnEvent", function(self, event)
	local inCombat = event == "PLAYER_REGEN_DISABLED"
		or (event == "PLAYER_LOGIN" and InCombatLockdown())
	if not C_CVar.SetCVar("nameplateShowEnemies", inCombat and "1" or "0") then
		print("!iCatCaddy: Could not set CVar nameplateShowEnemies")
	end
end)
