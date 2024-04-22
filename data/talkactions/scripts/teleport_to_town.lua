JAILPOSITION = {x=32319, y=31932, z=8}

function onSay(player, words, param)
	if player:getGroupId() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end

	if param == "JAIL" or param == "jail" then
		player:teleportTo(JAILPOSITION)
		return false
	end
    logCommand(player, words, param)

	local town = Town(param) or Town(tonumber(param))
	if town then
		player:teleportTo(town:getTemplePosition())
	else
		player:sendCancelMessage("Town not found.")
	end
	return false
end
