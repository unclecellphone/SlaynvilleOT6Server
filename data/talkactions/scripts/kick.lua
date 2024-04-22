function onSay(player, words, param)
	if player:getGroupId() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

    logCommand(player, words, param)
	local target = Player(param)
	if not target then
		player:sendCancelMessage("Player not found.")
		return false
	end

	if target:getGroup():getAccess() then
		player:sendCancelMessage("You cannot kick this player.")
		return false
	end

	target:remove()
	return false
end
