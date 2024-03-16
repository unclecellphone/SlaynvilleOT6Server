function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(toPosition.x == 0 and toPosition.y == 0 and toPosition.z == 0) then
		doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	if(toPosition.x == CONTAINER_POSITION) then
		doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local newPos = {x = toPosition.x, y = toPosition.y, z = toPosition.z, stackpos = 0}
	local groundItem = getThingFromPos(newPos)
	if (isInArray(ROPE_SPOT, groundItem.itemid) ) then
		newPos.y = newPos.y + 1
		newPos.z = newPos.z - 1
		doTeleportThing(cid, newPos)
	elseif (isInArray(OPENED_HOLE, itemEx.itemid) or isInArray(OPENED_TRAP, itemEx.itemid) or isInArray(DOWN_LADDER, itemEx.itemid) ) then
		newPos.y = newPos.y + 1
		local downPos = {x = toPosition.x, y = toPosition.y, z = toPosition.z + 1, stackpos = 255}
		local downItem = getThingFromPos(downPos)
		if downItem ~= nil and (downItem.itemid > 0) then
			doTeleportThing(downItem.uid, newPos)
		else
			doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
		end
	else
		return false
	end
	return true
end