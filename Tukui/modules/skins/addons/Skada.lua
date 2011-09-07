local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

if not IsAddOnLoaded("Skada") or not C.skins.Skada then return end

local Skada = Skada
local barSpacing = T.Scale(1, 1)
local borderWidth = T.Scale(2, 2)

local barmod = Skada.displays["bar"]

local titleBG = {
	bgFile = C["media"].normTex,
	tile = false,
	tileSize = 0
}

barmod.ApplySettings_ = barmod.ApplySettings
barmod.ApplySettings = function(self, win)
	barmod.ApplySettings_(self, win)

	local skada = win.bargroup

	if win.db.enabletitle then
		skada.button:SetBackdrop(titleBG)
	end

	skada:SetTexture(C["media"].normTex)
	skada:SetSpacing(barSpacing)
	skada:SetFont(C["media"].font, C["general"].fontscale)
	skada:SetFrameLevel(5)

	skada:SetBackdrop(nil)
	if not skada.backdrop then
		skada:CreateBackdrop('Default')
	end
	skada.backdrop:ClearAllPoints()
	skada.backdrop:Point('TOPLEFT', win.bargroup.button or win.bargroup, 'TOPLEFT', -2, 2)
	skada.backdrop:Point('BOTTOMRIGHT', win.bargroup, 'BOTTOMRIGHT', 2, -4)
end

-- Update pre-existing displays
for _, window in ipairs(Skada:GetWindows()) do
	window:UpdateDisplay()
end