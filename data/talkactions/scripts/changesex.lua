local premiumDaysCost = 3

local outfits = {
    -- Add all outfits here --
    [1] = {male = 128, female = 136}
}

function onSay(player, words, param)
	if player:getGroup():getAccess() then
		player:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		player:setSex(player:getSex() == PLAYERSEX_FEMALE and PLAYERSEX_MALE or PLAYERSEX_FEMALE)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your sex.")
		return false
	end


	--player:removePremiumDays(premiumDaysCost)
	player:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
	player:setSex(player:getSex() == PLAYERSEX_FEMALE and PLAYERSEX_MALE or PLAYERSEX_FEMALE)

	local outfit = player:getOutfit()
    if player:getSex() == PLAYERSEX_FEMALE then
        outfit.looktype = 128
        for i = 1, #outfits do
            if player:hasOutfit(outfits[i].female) then
                player:addOutfit(outfits[i].male)
            end
        end
    else
        outfit.looktype = 136
        for i = 1, #outfits do
            if player:hasOutfit(outfits[i].male) then
                player:addOutfit(outfits[i].female)
            end
        end
    end
    
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your sex.")

	return false
end
