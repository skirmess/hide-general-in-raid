
-- Copyright (c) 2010-2015, Sven Kirmess

local Version = 9
local Loaded = false

local function log(msg)

	if ( msg == nil ) then
		return
	end

	DEFAULT_CHAT_FRAME:AddMessage("Hide General In Raid: "..msg)
end

local function HideOrShowGeneral()

	local inInstance, instanceType = IsInInstance()
	if ( ( inInstance ) and ( instanceType == "raid" ) ) then
		-- log(string.format("%s channel hidden", GENERAL))
		ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, GENERAL)
	else
		-- log(string.format("%s channel shown", GENERAL))
		ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, GENERAL)
	end
end

local function EventHandler(self, event, ...)

	if ( event == "PLAYER_ENTERING_WORLD" ) then

		if ( not Loaded ) then
			log(string.format("Version %i loaded.", Version))
			Loaded = true
		end

		-- log("PLAYER_ENTERING_WORLD")
		HideOrShowGeneral()
	end
end

-- main
local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", EventHandler)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
