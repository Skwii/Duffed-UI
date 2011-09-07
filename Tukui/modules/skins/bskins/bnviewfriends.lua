local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales
if not C["skins"].bskins == true then return end

local function LoadSkin()
	FriendsFriendsFrame:CreateBackdrop("Transparent")

	local StripAllTextures = {
		"FriendsFriendsFrame",
		"FriendsFriendsList",
		"FriendsFriendsNoteFrame",
	}

	local buttons = {
		"FriendsFriendsSendRequestButton",
		"FriendsFriendsCloseButton",
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for _, button in pairs(buttons) do
		T.SkinButton(_G[button])
	end

	T.SkinEditBox(FriendsFriendsList)
	T.SkinEditBox(FriendsFriendsNoteFrame)
	T.SkinDropDownBox(FriendsFriendsFrameDropDown,150)
end

tinsert(T.SkinFuncs["Tukui"], LoadSkin)