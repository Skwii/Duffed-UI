local T, C, L = unpack(select(2, ...))

C["media"] = {
	-- fonts
	["font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], 					-- general font of tukui
	["uffont"] = [[Interface\AddOns\Tukui\medias\fonts\uf_font.ttf]], 						-- general font of unitframes
	["dmgfont"] = [[Interface\AddOns\Tukui\medias\fonts\combat_font.ttf]], 					-- general font of dmg / sct
	["outline"] = "THINOUTLINE",															-- general outline
	
	-- fonts (RUSSIAN)
	["ru_font"] = [=[Interface\Addons\Tukui\medias\fonts\normal_font.ttf]=], 				-- general font of tukui
	["ru_uffont"] = [[Fonts\ARIALN.TTF]], 													-- general font of unitframes
	["ru_dmgfont"] = [[Interface\AddOns\Tukui\medias\fonts\combat_font_rus.ttf]], 			-- general font of dmg / sct
	
	-- fonts (TAIWAN ONLY)
	["tw_font"] = [=[Fonts\bLEI00D.ttf]=], 													-- general font of tukui
	["tw_uffont"] = [[Fonts\bLEI00D.ttf]], 													-- general font of unitframes
	["tw_dmgfont"] = [[Fonts\bLEI00D.ttf]], 												-- general font of dmg / sct
	
	-- fonts (KOREAN ONLY)
	["kr_font"] = [=[Fonts\2002.TTF]=], 													-- general font of tukui
	["kr_uffont"] = [[Fonts\2002.TTF]], 													-- general font of unitframes
	["kr_dmgfont"] = [[Fonts\2002.TTF]],													-- general font of dmg / sct
	
	-- fonts (Chinese only)
	["cn_font"] = [=[Fonts\ZYKai_T.TTF]=], -- general font of tukui
	["cn_uffont"] = [[Fonts\ZYHei.TTF]], -- general font of unitframes
	["cn_dmgfont"] = [[Fonts\ZYKai_C.TTF]], -- general font of dmg / sct
	
	-- textures
	["normTex"] = [[Interface\AddOns\Tukui\medias\textures\normTex]], 						-- texture used for tukui healthbar/powerbar/etc
	["glowTex"] = [[Interface\AddOns\Tukui\medias\textures\glowTex]], 						-- the glow text around some frame.
	["bubbleTex"] = [[Interface\AddOns\Tukui\medias\textures\bubbleTex]], 					-- unitframes combo points
	["blank"] = [[Interface\AddOns\Tukui\medias\textures\blank]], 							-- the main texture for all borders/panels
	["arrowup"] = [[Interface\Addons\Tukui\medias\textures\arrowup]], 						-- arrowup
	["arrowdown"] = [[Interface\Addons\Tukui\medias\textures\arrowdown]], 					-- arrowdown
	["bordercolor"] = C.general.bordercolor or { .15, .15, .15 }, 							-- border color of tukui panels
	["backdropcolor"] = C.general.backdropcolor or { .05,.05,.05 }, 						-- background color of tukui panels
	["valuecolor"] = {r = 23/255,g = 132/255,b = 209/255}, 									-- color for values of datatexts
	["buttonhover"] = [[Interface\AddOns\Tukui\medias\textures\button_hover]],				-- hovertexture
	
	-- sound
	["whisper"] = [[Interface\AddOns\Tukui\medias\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\Tukui\medias\sounds\warning.mp3]],
}

-- LibSharedMedia crap
if not LibStub then return end
local LSM = LibStub("LibSharedMedia-3.0", true)
if not LSM then return end

LSM:Register("statusbar","Tukui Blank", C.media.blank)
LSM:Register("statusbar","Tukui Statusbar", C.media.normTex)
LSM:Register("border","Tukui Glow", C.media.glowTex)
LSM:Register("font","Tukui Datatext Font", C.datatext.font)
LSM:Register("font","Tukui UF Font", C.media.uffont)
LSM:Register("font","Tukui Normal Font", C.media.font)