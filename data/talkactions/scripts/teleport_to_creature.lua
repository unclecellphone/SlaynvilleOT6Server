function onSay(player, words, param)
	if player:getGroupId() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end
    logCommand(player, words, param)

	local target = Creature(param)
	if target then
		player:teleportTo(target:getPosition())
	else
		player:sendCancelMessage("Creature not found.")
	end
	return false
end
