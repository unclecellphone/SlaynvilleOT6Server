local increasing = {[416] = 417, [426] = 425, [446] = 447, [3216] = 3217, [3202] = 3215, [11062] = 11063}
local decreasing = {[417] = 416, [425] = 426, [447] = 446, [3217] = 3216, [3215] = 3202, [11063] = 11062}

LIGHTHOUSESTEP = { x = 32225, y = 32268, z = 9 }
LIGHTHOUSETP = { x = 32232, y = 32276, z = 9, stackpos=1 }
LIGHTHOUSETPHIDDEN = { x = 32235, y = 32276, z = 9, stackpos=1 }
LIGHTHOUSETPUID = 20111
DruidIsland = {
	{ x = 32830, y = 32295, z = 7 },  
	{ x = 32830, y = 32294, z = 7 },  
	{ x = 32830, y = 32293, z = 7 },  
	{ x = 32831, y = 32293, z = 7 },  
	{ x = 32832, y = 32293, z = 7 },  
	{ x = 32832, y = 32294, z = 7 },  
	{ x = 32832, y = 32295, z = 7 },  
	{ x = 32831, y = 32295, z = 7 }
}

DRUIDTPTO = { x = 32837, y = 32294, z =  7 }
SORCTHAISTP = { x = 32300, y = 32268, z =  7 }
SORCTHAISTP2 = { x = 32300, y = 32267, z =  7 }
SORCTHAISTPTO = { x = 32308, y = 32267, z =  7 }
SORCVOC = { 1, 5 }
DRUIDVOC = { 2, 6 }

function onStepIn(creature, item, position, fromPosition)
	if creature and creature.uid then
		for i, loc in ipairs(DruidIsland) do
			local isTP = loc.x == position.x and loc.y == position.y and loc.z == position.z
			if isTP then
				local voc = getPlayerVocation(creature.uid)
				if voc ~= DRUIDVOC[1] and voc ~= DRUIDVOC[2] then
					if not creature:getPlayer() or not creature:getGroup():getAccess() then
						doTeleportThing(creature.uid, DRUIDTPTO)
						return true
					end
				end
			end
		end
	end

	if not increasing[item.itemid] then
		return true
	end

	item:transform(increasing[item.itemid])

	if creature and creature.uid then
		local isTP1 = position.x == SORCTHAISTP.x and position.y == SORCTHAISTP.y and position.z == SORCTHAISTP.z
		local isTP2 = position.x == SORCTHAISTP2.x and position.y == SORCTHAISTP2.y and position.z == SORCTHAISTP2.z
		if isTP1 or isTP2 then
			local voc = getPlayerVocation(creature.uid)
			if voc ~= SORCVOC[1] and voc ~= SORCVOC[2] then
				if not creature:getGroup():getAccess() then
					doTeleportThing(creature.uid, SORCTHAISTPTO)
					return true
				end
			end
		end

		local isLIGHTHOUSE = position.x == LIGHTHOUSESTEP.x and position.y == LIGHTHOUSESTEP.y and position.z == LIGHTHOUSESTEP.z
		if isLIGHTHOUSE then
			local thing = Item(LIGHTHOUSETPUID)
			if thing then
				thing:moveTo(LIGHTHOUSETP)
			end
			return true
		end
	end

	if item.actionid >= actionIds.levelDoor then
		if creature:getLevel() < item.actionid - actionIds.levelDoor then
			creature:teleportTo(fromPosition, false)
			position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The tile seems to be protected against unwanted intruders.  item.actionid: " .. item.actionid .. " actionIds.levelDoor " .. actionIds.levelDoor .. " creature:getLevel() " .. creature:getLevel())
		end
		return true
	end

	if Tile(position):hasFlag(TILESTATE_PROTECTIONZONE) then
		local lookPosition = creature:getPosition()
		lookPosition:getNextPosition(creature:getDirection())
		local depotItem = Tile(lookPosition):getItemByType(ITEM_TYPE_DEPOT)
		if depotItem then
			local depotItems = creature:getDepotChest(getDepotId(depotItem:getUniqueId()), true):getItemHoldingCount()
			creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Your depot contains " .. depotItems .. " item" .. (depotItems > 1 and "s." or "."))
			creature:addAchievementProgress("Safely Stored Away", 1000)
			return true
		end
	end

	if item.actionid ~= 0 and creature:getStorageValue(item.actionid) <= 0 then
		creature:teleportTo(fromPosition, false)
		position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The tile seems to be protected against unwanted intruders.")
		return true
	end
	return true
end

function onStepOut(creature, item, position, fromPosition)
	if not decreasing[item.itemid] then
		return true
	end


	if creature:isPlayer() and creature:isInGhostMode() then
		return true
	end

	item:transform(decreasing[item.itemid])

	local isLIGHTHOUSE = fromPosition.x == LIGHTHOUSESTEP.x and fromPosition.y == LIGHTHOUSESTEP.y and fromPosition.z == LIGHTHOUSESTEP.z
	if isLIGHTHOUSE then
		local thing = Item(LIGHTHOUSETPUID)
		if thing then
			thing:moveTo(LIGHTHOUSETPHIDDEN)
		end
	end
	return true
end
