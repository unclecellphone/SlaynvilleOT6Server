function onCastSpell(cid, var)
	local player=Player(cid)
	--any one can do this spell
	--if not player:hasFlag(PlayerFlag_CanBroadcast) then
		--return true
	--end

	local param = var:getString()
	local text = "> " .. player:getName() .. " broadcasted via spell: " .. param .. "."
	print(text)
	for _, targetPlayer in ipairs(Game.getPlayers()) do
		targetPlayer:sendPrivateMessage(player, param, TALKTYPE_BROADCAST)
	end
	return true
end
