-- short money 
COPPER_AMOUNT = "%d|cFF954F28"..COPPER_AMOUNT_SYMBOL.."|r"
SILVER_AMOUNT = "%d|cFFC0C0C0"..SILVER_AMOUNT_SYMBOL.."|r"
GOLD_AMOUNT = "%d|cFFF0D440"..GOLD_AMOUNT_SYMBOL.."|r"
YOU_LOOT_MONEY = "+ %s"
YOU_LOOT_MONEY_GUILD = "+ %s (%s)"
LOOT_MONEY_SPLIT = "+ %s"
LOOT_MONEY_SPLIT_GUILD = "+ %s (%s)"

-- Loot, currencies and crafting
LOOT_ITEM = "%s + %s"
LOOT_ITEM_MULTIPLE = "%s + %sx%d"
LOOT_ITEM_SELF = "+ %s"
LOOT_ITEM_SELF_MULTIPLE = "+ %sx%d"
LOOT_ITEM_PUSHED_SELF = "+ %s"
LOOT_ITEM_PUSHED_SELF_MULTIPLE = "+ %sx%d"
LOOT_ITEM_CREATED_SELF = "+ %s.";
LOOT_ITEM_CREATED_SELF_MULTIPLE = "+ %sx%d."
CURRENCY_GAINED = "+ %s"

-- Achievements by Saiket on wowinterface. http://www.wowinterface.com/forums/showpost.php?p=234112&postcount=6
-- Player name argument must be escaped
local FORMAT_OTHER = "%%s earned %s.";
local FORMAT_SELF = "|cffffffff+|r  %s.";
local GUIDPlayer = UnitGUID( "player" );

--- Shortens achievement earned messages.
local function OnFilter ( self, Event, Format, Name, ... )
  local Achievement = Format:match( "|c%x%x%x%x%x%x%x%x|Hachievement:.-|h.-|h|r" );
  local GUID = select( 10, ... );
  Format = ( GUID == PlayerGUID and FORMAT_SELF or FORMAT_OTHER ):format( Achievement );
  
  return false, Format, Name, ...; -- Name gets added to Format by default UI
end
ChatFrame_AddMessageEventFilter( "CHAT_MSG_ACHIEVEMENT", OnFilter );
ChatFrame_AddMessageEventFilter( "CHAT_MSG_GUILD_ACHIEVEMENT", OnFilter );
	
-- Zone discovering	
ERR_ZONE_EXPLORED = "%s"
ERR_ZONE_EXPLORED_XP = "%s: + %d exp"

-- Skill ups
ERR_SKILL_UP_SI = "%s + %d"

-- Players login/logoff
ERR_FRIEND_OFFLINE_S = "%s |cffff0000 offline|r."
ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h%s|h |cff00ff00 online|r."
BN_INLINE_TOAST_FRIEND_OFFLINE = "\124TInterface\\FriendsFrame\\UI-Toast-ToastIcons.tga:16:16:0:0:128:64:2:29:34:61\124t%s |cffff0000offline|r.";
BN_INLINE_TOAST_FRIEND_ONLINE = "\124TInterface\\FriendsFrame\\UI-Toast-ToastIcons.tga:16:16:0:0:128:64:2:29:34:61\124t%s |cff00ff00online|r.";
BN_TOAST_OFFLINE = " |cffff0000offline|r."
BN_TOAST_ONLINE = " |cff00ff00online|r."
	
-- Quests
ERR_QUEST_REWARD_EXP_I = "+ %d exp."
ERR_QUEST_REWARD_ITEM_MULT_IS = "+ %sx%d."
ERR_QUEST_REWARD_ITEM_S = "+ %s."
ERR_QUEST_REWARD_MONEY_S = "+ %s."