tibleId = 1970

NORTHSIDE = {x=32719, y=32328, z=10}
SOUTHSIDE = {x=32719, y=32330, z=10}
NORTHUID = 10202
SOUTHUID = 50001
function onStepIn(cid, item, position, fromPosition)
	if isPlayer(cid) == true then
		if item.uid == SOUTHUID then
			if getPlayerItemCount(cid, tibleId) >= 1 then
				doTeleportThing(cid, pos, TRUE)
				doSendMagicEffect(position, 12)
			end
		elseif item.uid == NORTHUID then
			if getPlayerItemCount(cid, tibleId) >= 1 then
				doTeleportThing(cid, pos, TRUE)
				doSendMagicEffect(position, 12)
			end
		end
		if getPlayerItemCount(cid, tibleId) >= 1 then

			doTeleportThing(cid, pos, TRUE)
			doSendMagicEffect(position, 12)
		end
	end
	return true
end