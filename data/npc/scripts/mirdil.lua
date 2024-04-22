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

shopModule:addSellableItem({'spike sword'}, 2383, 400)
shopModule:addSellableItem({'serpent sword'}, 2409, 900)
shopModule:addSellableItem({'ring of the skies'}, 2123, 30000)
shopModule:addSellableItem({'scale armor'}, 2483, 80)
shopModule:addSellableItem({'yellow gem'}, 2154, 500)
shopModule:addSellableItem({'power ring'}, 2166, 200)
shopModule:addSellableItem({'fire sword'}, 2392, 3500)
shopModule:addSellableItem({'wolf tooth chain'}, 2129, 200)
shopModule:addSellableItem({'warrior helmet'}, 2475, 3000)
shopModule:addSellableItem({'golden sickle'}, 2418, 200)
shopModule:addSellableItem({'mystic turban'}, 2663, 900)
shopModule:addSellableItem({'skull staff'}, 2436, 2900)
shopModule:addSellableItem({'life crystal'}, 2177, 300)
shopModule:addSellableItem({'crown helmet'}, 2491, 1200)
shopModule:addSellableItem({'crystal ring'}, 2124, 300)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I buy some stuff.  Shiny stuff. I want shiny.  SHINY."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Carlin has some capable fighters, allthough they lack the grace of an elf."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The people of thais boast about their mighty kingdom, but eventually their short lives will doom everything they buld."})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Their merchants have no patience and all to fast they loose their masks of friedlyness."})
keywordHandler:addKeyword({'roderick'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "His presence here is a waste of space and talking to or even about him a waste of time."})
keywordHandler:addKeyword({'olrik'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is quite amusing for a human."})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "That's our race."})
keywordHandler:addKeyword({'dwar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They have some talent in mining and smithing."})
keywordHandler:addKeyword({'human'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They have nothing to give us."})
keywordHandler:addKeyword({'troll'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are lazy and clumsy. We should use dwarfs instead."})
keywordHandler:addKeyword({'cenath'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Their magic is almost as impressive as their egos."})
keywordHandler:addKeyword({'kuridai'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Without us and our tools nothing would work in this town."})
keywordHandler:addKeyword({'deraisim'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Useless leafeaters."})
keywordHandler:addKeyword({'abdaisim'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They left; perhaps we should do that, too."})
keywordHandler:addKeyword({'teshial'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A stupid Cenath-myth."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He may scare the treedwellers or the big-mouthes above, but not the Kuridai."})

keywordHandler:addKeyword({'shiny'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I love anything shiny! Do you have Yellow Gem, fire sword, scale armor, serpent sword, spike sword, ring of the skies, or power ring?"})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What you need? I desire shiniest shinies. I want wolf tooth chain, warrior helmet, golden sickle, mystic turban, skull staff, crown helmet, crystal ring."})


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())