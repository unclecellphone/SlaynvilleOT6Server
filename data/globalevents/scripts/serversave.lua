local function ServerSave()
	if configManager.getBoolean(configKeys.SERVER_SAVE_SHUTDOWN) then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	else
		local closeAtServerSave = configManager.getBoolean(configKeys.SERVER_SAVE_CLOSE)
		if closeAtServerSave then
			Game.setGameState(GAME_STATE_CLOSED)
		end

		saveServer()

		if configManager.getBoolean(configKeys.SERVER_SAVE_CLEAN_MAP) then
			cleanMap()
		end

		if closeAtServerSave then
			Game.setGameState(GAME_STATE_NORMAL)
		end
	end
end

local function ServerSaveWarning(time)
	local fiveMinutes = 60000 * 5
	if time > fiveMinutes + 1 then
		local remainingTime = tonumber(time) - fiveMinutes
		if configManager.getBoolean(configKeys.SERVER_SAVE_NOTIFY_MESSAGE) then
			Game.broadcastMessage("Server is saving game in " .. ( remainingTime /60000 ) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
		end

		if remainingTime >= fiveMinutes * 2 then
			addEvent(ServerSaveWarning, fiveMinutes, remainingTime)
		elseif remainingTime > 60000 then
			addEvent(ServerSaveWarning, 60000, remainingTime)
		end
	else
		local remainingTime = tonumber(time) - 60000
		if configManager.getBoolean(configKeys.SERVER_SAVE_NOTIFY_MESSAGE) then
			Game.broadcastMessage("Server is saving game in " .. (remainingTime/60000) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
		end
		if remainingTime > 60000 then
			addEvent(ServerSaveWarning, 60000, remainingTime)
		else
			addEvent(ServerSave, 60000)
		end
	end
end

function onTime(interval)
	local remainingTime = configManager.getNumber(configKeys.SERVER_SAVE_NOTIFY_DURATION) * 60000
	if configManager.getBoolean(configKeys.SERVER_SAVE_NOTIFY_MESSAGE) then
		Game.broadcastMessage("Server is saving game in " .. (remainingTime/60000) .."  minute(s). Please logout.", MESSAGE_STATUS_WARNING)
	end

	addEvent(ServerSaveWarning, 60000 * 5, remainingTime)
	return not configManager.getBoolean(configKeys.SERVER_SAVE_SHUTDOWN)
end
