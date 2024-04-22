function onUse(cid, item, fromPosition, itemEx, toPosition)
	local gatePos = {x=32792, y=31893, z=11, stackpos=1}
	local nextTile = {x=gatePos.x+1, y=gatePos.y, z=gatePos.z}
	local teleportPos = {x=32796, y=31892, z=11, stackpos=1}
	local goPos = {x=32796, y=31893, z=10, stackpos=1}
	local gateItem = getThingFromPos(gatePos)
	local teleportItem = getThingFromPos(teleportPos)

	if item.itemid == 1945 and gateItem.itemid == 1355 then
		doRemoveItem(gateItem.uid,1)
		doCreateTeleport(1387, goPos, teleportPos)
		doTransformItem(item.uid,item.itemid+1)
	elseif item.itemid == 1946 then
		doRelocate(gatePos, nextTile)
		doCreateItem(1355,1,gatePos)
		doRemoveItem(teleportItem.uid,1)
		doTransformItem(item.uid,item.itemid-1)
	else
		doPlayerSendCancel(cid,"Sorry not possible.")
	end
	
	return true
end