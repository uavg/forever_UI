local repairPending = false
local repairWarningShown = false

local function RepairEquipment()
	if not repairPending then return end
	local cost, canRepair = GetRepairAllCost()
	if not canRepair or cost <= 0 then
		repairPending = false
		return
	end
	if GetMoney() < cost then
		if not repairWarningShown then
			print("!iCatCaddy: Not enough gold to auto-repair. Need " .. GetCoinTextureString(cost) .. ".")
			repairWarningShown = true
		end
		return
	end
	-- Repairing can trigger PLAYER_MONEY before this call returns.
	repairPending = false
	RepairAllItems(false)
end

local function SellJunk()
	if C_MerchantFrame.GetNumJunkItems() == 0 then return end
	if not C_MerchantFrame.IsSellAllJunkEnabled() then
		print("!iCatCaddy: Automatic junk selling is unavailable at this merchant.")
		return
	end
	C_MerchantFrame.SellAllJunkItems()
end

local merchant = CreateFrame("Frame")
merchant:RegisterEvent("MERCHANT_SHOW")
merchant:RegisterEvent("MERCHANT_CLOSED")
merchant:RegisterEvent("PLAYER_MONEY")
merchant:SetScript("OnEvent", function(self, event)
	if event == "MERCHANT_SHOW" then
		repairPending = CanMerchantRepair()
		repairWarningShown = false
		SellJunk()
		RepairEquipment()
	elseif event == "MERCHANT_CLOSED" then
		repairPending = false
	elseif event == "PLAYER_MONEY" then
		-- Junk-sale proceeds may arrive after MERCHANT_SHOW.
		RepairEquipment()
	end
end)