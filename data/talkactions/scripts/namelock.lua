local banDays = 7

function onSay(player, words, param)
	if player:getGroupId() <= ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	logCommand(player, words, param)
	local name = param
	local reason = ''

	local separatorPos = param:find(',')
	if separatorPos then
		name = param:sub(0, separatorPos - 1)
		reason = string.trim(param:sub(separatorPos + 1))
	end

	local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = '" .. name .. "'")
	if resultId then
		local timeNow = os.time()
		db.query("INSERT INTO `player_namelocks` (`player_id`, `reason`, `namelocked_at`, `namelocked_by` ) VALUES (" ..
				resultId .. ", " .. db.escapeString(reason) .. ", " .. timeNow .. ", " .. player:getGuid() .. ")")

		local target = Player(name)
		if target then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, target:getName() .. " has been namelocked and kicked.")
			target:remove()
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, name .. " has been namelocked.")
		end
	end

end
