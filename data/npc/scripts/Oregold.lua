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

shopModule:addSellableItem({'dragon hammer'}, 2434, 2000)
shopModule:addSellableItem({'plate legs'}, 2647, 400)
shopModule:addSellableItem({'knight legs'}, 2477, 2500)
shopModule:addSellableItem({'tower shield'}, 2528, 3000)
shopModule:addSellableItem({'copper shield'}, 2530, 20)
shopModule:addSellableItem({'double axe'}, 2387, 260)
shopModule:addSellableItem({'knight armor'}, 2476, 2500)
shopModule:addSellableItem({'dark helmet'}, 2490, 50)
shopModule:addSellableItem({'dwarven axe'}, 2435, 1200)
shopModule:addSellableItem({'war hammer'}, 2391, 900)
shopModule:addSellableItem({'guardian shield'}, 2515, 900)
shopModule:addSellableItem({'brass legs'}, 2478, 15)
shopModule:addSellableItem({'plate armor'}, 2463, 200)
shopModule:addSellableItem({'halberd'}, 2381, 300)
shopModule:addSellableItem({'battle axe'}, 2378, 50)
shopModule:addSellableItem({'fishing rod'}, 2580, 50)
shopModule:addSellableItem({'plate shield'}, 2510, 20)
shopModule:addSellableItem({'broadsword'}, 2413, 300)

shopModule:addBuyableItem({'crossbow'}, 2455, 500)
shopModule:addBuyableItem({'bow'}, 2456, 400)
shopModule:addBuyableItem({'arrow'}, 2544, 2)
shopModule:addBuyableItem({'bolt'}, 2543, 3)

keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me a blacksmith is, and me pay 1,000 gold coins for dis.  And me melt. And also' faker Uzgod stupid."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me a blacksmith is, me MELT.  me MELT, not like that shopkeeper' an' faker Uzgod. He not melt.  He store."})
keywordHandler:addKeyword({'shop'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me a blacksmith is, an' weapons me melt. You want melt weapons?  PLEASE ME MELT WEAPON NOW!"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me is Oregold Hammerslammer, true son of Fire, from the Savage Axes. Check is palms, Me brother is a weakling.  "})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can buy the weapons me maked or sell weapons you have, jawoll."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me make often hunt on big nasties. Me brother never hunt, jawoll."})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We no dungeon need. We prison isle have.  Should throw brother in there."})
keywordHandler:addKeyword({'prison'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Bad ones locked up there. Never come out again there, jawoll."})
keywordHandler:addKeyword({'mines'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me hacking and smashing rocks as me was little dwarf, jawoll."})
keywordHandler:addKeyword({'thank'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me enjoy doing that."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What you need? Me just the melties sell."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Time is |TIME| now."})

keywordHandler:addKeyword({'melt'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I love to melt things.. Do you have Dragon hammer, or plate legs, or knight legs, tower shield, copper shield, double axe, knight armor?"})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What you need? Me just buy the melties sell. Me want dark helmet, dwarven axe, war hammer, guardian shield, brass legs, plate armor, halberd, battle axe, fishing rod, plate shield, broadsword"})



npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())