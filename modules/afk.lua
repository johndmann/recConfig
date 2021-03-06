-- $Id: afk.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("CHAT_MSG_SYSTEM")
t.events:RegisterEvent("PLAYER_LOGOUT")
t.events:RegisterEvent("PLAYER_ENTERING_WORLD")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_SYSTEM" or event == "PLAYER_LOGOUT" or event == "PLAYER_ENTERING_WORLD" then
		if event == "PLAYER_LOGOUT" then
			SetCVar("UnitNameOwn", 0)
		else
			SetCVar("UnitNameOwn", UnitIsAFK("player") and 1 or 0)
			
			if event == "CHAT_MSG_SYSTEM" then
				if string.find(..., CLEARED_AFK) then
					SetCVar("UnitNameOwn", 0)
				elseif string.find(..., string.gsub(MARKED_AFK_MESSAGE, "%%s", ".*")) or string.find(..., MARKED_AFK) then
					SetCVar("UnitNameOwn", 1)
				end
			end
		end
	end
end)