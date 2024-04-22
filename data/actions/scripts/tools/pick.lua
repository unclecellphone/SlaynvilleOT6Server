local MUD_HOLE = 392
local duration = 5 * 60000 -- 5 minutes
local DIRT = 354
local function __doTransformHole__(parameters)
	local t = Tile(parameters.pos)
	local hole = t:getGround()
    hole:transform(DIRT)
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if itemEx.actionid == 100 and isMoveable(itemEx.uid) == false and isCorpse(itemEx.uid) == false then
		doTransformItem(itemEx.uid, MUD_HOLE)
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		if itemEx.actionid ~= 0 then
			doSetItemActionId(itemEx.uid, itemEx.actionid)
		end
		for i = 1, #POOLS do
			local pool = getTileItemById(toPosition, POOLS[i]).uid
			if pool > 0 then
				doRemoveItem(pool,1)
			end
		end

		addEvent(__doTransformHole__, duration, {oldType = itemEx.itemid, pos = toPosition, oldaid = itemEx.actionid})
		return true
	end
	return false
end