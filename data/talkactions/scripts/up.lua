function onSay(player, words, param)
	if player:getGroupId() <= ACCOUNT_TYPE_GAMEMASTER then
		return true
	end
    logCommand(player, words, param)

	local position = player:getPosition()
	position.z = position.z - 1
	player:teleportTo(position)
	return false
end
