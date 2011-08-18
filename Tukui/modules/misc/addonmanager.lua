--[[
	Basecode from Asphyxia, thanks a lot :)
]]--

local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
local font, fontsize, fontstyle = C.media.font, C["datatext"].fontsize, C["unitframes"].outline
local cm = "|cff9a1212"


local function ModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	self:SetBackdropColor(color.r*.15, color.g*.15, color.b*.15)
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function OriginalBackdrop(self)
	self:SetTemplate("Default")
end

-- Create BG
local addonBG = CreateFrame("Frame", "addonBG", UIParent)
addonBG:CreatePanel("Default", T.InfoLeftRightWidth, 514, "CENTER", UIParent, "CENTER", 0, 0)
addonBG:EnableMouse(true)
addonBG:SetMovable(true)
addonBG:SetUserPlaced(true)
addonBG:SetClampedToScreen(true)
addonBG:SetScript("OnMouseDown", function(self) self:StartMoving() end)
addonBG:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
addonBG:SetFrameStrata("MEDIUM")
addonBG:Hide()

local addonHeader = CreateFrame("Frame", "addonHeader", addonBG)
addonHeader:CreatePanel("Default", addonBG:GetWidth(), 20, "BOTTOM", addonBG, "TOP", 0, 3, true)
addonHeader.Text = T.SetFontString(addonHeader, font, fontsize, fontstyle)
addonHeader.Text:SetPoint("CENTER", 0, 1)
addonHeader.Text:SetText(T.panelcolor.."AddOns List"..": "..T.panelcolor..T.myname)

-- Create scroll frame
local scrollFrame = CreateFrame("ScrollFrame", "scrollFrame", addonBG, "UIPanelScrollFrameTemplate")
scrollFrame:SetPoint("TOPLEFT", addonBG, "TOPLEFT", 10, -10)
scrollFrame:SetPoint("BOTTOMRIGHT", addonBG, "BOTTOMRIGHT", -30, 40)
T.SkinScrollBar(scrollFrameScrollBar)

-- Create inside BG (uses scroll frame)
local buttonsBG = CreateFrame("Frame", "buttonsBG", scrollFrame)
buttonsBG:SetPoint("TOPLEFT")
buttonsBG:SetWidth(scrollFrame:GetWidth())
buttonsBG:SetHeight(scrollFrame:GetHeight())
scrollFrame:SetScrollChild(buttonsBG)


local saveButton = CreateFrame("Button", "saveButton", addonBG)
saveButton:CreatePanel("Default", 130, 20, "BOTTOMLEFT", addonBG, "BOTTOMLEFT", 10, 10, true)
saveButton:SetFrameStrata("TOOLTIP")
saveButton.text = T.SetFontString(saveButton, font, fontsize, fontstyle)
saveButton.text:SetPoint("CENTER", 0, 0)
saveButton.text:SetText(T.panelcolor.."Save Changes")
saveButton:SetScript("OnClick", function() ReloadUI() end)
saveButton:HookScript("OnEnter", ModifiedBackdrop)
saveButton:HookScript("OnLeave", OriginalBackdrop)

local closeButton = CreateFrame("Button", "closeButton", addonBG)
closeButton:CreatePanel("Default", 130, 20, "BOTTOMRIGHT", addonBG, "BOTTOMRIGHT", -10, 10, true)
closeButton:SetFrameStrata("TOOLTIP")
closeButton.text = T.SetFontString(closeButton, font, fontsize, fontstyle)
closeButton.text:SetPoint("CENTER", 0, 0)
closeButton.text:SetText(T.panelcolor.."Cancel")
closeButton:SetScript("OnClick", function(self) addonBG:Hide() end)
closeButton:HookScript("OnEnter", ModifiedBackdrop)
closeButton:HookScript("OnLeave", OriginalBackdrop)

local function UpdateAddons()
	local addons = {}
	for i=1, GetNumAddOns() do
		addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(addons)
	local oldb
	for i,v in pairs(addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)
		local button = CreateFrame("CheckButton", v.."_Button", buttonsBG, "OptionsCheckButtonTemplate")
		button:SetFrameLevel(buttonsBG:GetFrameLevel() + 1)
		button:Size(16, 16)
		button:SetTemplate("Default")

		if i==1 then
			button:Point("TOPLEFT", buttonsBG, "TOPLEFT", 0, 0)
		else
			button:Point("TOP", oldb, "BOTTOM", 0, -6)
		end
		local text = T.SetFontString(button, C.media.font, C["datatext"].fontsize, C["unitframes"].outline)
		text:Point("LEFT", button, "RIGHT", 8, 0)
		text:SetText(title)
	
		 button:SetScript("OnMouseDown", function()
            if enabled then
                DisableAddOn(name)
                enabled = false
            else
                EnableAddOn(name)
                enabled = true
            end
        end)
		button:SetChecked(enabled)
		
		_G[v.."_Button"]:StripTextures()
		_G[v.."_Button"]:SetTemplate("Default")
		_G[v.."_Button"]:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		_G[v.."_Button"]:Size(16, 16)
		_G[v.."_Button"]:GetCheckedTexture():Point("TOPLEFT", -4, 4)
		_G[v.."_Button"]:GetCheckedTexture():Point("BOTTOMRIGHT", 4, -4)
	
		oldb = button
	end
end

UpdateAddons()

-- Slash commands
SLASH_ALOAD1 = "/am"
SlashCmdList.ALOAD = function (msg)
	addonBG:Show()
end