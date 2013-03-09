
-- Copyright (c) 2010-2013, Sven Kirmess

local Version = 6
local Loaded = false

local function log(msg)

	if ( msg == nil ) then
		return
	end

	DEFAULT_CHAT_FRAME:AddMessage("Hide General In Raid: "..msg)
end

local function EventHandler(self, event, ...)

	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...

	if ( event == "PLAYER_ENTERING_WORLD" ) then

		if ( not Loaded ) then
			log(string.format("Version %i loaded.", Version))
			Loaded = true
		end

		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")

	elseif ( event == "PLAYER_LEAVING_WORLD" ) then

		self:UnregisterEvent("CHAT_MSG_CHANNEL_NOTICE")

	elseif ( event == "CHAT_MSG_CHANNEL_NOTICE" ) then

		-- Fired when you enter or leave a chat channel (or a channel was
		-- recently throttled)
		--
		-- arg1		type
		--		"YOU_JOINED" if you joined a channel
		--		"YOU_LEFT" if you left
		--		"THROTTLED" if channel was throttled
		--
		-- arg4		Channel name with number (e.g. "6. TestChannel")
		--
		-- arg7		Channel Type (e.g. 0 for any user channel,
		--		1 for system-channel "General", 2 for "Trade")
		--
		-- arg8		Channel Number
		--
		-- arg9		Channel name without number

		-- CHAT_MSG_CHANNEL_NOTICE(arg1, arg7, arg8, arg9)
		if ( not arg1 or not arg7 ) then
			log("Ignoring malformed CHAT_MSG_CHANNEL_NOTICE event.")
			return
		end

		if ( arg7 == 1 ) then
			-- General
			if (( arg1 == "YOU_JOINED" ) or ( arg1 == "YOU_CHANGED" ) ) then
				local inInstance, instanceType = IsInInstance()
				if ( ( inInstance ) and ( instanceType == "raid" ) ) then
					ChatFrame_RemoveChannel(DEFAULT_CHAT_FRAME, "General")
				else
					ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, "General")
				end
			end
		end
	end
end

-- main
local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", EventHandler)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")

