dofile('data/npc/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'kevin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ah, this human is persistant as a dwarf. A worthy leader indeed, jawoll."})
keywordHandler:addKeyword({'postner'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ah, this human is persistant as a dwarf. A worthy leader indeed, jawoll."})
keywordHandler:addKeyword({'postmasters guild'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The guild keeps things running. Organized and reliable. I appreciate that, jawoll."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our members are handpicked by Kevin postner in our headquarter."})
keywordHandler:addKeyword({'headquarter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Its south of kazordoon. Just follow that road, can't miss it."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if msgcontains(msg, 'parcel') or msgcontains(msg, 'Parcel') then
		itemname = "parcel"
		itemprice = 10
		npcHandler:say("Would you like to buy a parcel for 10 gold?", cid)
		talk_state = 8595
		
	elseif msgcontains(msg, 'letter') or msgcontains(msg, 'Letter') then
		itemname = "letter"
		itemprice = 5
		npcHandler:say("Would you like to buy a letter for 5 gold?", cid)
		talk_state = 8596	
				
	elseif talk_state == 8595 and msgcontains(msg, 'yes') or talk_state == 8595 and msgcontains(msg, 'Yes') then
		if doPlayerRemoveMoney(cid, 10) == true then
			npcHandler:say("Here you are. Don't forget to write the name and the address of the receiver on the label. The label has to be in the parcel before you put the parcel in a mailbox.", cid)
			doPlayerAddItem(cid, 2595)
			doPlayerAddItem(cid, 2599)
		else
		npcHandler:say("Oh, you do not have enough gold to buy a ".. itemname ..".", cid)
		end
	elseif talk_state == 8596 and msgcontains(msg, 'yes') or talk_state == 8596 and msgcontains(msg, 'Yes') then
		if doPlayerRemoveMoney(cid, 5) == true then
			npcHandler:say("Here it is. Don't forget to write the name of the receiver in the first line and the address in the second one before you put the letter in a mailbox.", cid)
			doPlayerAddItem(cid, 2597)
		else
		npcHandler:say("Oh, you do not have enough gold to buy a ".. itemname ..".", cid)
		end
		
	elseif talk_state == 8595 and msgcontains(msg, '') then
	npcHandler:say("Ok.", cid)
	elseif talk_state == 8596 and msgcontains(msg, '') then
	npcHandler:say("Ok.", cid)

	elseif  msgcontains(msg, 'mail') then
	    npcHandler:say("Our mail system is unique! And everyone can use it. Do you want to know more about it?", cid)
	    talk_state = 505   

	        elseif talk_state == 505 and msgcontains(msg, 'yes') then
			npcHandler:say("The Tibia Mail System enables you to send and receive letters and parcels. You can buy them here if you want.", cid)
			talk_state = 0
	        elseif talk_state == 505 and msgcontains(msg, 'no') then
			npcHandler:say("Is there anything else I can do for you?", cid)
			talk_state = 0

		-- The Postman Missions Quest	
		elseif msgcontains(msg, 'measurements') and getPlayerStorageValue(cid,234) > 0 and getPlayerStorageValue(cid,236) < 1 then
		npcHandler:say("Oh they dont change that much since in the old days as... <tells a boring and confusing story about a cake, a parcel, himself and two squirrels, at least he tells you his measurements in the end>", cid)
		setPlayerStorageValue(cid,236,1)
		setPlayerStorageValue(cid,234,getPlayerStorageValue(cid,234)+1)
		
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
		npcHandler:say("So I should change "..b.." of your gold coins to "..n.." platinum coins for you?", cid)
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
		npcHandler:say("So I should change "..n.." of your platinum coins to "..b.." gold coins for you?", cid)
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
		npcHandler:say("So I should change "..b.." of your platinum coins to "..n.." crystal coins for you?", cid)
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
		npcHandler:say("So I should change "..n.." of your crystal coins to "..b.." platinum coins for you?", cid)
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
