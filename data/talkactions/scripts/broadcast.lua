function onSay(player, words, param)
	--only god can do this with /b
	if not player:hasFlag(PlayerFlag_CanBroadcast) then
		return true
	end
	if player:getGroupId() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end
	logCommand(player, words, param)
	print("> " .. player:getName() .. " broadcasted via /b: \"" .. param .. "\".")
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
	end
	return false
end
