local textFont = "Interface\\AddOns\\Media\\Fonts\\1.ttf"
local combatNumberFont = "Interface\\AddOns\\Media\\Fonts\\2.ttf"

-- World text fonts are loaded by the client at login; changing them needs a relog.
STANDARD_TEXT_FONT = textFont
UNIT_NAME_FONT = textFont
DAMAGE_TEXT_FONT = combatNumberFont

local function ApplyTextFont(font)
	if not font then return end
	local file, height, flags = font:GetFont()
	if file and height and height > 0 and file ~= textFont then
		font:SetFont(textFont, height, flags)
	end
end

local function ApplyUIFonts()
	if InCombatLockdown() then return end
	for _, name in ipairs(GetFonts()) do
		-- CombatTextFont also renders Chinese status messages, which 2.ttf lacks.
		ApplyTextFont(_G[name])
	end
	for _, name in ipairs(CHAT_FRAMES or {}) do
		ApplyTextFont(_G[name])
	end
end

local fonts = CreateFrame("Frame")
fonts:RegisterEvent("ADDON_LOADED")
fonts:RegisterEvent("PLAYER_LOGIN")
fonts:RegisterEvent("PLAYER_ENTERING_WORLD")
fonts:RegisterEvent("PLAYER_REGEN_ENABLED")
fonts:SetScript("OnEvent", ApplyUIFonts)
ApplyUIFonts()
