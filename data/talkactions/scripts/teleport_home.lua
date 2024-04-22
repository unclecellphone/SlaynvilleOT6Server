function onSay(player, words, param)
	if player:getGroupId() <= ACCOUNT_TYPE_GAMEMASTER then
		return true
	end
    logCommand(player, words, param)

	player:teleportTo(player:getTown():getTemplePosition())
	return false
end
