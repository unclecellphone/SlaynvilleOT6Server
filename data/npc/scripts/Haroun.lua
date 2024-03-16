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

shopModule:addSellableItem({'magic lightwand'}, 2162, 35)
shopModule:addSellableItem({'life crystal'}, 2177, 50)
shopModule:addSellableItem({'orb'}, 2176, 750)
shopModule:addBuyableItem({'garlic necklace'}, 2199, 100, 150)
shopModule:addBuyableItem({'bronze amulet'}, 2172, 100, 200)

keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm afraid I do not trade with weapons or armour. Nah'bob only deals with magical equipment."})
keywordHandler:addKeyword({'armor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm afraid I do not trade with weapons or armour. Nah'bob only deals with magical equipment."})
keywordHandler:addKeyword({'legs'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm afraid I do not trade with weapons or armour. Nah'bob only deals with magical equipment."})
keywordHandler:addKeyword({'wares'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'magical'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I only deal with magical equipment. Our range of goods include amulets, rings, wands and some special items."})
keywordHandler:addKeyword({'special'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling and buying magic light wands. I'm currently also looking for mind stones, life crystals and orbs."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())