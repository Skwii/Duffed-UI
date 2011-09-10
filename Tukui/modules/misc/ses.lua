-----------------------------------------------
-- Spec Helper, by EPIC
-----------------------------------------------
local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if not C["misc"].sesenable == true then return end

-- colors
local hoverovercolor = {.4, .4, .4}
local cp = "|cff319f1b" -- +
local cm = "|cff9a1212" -- -
local dr, dg, db = unpack({ 0.4, 0.4, 0.4 })
panelcolor = ("|cff%.2x%.2x%.2x"):format(dr * 255, dg * 255, db * 255)

-- Gear Settings
local Enablegear = C["misc"].sesenablegear -- herp
local Autogearswap = C["misc"].sesgearswap -- derp
local Specswitchcastbar = C["misc"].sescastbar -- show a castbar for spec switching
local set1 = C["misc"].sesset1 -- this is the gear set that gets equiped with your primary spec. (must be the NUMBER from 1-10)
local set2 = C["misc"].sesset2 -- this is the gear set that gets equiped with your secondary spec.(must be the NUMBER from 1-10)

--functions
local function HasDualSpec() if GetNumTalentGroups() > 1 then return true end end

local function GetSecondaryTalentIndex()
	local secondary
	if GetActiveTalentGroup() == 1 then
		secondary = 2
	else
		secondary = 1
	end
	return secondary
end

local function ActiveTalents()
	local tree1 = select(5,GetTalentTabInfo(1))
	local tree2 = select(5,GetTalentTabInfo(2))
	local tree3 = select(5,GetTalentTabInfo(3))
	local Tree = GetPrimaryTalentTree(false,false,GetActiveTalentGroup())
	return tree1, tree2, tree3, Tree
end	

local function UnactiveTalents()
	local sTree1 = select(5,GetTalentTabInfo(1,false,false, GetSecondaryTalentIndex()))
	local sTree2 = select(5,GetTalentTabInfo(2,false,false, GetSecondaryTalentIndex()))
	local sTree3 = select(5,GetTalentTabInfo(3,false,false, GetSecondaryTalentIndex()))
	local sTree = GetPrimaryTalentTree(false,false,(GetSecondaryTalentIndex()))
	return sTree1, sTree2, sTree3, sTree
end

local function HasUnactiveTalents()
	local sTree = GetPrimaryTalentTree(false,false,(GetSecondaryTalentIndex()))
	if sTree == nil then
		return false
	else
		return true
	end
end

local function AutoGear(set1, set2)
	local name1 = GetEquipmentSetInfo(set1)
	local name2 = GetEquipmentSetInfo(set2)
	if GetActiveTalentGroup() == 1 then
		if name1 then UseEquipmentSet(name1) end
	else
		if name2 then UseEquipmentSet(name2) end
	end
end

	
local function SpecChangeCastbar(self)
	if C["castbar"].enable == true then
		local specbar = CreateFrame("StatusBar", nil, UIParent)
		specbar:Point("TOPLEFT", self, "BOTTOMLEFT", 0, -2)
		specbar:Point("TOPRIGHT", self, "BOTTOMRIGHT", 22, -2)
		specbar:Height(19)
		local border = CreateFrame("Frame", specbar:GetName() and specbar:GetName() .. "InnerBorder" or nil, specbar)
		border:Point("TOPLEFT", -T.mult, T.mult)
		border:Point("BOTTOMRIGHT", T.mult, -T.mult)
		border:SetBackdrop({
			edgeFile = C["media"].blank, 
			edgeSize = T.mult, 
			insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
			})
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		specbar.iborder = border
		specbar:CreateShadow("Default")
	
		specbar:SetStatusBarTexture(C.media.normTex)
		specbar:GetStatusBarTexture():SetHorizTile(false)
		specbar:SetBackdrop({bgFile = C.media.blank})
		specbar:SetBackdropColor(.2, .2, .2, 1)
		specbar:SetMinMaxValues(0, 5)
	
		specbar.t = specbar:CreateFontString(specbar, "OVERLAY")
		specbar.t:Point("CENTER", specbar, "CENTER", 0, 0)  
		specbar.t:SetFont(C["media"].uffont, C.datatext.fontsize)	
	
		specbar:RegisterEvent("UNIT_SPELLCAST_START")
		specbar:RegisterEvent("UNIT_SPELLCAST_STOP")
		specbar:SetScript("OnUpdate", function(self)
			local spell, _, DisplayName, _, startTime, endTime, _, castID, _ = UnitCastingInfo("player")
			local time = GetTime()
			if (spell == "Activating Primary Spec") or (spell == "Activating Secondary Spec") then
				local val = time-(startTime/1000) or 0
				self:SetAlpha(1)
				self:SetValue(val)
				specbar.t:SetText(spell)
			
				TukuiPlayerCastBar:SetAlpha(0)
			else
				TukuiPlayerCastBar:SetAlpha(1)
				self:SetAlpha(0)
			end
		end)
	end
end

-----------
-- Spec
-----------
local spec = CreateFrame("Button", "Tukui_Spechelper", UIParent)
spec:CreatePanel("Default", 1, 20, "TOPRIGHT", UIParent, "TOPRIGHT", -32, -212)
spec:CreateShadow("Default")

	-- Positioning EDIT HERE FOR ANCHORING!
	if TukuiMinimap then
		spec:SetPoint("TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -2)
		spec:SetPoint("TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", -22, -2)
	end
	
	if TukuiMinimapStatsLeft and TukuiMinimapStatsRight then
		spec:SetPoint("TOPLEFT", TukuiMinimapStatsLeft, "BOTTOMLEFT", 0, -2)
		spec:SetPoint("TOPRIGHT", TukuiMinimapStatsRight, "BOTTOMRIGHT", -22, -2)
	end
	
	-- Text
	spec.t = spec:CreateFontString(spec, "OVERLAY")
	spec.t:SetPoint("CENTER")
	spec.t:SetFont(C["media"].uffont, C.datatext.fontsize)

	local int = 1
	local function Update(self, t)
	int = int - t
	if int > 0 then return end
		if not GetPrimaryTalentTree() then spec.t:SetText("No talents") return end
		local tree1, tree2, tree3, Tree = ActiveTalents()
		name = select(2, GetTalentTabInfo(Tree))
		spec.t:SetText(name.." "..panelcolor..tree1.."/"..tree2.."/"..tree3)
		
		if HasDualSpec() then
			if HasUnactiveTalents() then 
				local sTree1, sTree2, sTree3, sTree = UnactiveTalents()
				sName = select(2, GetTalentTabInfo(sTree))
				spec:SetScript("OnEnter", function() spec.t:SetText(cm..sName.." "..panelcolor..sTree1.."/"..sTree2.."/"..sTree3) end)
				spec:SetScript("OnLeave", function() spec.t:SetText(name.." "..panelcolor..tree1.."/"..tree2.."/"..tree3) end)
			else
				spec:SetScript("OnEnter", function() spec.t:SetText(cm.."No talents") end)
				spec:SetScript("OnLeave", function() spec.t:SetText(name.." "..panelcolor..tree1.."/"..tree2.."/"..tree3) end)
			end
		end
		int = 1
		self:SetScript("OnUpdate", nil)
	end

	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		else
			self:SetScript("OnUpdate", Update)
		end
	end	
	
	spec:RegisterEvent("PLAYER_TALENT_UPDATE")
	spec:RegisterEvent("PLAYER_ENTERING_WORLD")
	spec:RegisterEvent("CHARACTER_POINTS_CHANGED")
	spec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	spec:SetScript("OnEvent", OnEvent) 

	spec:SetScript("OnClick", function(self) 
	local i = GetActiveTalentGroup()
	if IsModifierKeyDown() then
		ToggleTalentFrame()
	else
		if i == 1 then SetActiveTalentGroup(2) end
		if i == 2 then SetActiveTalentGroup(1) end
	end
	end)
	
	if Specswitchcastbar == true then
		SpecChangeCastbar(spec)
	end
	
	if C.general.colorscheme == true then
		spec:SetBackdropColor(unpack(C.general.color))
	end
	
------------
--Move UI
------------
local mui = CreateFrame("Button", nil, spec, "SecureActionButtonTemplate")
mui:CreatePanel("Default", 48, 19, "TOPLEFT", spec, "BOTTOMLEFT", 0, -2)
mui:CreateShadow("Default")

mui:Hide()	
mui.t = mui:CreateFontString(nil, "OVERLAY")
mui.t:SetPoint("CENTER")
mui.t:SetFont(C["media"].uffont, C.datatext.fontsize)
mui.t:SetText("Move UI")

mui:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
mui:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C.media.bordercolor)) end)
mui:SetAttribute("type", "macro")
mui:SetAttribute("macrotext", "/moveui")

	if C.general.colorscheme == true then
		mui:SetBackdropColor(unpack(C.general.color))
	end	
	
------------
--Key Binds
------------
local binds = CreateFrame("Button", nil, mui, "SecureActionButtonTemplate")
binds:CreatePanel("Default", 30, 19, "LEFT", mui, "RIGHT", 3, 0)
binds:CreateShadow("Default")

binds.t = binds:CreateFontString(nil, "OVERLAY")
binds.t:SetPoint("CENTER")
binds.t:SetFont(C["media"].uffont, C.datatext.fontsize)
binds.t:SetText("Bind")

binds:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
binds:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C.media.bordercolor)) end)
binds:SetAttribute("type", "macro")
binds:SetAttribute("macrotext", "/bindkey")

	if C.general.colorscheme == true then
		binds:SetBackdropColor(unpack(C.general.color))
	end	
	
---------------	
-- Heal layout
---------------
local heal = CreateFrame("Button", nil, mui, "SecureActionButtonTemplate")
heal:CreatePanel("Default", 29, 19, "LEFT", binds, "RIGHT", 3, 0)
heal:CreateShadow("Default")
		
heal.t = heal:CreateFontString(nil, "OVERLAY")
heal.t:SetPoint("CENTER")
heal.t:SetFont(C["media"].uffont, C.datatext.fontsize)
heal.t:SetText("HEAL")

heal:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
heal:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C.media.bordercolor)) end)
heal:SetAttribute("type", "macro")
heal:SetAttribute("macrotext", "/heal")

	if C.general.colorscheme == true then
		heal:SetBackdropColor(unpack(C.general.color))
	end
	
--------------
-- DPS layout
--------------
local dps = CreateFrame("Button", nil, mui, "SecureActionButtonTemplate")
dps:CreatePanel("Default", 28, 19, "LEFT", heal, "RIGHT", 3, 0)	
dps:CreateShadow("Default")
	
dps.t = dps:CreateFontString(nil, "OVERLAY")
dps.t:SetPoint("CENTER")
dps.t:SetFont(C["media"].uffont, C.datatext.fontsize)
dps.t:SetText("DPS")

dps:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
dps:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C.media.bordercolor)) end)
dps:SetAttribute("type", "macro")
dps:SetAttribute("macrotext", "/dps")

	if C.general.colorscheme == true then
		dps:SetBackdropColor(unpack(C.general.color))
	end
	
------------------		
-- Gear switching
------------------
if Enablegear == true then
	local gearSets = CreateFrame("Frame", nil, dps)	
	for i = 1, 10 do
			gearSets[i] = CreateFrame("Button", nil, dps)
			gearSets[i]:CreatePanel("Default", 19, 19, "CENTER", dps, "CENTER", 0, 0)
			gearSets[i]:CreateShadow("Default")

			if i == 1 then
				gearSets[i]:Point("TOPRIGHT", dps, "BOTTOMRIGHT", 0, -2)
			else
				gearSets[i]:SetPoint("BOTTOMRIGHT", gearSets[i-1], "BOTTOMLEFT", -3, 0)
			end
			gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
			gearSets[i].texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i] ,"TOPLEFT", 2, -2)
			gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i] ,"BOTTOMRIGHT", -2, 2)
			gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))
			gearSets[i]:Hide()
		
		gearSets[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
		gearSets[i]:RegisterEvent("EQUIPMENT_SETS_CHANGED")
		gearSets[i]:SetScript("OnEvent", function(self, event)
			local points, pt = 0, GetNumEquipmentSets()
			local frames = { gearSets[1]:IsShown(), gearSets[2]:IsShown(), gearSets[3]:IsShown(), gearSets[4]:IsShown(), 
						 gearSets[5]:IsShown(), gearSets[6]:IsShown(), gearSets[7]:IsShown(), gearSets[8]:IsShown(), -- lol WTF was I thinking here!
						 gearSets[9]:IsShown(), gearSets[10]:IsShown() }
			if pt > points then
				for i = points + 1, pt do
					gearSets[i]:Show()
				end
			end
			if frames[pt+1] == 1 then
				gearSets[pt+1]:Hide()
			end
			
			gearSets[i].texture = gearSets[i]:CreateTexture(nil, "BORDER")
			gearSets[i].texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			gearSets[i].texture:SetPoint("TOPLEFT", gearSets[i] ,"TOPLEFT", 2, -2)
			gearSets[i].texture:SetPoint("BOTTOMRIGHT", gearSets[i] ,"BOTTOMRIGHT", -2, 2)
			gearSets[i].texture:SetTexture(select(2, GetEquipmentSetInfo(i)))
			
			gearSets[i]:SetScript("OnClick", function(self) UseEquipmentSet(GetEquipmentSetInfo(i)) end)
			gearSets[i]:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
			gearSets[i]:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C.media.bordercolor)) end)
			
			if Autogearswap == true then
				gearSets[1]:SetBackdropBorderColor(0,1,0)
				gearSets[2]:SetBackdropBorderColor(1,0,0)
				gearSets[1]:SetScript("OnEnter", nil)
				gearSets[1]:SetScript("OnLeave", nil)
				gearSets[2]:SetScript("OnEnter", nil)
				gearSets[2]:SetScript("OnLeave", nil)
			end
		end)
	end	
	
	if Autogearswap == true then
		gearsetfunc = CreateFrame("Frame", "gearSetfunc", UIParent)
		local function OnEvent(self, event)
			if event == "PLAYER_ENTERING_WORLD" then
				self:UnregisterEvent("PLAYER_ENTERING_WORLD")
			else
				AutoGear(set1, set2) 
			end
		end
		
		gearsetfunc:RegisterEvent("PLAYER_ENTERING_WORLD")
		gearsetfunc:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		gearsetfunc:SetScript("OnEvent", OnEvent)
	end
end

----------------
--Toggle Button
----------------
local toggle = CreateFrame("Button", nil, spec)
toggle:CreatePanel("Default", 20, 20, "TOPLEFT", spec, "TOPRIGHT", 2, 0)
toggle:CreateShadow("Default")

	toggle.t = toggle:CreateFontString(nil, "OVERLAY")
	toggle.t:SetPoint("CENTER")
	toggle.t:SetFont(C["media"].uffont, C.datatext.fontsize)
	toggle.t:SetText(cp.."+|r")
	toggle:SetScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(hoverovercolor)) end)
	toggle:SetScript("OnLeave", function(self) self:SetBackdropBorderColor(unpack(C.media.bordercolor)) end)
		
	toggle:SetScript("OnClick", function(self) 
		if mui:IsShown() then	
			mui:Hide()
			toggle.t:SetText(cp.."+")
		else
			mui:Show()
			toggle.t:SetText(cm.."-")
		end
	end)
		
	if C.general.colorscheme == true then
		toggle:SetBackdropColor(unpack(C.general.color))
	end