function onUse(cid, item, fromPosition, itemEx, toPosition)
	gatepos1 = {x=32605, y=31901, z=4, stackpos=1}
	getgate1 = getThingFromPos(gatepos1)
	if item.uid == 2470 and item.itemid == 1945 then
	 getgate1 = getThingFromPos(gatepos1)
	 doRemoveItem(getgate1.uid,1)
	 doCreateItem(430,1,gatepos1)
	 doTransformItem(item.uid,item.itemid+1)
	elseif item.uid == 2470 and item.itemid == 1946 then
	 getgate1 = getThingFromPos(gatepos1)
	 doRemoveItem(getgate1.uid,1)
	 local item = doCreateItem(408,1,gatepos1)
	 doTransformItem(item.uid,item.itemid-1)
	else
	 doPlayerSendCancel(cid,"Sorry, not possible.")
	end
	return true
end