function onUse(cid, item, fromPosition, itemEx, toPosition)
	local stonePositions={
		{x=33295, y=31677, z=15, stackpos=1},
		{x=33296, y=31677, z=15, stackpos=1},
		{x=33297, y=31677, z=15, stackpos=1},
		{x=33298, y=31677, z=15, stackpos=1},
		{x=33299, y=31677, z=15, stackpos=1}
	}
	local stonePositionsBivers={
		{x=32623, y=31793, z=12, stackpos=1},
		{x=32623, y=31793, z=12, stackpos=1},
		{x=32623, y=31793, z=12, stackpos=1},
		{x=32623, y=31793, z=12, stackpos=1},
		{x=32623, y=31793, z=12, stackpos=1}
	}
	local stoneItem
	
	if item.itemid == 1945 then
		for i=1, #stonePositionsBivers do
			stoneItem=getThingFromPos(stonePositionsBivers[i])
			if stoneItem then
				doSendMagicEffect(stonePositionsBivers[i], CONST_ME_POFF)
				doRemoveItem(stoneItem.uid,1)
			end
		end
		doTransformItem(item.uid,item.itemid+1)
	elseif item.itemid == 1946 then
		for i=1, #stonePositionsBivers do
			local nextTile={x=stonePositionsBivers[i].x, y=stonePositionsBivers[i].y+1, z=stonePositionsBivers[i].z}
			doRelocate(stonePositionsBivers[i], nextTile)
			doCreateItem(1304,1,stonePositionsBivers[i])
		end
		doTransformItem(item.uid,item.itemid-1)
	else
		doPlayerSendCancel(cid,"Sorry not possible.")
	end

	return true
end