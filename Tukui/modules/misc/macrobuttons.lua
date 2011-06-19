local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales
if not C["actionbar"].macro == true then return end

local ActionButton_ShowOverlayGlow = ActionButton_ShowOverlayGlow
local ActionButton_HideOverlayGlow =ActionButton_HideOverlayGlow
local ActionButton_UpdateOverlayGlow = ActionButton_UpdateOverlayGlow
local GetActionInfo = GetActionInfo
local GetMacroSpell = GetMacroSpell

local overlayedSpells = {}

hooksecurefunc('ActionButton_HideOverlayGlow', function(button)
	if button.__LAB_Version then return end
	local actionType, actionParam = GetActionInfo(button.action)
	if actionType == "macro" and overlayedSpells[GetMacroSpell(actionParam) or false] then
		return ActionButton_ShowOverlayGlow(button)
	end
end)

hooksecurefunc('ActionButton_OnEvent',  function(button, event, id)
	if event == 'SPELL_ACTIVATION_OVERLAY_GLOW_SHOW' or event == 'SPELL_ACTIVATION_OVERLAY_GLOW_HIDE' then
		local spell, actionType, actionParam = GetSpellInfo(id), GetActionInfo(button.action)
		local show = event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"
		overlayedSpells[spell] = show
		if actionType == 'macro' and GetMacroSpell(actionParam) == spell then
			if show then
				return ActionButton_ShowOverlayGlow(button)
			else
				return ActionButton_HideOverlayGlow(button)
			end
		end
	end
end)
