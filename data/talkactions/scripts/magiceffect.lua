function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
    logCommand(player, words, param)

	local effect = tonumber(param)
	if(effect ~= nil and effect > 0) then
		player:getPosition():sendMagicEffect(effect)
	end

	return false
end
