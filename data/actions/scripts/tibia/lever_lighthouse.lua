local coalWhenLeverUnflipped = 1481
local coalUID = 20112

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if item.itemid == 1945 then
		doTransformItem(coalUID,coalWhenLeverUnflipped+1)
		doTransformItem(item.uid,item.itemid+1)
	elseif item.itemid == 1946 then
		doTransformItem(item.uid,item.itemid-1)
		doTransformItem(coalUID,coalWhenLeverUnflipped)
	else
		doPlayerSendCancel(cid,"Sorry not possible.")
	end
	return true
end