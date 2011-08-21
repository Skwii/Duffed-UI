local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

local function LoadSkin()
	-- Blizzard frame we want to reskin
	local skins = {
		"StaticPopup1",
		"StaticPopup2",
		"StaticPopup3",
		"StaticPopup4",
		"GameMenuFrame",
		"InterfaceOptionsFrame",
		"VideoOptionsFrame",
		"AudioOptionsFrame",
		"LFDDungeonReadyStatus",
		"BNToastFrame",
		"TicketStatusFrameButton",
		"LFDSearchStatus",
		"AutoCompleteBox",
		"ConsolidatedBuffsTooltip",
		"ReadyCheckFrame",
		"StackSplitFrame",
		"CharacterFrame",
	}
	
	for i = 1, getn(skins) do
		_G[skins[i]]:SetTemplate("Transparent")
		if _G[skins[i]] ~= _G["GhostFrameContentsFrame"] or _G[skins[i]] ~= _G["AutoCompleteBox"] then -- frame to blacklist from create shadow function
			_G[skins[i]]:CreateShadow("Default")
		end
	end
	
	-- Skin all DropDownList[i]
	local function SkinDropDownList(level, index)
		for i = 1, UIDROPDOWNMENU_MAXLEVELS do
			local menubackdrop = _G["DropDownList"..i.."MenuBackdrop"]
			local backdrop = _G["DropDownList"..i.."Backdrop"]
			if not backdrop.isSkinned then
				menubackdrop:SetTemplate("Default")
				backdrop:SetTemplate("Default")
				backdrop.isSkinned = true
			end
		end
	end
	hooksecurefunc("UIDropDownMenu_CreateFrames", SkinDropDownList)
	
	local ChatMenus = {
		"ChatMenu",
		"EmoteMenu",
		"LanguageMenu",
		"VoiceMacroMenu",		
	}

	for i = 1, getn(ChatMenus) do
		if _G[ChatMenus[i]] == _G["ChatMenu"] then
			_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Default", true) self:SetBackdropColor(unpack(C["media"].backdropfadecolor)) self:ClearAllPoints() self:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, T.Scale(30)) end)
		else
			_G[ChatMenus[i]]:HookScript("OnShow", function(self) self:SetTemplate("Default", true) self:SetBackdropColor(unpack(C["media"].backdropfadecolor)) end)
		end
	end
	
	T.SkinSlideBar(OpacityFrameSlider)
	OpacityFrameSlider:Width(8)

	--LFD Role Picker frame
	LFDRoleCheckPopup:StripTextures()
	LFDRoleCheckPopup:SetTemplate("Transparent")
	T.SkinButton(LFDRoleCheckPopupAcceptButton)
	T.SkinButton(LFDRoleCheckPopupDeclineButton)
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonTank:GetChildren())
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonDPS:GetChildren())
	T.SkinCheckBox(LFDRoleCheckPopupRoleButtonHealer:GetChildren())
	LFDRoleCheckPopupRoleButtonTank:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonTank:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonDPS:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonDPS:GetChildren():GetFrameLevel() + 1)
	LFDRoleCheckPopupRoleButtonHealer:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonHealer:GetChildren():GetFrameLevel() + 1)
	
	-- reskin popup buttons
	for i = 1, 4 do
		for j = 1, 3 do
			T.SkinButton(_G["StaticPopup"..i.."Button"..j])
			T.SkinEditBox(_G["StaticPopup"..i.."EditBox"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameGold"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameSilver"])
			T.SkinEditBox(_G["StaticPopup"..i.."MoneyInputFrameCopper"])
			_G["StaticPopup"..i.."EditBox"].backdrop:Point("TOPLEFT", -2, -4)
			_G["StaticPopup"..i.."EditBox"].backdrop:Point("BOTTOMRIGHT", 2, 4)
			_G["StaticPopup"..i.."ItemFrameNameFrame"]:Kill()
			_G["StaticPopup"..i.."ItemFrame"]:GetNormalTexture():Kill()
			_G["StaticPopup"..i.."ItemFrame"]:SetTemplate("Default")
			_G["StaticPopup"..i.."ItemFrame"]:StyleButton()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:SetTexCoord(.08, .92, .08, .92)
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:ClearAllPoints()
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["StaticPopup"..i.."ItemFrameIconTexture"]:Point("BOTTOMRIGHT", -2, 2)
		end
	end
	
	-- Tutorial
	TutorialFrame:StripTextures()
	TutorialFrame:CreateBackdrop("Transparent")
	TutorialFrame.backdrop:CreateShadow("Transparent")
	TutorialFrame.backdrop:Point("TOPLEFT", 6, 0)
	TutorialFrame.backdrop:Point("BOTTOMRIGHT", 6, -6)
	T.SkinCloseButton(TutorialFrameCloseButton, TutorialFrameCloseButton.backdrop)
	T.SkinNextPrevButton(TutorialFramePrevButton)
	T.SkinNextPrevButton(TutorialFrameNextButton)
	T.SkinButton(TutorialFrameOkayButton)
	TutorialFrameOkayButton:ClearAllPoints()
	TutorialFrameOkayButton:Point("LEFT", TutorialFrameNextButton,"RIGHT", 10, 0)
	
	-- reskin all esc/menu buttons
	local BlizzardMenuButtons = {
		"Options", 
		"SoundOptions", 
		"UIOptions", 
		"Keybindings", 
		"Macros",
		"Ratings",
		"AddOns", 
		"Logout", 
		"Quit", 
		"Continue", 
		"MacOptions",
		"Help"
	}
	
	for i = 1, getn(BlizzardMenuButtons) do
		local TukuiMenuButtons = _G["GameMenuButton"..BlizzardMenuButtons[i]]
		if TukuiMenuButtons then
			T.SkinButton(TukuiMenuButtons)
		end
	end
	
	if IsAddOnLoaded("OptionHouse") then
		T.SkinButton(GameMenuButtonOptionHouse)
	end
	
	-- skin return to graveyard button
	do
		T.SkinButton(GhostFrame)
		GhostFrame:SetBackdropColor(0,0,0,0)
		GhostFrame:SetBackdropBorderColor(0,0,0,0)
		GhostFrame.SetBackdropColor = T.dummy
		GhostFrame.SetBackdropBorderColor = T.dummy
		GhostFrame:ClearAllPoints()
		GhostFrame:SetPoint("TOP", UIParent, "TOP", 0, 25)
		T.SkinButton(GhostFrameContentsFrame)
		GhostFrameContentsFrameIcon:SetTexture(nil)
	end
	
	-- hide header textures and move text/buttons.
	local BlizzardHeader = {
		"GameMenuFrame", 
		"InterfaceOptionsFrame", 
		"AudioOptionsFrame", 
		"VideoOptionsFrame",
	}
	
	for i = 1, getn(BlizzardHeader) do
		local title = _G[BlizzardHeader[i].."Header"]			
		if title then
			title:SetTexture("")
			title:ClearAllPoints()
			if title == _G["GameMenuFrameHeader"] then
				title:SetPoint("TOP", GameMenuFrame, 0, 7)
			else
				title:SetPoint("TOP", BlizzardHeader[i], 0, 0)
			end
		end
	end
	
	-- here we reskin all "normal" buttons
	local BlizzardButtons = {
		"VideoOptionsFrameOkay", 
		"VideoOptionsFrameCancel", 
		"VideoOptionsFrameDefaults", 
		"VideoOptionsFrameApply", 
		"AudioOptionsFrameOkay", 
		"AudioOptionsFrameCancel", 
		"AudioOptionsFrameDefaults", 
		"InterfaceOptionsFrameDefaults", 
		"InterfaceOptionsFrameOkay", 
		"InterfaceOptionsFrameCancel",
		"ReadyCheckFrameYesButton",
		"ReadyCheckFrameNoButton",
		"StackSplitOkayButton",
		"StackSplitCancelButton",
		"RolePollPopupAcceptButton"
	}
	
	for i = 1, getn(BlizzardButtons) do
		local TukuiButtons = _G[BlizzardButtons[i]]
		if TukuiButtons then
			T.SkinButton(TukuiButtons)
		end
	end
	
	-- if a button position is not really where we want, we move it here
	VideoOptionsFrameCancel:ClearAllPoints()
	VideoOptionsFrameCancel:SetPoint("RIGHT",VideoOptionsFrameApply,"LEFT",-4,0)		 
	VideoOptionsFrameOkay:ClearAllPoints()
	VideoOptionsFrameOkay:SetPoint("RIGHT",VideoOptionsFrameCancel,"LEFT",-4,0)	
	AudioOptionsFrameOkay:ClearAllPoints()
	AudioOptionsFrameOkay:SetPoint("RIGHT",AudioOptionsFrameCancel,"LEFT",-4,0)
	InterfaceOptionsFrameOkay:ClearAllPoints()
	InterfaceOptionsFrameOkay:SetPoint("RIGHT",InterfaceOptionsFrameCancel,"LEFT", -4,0)
	ReadyCheckFrameYesButton:SetParent(ReadyCheckFrame)
	ReadyCheckFrameNoButton:SetParent(ReadyCheckFrame) 
	ReadyCheckFrameYesButton:SetPoint("RIGHT", ReadyCheckFrame, "CENTER", -1, 0)
	ReadyCheckFrameNoButton:SetPoint("LEFT", ReadyCheckFrameYesButton, "RIGHT", 3, 0)
	ReadyCheckFrameText:SetParent(ReadyCheckFrame)	
	ReadyCheckFrameText:ClearAllPoints()
	ReadyCheckFrameText:SetPoint("TOP", 0, -12)
	
	-- others
	ReadyCheckListenerFrame:SetAlpha(0)
	ReadyCheckFrame:HookScript("OnShow", function(self) if UnitIsUnit("player", self.initiator) then self:Hide() end end) -- bug fix, don't show it if initiator
	StackSplitFrame:GetRegions():Hide()

	T.SkinButton(LFDDungeonReadyDialogEnterDungeonButton)
	T.SkinButton(LFDDungeonReadyDialogLeaveQueueButton)
	
	RolePollPopup:SetTemplate("Transparent")
	RolePollPopup:CreateShadow("Default")

	-- mac menu/option panel, made by affli.
	if IsMacClient() then
		-- Skin main frame and reposition the header
		MacOptionsFrame:SetTemplate("Default", true)
		MacOptionsFrameHeader:SetTexture("")
		MacOptionsFrameHeader:ClearAllPoints()
		MacOptionsFrameHeader:SetPoint("TOP", MacOptionsFrame, 0, 0)
 
		--Skin internal frames
		MacOptionsFrameMovieRecording:SetTemplate("Default", true)
		MacOptionsITunesRemote:SetTemplate("Default", true)
 
		--Skin buttons
		T.SkinButton(MacOptionsFrameCancel)
		T.SkinButton(MacOptionsFrameOkay)
		T.SkinButton(MacOptionsButtonKeybindings)
		T.SkinButton(MacOptionsFrameDefaults)
		T.SkinButton(MacOptionsButtonCompress)
 
		--Reposition and resize buttons
		local tPoint, tRTo, tRP, tX, tY =  MacOptionsButtonCompress:GetPoint()
		MacOptionsButtonCompress:SetWidth(136)
		MacOptionsButtonCompress:ClearAllPoints()
		MacOptionsButtonCompress:SetPoint(tPoint, tRTo, tRP, T.Scale(4), tY)
 
		MacOptionsFrameCancel:SetWidth(96)
		MacOptionsFrameCancel:SetHeight(22)
		tPoint, tRTo, tRP, tX, tY =  MacOptionsFrameCancel:GetPoint()
		MacOptionsFrameCancel:ClearAllPoints()
		MacOptionsFrameCancel:SetPoint(tPoint, tRTo, tRP, T.Scale(-14), tY)
 
		MacOptionsFrameOkay:ClearAllPoints()
		MacOptionsFrameOkay:SetWidth(96)
		MacOptionsFrameOkay:SetHeight(22)
		MacOptionsFrameOkay:SetPoint("LEFT",MacOptionsFrameCancel,T.Scale(-99),0)
 
		MacOptionsButtonKeybindings:ClearAllPoints()
		MacOptionsButtonKeybindings:SetWidth(96)
		MacOptionsButtonKeybindings:SetHeight(22)
		MacOptionsButtonKeybindings:SetPoint("LEFT",MacOptionsFrameOkay,T.Scale(-99),0)
 
		MacOptionsFrameDefaults:SetWidth(96)
		MacOptionsFrameDefaults:SetHeight(22)

		-- why these buttons is using game menu template? oO
		MacOptionsButtonCompressLeft:SetAlpha(0)
		MacOptionsButtonCompressMiddle:SetAlpha(0)
		MacOptionsButtonCompressRight:SetAlpha(0)
		MacOptionsButtonKeybindingsLeft:SetAlpha(0)
		MacOptionsButtonKeybindingsMiddle:SetAlpha(0)
		MacOptionsButtonKeybindingsRight:SetAlpha(0)
	end
	
	OpacityFrame:StripTextures()
	OpacityFrame:SetTemplate("Transparent")
	T.SkinButton(WatchFrameCollapseExpandButton)
	
	-- Graphics_Quality is not like the other sliders
	Graphics_Quality:SetScript("OnUpdate", function(self)
		T.SkinSlideBar(Graphics_Quality,11)
	end)
	Graphics_RightQuality:SetAlpha(0) -- Graphics Quality Slide background =O
	
	-- Graphics_Quality Values
	Graphics_QualityLow2:Point("BOTTOM",0,-20)
	Graphics_QualityFair:Point("BOTTOM",0,-20)
	Graphics_RightQualityLabel:Point("TOP",0,16)
	Graphics_QualityMed:Point("BOTTOM",0,-20)
	Graphics_QualityHigh2:Point("BOTTOM",0,-20)
	Graphics_QualityUltra:Point("BOTTOM",0,-20)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)