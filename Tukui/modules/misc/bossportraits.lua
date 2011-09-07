local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales
if C["rd"].bossicons == false then return end

local deadBosses = {}
local PopulateEncounterInfo = function()
	wipe(deadBosses)

	for i = 1, GetNumSavedInstances() do
		local savedName, _, _, _, locked = GetSavedInstanceInfo(i)
		-- We're saved to the instance we're currently in
		if (GetInstanceInfo()) == savedName and locked then
			local index = 1
			local name, _, dead = GetSavedInstanceEncounterInfo(i, index)
			while name do
				if dead then
					deadBosses[name] = true
				end
			
				index = index + 1
				name, _, dead = GetSavedInstanceEncounterInfo(i, index)
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("WORLD_MAP_UPDATE")
f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:SetScript("OnEvent", function(self, event)
	if event == "ZONE_CHANGED_NEW_AREA" then
		-- The EJ_X functions don't work until the Encounter Journal has been seen during that session
		local _, type = GetInstanceInfo()
		if type == "party" or type == "raid" then
			EncounterJournal:Show()
			EncounterJournal:Hide()
		end
	
		return
	end

	if WorldMapFrame:IsShown() then
		PopulateEncounterInfo()
	
		local i = 1
		local button = _G["EJMapButton"..i]
		while button and button:IsShown() do
			button:SetSize(25, 25)
			
			if not button.label then
				button.label = button:CreateFontString(nil, "OVERLAY")
				button.label:SetFont(C["media"].font, 15, "THINOUTLINE")
				button.label:SetText(i)
				button.label:SetPoint("CENTER")
			end
			
			if deadBosses[(EJ_GetEncounterInfoByIndex(i))] then
				button.label:SetTextColor(1, 0, 0)
			else
				button.label:SetTextColor(0, 1, 0)
			end
			
			for _, region in pairs{button:GetRegions()} do
				if region:GetObjectType() ~= "FontString" then
					region:Hide()
					region.Show = function() end
				
					if region.SetTexture then region:SetTexture() end
				end
			end
			
			i = i + 1
			button = _G["EJMapButton"..i]
		end
	end
end)