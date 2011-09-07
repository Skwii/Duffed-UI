local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales
if not C["skins"].bskins == true then return end

local function LoadSkin()
	local frames = {
		"ChatConfigFrame",
		"ChatConfigCategoryFrame",
		"ChatConfigBackgroundFrame",
		"ChatConfigChatSettingsClassColorLegend",
		"ChatConfigChannelSettingsClassColorLegend",
		"ChatConfigCombatSettingsFilters",
		"ChatConfigCombatSettingsFiltersScrollFrame",
		"CombatConfigColorsHighlighting",
		"CombatConfigColorsColorizeUnitName",
		"CombatConfigColorsColorizeSpellNames",
		"CombatConfigColorsColorizeDamageNumber",
		"CombatConfigColorsColorizeDamageSchool",
		"CombatConfigColorsColorizeEntireLine",
		"ChatConfigChatSettingsLeft",
		"ChatConfigOtherSettingsCombat",
		"ChatConfigOtherSettingsPVP",
		"ChatConfigOtherSettingsSystem",
		"ChatConfigOtherSettingsCreature",
		"ChatConfigChannelSettingsLeft",
		"CombatConfigMessageSourcesDoneBy",
		"CombatConfigMessageSourcesDoneTo",
		"CombatConfigColorsUnitColors",
	}
	
	for i = 1, getn(frames) do
		local SkinFrames = _G[frames[i]]
		SkinFrames:StripTextures()
		SkinFrames:CreateBackdrop("Transparent")
		if SkinFrames ~= _G["ChatConfigCategoryFrame"] and SkinFrames ~= _G["ChatConfigFrame"] then
			SkinFrames.backdrop:Point("TOPLEFT",3,-1)
			SkinFrames.backdrop:Point("BOTTOMRIGHT",-3,1)
		else
			SkinFrames.backdrop:Point("TOPLEFT",1,-1)
			SkinFrames.backdrop:Point("BOTTOMRIGHT",-1,1)
		end
	end

	-- >> Chat >> Chat Settings
	ChatConfigChatSettingsLeft:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigChatSettingsLeft:SetScript("OnEvent", function(ChatConfigChatSettingsLeft, event)
		for i = 1,#CHAT_CONFIG_CHAT_LEFT do
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigChatSettingsLeftCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			_G["ChatConfigChatSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			T.SkinCheckBox(_G["ChatConfigChatSettingsLeftCheckBox"..i.."Check"])
			T.SkinCheckBox(_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"])
			_G["ChatConfigChatSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end
	end)

	-- >> Chat >> Channel Settings      /!\ I don't know why, but the skin works only after /reload ui, not at first login =(
	ChatConfigChannelSettingsLeft:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigChannelSettingsLeft:SetScript("OnEvent", function(ChatConfigChannelSettingsLeft, event)
		for i = 1,#ChatConfigChannelSettingsLeft.checkBoxTable do
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:StripTextures()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigChannelSettingsLeftCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			_G["ChatConfigChannelSettingsLeftCheckBox"..i]:SetHeight(ChatConfigOtherSettingsCombatCheckBox1:GetHeight())
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."Check"])
			T.SkinCheckBox(_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"])
			_G["ChatConfigChannelSettingsLeftCheckBox"..i.."ColorClasses"]:SetHeight(ChatConfigChatSettingsLeftCheckBox1Check:GetHeight())
		end
	end)
	
	--Makes the skin work, but only after /reload ui :o   (found in chatconfingframe.xml)
	CreateChatChannelList(self, GetChannelList())
	ChatConfig_CreateCheckboxes(ChatConfigChannelSettingsLeft, CHAT_CONFIG_CHANNEL_LIST, "ChatConfigCheckBoxWithSwatchAndClassColorTemplate", CHANNELS)
	ChatConfig_UpdateCheckboxes(ChatConfigChannelSettingsLeft)
	
	-- >> Other >> Combat
	ChatConfigOtherSettingsCombat:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigOtherSettingsCombat:SetScript("OnEvent", function(ChatConfigOtherSettingsCombat, event)
		for i = 1,#CHAT_CONFIG_OTHER_COMBAT do
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCombatCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsCombatCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsCombatCheckBox"..i.."Check"])
		end
	end)
			
	-- >> Other >> PvP
	ChatConfigOtherSettingsPVP:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigOtherSettingsPVP:SetScript("OnEvent", function(ChatConfigOtherSettingsPVP, event)
		for i = 1,#CHAT_CONFIG_OTHER_PVP do
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsPVPCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsPVPCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsPVPCheckBox"..i.."Check"])
		end
	end)
	
	-- >> Other >> System
	ChatConfigOtherSettingsSystem:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigOtherSettingsSystem:SetScript("OnEvent", function(ChatConfigOtherSettingsSystem, event)
		for i = 1,#CHAT_CONFIG_OTHER_SYSTEM do
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsSystemCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsSystemCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsSystemCheckBox"..i.."Check"])
		end
	end)
	
	-- >> Other >> Creatures
	ChatConfigOtherSettingsCreature:RegisterEvent("PLAYER_ENTERING_WORLD")
	ChatConfigOtherSettingsCreature:SetScript("OnEvent", function(ChatConfigOtherSettingsCreature, event)
		for i = 1,#CHAT_CONFIG_CHAT_CREATURE_LEFT do
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:StripTextures()
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i]:CreateBackdrop()
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["ChatConfigOtherSettingsCreatureCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["ChatConfigOtherSettingsCreatureCheckBox"..i.."Check"])
		end
	end)
	
	-- >> Sources >> DoneBy
	CombatConfigMessageSourcesDoneBy:RegisterEvent("PLAYER_ENTERING_WORLD")
	CombatConfigMessageSourcesDoneBy:SetScript("OnEvent", function(CombatConfigMessageSourcesDoneBy, event)
		for i = 1,#COMBAT_CONFIG_MESSAGESOURCES_BY do
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i]:CreateBackdrop()
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["CombatConfigMessageSourcesDoneByCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["CombatConfigMessageSourcesDoneByCheckBox"..i.."Check"])
		end
	end)
	
	-- >> Sources >> DoneTo
	CombatConfigMessageSourcesDoneTo:RegisterEvent("PLAYER_ENTERING_WORLD")
	CombatConfigMessageSourcesDoneTo:SetScript("OnEvent", function(CombatConfigMessageSourcesDoneTo, event)
		for i = 1,#COMBAT_CONFIG_MESSAGESOURCES_TO do
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:StripTextures()
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i]:CreateBackdrop()
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["CombatConfigMessageSourcesDoneToCheckBox"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
			T.SkinCheckBox(_G["CombatConfigMessageSourcesDoneToCheckBox"..i.."Check"])
		end
	end)
	
	-- >> Combat >> Colors >> Unit Colors
	CombatConfigColorsUnitColors:RegisterEvent("PLAYER_ENTERING_WORLD")
	CombatConfigColorsUnitColors:SetScript("OnEvent", function(CombatConfigColorsUnitColors, event)
		for i = 1,#COMBAT_CONFIG_UNIT_COLORS do
			_G["CombatConfigColorsUnitColorsSwatch"..i]:StripTextures()
			_G["CombatConfigColorsUnitColorsSwatch"..i]:CreateBackdrop()
			_G["CombatConfigColorsUnitColorsSwatch"..i].backdrop:Point("TOPLEFT",3,-1)
			_G["CombatConfigColorsUnitColorsSwatch"..i].backdrop:Point("BOTTOMRIGHT",-3,1)
		end
	end)
			
	-- >> Combat >> Messages Types
	CombatConfigMessageTypesLeft:RegisterEvent("PLAYER_ENTERING_WORLD")
	CombatConfigMessageTypesLeft:SetScript("OnEvent", function(CombatConfigMessageTypesLeft, event)
		for i=1,4 do
			for j=1,4 do
				if _G["CombatConfigMessageTypesLeftCheckBox"..i] and _G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesLeftCheckBox"..i.."_"..j])
				end
			end
			for j=1,10 do
				if _G["CombatConfigMessageTypesRightCheckBox"..i] and _G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j] then
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i])
					T.SkinCheckBox(_G["CombatConfigMessageTypesRightCheckBox"..i.."_"..j])
				end
			end
			T.SkinCheckBox(_G["CombatConfigMessageTypesMiscCheckBox"..i])
		end
	end)
			
	-- >> Combat >> Tabs
	for i = 1,#COMBAT_CONFIG_TABS do
		local cctab = _G["CombatConfigTab"..i]
		if cctab then
			T.SkinTab(cctab)
			cctab:SetHeight(cctab:GetHeight()-2)
			cctab:SetWidth(math.ceil(cctab:GetWidth()+1.6))
			_G["CombatConfigTab"..i.."Text"]:SetPoint("BOTTOM",0,10)
		end
	end
	CombatConfigTab1:ClearAllPoints()
	CombatConfigTab1:SetPoint("BOTTOMLEFT",ChatConfigBackgroundFrame,"TOPLEFT",6,-2)

	local ccbuttons = {
		"ChatConfigFrameOkayButton",
		"ChatConfigFrameDefaultButton",
		"CombatLogDefaultButton",
		"ChatConfigCombatSettingsFiltersDeleteButton",
		"ChatConfigCombatSettingsFiltersAddFilterButton",
		"ChatConfigCombatSettingsFiltersCopyFilterButton",
		"CombatConfigSettingsSaveButton",
	}
	
	for i = 1, getn(ccbuttons) do
		local ccbtn = _G[ccbuttons[i]]
		if ccbtn then
			T.SkinButton(ccbtn)
			ccbtn:ClearAllPoints()
		end
	end
	
	ChatConfigFrameOkayButton:SetPoint("TOPRIGHT",ChatConfigBackgroundFrame,"BOTTOMRIGHT",-3,-5)
	ChatConfigFrameDefaultButton:SetPoint("TOPLEFT",ChatConfigCategoryFrame,"BOTTOMLEFT",1,-5)
	CombatLogDefaultButton:SetPoint("TOPLEFT",ChatConfigCategoryFrame,"BOTTOMLEFT",1,-5)
	ChatConfigCombatSettingsFiltersDeleteButton:SetPoint("TOPRIGHT",ChatConfigCombatSettingsFilters,"BOTTOMRIGHT",-3,-1)
	ChatConfigCombatSettingsFiltersCopyFilterButton:SetPoint("RIGHT",ChatConfigCombatSettingsFiltersDeleteButton,"LEFT",-2,0)
	ChatConfigCombatSettingsFiltersAddFilterButton:SetPoint("RIGHT",ChatConfigCombatSettingsFiltersCopyFilterButton,"LEFT",-2,0)
	
	local cccheckbox = {
		"CombatConfigColorsHighlightingLine",
		"CombatConfigColorsHighlightingAbility",
		"CombatConfigColorsHighlightingDamage",
		"CombatConfigColorsHighlightingSchool",
		"CombatConfigColorsColorizeUnitNameCheck",
		"CombatConfigColorsColorizeSpellNamesCheck",
		"CombatConfigColorsColorizeSpellNamesSchoolColoring",
		"CombatConfigColorsColorizeDamageNumberCheck",
		"CombatConfigColorsColorizeDamageNumberSchoolColoring",
		"CombatConfigColorsColorizeDamageSchoolCheck",
		"CombatConfigColorsColorizeEntireLineCheck",
		"CombatConfigFormattingShowTimeStamp",
		"CombatConfigFormattingShowBraces",
		"CombatConfigFormattingUnitNames",
		"CombatConfigFormattingSpellNames",
		"CombatConfigFormattingItemNames",
		"CombatConfigFormattingFullText",
		"CombatConfigSettingsShowQuickButton",
		"CombatConfigSettingsSolo",
		"CombatConfigSettingsParty",
		"CombatConfigSettingsRaid",
	}
	
	for i = 1, getn(cccheckbox) do
	local ccbtn = _G[cccheckbox[i]]
		T.SkinCheckBox(_G[cccheckbox[i]])
	end
	
	T.SkinNextPrevButton(ChatConfigMoveFilterUpButton,true)
	T.SkinNextPrevButton(ChatConfigMoveFilterDownButton,true)
	ChatConfigMoveFilterUpButton:ClearAllPoints()
	ChatConfigMoveFilterDownButton:ClearAllPoints()
	ChatConfigMoveFilterUpButton:SetPoint("TOPLEFT",ChatConfigCombatSettingsFilters,"BOTTOMLEFT",3,0)
	ChatConfigMoveFilterDownButton:SetPoint("LEFT",ChatConfigMoveFilterUpButton,24,0)
	
	T.SkinEditBox(CombatConfigSettingsNameEditBox)

	ChatConfigFrame:Size(680,596)
	ChatConfigFrameHeader:ClearAllPoints()
	ChatConfigFrameHeader:SetPoint("TOP", ChatConfigFrame, 0, -5)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)