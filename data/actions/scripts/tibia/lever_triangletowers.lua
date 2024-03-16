local tileWhenLeverUnflipped = 1025
local gatePos = {x=32566, y=32119, z=7, stackpos=1}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local nextTile = {x=gatePos.x+1, y=gatePos.y, z=gatePos.z}
	local gateItem = getThingFromPos(gatePos)

	if item.itemid == 1945 and gateItem.itemid == tileWhenLeverUnflipped then
		doRemoveItem(gateItem.uid,1)
		doTransformItem(item.uid,item.itemid+1)
	elseif item.itemid == 1946 then
		doRelocate(gatePos, nextTile)
		doCreateItem(tileWhenLeverUnflipped,1,gatePos)
		doTransformItem(item.uid,item.itemid-1)
	else
		doPlayerSendCancel(cid,"Sorry not possible.")
	end
	return true
end