local T, C, L = unpack(Tukui)
if ( C == nil or C["unitframes"] == nil or not C["unitframes"]["enable"] ) then return end

--[[ Configuration functions - DO NOT TOUCH
	id - spell id
	castByAnyone - show if aura wasn't created by player
	color - bar color (nil for default color)
	unitType - 0 all, 1 friendly, 2 enemy
	castSpellId - fill only if you want to see line on bar that indicates if its safe to start casting spell and not clip the last tick, also note that this can be different from aura id 
]]--
local CreateSpellEntry = function( id, castByAnyone, color, unitType, castSpellId )
	return { id = id, castByAnyone = castByAnyone, color = color, unitType = unitType or 0, castSpellId = castSpellId };
end

-- Configuration starts here:
local targetdebuffs = C.classtimer.targetdebuffs -- display target debuffs above target
local BAR_HEIGHT = 15						-- Bar height
local BAR_SPACING = 1						-- Distance between bars
local SPARK = false							-- Show spark
local CAST_SEPARATOR = true					-- Show cast separator
local CAST_SEPARATOR_COLOR = { 0, 0, 0, .5 } -- Sets cast separator color
local TEXT_MARGIN = 5						-- Sets distance between right edge of bar and name and left edge of bar and time left

MASTER_FONT = { C["media"].uffont, C.unitframes.fontsize }; -- Sets font for all texts
STACKS_FONT = { C["media"].uffont, C.unitframes.fontsize , "THINOUTLINE"}; -- Sets font for stack count

local PERMANENT_AURA_VALUE = 1				-- Permanent aura bars 1 = filled 0 = empty

local PLAYER_BAR_COLOR = C["classtimer"].playercolor -- Player bar color
local PLAYER_DEBUFF_COLOR = nil -- Player debuff color
local TARGET_BAR_COLOR = C["classtimer"].targetbuffcolor --Target bar color
local TARGET_DEBUFF_COLOR = C["classtimer"].targetdebuffcolor --Target debuff color
local TRINKET_BAR_COLOR = C["classtimer"].trinketcolor --Trinket bar color

local SORT_DIRECTION = true -- Sort direction (true - descending, false - ascending)
local TENTHS_TRESHOLD = 1 -- Timer tenths threshold - range from 1 to 60

-- Trinket filter - mostly for trinket procs, delete or wrap into comment block --[[  ]] if you dont want to track those
local TRINKET_FILTER = {
		
		--Enchants
		CreateSpellEntry( 74221 ), -- Hurricane
		CreateSpellEntry( 74241 ), -- Power Torrent
		
		--Proccs
		CreateSpellEntry( 2825, true ), CreateSpellEntry( 32182, true ), CreateSpellEntry( 80353, true), -- Bloodlust/Heroism/Timewarp
		CreateSpellEntry( 90355, true ), -- Ancient Hysteria, bloodlust from hunters pet
		CreateSpellEntry( 26297 ), -- Berserking (troll racial)
		CreateSpellEntry( 33702 ), CreateSpellEntry( 33697 ), CreateSpellEntry( 20572 ), -- Blood Fury (orc racial)
		CreateSpellEntry( 57933 ), -- Tricks of Trade (15% dmg buff)
		CreateSpellEntry( 91810 ), -- License to Slay stacks
		CreateSpellEntry( 91832 ), -- Fury of Angerforge stacks
		
		-- Racials
		CreateSpellEntry( 65116 ), -- Stoneform (Dwarf)
		CreateSpellEntry( 59752 ), -- Every Man for Himself (Human)
		CreateSpellEntry( 57901 ), -- Gift of the Naaru (Draenei)
		CreateSpellEntry( 68992 ), -- Darkflight (Worgen)
		CreateSpellEntry( 7744 ), -- Will of the Forsaken (Undead)
		CreateSpellEntry( 20577 ), -- Cannibalize (Undead)
		CreateSpellEntry( 26297 ), -- Berserking (Troll)
		CreateSpellEntry( 20572 ), -- Blood Fury for Attack Power (Orc)
		CreateSpellEntry( 33702 ), -- Blood Fury for Spell Power (Orc)
		CreateSpellEntry( 33697 ), -- Blood Fury for Both (Orc)
		
		--Baradin
		CreateSpellEntry( 91047 ), -- Stump of Time
		CreateSpellEntry( 91828 ), -- Thrill for Victory
		CreateSpellEntry( 92222 ), -- Image of Immortality
		
		--Darkmoon Cards
		CreateSpellEntry( 89181 ), -- Earthquake
		CreateSpellEntry( 89182 ), -- Tsunami
		CreateSpellEntry( 89091 ), -- Volcano
		
		-- Blackwing Descent
		CreateSpellEntry( 91322 ), CreateSpellEntry( 92331 ), -- Jar of Ancient Remedies Normal
		CreateSpellEntry( 91007 ), CreateSpellEntry( 92318 ), -- Bell of Enraging Reasonance
		CreateSpellEntry( 91816 ), CreateSpellEntry( 92345 ), -- Heart of Rage
		CreateSpellEntry( 92235 ), CreateSpellEntry( 92355 ), -- Symbiotic Worm
		
		--The Bastion of Twilight
		CreateSpellEntry( 92126 ), CreateSpellEntry( 92351 ), -- Essence of the Cyclone Normal
		CreateSpellEntry( 91184 ), CreateSpellEntry( 92332 ), -- Fall of mortality
		CreateSpellEntry( 92213 ), CreateSpellEntry( 92357 ), -- Vial of Stolen Memories
		CreateSpellEntry( 91024 ), CreateSpellEntry( 92320 ), -- Theralion's Mirror
		CreateSpellEntry( 91821 ), CreateSpellEntry( 92342 ), -- Crushing Weight
		CreateSpellEntry( 91027 ), CreateSpellEntry( 92236 ), -- Heart of Ignacious Stacks
		CreateSpellEntry( 91041 ), CreateSpellEntry( 92328 ), -- Heart of Ignacious on use
		
		--Firelands
		CreateSpellEntry( 96908 ), CreateSpellEntry( 97121 ), -- Jaws of Defeat
		CreateSpellEntry( 96976 ), CreateSpellEntry( 97138 ), -- Matrix Restabilizer
		CreateSpellEntry( 96962 ), CreateSpellEntry( 97131 ), -- Necromantic Focus
		CreateSpellEntry( 96945 ), CreateSpellEntry( 97129 ), -- Spidersilk Spindle
		CreateSpellEntry( 96911 ), CreateSpellEntry( 97125 ), -- The Hungerer
		CreateSpellEntry( 96887 ), CreateSpellEntry( 97119 ), -- Variable Pulse Lightning Capacitor [Needs Buff-SpellID]
		CreateSpellEntry( 96980 ), CreateSpellEntry( 97142 ), -- Vessel of Acceleration
		CreateSpellEntry( 96927 ), CreateSpellEntry( 96928 ), CreateSpellEntry( 96929 ), -- Blessing of the Shaper (normal)
		CreateSpellEntry( 96923 ), -- Titanic Power
		CreateSpellEntry( 96881 ), -- Scales of Life
		
		--Molten Front
		CreateSpellEntry( 100403 ), -- Moonwell Chalice
		
		---------------
		--T-Set Procs--
		---------------		
		--DeathKnight
		CreateSpellEntry( 90507 ), -- DPS set T11
		CreateSpellEntry( 98971 ), -- Smoldering Rune DPS set T12
		
		--Druid
		CreateSpellEntry( 90159 ), -- Resto T11
		CreateSpellEntry( 90163 ), -- Moonkin T11
		CreateSpellEntry( 90165 ), -- Feral T11
		
		--Hunter
		CreateSpellEntry( 99058 ), -- Flaming Arrow T12
		CreateSpellEntry( 99060 ), -- Burning Adrenaline T12
		
		--Mage
		CreateSpellEntry( 99063), -- Mirror Image T12
		
		--Paladin
		CreateSpellEntry( 90311 ), -- Holy T11
		CreateSpellEntry( 99069 ), -- Holy T12
		
		--Priest
		CreateSpellEntry( 89911 ), -- Holy/Disc T11
		CreateSpellEntry( 99132 ), -- Holy Disc Divine Fire T12
		CreateSpellEntry( 99136 ), -- Holy Disc Cauterizing Flame T12
		CreateSpellEntry( 99157 ), -- Shadow Dark Flames T12
		
		--Rogue
		CreateSpellEntry( 90472 ), -- T11
		CreateSpellEntry( 99175 ), -- T12
		
		--Shaman
		CreateSpellEntry( 90498 ), -- Resto T11
		CreateSpellEntry( 99189 ), -- Resto T11
		
		--Warlock
		CreateSpellEntry( 89937 ), -- T11
		CreateSpellEntry( 99221 ), -- Fiery Imp T12
		CreateSpellEntry( 99232 ), -- Apocalypse T12
		
		--Warrior
		CreateSpellEntry( 90294 ), -- DPS T11
		CreateSpellEntry( 99233 ), -- DPS Burning Rage T12
	};
	
local CLASS_FILTERS = {
		DEATHKNIGHT = { 
			target = {
				CreateSpellEntry( 55095 ), -- Frost Fever
				CreateSpellEntry( 55078 ), -- Blood Plague
				CreateSpellEntry( 81130 ), -- Scarlet Fever
				CreateSpellEntry( 50536 ), -- Unholy Blight
				CreateSpellEntry( 65142 ), -- Ebon Plague
				CreateSpellEntry( 51714 ), -- Razorice
				CreateSpellEntry( 98957 ), -- Burning Blood Tank T12
			},
			player = {
				CreateSpellEntry( 59052 ), -- Freezing Fog
				CreateSpellEntry( 51124 ), -- Killing Machine
				CreateSpellEntry( 49016 ), -- Unholy Frenzy
				CreateSpellEntry( 57330 ), -- Horn of Winter
				CreateSpellEntry( 70654 ), -- Blood Armor
				CreateSpellEntry( 77535 ), -- Blood Shield
				CreateSpellEntry( 55233 ), -- Vampiric Blood
				CreateSpellEntry( 81141 ), -- Blood Swarm
				CreateSpellEntry( 45529 ), -- Blood Tap
				CreateSpellEntry( 49222 ), -- Bone sheild
				CreateSpellEntry( 48792 ), -- Ice Bound Fortitude
				CreateSpellEntry( 49028 ), -- Dancing Rune Weapon
				CreateSpellEntry( 51271 ), -- Pillar of Frost
				CreateSpellEntry( 48707 ), -- Anti-Magic Shell
			},
			procs = {
				CreateSpellEntry( 53365 ), -- Unholy Strength
				CreateSpellEntry( 64856 ), -- Blade barrier
				CreateSpellEntry( 70657 ), -- Advantage
				CreateSpellEntry( 81340 ), -- Sudden Doom
			}		
		},
		DRUID = { 
			target = { 
				CreateSpellEntry( 48438 ), -- Wild Growth
				CreateSpellEntry( 774 ), -- Rejuvenation
				CreateSpellEntry( 8936, false, nil, nil, 8936 ), -- Regrowth
				CreateSpellEntry( 33763 ), -- Lifebloom
				CreateSpellEntry( 5570 ), -- Insect Swarm
				CreateSpellEntry( 8921 ), -- Moonfire
				CreateSpellEntry( 339 ), -- Entangling Roots
				CreateSpellEntry( 33786 ), -- Cyclone
				CreateSpellEntry( 2637 ), -- Hibernate
				CreateSpellEntry( 2908 ), -- Soothe
				CreateSpellEntry( 50259 ), -- Feral Charge (Cat) - daze
				CreateSpellEntry( 45334 ), -- Feral Charge (Bear) - immobilize
				CreateSpellEntry( 58180 ), -- Infected Wounds
				CreateSpellEntry( 6795 ), -- Growl
				CreateSpellEntry( 5209 ), -- Challenging Roar
				CreateSpellEntry( 99 ), -- Demoralizing Roar
				CreateSpellEntry( 33745 ), -- Lacerate
				CreateSpellEntry( 5211 ), -- Bash
				CreateSpellEntry( 80964 ), -- Skull Bash (Bear)
				CreateSpellEntry( 80965 ), -- Skull Bash (Cat)
				CreateSpellEntry( 22570 ), -- Maim
				CreateSpellEntry( 1822 ), -- Rake
				CreateSpellEntry( 1079 ), -- Rip
				CreateSpellEntry( 33878, true ), -- Mangle (Bear)
				CreateSpellEntry( 33876, true ), -- Mangle (Cat)
				CreateSpellEntry( 9007 ), -- Pounce bleed
				CreateSpellEntry( 9005 ), -- Pounce stun
				CreateSpellEntry( 16857, true ), -- Faerie Fire (Feral)
				CreateSpellEntry( 770, true ), -- Farie Fire
				CreateSpellEntry( 91565, true), -- Farie Fire? :>
				CreateSpellEntry( 467 ), -- Thorns
				CreateSpellEntry( 78675 ), -- Solar Beam
				CreateSpellEntry( 93402 ), -- Sunfire
			},
			player = {
				CreateSpellEntry( 48505 ), -- Starfall
				CreateSpellEntry( 29166 ), -- Innervate
				CreateSpellEntry( 22812 ), -- Barkskin
				CreateSpellEntry( 5215 ), -- Prowl
				CreateSpellEntry( 16689 ), -- Nature's Grasp
				CreateSpellEntry( 17116 ), -- Nature's Swiftness
				CreateSpellEntry( 5229 ), -- Enrage
				CreateSpellEntry( 52610 ), -- Savage Roar
				CreateSpellEntry( 5217 ), -- Tiger's Fury
				CreateSpellEntry( 1850 ), -- Dash
				CreateSpellEntry( 22842 ), -- Frenzied Regeneration
				CreateSpellEntry( 50334 ), -- Berserk
				CreateSpellEntry( 61336 ), -- Survival Instincts
				CreateSpellEntry( 48438 ), -- Wild Growth
				CreateSpellEntry( 774 ), -- Rejuvenation
				CreateSpellEntry( 8936, false, nil, nil, 8936 ), -- Regrowth
				CreateSpellEntry( 33763 ), -- Lifebloom
				CreateSpellEntry( 467 ), -- Thorns
				CreateSpellEntry( 80951 ), -- Pulverize
				CreateSpellEntry( 16870 ), -- Clearcasting
			},
			procs = {
				CreateSpellEntry( 48518 ), -- Eclipse Lunar
				CreateSpellEntry( 48517 ), -- Eclipse Solar
				CreateSpellEntry( 69369 ), -- Predator's Swiftness
				CreateSpellEntry( 93400 ), -- Shooting Stars
				CreateSpellEntry( 81006 ), CreateSpellEntry( 81191 ), CreateSpellEntry( 81192 ), -- Lunar Shower Rank 1/2/3
				CreateSpellEntry( 16880 ), CreateSpellEntry( 61345 ), CreateSpellEntry( 61346 ), -- Nature's Grace Rank 1/2/3
			},
		},
		HUNTER = { 
			target = {
				CreateSpellEntry( 49050 ), -- Aimed Shot
				CreateSpellEntry( 1978 ), -- Serpent Sting
				CreateSpellEntry( 53238 ), -- Piercing Shots
				CreateSpellEntry( 3674 ), -- Black Arrow
				CreateSpellEntry( 82654 ), -- Widow Venom
				CreateSpellEntry( 34490 ), -- Silencing Shot
				CreateSpellEntry( 37506 ), -- Scatter Shot
				CreateSpellEntry( 88691 ), -- Marker for death
				CreateSpellEntry( 1130, true ), -- Hunters mark
			},
			player = {
				CreateSpellEntry( 82749 ), -- killing streak
				CreateSpellEntry( 3045 ), -- Rapid Fire
				CreateSpellEntry( 34471 ), --The beast within
				CreateSpellEntry( 53434 ), --call of the wild
				CreateSpellEntry( 64418 ), CreateSpellEntry( 64419 ), CreateSpellEntry( 64420 ), -- Sniper Training Rank 1/2/3
			},
			procs = {
				CreateSpellEntry( 53257 ), -- cobra strikes 
				CreateSpellEntry( 6150 ), -- Quick Shots
				CreateSpellEntry( 56453 ), -- Lock and Load
				CreateSpellEntry( 82692 ), --Focus Fire
				CreateSpellEntry( 35099 ), --Rapid Killing Rank 2
				CreateSpellEntry( 53220 ), -- Improved Steadyshot
				CreateSpellEntry( 89388 ), -- sic'em
				CreateSpellEntry( 94007 ), -- Killing Streak
				CreateSpellEntry( 70893 ), -- Culling the herd
				CreateSpellEntry( 82925 ), --Ready, Set, Aim
				CreateSpellEntry( 82926 ), --Fire
			},
		},
		MAGE = {
			target = { 
				CreateSpellEntry( 44457 ), -- Living Bomb
				CreateSpellEntry( 118 ), -- Polymorph
				CreateSpellEntry( 28271 ), -- Polymorph Turtle
				CreateSpellEntry( 31589 ), -- Slow
				CreateSpellEntry( 116 ), -- Frostbolt
				CreateSpellEntry( 120 ), -- Cone of Cold
				CreateSpellEntry( 122 ), -- Frost Nova
				CreateSpellEntry( 44614 ), -- Frostfire Bolt
				CreateSpellEntry( 92315 ), -- Pyroblast!
				CreateSpellEntry( 12654 ), -- Ignite
				CreateSpellEntry( 22959 ), -- Critical Mass
				CreateSpellEntry( 83853 ), -- Combustion
				CreateSpellEntry( 31661 ), -- Dragon's Breath
				CreateSpellEntry( 83154 ), -- Piercing Chill
				CreateSpellEntry( 44572 ), -- Deep Freeze
				CreateSpellEntry( 11113 ), -- Blast Wave
				CreateSpellEntry( 82691 ), -- Ring of Frost
				CreateSpellEntry( 12355 ), -- Impact
			},
			player = {
				CreateSpellEntry( 36032 ), -- Arcane Blast
				CreateSpellEntry( 12042 ), -- Arcane Power
				CreateSpellEntry( 32612 ), -- Invisibility
				CreateSpellEntry( 1463 ), -- Mana Shield
				CreateSpellEntry( 543 ), -- Mage Ward
				CreateSpellEntry( 11426 ), -- Ice Barrier
				CreateSpellEntry( 45438 ), -- Ice Block
				CreateSpellEntry( 12472 ), -- Icy Veins
				CreateSpellEntry( 130 ), -- Slow Fall
				CreateSpellEntry( 57761 ), -- Brain Freeze
				CreateSpellEntry( 12536 ), -- Clearcasting
			},
			procs = {
				CreateSpellEntry( 44544 ), -- Fingers of Frost
				CreateSpellEntry( 79683 ), -- Arcane Missiles!
				CreateSpellEntry( 48108 ), -- Hot Streak
				CreateSpellEntry( 64343 ), -- Impact
				CreateSpellEntry( 83582 ), -- Pyromaniac
			},
		},
		PALADIN = { 
			target = {
				CreateSpellEntry( 31803 ), -- Censure --
				CreateSpellEntry( 20066 ), -- Repentance --
				CreateSpellEntry( 853 ), -- Hammer of Justice --
				CreateSpellEntry( 31935 ), -- Avenger's Shield --
				CreateSpellEntry( 20170 ), -- Seal of Justice --
				CreateSpellEntry( 26017 ), -- Vindication --
				CreateSpellEntry( 68055 ), -- Judgements of the Just --
				CreateSpellEntry( 86273 ), -- Illuminated Healing
			},
			player = {
				CreateSpellEntry( 642 ), -- Divine Shield
				CreateSpellEntry( 31850 ), -- Ardent Defender
				CreateSpellEntry( 498 ), -- Divine Protection
				CreateSpellEntry( 31884 ), -- Avenging Wrath
				CreateSpellEntry( 85696 ), -- Zealotry
				CreateSpellEntry( 25771 ), -- Debuff: Forbearance
				CreateSpellEntry( 1044 ), -- Hand of Freedom
				CreateSpellEntry( 1022 ), -- Hand of Protection
				CreateSpellEntry( 1038 ), -- Hand of Salvation
				CreateSpellEntry( 53657 ), -- Judgements of the Pure
				CreateSpellEntry( 53563 ), -- Beacon of Light
				CreateSpellEntry( 31821 ), -- Aura Mastery
				CreateSpellEntry( 54428 ), -- Divine Plea
				CreateSpellEntry( 31482 ), -- Divine Favor
				CreateSpellEntry( 6940 ), -- Hand of Sacrifice
				CreateSpellEntry( 84963 ), -- Inquisition
			},
			procs = {
				CreateSpellEntry( 59578 ), -- The Art of War
				CreateSpellEntry( 90174 ), -- Hand of Light
				CreateSpellEntry( 71396 ), -- Rage of the Fallen		
				CreateSpellEntry( 53672 ), CreateSpellEntry( 54149 ), -- Infusion of Light (Rank1/Rank2)
				CreateSpellEntry( 85496 ), -- Speed of Light
				CreateSpellEntry( 88819 ), -- Daybreak
				CreateSpellEntry( 20050 ), CreateSpellEntry( 20052 ), CreateSpellEntry( 20053 ), -- Conviction (Rank1/Rank2/Rank3)
			},
		},
		PRIEST = { 
			target = { 
				CreateSpellEntry( 17 ), -- Power Word: Shield
				CreateSpellEntry( 6788, true, nil, 1 ), -- Weakened Soul
				CreateSpellEntry( 139 ), -- Renew
				CreateSpellEntry( 33076 ), -- Prayer of Mending
				CreateSpellEntry( 552 ), -- Abolish Disease
				CreateSpellEntry( 63877 ), -- Pain Suppression
				CreateSpellEntry( 34914, false, nil, nil, 34914 ), -- Vampiric Touch
				CreateSpellEntry( 589 ), -- Shadow Word: Pain
				CreateSpellEntry( 2944 ), -- Devouring Plague
				CreateSpellEntry( 48153 ), -- Guardian Spirit
				CreateSpellEntry( 77489 ), -- Echo of Light
			},
			player = {
				CreateSpellEntry( 96219 ), -- Strength of Soul (silence immun)
				CreateSpellEntry( 89489 ), -- priest slow immun
				CreateSpellEntry( 139 ), -- Renew
				CreateSpellEntry( 10060 ), -- Power Infusion
				CreateSpellEntry( 47585 ), -- Dispersion
				CreateSpellEntry( 81700 ), -- Archangel
				CreateSpellEntry( 14751 ), -- Chakra
				CreateSpellEntry( 81208 ), -- Chakra Heal
				CreateSpellEntry( 81207 ), -- Chakra Renew
				CreateSpellEntry( 81209 ), -- Chakra Smite
				CreateSpellEntry( 81206 ), -- Prayer of Healing
			},
			procs = {
				CreateSpellEntry( 63735 ), -- Serendipity
				CreateSpellEntry( 88690 ), -- Surge of Light
				CreateSpellEntry( 77487 ), -- Shadow Orb
				CreateSpellEntry( 71572 ), -- Cultivated Power
				CreateSpellEntry( 81661 ), -- Evangelism
				CreateSpellEntry( 72418 ), -- Kuhlendes Wissen
				CreateSpellEntry( 71584 ), -- Revitalize
				CreateSpellEntry( 59888 ), -- Borrowed Time
				CreateSpellEntry( 95799 ), -- Empowered Shadow
			},
		},
		ROGUE = { 
			target = { 
				CreateSpellEntry( 1833 ), -- Cheap Shot
				CreateSpellEntry( 408 ), -- Kidney Shot
				CreateSpellEntry( 1776 ), -- Gouge
				CreateSpellEntry( 2094 ), -- Blind
				CreateSpellEntry( 8647 ), -- Expose Armor
				CreateSpellEntry( 51722 ), -- Dismantle
				CreateSpellEntry( 2818 ), -- Deadly Poison
				CreateSpellEntry( 13218 ), -- Wound Posion
				CreateSpellEntry( 3409 ),  -- Crippling Poison 
				CreateSpellEntry( 5760 ), -- Mind-Numbing Poison
				CreateSpellEntry( 6770 ), -- Sap
				CreateSpellEntry( 1943 ), -- Rupture
				CreateSpellEntry( 703 ), -- Garrote
				CreateSpellEntry( 79140 ), -- vendetta
				CreateSpellEntry( 16511 ), -- Hemorrhage
				CreateSpellEntry( 84745 ), -- Shallow Insight
				CreateSpellEntry( 84746 ), -- Moderate Insight
				CreateSpellEntry( 84747 ), -- Deep Insight
			},
			player = {
				CreateSpellEntry( 13750 ), -- adrenalin stuff
				CreateSpellEntry( 32645 ), -- Envenom
				CreateSpellEntry( 2983 ), -- Sprint
				CreateSpellEntry( 5277 ), -- Evasion
				CreateSpellEntry( 1776 ), -- Gouge
				CreateSpellEntry( 51713 ), -- Shadow Dance
				CreateSpellEntry( 1966 ), -- Feint
				CreateSpellEntry( 73651 ), -- Recuperate
				CreateSpellEntry( 5171 ), -- Slice and Dice
				CreateSpellEntry( 55503 ), -- Lifeblood
				CreateSpellEntry( 13877 ), -- Blade Flurry
				CreateSpellEntry( 74001 ), -- Combat Readiness
			},
			procs = {
				CreateSpellEntry( 71396 ), -- Rage of the Fallen
			},
		},
		SHAMAN = {
			target = {
				CreateSpellEntry( 974 ), -- Earth Shield
				CreateSpellEntry( 8050), -- Flame Shock
				CreateSpellEntry( 8056 ), -- Frost Shock
				CreateSpellEntry( 17364 ), -- Storm Strike
				CreateSpellEntry( 61295 ), -- Riptide
				CreateSpellEntry( 51945 ), -- Earthliving
				CreateSpellEntry( 77657 ), -- Searing Flames
				CreateSpellEntry( 64701 ), -- Elemental Mastery
				CreateSpellEntry( 77661 ), -- Searing Flame
			},
				player = {
				CreateSpellEntry( 324 ), -- Lightning Shield
				CreateSpellEntry( 52127 ), -- Water Shield
				CreateSpellEntry( 974 ), -- Earth Shield
				CreateSpellEntry( 30823 ), -- Shamanistic Rage
				CreateSpellEntry( 55198 ), -- Tidal Force
				CreateSpellEntry( 61295 ), -- Riptide
				CreateSpellEntry( 51562 ), CreateSpellEntry( 51563 ), CreateSpellEntry( 51564 ), -- Tidal Waves Rank 1/2/3
			},
			procs = {
				CreateSpellEntry( 53817 ), -- Maelstrom Weapon
				CreateSpellEntry( 16246 ), -- Clearcasting				
			},
		},
		WARLOCK = {
			target = {
				CreateSpellEntry( 980 ), -- Bane of Agony
				CreateSpellEntry( 603 ), -- Bane of Doom
				CreateSpellEntry( 80240 ), -- Bane of Havoc
				CreateSpellEntry( 1490 ), -- Curse of the Elements
				CreateSpellEntry( 86105 ), -- Jinx: Curse of the Elements
				CreateSpellEntry( 18223 ), -- Curse of Exhaustion
				CreateSpellEntry( 1714 ), -- Curse of Tongue
				CreateSpellEntry( 702 ), -- Curse of Weakness
				CreateSpellEntry( 172 ), -- Corruption
				CreateSpellEntry( 27243, false, nil, nil, 27243 ), -- Seed of Corruption
				CreateSpellEntry( 48181, false, nil, nil, 48181 ), -- Haunt
				CreateSpellEntry( 32389 ), -- Shadow Embrace
				CreateSpellEntry( 30108, false, nil, nil, 30108 ), -- Unstable Affliction
				CreateSpellEntry( 348, false, nil, nil, 348 ), -- Immolate
				CreateSpellEntry( 5782 ), -- Fear
				CreateSpellEntry( 710 ), -- Banish
				CreateSpellEntry( 5484 ), -- Howl of Terror
				CreateSpellEntry( 6789 ), -- Deathcoil
				CreateSpellEntry( 17800 ), -- Shadow & Flame
			},
				player = {
				CreateSpellEntry( 17941 ), -- Shadow Trance
				CreateSpellEntry( 64371 ), -- Eradication
				CreateSpellEntry( 85383 ), -- Improved Soul Fire
				CreateSpellEntry( 79459 ),  CreateSpellEntry( 79463 ),  CreateSpellEntry( 79460 ),  CreateSpellEntry( 79462 ),  CreateSpellEntry( 79464 ), -- Demon Soul
			},
			procs = {
				CreateSpellEntry( 86121 ), -- Soul Swap
				CreateSpellEntry( 54274 ), CreateSpellEntry( 54276 ), CreateSpellEntry( 54277 ), -- Backdraft rank 1/2/3
				CreateSpellEntry( 71165 ), -- Molten Core
				CreateSpellEntry( 63167 ), -- Decimation
				CreateSpellEntry( 47283 ), -- Empowered Imp
			},
		},
		WARRIOR = { 
			target = {
				CreateSpellEntry( 94009 ), -- Rend
				CreateSpellEntry( 12294 ), -- Mortal Strike
				CreateSpellEntry( 1160 ), -- Demoralizing Shout
				CreateSpellEntry( 64382 ), -- Shattering Throw
				CreateSpellEntry( 58567 ), -- Sunder Armor
				CreateSpellEntry( 86346 ), -- Colossus Smash
				CreateSpellEntry( 7922 ), -- Charge (stun)
				CreateSpellEntry( 1715 ), -- Hamstring
				CreateSpellEntry( 50725 ), -- Vigilance
				CreateSpellEntry( 676 ), -- Disarm
				CreateSpellEntry( 29703 ), -- Daze (Shield Bash)
				CreateSpellEntry( 18498 ), -- Gag Order
				CreateSpellEntry( 12809 ), -- Concussion Blow
				CreateSpellEntry( 6343 ), -- Thunderclap
				CreateSpellEntry( 12162 ), CreateSpellEntry( 12850 ), CreateSpellEntry( 12868 ), -- Deep Wounds Rank 1, 2 & 3
			},
			player = {
				CreateSpellEntry( 469 ), -- Commanding Shout
				CreateSpellEntry( 6673 ), -- Battle Shout
				CreateSpellEntry( 55694 ), -- Enraged Regeneration
				CreateSpellEntry( 23920 ), -- Spell Reflection
				CreateSpellEntry( 871 ), -- Shield Wall
				CreateSpellEntry( 1719 ), -- Recklessness
				CreateSpellEntry( 20230 ), -- Retaliation
				CreateSpellEntry( 2565 ), -- Shield Block
				CreateSpellEntry( 12976 ), -- Last Stand
				CreateSpellEntry( 90806 ), -- Executioner
				CreateSpellEntry( 32216 ), -- Victorious (Victory Rush enabled)
				CreateSpellEntry( 12292 ), -- Death Wish
				CreateSpellEntry( 85738 ), CreateSpellEntry( 85739 ), -- Meat Cleaver Rank 1 and 2
				CreateSpellEntry( 86662 ), CreateSpellEntry( 86663 ), -- Rude interruption rank 1 and 2
				CreateSpellEntry( 23885 ), -- Blood Thirst
				CreateSpellEntry( 84584 ), CreateSpellEntry( 84585 ), CreateSpellEntry( 84586 ), -- Slaughter
			},
			procs = {
				CreateSpellEntry( 46916 ), -- Bloodsurge Slam (Free & Instant)
				CreateSpellEntry( 12964 ), -- Battle Trance (Free Special)
				CreateSpellEntry( 86627 ), -- Incite (Auto-crit HStrike)
			},
		},
	};

local CreateUnitAuraDataSource;
do
	local auraTypes = { "HELPFUL", "HARMFUL" };

	-- private
	local CheckFilter = function( self, id, caster, filter )
		if ( filter == nil ) then return false; end
			
		local byPlayer = caster == "player" or caster == "pet" or caster == "vehicle";
			
		for _, v in ipairs( filter ) do
			if ( v.id == id and ( v.castByAnyone or byPlayer ) ) then return v; end
		end
		
		return false;
	end
	
	local CheckUnit = function( self, unit, filter, result )
		if ( not UnitExists( unit ) ) then return 0; end

		local unitIsFriend = UnitIsFriend( "player", unit );

		for _, auraType in ipairs( auraTypes ) do
			local isDebuff = auraType == "HARMFUL";
		
			for index = 1, 40 do
				local name, _, texture, stacks, _, duration, expirationTime, caster, _, _, spellId = UnitAura( unit, index, auraType );		
				if ( name == nil ) then
					break;
				end							
				
				local filterInfo = CheckFilter( self, spellId, caster, filter );
				if ( filterInfo and ( filterInfo.unitType ~= 1 or unitIsFriend ) and ( filterInfo.unitType ~= 2 or not unitIsFriend ) ) then 					
					filterInfo.name = name;
					filterInfo.texture = texture;
					filterInfo.duration = duration;
					filterInfo.expirationTime = expirationTime;
					filterInfo.stacks = stacks;
					filterInfo.unit = unit;
					filterInfo.isDebuff = isDebuff;
					table.insert( result, filterInfo );
				end
			end
		end
	end

	-- public 
	local Update = function( self )
		local result = self.table;

		for index = 1, #result do
			table.remove( result );
		end				

		CheckUnit( self, self.unit, self.filter, result );
		if ( self.includePlayer ) then
			CheckUnit( self, "player", self.playerFilter, result );
		end
		
		self.table = result;
	end

	local SetSortDirection = function( self, descending )
		self.sortDirection = descending;
	end
	
	local GetSortDirection = function( self )
		return self.sortDirection;
	end
	
	local Sort = function( self )
		local direction = self.sortDirection;
		local time = GetTime();
	
		local sorted;
		repeat
			sorted = true;
			for key, value in pairs( self.table ) do
				local nextKey = key + 1;
				local nextValue = self.table[ nextKey ];
				if ( nextValue == nil ) then break; end
				
				local currentRemaining = value.expirationTime == 0 and 4294967295 or math.max( value.expirationTime - time, 0 );
				local nextRemaining = nextValue.expirationTime == 0 and 4294967295 or math.max( nextValue.expirationTime - time, 0 );
				
				if ( ( direction and currentRemaining < nextRemaining ) or ( not direction and currentRemaining > nextRemaining ) ) then
					self.table[ key ] = nextValue;
					self.table[ nextKey ] = value;
					sorted = false;
				end				
			end			
		until ( sorted == true )
	end
	
	local Get = function( self )
		return self.table;
	end
	
	local Count = function( self )
		return #self.table;
	end
	
	local AddFilter = function( self, filter, defaultColor, debuffColor )
		if ( filter == nil ) then return; end
		
		for _, v in pairs( filter ) do
			local clone = { };
			
			clone.id = v.id;
			clone.castByAnyone = v.castByAnyone;
			clone.color = v.color;
			clone.unitType = v.unitType;
			clone.castSpellId = v.castSpellId;
			
			clone.defaultColor = defaultColor;
			clone.debuffColor = debuffColor;
			
			table.insert( self.filter, clone );
		end
	end
	
	local AddPlayerFilter = function( self, filter, defaultColor, debuffColor )
		if ( filter == nil ) then return; end

		for _, v in pairs( filter ) do
			local clone = { };
			
			clone.id = v.id;
			clone.castByAnyone = v.castByAnyone;
			clone.color = v.color;
			clone.unitType = v.unitType;
			clone.castSpellId = v.castSpellId;
			
			clone.defaultColor = defaultColor;
			clone.debuffColor = debuffColor;
			
			table.insert( self.playerFilter, clone );
		end
	end
	
	local GetUnit = function( self )
		return self.unit;
	end
	
	local GetIncludePlayer = function( self )
		return self.includePlayer;
	end
	
	local SetIncludePlayer = function( self, value )
		self.includePlayer = value;
	end
	
	-- constructor
	CreateUnitAuraDataSource = function( unit )
		local result = {  };

		result.Sort = Sort;
		result.Update = Update;
		result.Get = Get;
		result.Count = Count;
		result.SetSortDirection = SetSortDirection;
		result.GetSortDirection = GetSortDirection;
		result.AddFilter = AddFilter;
		result.AddPlayerFilter = AddPlayerFilter;
		result.GetUnit = GetUnit; 
		result.SetIncludePlayer = SetIncludePlayer; 
		result.GetIncludePlayer = GetIncludePlayer; 
		
		result.unit = unit;
		result.includePlayer = false;
		result.filter = { };
		result.playerFilter = { };
		result.table = { };
		
		return result;
	end
end

local CreateFramedTexture;
do
	-- public
	local SetTexture = function( self, ... )
		return self.texture:SetTexture( ... );
	end
	
	local GetTexture = function( self )
		return self.texture:GetTexture();
	end
	
	local GetTexCoord = function( self )
		return self.texture:GetTexCoord();
	end
	
	local SetTexCoord = function( self, ... )
		return self.texture:SetTexCoord( ... );
	end
	
	local SetBorderColor = function( self, ... )
		return self.border:SetVertexColor( ... );
	end
	
	-- constructor
	CreateFramedTexture = function( parent )
		local result = parent:CreateTexture( nil, "BACKGROUND", nil );
		local texture = parent:CreateTexture( nil, "OVERLAY", nil );		

		texture:Point( "TOPLEFT", result, "TOPLEFT", 3, -3 );
		texture:Point( "BOTTOMRIGHT", result, "BOTTOMRIGHT", -3, 3 );
			
		result.texture = texture;
		
		result.SetTexture = SetTexture;
		result.GetTexture = GetTexture;
		result.SetTexCoord = SetTexCoord;
		result.GetTexCoord = GetTexCoord;
			
		return result;
	end
end

local CreateAuraBarFrame;
do
	-- classes
	local CreateAuraBar;
	do
		-- private 
		local OnUpdate = function( self, elapsed )	
			local time = GetTime();
		
			if ( time > self.expirationTime ) then
				self.bar:SetScript( "OnUpdate", nil );
				self.bar:SetValue( 0 );
				self.time:SetText( "" );
				
				local spark = self.spark;
				if ( spark ) then			
					spark:Hide();
				end
			else
				local remaining = self.expirationTime - time;
				self.bar:SetValue( remaining );
				
				local timeText = "";
				if ( remaining >= 3600 ) then
					timeText = tostring( math.floor( remaining / 3600 ) ) .. "h";
				elseif ( remaining >= 60 ) then
					timeText = tostring( math.floor( remaining / 60 ) ) .. "m";
				elseif ( remaining > TENTHS_TRESHOLD ) then
					timeText = tostring( math.floor( remaining ) );
				elseif ( remaining > 0 ) then
					timeText = tostring( math.floor( remaining * 10 ) / 10 );
				end
				self.time:SetText( timeText );
				
				local barWidth = self.bar:GetWidth();
				
				local spark = self.spark;
				if ( spark ) then			
					spark:Point( "CENTER", self.bar, "LEFT", barWidth * remaining / self.duration, 0 );
				end
				
				local castSeparator = self.castSeparator;
				if ( castSeparator and self.castSpellId ) then
					local _, _, _, _, _, _, castTime, _, _ = GetSpellInfo( self.castSpellId );

					castTime = castTime / 1000;
					if ( castTime and remaining > castTime ) then
						castSeparator:Point( "CENTER", self.bar, "LEFT", barWidth * ( remaining - castTime ) / self.duration, 0 );
					else
						castSeparator:Hide();
					end
				end
			end
		end
		
		-- public
		local SetIcon = function( self, icon )
			if ( not self.icon ) then return; end
			
			self.icon:SetTexture( icon );
		end
		
		local SetTime = function( self, expirationTime, duration )
			self.expirationTime = expirationTime;
			self.duration = duration;
			
			if ( expirationTime > 0 and duration > 0 ) then		
				self.bar:SetMinMaxValues( 0, duration );
				OnUpdate( self, 0 );
		
				local spark = self.spark;
				if ( spark ) then 
					spark:Show();
				end
		
				self:SetScript( "OnUpdate", OnUpdate );
			else
				self.bar:SetMinMaxValues( 0, 1 );
				self.bar:SetValue( PERMANENT_AURA_VALUE );
				self.time:SetText( "" );
				
				local spark = self.spark;
				if ( spark ) then 
					spark:Hide();
				end
				
				self:SetScript( "OnUpdate", nil );
			end
		end
		
		local SetName = function( self, name )
			self.name:SetText( name );
		end
		
		local SetStacks = function( self, stacks )
			if ( not self.stacks ) then
				if ( stacks ~= nil and stacks > 1 ) then
					local name = self.name;
					
					name:SetText( tostring( stacks ) .. "  " .. name:GetText() );
				end
			else			
				if ( stacks ~= nil and stacks > 1 ) then
					self.stacks:SetText( stacks );
				else
					self.stacks:SetText( "" );
				end
			end
		end
		
		local SetColor = function( self, color )
			self.bar:SetStatusBarColor( unpack( color ) );
		end
		
		local SetCastSpellId = function( self, id )
			self.castSpellId = id;
			
			local castSeparator = self.castSeparator;
			if ( castSeparator ) then
				if ( id ) then
					self.castSeparator:Show();
				else
					self.castSeparator:Hide();
				end
			end
		end
		
		local SetAuraInfo = function( self, auraInfo )
			self:SetName( auraInfo.name );
			self:SetIcon( auraInfo.texture );	
			self:SetTime( auraInfo.expirationTime, auraInfo.duration );
			self:SetStacks( auraInfo.stacks );
			self:SetCastSpellId( auraInfo.castSpellId );
		end
		
		-- constructor
		CreateAuraBar = function( parent )
			local result = CreateFrame( "Frame", nil, parent, nil );		
			local icon = CreateFramedTexture( result, "ARTWORK" );
			icon:SetTexCoord( 0.15, 0.85, 0.15, 0.85 );
			
			local iconAnchor1;
			local iconAnchor2;
			local iconOffset;
			iconAnchor1 = "TOPRIGHT";
			iconAnchor2 = "TOPLEFT";
			iconOffset = -1;	
			
			icon:Point( iconAnchor1, result, iconAnchor2, iconOffset * -5, 3 )
			icon:SetWidth( BAR_HEIGHT + 6 );
			icon:SetHeight( BAR_HEIGHT + 6 );	

			result.icon = icon;
			
			local stacks = result:CreateFontString( nil, "OVERLAY", nil );
			stacks:SetFont( unpack( STACKS_FONT ) );
			stacks:SetShadowColor( 0, 0, 0 );
			stacks:SetShadowOffset( 1.25, -1.25 );
			stacks:SetJustifyH( "RIGHT" );
			stacks:SetJustifyV( "BOTTOM" );
			stacks:Point( "TOPLEFT", icon, "TOPLEFT", 0, 0 );
			stacks:Point( "BOTTOMRIGHT", icon, "BOTTOMRIGHT", -1, 3 );
			result.stacks = stacks;
			
			local bar = CreateFrame( "StatusBar", nil, result, nil );
			bar:SetStatusBarTexture(C["media"].normTex);
			bar:Point( "TOPLEFT", result, "TOPLEFT", 9, 0 );
			bar:Point( "BOTTOMRIGHT", result, "BOTTOMRIGHT", 0, 0 );
			result.bar = bar;
			
			if ( SPARK ) then
				local spark = bar:CreateTexture( nil, "OVERLAY", nil );
				spark:SetTexture( [[Interface\CastingBar\UI-CastingBar-Spark]] );
				spark:SetWidth( 12 );
				spark:SetBlendMode( "ADD" );
				spark:Show();
				result.spark = spark;
			end
			
			if ( CAST_SEPARATOR ) then
				local castSeparator = bar:CreateTexture( nil, "OVERLAY", nil );
				castSeparator:SetTexture( unpack( CAST_SEPARATOR_COLOR ) );
				castSeparator:SetWidth( 1 );
				castSeparator:SetHeight( BAR_HEIGHT );
				castSeparator:Show();
				result.castSeparator = castSeparator;
			end
						
			local name = bar:CreateFontString( nil, "OVERLAY", nil );
			name:SetFont( unpack( MASTER_FONT ) );
			name:SetShadowColor(0, 0, 0)
			name:SetShadowOffset(1.25, -1.25)
			name:SetJustifyH( "LEFT" );
			name:Point( "TOPLEFT", bar, "TOPLEFT", TEXT_MARGIN, 0 );
			name:Point( "BOTTOMRIGHT", bar, "BOTTOMRIGHT", -45, 0 );
			result.name = name;
			
			local time = bar:CreateFontString( nil, "OVERLAY", nil );
			time:SetFont( unpack( MASTER_FONT ) );
			time:SetJustifyH( "RIGHT" );
			time:Point( "LEFT", name, "RIGHT", 0, 0 );
			time:Point( "RIGHT", bar, "RIGHT", -TEXT_MARGIN, 0 );
			result.time = time;
			
			result.SetIcon = SetIcon;
			result.SetTime = SetTime;
			result.SetName = SetName;
			result.SetStacks = SetStacks;
			result.SetAuraInfo = SetAuraInfo;
			result.SetColor = SetColor;
			result.SetCastSpellId = SetCastSpellId;
			
			return result;
		end
	end

	-- private
	local SetAuraBar = function( self, index, auraInfo )
		local line = self.lines[ index ]
		if ( line == nil ) then
			line = CreateAuraBar( self );
			if ( index == 1 ) then
				line:Point( "TOPLEFT", self, "BOTTOMLEFT", 13, BAR_HEIGHT);
				line:Point( "BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0 );
			else
				local anchor = self.lines[ index - 1 ];
				line:Point( "TOPLEFT", anchor, "TOPLEFT", 0, BAR_HEIGHT + BAR_SPACING );
				line:Point( "BOTTOMRIGHT", anchor, "TOPRIGHT", 0, BAR_SPACING );
			end
			tinsert( self.lines, index, line );
		end	
		
		line:SetAuraInfo( auraInfo );
		if ( auraInfo.color ) then
			line:SetColor( auraInfo.color );
		elseif ( auraInfo.debuffColor and auraInfo.isDebuff ) then
			line:SetColor( auraInfo.debuffColor );
		elseif ( auraInfo.defaultColor ) then
			line:SetColor( auraInfo.defaultColor );
		end
		
		line:Show();
	end
	
	local function OnUnitAura( self, unit )
		if ( unit ~= self.unit and ( self.dataSource:GetIncludePlayer() == false or unit ~= "player" ) ) then
			return;
		end
		
		self:Render();
	end
	
	local function OnPlayerTargetChanged( self, method )
		self:Render();
	end
	
	local function OnPlayerEnteringWorld( self )
		self:Render();
	end
	
	local function OnEvent( self, event, ... )
		if ( event == "UNIT_AURA" ) then
			OnUnitAura( self, ... );
		elseif ( event == "PLAYER_TARGET_CHANGED" ) then
			OnPlayerTargetChanged( self, ... );
		elseif ( event == "PLAYER_ENTERING_WORLD" ) then
			OnPlayerEnteringWorld( self );
		else
			error( "Unhandled event " .. event );
		end
	end
	
	-- public
	local function Render( self )
		local dataSource = self.dataSource;	

		dataSource:Update();
		dataSource:Sort();
		
		local count = dataSource:Count();

		for index, auraInfo in ipairs( dataSource:Get() ) do
			SetAuraBar( self, index, auraInfo );
		end
		
		for index = count + 1, 80 do
			local line = self.lines[ index ];
			if ( line == nil or not line:IsShown() ) then
				break;
			end
			line:Hide();
		end
		
		if ( count > 0 ) then
			self:SetHeight( ( BAR_HEIGHT + BAR_SPACING ) * count - BAR_SPACING );
			self:Show();
		else
			self:Hide();
			self:SetHeight( self.hiddenHeight or 1 );
		end
	end
	
	local function SetHiddenHeight( self, height )
		self.hiddenHeight = height;
	end

	-- constructor
	CreateAuraBarFrame = function( dataSource, parent )
		local result = CreateFrame( "Frame", nil, parent, nil );
		local unit = dataSource:GetUnit();
		
		result.unit = unit;
		
		result.lines = { };		
		result.dataSource = dataSource;
		
		local background = CreateFrame( "Frame", nil, result, nil );
		background:SetFrameStrata("BACKGROUND")
		background:Point( "TOPLEFT", result, "TOPLEFT", 20, 2 );
		background:Point( "BOTTOMRIGHT", result, "BOTTOMRIGHT", 2, -2 );
		background:SetTemplate("Transparent")
		background:CreateShadow("Default")
		result.background = background;
		
		local border = CreateFrame( "Frame", nil, result, nil );
		border:SetFrameStrata("BACKGROUND")
		border:Point( "TOPLEFT", result, "TOPLEFT", 21, 1 );
		border:Point( "BOTTOMRIGHT", result, "BOTTOMRIGHT", 1, -1 );
		border:SetBackdrop {
		  edgeFile = C["media"].blank, edgeSize = 1,
		  insets = {left = 0, right = 0, top = 0, bottom = 0}
		}
		border:SetBackdropColor(0, 0, 0, 0)
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		result.border = border;		
		
		-- Icon border ..crappy way! :)
		iconborder = CreateFrame("Frame", nil, result)
		iconborder:CreatePanel("Default",1,1,"TOPLEFT", result, "TOPLEFT", -2, 2)
		iconborder:Point("BOTTOMRIGHT", result, "BOTTOMLEFT", BAR_HEIGHT+2, -2)
		iconborder:CreateShadow("Default")
		
		
		result:RegisterEvent( "PLAYER_ENTERING_WORLD" );
		result:RegisterEvent( "UNIT_AURA" );
		if ( unit == "target" ) then
			result:RegisterEvent( "PLAYER_TARGET_CHANGED" );
		end
		
		result:SetScript( "OnEvent", OnEvent );
		
		result.Render = Render;
		result.SetHiddenHeight = SetHiddenHeight;
		
		return result;
	end
end

local _, playerClass = UnitClass( "player" )
local classFilter = CLASS_FILTERS[ playerClass ]

local targetDataSource = CreateUnitAuraDataSource( "target" )
local playerDataSource = CreateUnitAuraDataSource( "player" )
local trinketDataSource = CreateUnitAuraDataSource( "player" )

targetDataSource:SetSortDirection( SORT_DIRECTION )
playerDataSource:SetSortDirection( SORT_DIRECTION )
trinketDataSource:SetSortDirection( SORT_DIRECTION )

if ( classFilter ) then
	targetDataSource:AddFilter( classFilter.target, TARGET_BAR_COLOR, TARGET_DEBUFF_COLOR );	
	playerDataSource:AddFilter( classFilter.player, PLAYER_BAR_COLOR, PLAYER_DEBUFF_COLOR )
	trinketDataSource:AddFilter( classFilter.procs, TRINKET_BAR_COLOR )
end
trinketDataSource:AddFilter( TRINKET_FILTER, TRINKET_BAR_COLOR )

local yOffset = 7
local xOffset = 0
if C["unitframes"].charportrait == true then xOffset = -62 end

local playerFrame = CreateAuraBarFrame( playerDataSource, TukuiPlayer );
playerFrame:SetHiddenHeight( -yOffset );

if C.unitframes.layout == 1 then
	if C.unitframes.largefocus then
		playerFrame:Point( "BOTTOMLEFT", TukuiPlayer, "TOPLEFT", xOffset, 6 )
	else
		if TukuiFocus:IsShown() then
			playerFrame:Point( "BOTTOMLEFT", TukuiPlayer, "TOPLEFT", xOffset, yOffset   + TukuiFocus:GetHeight() +6)
		else
			playerFrame:Point( "BOTTOMLEFT", TukuiPlayer, "TOPLEFT", xOffset, 6 )
		end
		TukuiFocus:HookScript("OnShow", function()
			playerFrame:Point( "BOTTOMLEFT", TukuiPlayer, "TOPLEFT", xOffset, yOffset   + TukuiFocus:GetHeight() +6)
		end)
		TukuiFocus:HookScript("OnHide", function()
			playerFrame:Point( "BOTTOMLEFT", TukuiPlayer, "TOPLEFT", xOffset, 6 )
		end)	
	end
	playerFrame:Point( "BOTTOMRIGHT", TukuiPlayer, "TOPRIGHT", 0, yOffset )
elseif C.unitframes.layout == 2 then
	playerFrame:Point("BOTTOMLEFT", ShardBarBorder or RuneBarBorder or TotemBarBorder or TukuiPlayer, "TOPLEFT", 2, 5)
	playerFrame:Point("BOTTOMRIGHT", ShardBarBorder or RuneBarBorder or TotemBarBorder or TukuiPlayer, "TOPRIGHT", -2, 5)

	if T.myclass == "DRUID" then
		if EclipseBarBorder:IsShown() then
			playerFrame:Point("BOTTOMLEFT", EclipseBarBorder, "TOPLEFT", 2, 5)
			playerFrame:Point("BOTTOMRIGHT", EclipseBarBorder, "TOPRIGHT", -2, 5)
		end
		EclipseBarBorder:HookScript("OnShow", function(self)
			playerFrame:Point("BOTTOMLEFT", self, "TOPLEFT", 2, 5)
			playerFrame:Point("BOTTOMRIGHT", self, "TOPRIGHT", -2, 5)
		end)
		EclipseBarBorder:HookScript("OnHide", function(self)
			playerFrame:Point("BOTTOMLEFT", TukuiPlayer, "TOPLEFT", 2, 5)
			playerFrame:Point("BOTTOMRIGHT", TukuiPlayer, "TOPRIGHT", -2, 5)
		end)
	end
elseif C.unitframes.layout == 3 then
	playerFrame:Point("BOTTOMLEFT", TukuiPlayer, "TOPLEFT", 2, 7)
	playerFrame:Point("BOTTOMRIGHT", TukuiPlayer, "TOPRIGHT", -2, 7)
end

local trinketFrame = CreateAuraBarFrame( trinketDataSource, TukuiPlayer )
trinketFrame:SetHiddenHeight( -yOffset )
trinketFrame:Point( "BOTTOMLEFT", playerFrame, "TOPLEFT", 0, yOffset )
trinketFrame:Point( "BOTTOMRIGHT", playerFrame, "TOPRIGHT", 0, yOffset )

if not targetdebuffs then
	local targetFrame = CreateAuraBarFrame( targetDataSource, TukuiPlayer )
	targetFrame:SetHiddenHeight( -yOffset )
	targetFrame:Point( "BOTTOMLEFT", trinketFrame, "TOPLEFT", 0, yOffset )
	targetFrame:Point( "BOTTOMRIGHT", trinketFrame, "TOPRIGHT", 0, yOffset )
else
	local targetFrame = CreateAuraBarFrame( targetDataSource, TukuiTarget )
	targetFrame:SetHiddenHeight( -yOffset )
	targetFrame:Point( "BOTTOMLEFT", TukuiTarget, "TOPLEFT", 0, 61 )
	targetFrame:Point( "BOTTOMRIGHT", TukuiTarget, "TOPRIGHT", -2, 61 )
end