function onSay(player, words, param)
	if player:getGroupId() <= ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	local steps = tonumber(param)
	if not steps then
		return false
	end
    logCommand(player, words, param)

	local position = player:getPosition()
	position:getNextPosition(player:getDirection(), steps)

	position = player:getClosestFreePosition(position, false)
	if position.x == 0 then
		player:sendCancelMessage("You cannot teleport there.")
		return false
	end

	player:teleportTo(position)
	return false
end
