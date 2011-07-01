local T, C, L, DB = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

if not IsAddOnLoaded("DXE") or not C.skins.DXE then return end

local DXE = DXE
local _G = getfenv(0)
local barSpacing = T.Scale(1, 1)
local borderWidth = T.Scale(2, 2)
local buttonZoom = {.09,.91,.09,.91}
local movers = {
	"DXEAlertsCenterStackAnchor",
	"DXEAlertsWarningStackAnchor",
	"DXEDistributorStackAnchor",
	"DXEAlertsTopStackAnchor",
	"DXEArrowsAnchor1",
	"DXEArrowsAnchor2",
	"DXEArrowsAnchor3",
}

local function SkinDXEBar(bar)
	-- The main bar
	bar:SetTemplate("Transparent")
	bar.bg:SetTexture(nil)
	bar.border:Kill()
	bar.statusbar:SetStatusBarTexture(C["media"].normTex)
	bar.statusbar:ClearAllPoints()
	bar.statusbar:SetPoint("TOPLEFT",borderWidth, -borderWidth)
	bar.statusbar:SetPoint("BOTTOMRIGHT",-borderWidth, borderWidth)
	
	-- Right Icon
	bar.righticon:SetTemplate("Default")
	bar.righticon.border:Kill()
	bar.righticon.t:SetTexCoord(unpack(buttonZoom))
	bar.righticon.t:ClearAllPoints()
	bar.righticon.t:SetPoint("TOPLEFT", borderWidth, -borderWidth)
	bar.righticon.t:SetPoint("BOTTOMRIGHT", -borderWidth, borderWidth)
	bar.righticon.t:SetDrawLayer("ARTWORK")
	
	-- Left Icon
	bar.lefticon:SetTemplate("Default")
	bar.lefticon.border:Kill()
	bar.lefticon.t:SetTexCoord(unpack(buttonZoom))
	bar.lefticon.t:ClearAllPoints()
	bar.lefticon.t:SetPoint("TOPLEFT",borderWidth, -borderWidth)
	bar.lefticon.t:SetPoint("BOTTOMRIGHT",-borderWidth, borderWidth)
	bar.lefticon.t:SetDrawLayer("ARTWORK")
end

--Kill DXE's skinning
DXE.NotifyBarTextureChanged = T.dummy
DXE.NotifyBorderChanged = T.dummy
DXE.NotifyBorderColorChanged = T.dummy
DXE.NotifyBorderEdgeSizeChanged = T.dummy
DXE.NotifyBackgroundTextureChanged = T.dummy
DXE.NotifyBackgroundInsetChanged = T.dummy
DXE.NotifyBackgroundColorChanged = T.dummy

--Hook Window Creation
DXE.CreateWindow_ = DXE.CreateWindow
DXE.CreateWindow = function(self, name, width, height)
	local win = self:CreateWindow_(name, width, height)
	win:SetTemplate("Transparent")
	return win
end

-- Skin the pane
DXE.Pane:SetTemplate("Transparent")

-- Hook Health frames (Skin & spacing)
DXE.LayoutHealthWatchers_ = DXE.LayoutHealthWatchers
DXE.LayoutHealthWatchers = function(self)
	self.db.profile.Pane.BarSpacing = barSpacing
	self:LayoutHealthWatchers_()
	for i,hw in ipairs(self.HW) do
		if hw:IsShown() then
			hw:SetTemplate("Transparent")
			hw.border:Kill()
			hw.healthbar:SetStatusBarTexture(C["media"].normTex)
		end
	end
end

DXE.Alerts.RefreshBars_ = DXE.Alerts.RefreshBars
DXE.Alerts.RefreshBars = function(self)
	if self.refreshing then return end
	self.refreshing = true
	self.db.profile.BarSpacing = barSpacing
	self.db.profile.IconXOffset = barSpacing
	self:RefreshBars_()
	local i = 1
	while _G["DXEAlertBar"..i] do
		local bar = _G["DXEAlertBar"..i]
		bar:SetScale(1)
		bar:SetAlpha(1)
		bar.SetAlpha = T.dummy
		bar.SetScale = T.dummy
		SkinDXEBar(bar)
		i = i + 1
	end
	self.refreshing = false
end

DXE.Alerts.Dropdown_ = DXE.Alerts.Dropdown
DXE.Alerts.Dropdown = function(self,...)
	self:Dropdown_(...)
	self:RefreshBars()
end

DXE.Alerts.CenterPopup_ = DXE.Alerts.CenterPopup
DXE.Alerts.CenterPopup = function(self,...)
	self:CenterPopup_(...)
	self:RefreshBars()
end

DXE.Alerts.Simple_ = DXE.Alerts.Simple
DXE.Alerts.Simple = function(self,...)
	self:Simple_(...)
	self:RefreshBars()
end

-- Force some updates
DXE:LayoutHealthWatchers()
DXE.Alerts:RefreshBars()
DXE.Pane.border:Kill()

--Force some default profile options
if not DXEDB then DXEDB = {} end
if not DXEDB["profiles"] then DXEDB["profiles"] = {} end
if not DXEDB["profiles"][T.myname.." - "..GetRealmName()] then DXEDB["profiles"][T.myname.." - "..T.myrealm] = {} end
if not DXEDB["profiles"][T.myname.." - "..GetRealmName()]["Globals"] then DXEDB["profiles"][T.myname.." - "..T.myrealm]["Globals"] = {} end
DXEDB["profiles"][T.myname.." - "..T.myrealm]["Globals"]["BackgroundTexture"] = "Tukui Blank"
DXEDB["profiles"][T.myname.." - "..T.myrealm]["Globals"]["BarTexture"] = "Tukui Statusbar"
DXEDB["profiles"][T.myname.." - "..T.myrealm]["Globals"]["Border"] = "None"
DXEDB["profiles"][T.myname.." - "..T.myrealm]["Globals"]["Font"] = "Tukui Normal Font"
DXEDB["profiles"][T.myname.." - "..T.myrealm]["Globals"]["TimerFont"] = "Tukui Normal Font"

local function PositionDXEAnchor()
	if not DXEAlertsTopStackAnchor then return end
	DXEAlertsTopStackAnchor:ClearAllPoints()
	if T.CheckAddOnShown() == true then
		if C["chat"].showbackdrop == true and T.ChatRightShown == true then
			if E.RightChat == true then
				DXEAlertsTopStackAnchor:Point("BOTTOM", ChatRBackground, "TOP", 13, 14)	
			else
				DXEAlertsTopStackAnchor:Point("BOTTOM", ChatRBackground, "TOP", 13, -9)
			end
		else
			DXEAlertsTopStackAnchor:Point("BOTTOM", ChatRBackground, "TOP", 13, -9)	
		end	
	else
		DXEAlertsTopStackAnchor:Point("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -41, 14)		
	end
end

--Hook bar to chatframe, rest of this is handled inside chat.lua and chatanimation.lua
local DXE_Skin = CreateFrame("Frame")
DXE_Skin:RegisterEvent("PLAYER_ENTERING_WORLD")
DXE_Skin:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent(event)
		self = nil
		
		--DXE doesn't like the pane timer font to listen for some reason
		DXE.Pane.timer.left:SetFont(C["media"].font, 18)
		DXE.Pane.timer.right:SetFont(C["media"].font, 12)
		
		for i=1, #movers do
			if not _G[movers[i]] then
				print(movers[i])
			else
				_G[movers[i]]:SetTemplate("Transparent")
			end
		end
		
	elseif event == "PLAYER_REGEN_DISABLED" then
		PositionDXEAnchor()
	elseif event == "PLAYER_REGEN_ENABLED" then
		PositionDXEAnchor()
	end
end)