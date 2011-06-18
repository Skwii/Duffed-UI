local T, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

local function LoadSkin()
	xMerchantFrame:StripTextures()
		
	T.SkinScrollBar(xMerchantScrollFrame)
	T.SkinCheckBox(xMerchantFrameTooltipSearching)
	T.SkinEditBox(xMerchantFrameSearch)
end

T.SkinFuncs["xMerchant"] = LoadSkin