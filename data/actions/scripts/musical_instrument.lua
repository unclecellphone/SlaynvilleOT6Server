-- by Nottinghster

local BIRD_CAGE = 2095
local CORNUCOPIA = 2369

function onUse(cid, item, fromPosition, itemEx, toPosition)
	local random = math.random(1, 5)
	if (isInArray(MUSICAL_INSTRUMENTS, item.itemid) == true) then
		if random < 3 then
			doSendMagicEffect(fromPosition, CONST_ME_SOUND_BLUE)
		else
			doSendMagicEffect(fromPosition, CONST_ME_SOUND_GREEN)
		end
	elseif (item.itemid == BIRD_CAGE) then
		doSendMagicEffect(fromPosition, CONST_ME_SOUND_YELLOW)
	elseif (item.itemid == CORNUCOPIA) then
		for i = 1, 11 do
			doPlayerAddItem(cid, 2681)
		end
		
		doRemoveItem(item.uid, 1)
		doSendMagicEffect(fromPosition, CONST_ME_SOUND_YELLOW)
	end
	
	return true
end 