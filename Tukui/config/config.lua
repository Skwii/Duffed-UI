﻿local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

C["general"] = {
	["blizzardsct"] = true,								-- Skin also Blizzard SCT Font(put it in generel now)
	["normalfont"] = false,								-- Use the normal/old font + fontsize instead of pixelfont :>
	["overridehightolow"] = false,						-- even that is experimental only! :> .. use lowres version on high resolution.
	["classcoloredborder"] = false, 					-- 
	
	["bordercolor"] = { .15, .15, .15 },				-- border color of tukui panels
	["backdropcolor"] = { .05,.05,.05 },				-- background color of tukui panels

	["autoscale"] = true,                               -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.73,                                 -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,                      -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,                      -- i don't recommend this because of shitty border but, voila!
}

C["unitframes"] = {
	["layout"] = 2,										-- Layout 1 or 2
	["outline"] = "NONE",								-- Set outlines
	["totdebuff"] = 19.5,								-- Set size of Target of Target debuffs
	
	["fontsize"] = 8,									-- Fontsize on Unitframes
	["healthbarcolor"] = {.2, .2, .2, 1},				-- Healthbar color (if unicolor = true) 
	["deficitcolor"] = {0, 0, 0},						-- Healthbar deficit color (if unicolor = true)
	["totandpetlines"] = true,							-- Show the small Lines on pet & Target of Target
	["priestarmor"] = false,							-- Display which Armor is currently up on ur priest
	["framewidth"] = 218,								-- Width of Player & Target Frame (affect also arena- & bossframes)
	["vengeancebar"] = false,							-- Display a Vengeance-Bar instead of Threat-Bar at the right info panel
	["fader"] = false,									-- EXPERIMENTAL (cause i didnt really test it :) - Fade Unitframes out when ooc etc.
		["fader_alpha"] = 1,							-- alpha for frames if you're not in combat but hp is < 100% and some more conditions
	["largefocus"] = false,								-- Use larger Focus Frame
	["gridpets"] = true,								-- show pets in grid layout (only in group, not raid)
	["gridvertical"] = false,							-- Grid direction vertical instead of horizontal
	["gridsolo"] = false,								-- Show Grid even without a group (solo)
	["focusdebuffs"] = true,							-- display focus debuffs
	["buffrows"] = 1,									-- Buff rows above Target (and Player if u enable it)
	["debuffrows"] = 2, 								-- Debuff rows above Target (and Player if u enable it)
	["portraitstyle"] = "ICON",							-- "ICON" or "MODEL" (Layout 2 only)
	["ColorGradient"] = false,							-- Add Color-Gradient to healthbar from healthbarcolor to red
	["powerClasscolored"] = true,						-- Color in Class-color instead of power-color :>
	
	-- general options
	["enable"] = true,                                  -- do i really need to explain this?
	["enemyhcolor"] = false,                            -- enemy target (players) color by hostility, very useful for healer.´
	["auratimer"] = true,                               -- enable timers on buffs/debuffs
	["auratextscale"] = 8,                             -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = false,                            -- enable auras
	["targetauras"] = true,                             -- enable auras on target unit frame
	["lowThreshold"] = 20,                              -- global low threshold, for low mana warning.
	["totdebuffs"] = true,                             -- enable tot debuffs (high reso only)
	["showtotalhpmp"] = false,                          -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                              -- enable smooth bar
	["charportrait"] = true,                           	-- do i really need to explain this?
	["maintank"] = false,                               -- enable maintank
	["mainassist"] = false,                             -- enable mainassist
	["unicolor"] = true,                               	-- enable unicolor theme
	["combatfeedback"] = true,                          -- enable combattext on player and target.
	["playeraggro"] = true,                             -- color player border to red if you have aggro on current target.
	["healcomm"] = true,                               	-- enable healprediction support.
	["onlyselfdebuffs"] = false,                        -- display only our own debuffs applied on target

	-- raid layout (if one of them is enabled)
	["showrange"] = true,                               -- show range opacity on raidframes
	["raidalphaoor"] = 0.5,                             -- alpha of unitframes when unit is out of range
	["gridonly"] = true,                               	-- enable grid only mode for all healer mode raid layout.
	["showsymbols"] = true,	                            -- show symbol.
	["aggro"] = true,                                   -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,                     -- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,                      -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,                      	-- show my player frame in party
	["gridscale"] = 1,                                  -- set the healing grid scaling
	
	-- boss frames
	["showboss"] = true,                                -- enable boss unit frames for PVELOL encounters.

	-- priest only plugin
	["weakenedsoulbar"] = true,                         -- show weakened soul bar
	
	-- class bar
	["classbar"] = true,                                -- enable tukui classbar over player unit
}

C["castbar"] = {
	["enable"] = true,
	["cbicons"] = true,
	["cblatency"] = false,                              -- enable castbar latency
	["classcolored"] = true,
		["color"] = { 0.9, 0.9, 0.9, 0.9 },				-- Castbar color for everything except player (if classcolored = false)
	["target-y-offset"] = 380,							-- Target Castbar offset from the BOTTOM
	["target-x-offset"] = 0,							-- Target Castbar offset from the CENTER (horizontal)
	["targetwidth"] = 240,								-- Target Castbar width
	["focus-y-offset"] = -320,							-- Focus Castbar offset from the TOP
	["focus-x-offset"] = 0,								-- Focus Castbar offset from the CENTER (horizontal)
	["focuswidth"] = 240,								-- Focus Castbar width
}

C["actionbar"] = {
	["swapbar1and3"] = false,							-- Swap Mainbar with 2. or 3. (depends on which AB-Layout you use)
	["rightbarsmouseover"] = true, 						-- Right Bars on mouseover
	["shapeshiftborder"] = true,						-- Create a Border around the shapeshift buttons
	["shapeshiftmouseover"] = false,					-- Shapeshiftbar on mouseover
	["verticalshapeshift"] = false,						-- Shapeshiftbar vertical
	["macrotext"] = false,								-- display macro text on buttons
	["macro"] = true,									-- Enable Buttonhighlightning like Blizzstandard for procs
	["petbaralwaysvisible"] = true,						-- Always show petbar even if rightbarsmouseover = true
	["petbarhorizontal"] = false,						-- Petbar horizontal on top of Bar1/2
	["button2"] = false,								-- TukuiBar2Button Show / Hide

	["enable"] = true,                                  -- enable tukui action bars
	["layout"] = 1,										-- layout testingstuff
	["hotkey"] = false,                                 -- enable hotkey display because it was a lot requested
	["hideshapeshift"] = false,                         -- hide shapeshift or totembar because it was a lot requested.
	["showgrid"] = true,                                -- show grid on empty button
	["buttonsize"] = 27,                                -- normal buttons size
	["petbuttonsize"] = 29,                             -- pet & stance buttons size
	["buttonspacing"] = 4,                              -- buttons spacing
}

C["arena"] = {
	["unitframes"] = true,                              -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
}

C["pvp"] = {
	["drinkannouncement"] = true,						-- Drink announcement for arena
	["ccannouncement"] = true,							-- Announce CC/Buffs/Debuffs (config in AddOns/Stuff/Config.lua)
	["sayinterrupt"] = true,							-- Interrupt announce
	["dispelannouncement"] = false,						-- Announce dispels in a movable frame (/duffed)
	
	["arenaonly"] = true,								-- Aura and Interrupt announce in arena only
}

C["misc"] = {
	["sesenable"] = true,								-- Enable Specswitcher
	["sesenablegear"] = true,							-- Enable Gear
	["sesset1"] = 1,									-- Gearset for Primary Spec
	["sesset2"] = 2,									-- Gearset for Secondary Spec
	["sesgearswap"] = true,								-- Enable automatic gearswap @respec
	["sescastbar"] = true,								-- Enable castbar @specswitcher
	["npdebuff"] = true,								-- enable Debuffdisplay on nameplates
	["rbf"] = true,										-- enable raidbuffreminder
	["bossicons"] = true,								-- enable alternative Bossportraits
	["rbfmouseover"] = true,							-- enable mouseover for RaidBuff Reminder
	["swingtimerenable"] = false,						-- enable ouf_Swing Swingtimer Plugin (movable bar)
	["swingtimerwidth"] = 210,							-- bar width
	["swingtimerheight"] = 6,							-- bar height
	["swingtimercolor"] = {1, 0, 0, 0.8},				-- bar color
	["sComboenable"] = true,							-- Enable sCombo-Addon for combopoints instead of default cp-display
	["sComboenergybar"] = false,						-- show energy-Bar below cp bar
}

C["skins"] = {
	["background"] = false,								-- Create a Panel that has the exactly same size as the left chat, placed at the bottomright (for addon placement)
		["combat_toggle"] = false,						-- Shows the Addon Background, Omen, Recount & Skada infight, hides outfight
	["Recount"] = true,									-- Enable Recount Skin
	["Skada"] = true,									-- Enable Skada Skin
	["Omen"] = true,									-- Enable Omen Skin
	["BigWigs"] = true,									-- Enable BigWigs Skin
	["DXE"] = true,										-- Enable DXE Skin
	["TinyDPS"] = true,									-- Enable TinyDPS Skin
	["Quartz"] = true,									-- Enable Quartz Skin
	["DBM"] = true,										-- Enable DBM Skin
	["bskins"] = true,									-- Enable the Skinning for Blizzardframes
	["itemborder"] = true, 								-- Enable Qualityborder for Items on Character / Inspectframe
}

C["sCombo"] = {
	
}

C["classtimer"] = {
	["targetdebuffs"] = false,							-- target debuffs above target (looks crappy imo)
	["playercolor"] = {.2, .2, .2, 1 },
	["targetbuffcolor"] = { 70/255, 150/255, 70/255, 1 },
	["targetdebuffcolor"] = { 150/255, 30/255, 30/255, 1 },
	["trinketcolor"] = {75/255, 75/255, 75/255, 1 },
}

C["auras"] = {
	["player"] = true,                                  -- enable tukui buffs/debuffs
}

C["bags"] = {
	["enable"] = true,                                  -- enable an all in one bag mod that fit tukui perfectly
	["moveable"] = true,								-- enable to move your bags
	["transparent"] = false,							-- enable transparent for bags
}

C["map"] = {
	["enable"] = true,                                  -- reskin the map to fit tukui
}

C["loot"] = {
	["lootframe"] = true,                               -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,                           -- reskin the roll frame to fit tukui
	["autogreed"] = true,                               -- auto-dez or auto-greed item at max level, auto-greed Frozen orb
}

C["cooldown"] = {
	["enable"] = true,                                  -- do i really need to explain this?
	["treshold"] = 8,                                   -- show decimal under X seconds and text turn red
}

C["tb"] = {
	["chattab"] = true,									-- Set Threatbarpoint to TukuiInfoRight
}

C["datatext"] = {
	["classcolored"] = false,							-- classcolored datatext
		["color"] = { 0.4, 0.4, 0.4 },				-- datatext color (if classcolored = false) -- 0.15, 0.49, 0.69
	["zonepanel"] = false,								-- Show Panel with ur current Zone instead of mouseover on minimap
	["mmenu"] = 0,										-- shows mMenu datatext (required: mMenu AddOn)
	["experience"] = 0,
	["reputation"] = 5,
	["honor"] = 0,
	["honorablekills"] = 0,
	
	["fps_ms"] = 2,                                     -- show fps and ms on panels
	["system"] = 0,                                     -- show total memory and others systems infos on panels
	["bags"] = 0,                                       -- show space used in bags on panels
	["gold"] = 6,                                       -- show your current gold on panels
	["wowtime"] = 8,                                    -- show time on panels
	["guild"] = 1,                                      -- show number on guildmate connected on panels
	["dur"] = 4,                                        -- show your equipment durability on panels.
	["friends"] = 3,                                    -- show number of friends connected.
	["dps_text"] = 0,                                   -- show a dps meter on panels
	["hps_text"] = 0,                                   -- show a heal meter on panels
	["power"] = 7,                                      -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 0,                                      -- show your haste rating on panels.
	["crit"] = 0,                                       -- show your crit rating on panels.
	["avd"] = 0,                                        -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                                      -- show your armor value against the level mob you are currently targeting
	["currency"] = 0,                                   -- show your tracked currency on panels.
	["hit"] = 0,										-- show your current hit rating on panels.
	["mastery"] = 0,									-- show your current mastery rating on panels.
	["micromenu"] = 0,									-- Micromenu on panels (toggle the same menu as on minimap).
	["regen"] = 0,										-- show your manaregen
	["calltoarms"] = 0,									-- show Call to Arms
	["profession"] = 0,									-- show Professions
	["block"] = 0,										-- show Block %
	["parry"] = 0,										-- show Parry Chance
	["dodge"] = 0,										-- show Dodge Chance

	["battleground"] = true,                            -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = true,                                  -- set time to 24h format.
	["localtime"] = false,                              -- set time to local time instead of server time.
	["font"] = [[Interface\AddOns\Tukui\medias\fonts\uf_font.ttf]],
	["fontsize"] = 8,                                  -- font size for panels.
}

C["chat"] = {
	["leftchatbackground"] = true,						-- attached to ChatFrame1
	["rightchatbackground"] = true,						-- attached to ChatFrameX
		["rightchatnumber"] = 4,						-- Rightchat-background is attached to ChatFrameX ..X = value
		["rightchatalign"] = true,						-- Set align of right chatframe to left or right
	["fading"] = true,									-- Enable Fading
	
	["enable"] = true,                                  -- blah
	["whispersound"] = true,                            -- play a sound when receiving whisper
}

C["nameplate"] = {
	["enable"] = true,                                  -- enable nice skinned nameplates that fit into tukui
	["overlap"] = true,									-- allows to overlap nameplates
	["showhealth"] = false,				                -- show health text on nameplate
	["enhancethreat"] = false,			                -- threat features based on if your a tank or not
	["combat"] = false,					                -- only show enemy nameplates in-combat.
	["goodcolor"] = {75/255,  175/255, 76/255},	        -- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},			        -- bad threat color (opposite of above)
	["gtransitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat
	["btransitioncolor"] = {240/255, 154/255, 17/255},	-- threat color when losing threat
}

C["tooltip"] = {
	["showspellid"] = false,

	["enable"] = true,                                  -- true to enable this mod, false to disable
	["hidecombat"] = false,                             -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,                            -- always hide action bar buttons tooltip.
	["hideuf"] = false,                                 -- hide tooltip on unitframes
	["cursor"] = false,                                 -- tooltip via cursor only
	["ilvl"] = true,									-- shows average itemlevel at tooltip
}

C["merchant"] = {
	["sellgrays"] = true,                               -- automaticly sell grays?
	["autorepair"] = true,                              -- automaticly repair?
		["autoguildrepair"] = true,						-- automaticly repair from guild bank is possible
	["sellmisc"] = true,                                -- sell defined items automatically
}

C["error"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
	filter = {                                          -- what messages to not hide
		[INVENTORY_FULL] = true,                        -- inventory is full will not be hidden by default
	},
}

C["invite"] = { 
	["autoaccept"] = true,                              -- auto-accept invite from guildmate and friends.
}

C["buffreminder"] = {
	["enable"] = true,                                  -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = false,                                  -- enable warning sound notification for reminder.
}
