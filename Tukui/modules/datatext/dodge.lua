local T, C, L, DB = unpack(select(2, ...))

if not C["datatext"].dodge or C["datatext"].dodge == 0 then return end

local Stat = CreateFrame("Frame")
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
Text:SetFont(C["datatext"].font, C["datatext"].fontsize)
T.PP(C["datatext"].dodge, Text)

local format = string.format
local displayFloat = string.join("", "%s", T.panelcolor, "%.2f%%|r")
local displayChance = string.join("", T.panelcolor, "%.2f|r (%.2f + |cff00ff00%.2f|r)")
local displayRating = string.join("", "%d (|cff00ff00+%.2f|r)")

local int = 5
local function Update(self, t)
	int = int - t
	if int > 0 then return end

	Text:SetFormattedText(displayFloat, STAT_DODGE..": ", GetDodgeChance())

	self:SetAllPoints(Text)

	int = 2
end

local function ShowTooltip(self)
	local anchor, panel, xoff, yoff = T.DataTextTooltipAnchor(Text)
	GameTooltip:SetOwner(panel, anchor, xoff, yoff)
	GameTooltip:ClearLines()

	local rating = GetCombatRating(CR_DODGE)
	local ratingChance = GetCombatRatingBonus(CR_DODGE)
	local baseChance = GetDodgeChance() - ratingChance

	GameTooltip:AddDoubleLine(STAT_DODGE, format(displayChance, GetDodgeChance(), baseChance, ratingChance), 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine(ITEM_MOD_DODGE_RATING_SHORT, format(displayRating, rating, ratingChance), 1, 1, 1, 1, 1, 1)
	GameTooltip:Show()
end

Stat:SetScript("OnEnter", function() ShowTooltip(Stat) end)
Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
Stat:SetScript("OnUpdate", Update)
Update(Stat, 6)