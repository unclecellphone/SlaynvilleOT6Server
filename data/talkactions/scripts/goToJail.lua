JAILPOSITION = {x=32319, y=31932, z=8}

function onSay(player, words, param)
	if player:getGroupId() < ACCOUNT_TYPE_GAMEMASTER then
		return true
	end
	local creature = Creature(param)
	if not creature then
		player:sendCancelMessage("A creature with that name could not be found.")
		return false
	end

    logCommand(player, words, param)
	local oldPosition = creature:getPosition()
	local newPosition = creature:getClosestFreePosition(JAILPOSITION, false)
	if newPosition.x == 0 then
		player:sendCancelMessage("You can not teleport " .. creature:getName() .. ".")
		return false
	elseif creature:teleportTo(newPosition) then
		if not creature:isInGhostMode() then
			oldPosition:sendMagicEffect(CONST_ME_POFF)
			newPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
	return false
end
