dofile('data/npc/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'white pearl'}, 2143, 160)
shopModule:addSellableItem({'black pearl'}, 2144, 280)
shopModule:addSellableItem({'small diamond'}, 2145, 300)
shopModule:addSellableItem({'small sapphire'}, 2146, 250)
shopModule:addSellableItem({'small ruby'}, 2147, 250)
shopModule:addSellableItem({'small emerald'}, 2149, 250)
shopModule:addSellableItem({'small amethyst'}, 2150, 200)
shopModule:addBuyableItem({'wedding ring'}, 2121, 990)
shopModule:addBuyableItem({'golden amulet'}, 2130, 6600)
shopModule:addBuyableItem({'ruby necklace'}, 2133, 3560)
shopModule:addBuyableItem({'white pearl'}, 2143, 320)
shopModule:addBuyableItem({'black pearl'}, 2144, 560)
shopModule:addBuyableItem({'small diamond'}, 2145, 600)
shopModule:addBuyableItem({'small sapphire'}, 2146, 500)
shopModule:addBuyableItem({'small ruby'}, 2147, 500)
shopModule:addBuyableItem({'small emerald'}, 2149, 500)
shopModule:addBuyableItem({'small amethyst'}, 2150, 400)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a jeweller. Maybe you want to have a look at my wonderful offers. I also exchange and deposit money."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Tezila Gemcutter, daughter of Fire, from the Savage Axes."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can sell you glittering gems, precious pearls or some ... uhm ... jolly jewels."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can sell you glittering gems, precious pearls or some ... uhm ... jolly jewels."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can sell you glittering gems, precious pearls or some ... uhm ... jolly jewels."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can sell you glittering gems, precious pearls or some ... uhm ... jolly jewels."})
keywordHandler:addKeyword({'gem'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can buy and sell small diamonds, sapphires, rubies, emeralds, and amethysts."})
keywordHandler:addKeyword({'pearl'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have white and black pearls you can buy, but you can also sell me some."})
keywordHandler:addKeyword({'jewel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can purchase our fine dwarfish wares like wedding rings, golden amulets, and ruby necklaces."})
keywordHandler:addKeyword({'talon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am suspicious of these magic gems. Better you ask some mages about this."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's |TIME|."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

----MESSAGES------------------------------------------------------------------------------
	if msgcontains(msg, 'change gold') then
		npcHandler:say("How many platinum coins do you want to get?", cid)
		talkState = 8

	elseif msgcontains(msg, 'change platinum') then
		npcHandler:say("Do you want to change your platinum coins to gold or crystal?", cid)
		talkState = 10

	elseif msgcontains(msg, 'change crystal') then
		npcHandler:say("How many crystal coins do you want to change to platinum?", cid)
		talkState = 15

	----CHANGE GOLD---------------------------------------------------------------------------------
		elseif talkState == 8 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
			npcHandler:say("Well, can I help you with something else?", cid)
			talkState = 0
		elseif talkState == 8 then
			n = getMoneyCount(msg)
			b = n * 100
			npcHandler:say("So I should change '..b..' of your gold coins to '..n..' platinum coins for you?", cid)
			talkState = 9

		elseif talkState == 9 then
			if msgcontains(msg, 'yes') then
				if doPlayerRemoveItem(cid, 2148, b) == true then
					doPlayerAddItem(cid, 2152, n)
					npcHandler:say("Here you are.", cid)
					talkState = 0
				else
					npcHandler:say("You don\'t have money.", cid)
					talkState = 0
				end
			else
				npcHandler:say("Ok. We cancel.", cid)
				talkState = 0
			end

	----CHANGE PLATINUM-------------------------------------------------------------------------
		elseif talkState == 10 then
			if msgcontains(msg, 'gold') then
				npcHandler:say("How many platinum coins do you want to change to gold?", cid)
				talkState = 11
			elseif msgcontains(msg, 'crystal') then
				npcHandler:say("How many crystal coins do you want to get?", cid)
				talkState = 13
			end

		elseif talkState == 11 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
			npcHandler:say("Well, can I help you with something else?", cid)
			talkState = 0
		elseif talkState == 11 then
			n = getMoneyCount(msg)
			b = n * 100
			npcHandler:say("So I should change '..n..' of your platinum coins to '..b..' gold coins for you?", cid)
			talkState = 12

		elseif talkState == 12 then
			if msgcontains(msg, 'yes') then
				if doPlayerRemoveItem(cid, 2152, n) == true then
					doPlayerAddItem(cid, 2148, b)
					npcHandler:say("Here you are.", cid)
					talkState = 0
				else
					npcHandler:say("You don\'t have money.", cid)
					talkState = 0
				end
			else
				npcHandler:say("Ok. We cancel.", cid)
				talkState = 0
			end
		elseif talkState == 13 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
			npcHandler:say("Well, can I help you with something else?", cid)
			talkState = 0
		elseif talkState == 13 then
			n = getMoneyCount(msg)
			b = n * 100
			npcHandler:say("So I should change '..b..' of your platinum coins to '..n..' crystal coins for you?", cid)
			talkState = 14

		elseif talkState == 14 then
			if msgcontains(msg, 'yes') then
				if doPlayerRemoveItem(cid, 2152, b) == true then
					doPlayerAddItem(cid, 2160, n)
					npcHandler:say("Here you are.", cid)
					talkState = 0
				else
					npcHandler:say("You don\'t have money.", cid)
					talkState = 0
				end
			else
				npcHandler:say("Ok. We cancel.", cid)
				talkState = 0
			end

	----CHANGE CRYSTAL-------------------------------------------------------------------------------
		elseif talkState == 15 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
			npcHandler:say("Well, can I help you with something else?", cid)
			talkState = 0
		elseif talkState == 15 then
			n = getMoneyCount(msg)
			b = n * 100
			npcHandler:say("So I should change '..n..' of your crystal coins to '..b..' platinum coins for you?", cid)
			talkState = 16

		elseif talkState == 16 then
			if msgcontains(msg, 'yes') then
				if doPlayerRemoveItem(cid, 2160, n) == true then
					doPlayerAddItem(cid, 2152, b)
					npcHandler:say("Here you are.", cid)
					talkState = 0
				else
					npcHandler:say("You don\'t have money.", cid)
					talkState = 0
				end
			else
				npcHandler:say("Ok. We cancel.", cid)
				talkState = 0
			end
	--[[ // disabling bank accounts
----BALANCE-------------------------------------------------------------------------
	elseif	msgcontains(msg, 'balance') then
		npcHandler:say("Your account balance is ".. getPlayerBalance(cid) .." gold.", cid)
		talk_state = 0

----DEPOSIT------------------------------------------------------------------------
	elseif	msgcontains(msg, 'deposit all') then
		if getPlayerMoney(cid) > 0 then
			npcHandler:say("Would you like to deposit '.. getPlayerMoney(cid) ..' gold?", cid)
			talk_state = 205
		else
			npcHandler:say("You don\'t have money.", cid)
			talk_state = 0
		end

	elseif	msgcontains(msg, 'deposit') then
		DEPOSITAMOUNT = getMoneyCount(msg)
		if DEPOSITAMOUNT >= 1 then
			if DEPOSITAMOUNT <= getPlayerMoney(cid) then
				npcHandler:say("Would you like to deposit ".. DEPOSITAMOUNT .." gold?", cid)
				talk_state = 203
			else
				npcHandler:say("You don't have that money amount!", cid)
				talk_state = 0
			end
		else
			npcHandler:say("How much would you like to deposit?", cid)
			talk_state = 201
		end

	elseif talk_state == 201 then
		DEPOSITAMOUNT = getMoneyCount(msg)
		if DEPOSITAMOUNT >= 1 then
			if DEPOSITAMOUNT <= getPlayerMoney(cid) then
				npcHandler:say("Would you like to deposit ".. DEPOSITAMOUNT .." gold?", cid)
				talk_state = 203
			else
				npcHandler:say("You don't have that money amount!", cid)
				talk_state = 0
			end
		else
			npcHandler:say("I'm sorry, but you must give me an valid amount of how much you would like to deposit.", cid)
		end

	elseif talk_state == 203 and msgcontains(msg,'no') then
		npcHandler:say("Ok then.", cid)
		talk_state = 0

	elseif talk_state == 203 and msgcontains(msg, 'yes') then
		if doPlayerDepositMoney(cid, DEPOSITAMOUNT) == true then
			npcHandler:say("You have added ".. DEPOSITAMOUNT .." gold to your bank account.", cid)
			talk_state = 0
		else
			npcHandler:say("You don't have that money amount!", cid)
			talk_state = 0
		end

	elseif talk_state == 205 and msgcontains(msg, 'yes') then
		PLAYERCURRENTMONEY = getPlayerMoney(cid)
		if doPlayerDepositMoney(cid, PLAYERCURRENTMONEY) == true then
			npcHandler:say("You have added ".. PLAYERCURRENTMONEY .." gold to your bank account.", cid)
			talk_state = 0
		else
			npcHandler:say("Hey! where did you put the money?", cid)
			talk_state = 0
		end

----WITHDRAW-------------------------------------------------------------------------
	elseif	msgcontains(msg, 'withdraw all') then
		WITHDRAWMONEY = getPlayerBalance(cid)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:say("Would you like to withdraw ".. WITHDRAWMONEY .." gold?", cid)
				talk_state = 303
			else
				npcHandler:say("There is not enough gold on your account.", cid)
				talk_state = 0
			end
		else
			npcHandler:say("You don't have money on your bank account!", cid)
			talk_state = 0
		end

	elseif msgcontains(msg, 'withdraw') then
		WITHDRAWMONEY = getMoneyCount(msg)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:say("Would you like to withdraw ".. WITHDRAWMONEY .." gold?", cid)
				talk_state = 303
			else
				npcHandler:say("There is not enough gold on your account.", cid)
				talk_state = 0
			end
		else
			npcHandler:say("How much would you like to withdraw?", cid)
			talk_state = 301
		end

	elseif talk_state == 301 then
		WITHDRAWMONEY = getMoneyCount(msg)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:say("Would you like to withdraw ".. WITHDRAWMONEY .." gold?", cid)
				talk_state = 303
			else
				npcHandler:say("There is not enough gold on your account.", cid)
				talk_state = 0
			end
		else
			npcHandler:say("I'm sorry, but you must give me a valid amount of how much you would like to withdraw.", cid)
			talk_state = 0
		end

	elseif talk_state == 303 and msgcontains(msg, 'yes') then
		if doPlayerWithdrawMoney(cid, WITHDRAWMONEY) == true then
			npcHandler:say("Here you are.", cid)
			talk_state = 0
		else
			npcHandler:say("You don't have that money amount on your bank account!", cid)
			talk_state = 0
		end

	elseif talk_state == 303 and msgcontains(msg, 'no') then
		npcHandler:say("Ok then.", cid)
		talk_state = 0

----TRANSFER-------------------------------------------------------------------------
	elseif msgcontains(msg, 'transfer') then
		TRANSFERAMOUNT = getMoneyCount(msg)
		if TRANSFERAMOUNT >= 1 then
			if getPlayerBalance(cid) > TRANSFERAMOUNT then
				npcHandler:say("Who would you like transfer ' .. TRANSFERAMOUNT .. ' gold to?", cid)
				talk_state = 504
			else
				npcHandler:say("There is not enough gold on your account.", cid)
				talk_state = 0
			end
		else
			npcHandler:say("Please tell me the amount of gold you would like to transfer.", cid)
			talk_state = 501
		end

	elseif talk_state == 501 and getMoneyCount(msg) >= 1 then
		TRANSFERAMOUNT = getMoneyCount(msg)
		if getPlayerBalance(cid) > TRANSFERAMOUNT then
			npcHandler:say("Who would you like transfer ' .. TRANSFERAMOUNT .. ' gold to?", cid)
			talk_state = 504
		else
			npcHandler:say("There is not enough gold on your account.", cid)
			talk_state = 0
		end

	elseif talk_state == 504 then
		TRANSFERTO = msg
		if playerExists(TRANSFERTO) then
			newmsg = string.upper(string.sub(msg, 0, 1)) .. string.sub(msg, 2)
			UPPERCASETRANSFERTO = newmsg
			npcHandler:say("Would you like to transfer ".. TRANSFERAMOUNT .." gold to ".. UPPERCASETRANSFERTO .."?", cid)
			talk_state = 505
		else
			npcHandler:say("This player does not exist.", cid)
			talk_state = 0
		end

	elseif talk_state == 505 and msgcontains(msg, 'no') then
		npcHandler:say("Ok then.", cid)
		talk_state = 0

	elseif talk_state == 505 and msgcontains(msg, 'yes') then
		receiver = getPlayerGUIDByName(UPPERCASETRANSFERTO)
		if (getVocationByPlayerGUID(getPlayerGUIDByName(UPPERCASETRANSFERTO)) <= 0) or (getVocationByPlayerGUID(getPlayerGUIDByName(UPPERCASETRANSFERTO)) >= 9) then
			npcHandler:say("You can not send money to Rookgaard!", cid)
			talk_state = 0
		elseif receiver == getPlayerGUIDByName(getPlayerName(cid)) then
			npcHandler:say("You can not send money to yourself.", cid)
			talk_state = 0
		else
			doPlayerTransferMoneyTo(cid, UPPERCASETRANSFERTO, TRANSFERAMOUNT)
			npcHandler:say("Very well. You have transferred ' .. TRANSFERAMOUNT .. ' gold to ' .. UPPERCASETRANSFERTO ..'.", cid)
			talk_state = 0
		end	]]-- //disabling bank accounts
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
