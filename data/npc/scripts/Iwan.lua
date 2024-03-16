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
 


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell gems of all kind."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am sure even the king would appreciate my wares."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am sure even the king would appreciate my wares."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I know not much about the local army."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I hope the academy is safe from his assaults."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am sure you'd easily recognize it by the gems attached to it."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We supply Thais with gems found on this isle."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I know only so little about our world. It's a pity."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I never visited that city."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our island is rich in precious stones."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I haven't been told anything of interest lately."})
keywordHandler:addKeyword({'rumo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I haven't been told anything of interest lately."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you various gems, pearls or some wonderful jewels."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you various gems, pearls or some wonderful jewels."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you various gems, pearls or some wonderful jewels."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you various gems, pearls or some wonderful jewels."})
keywordHandler:addKeyword({'gem'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can buy and sell small diamonds, small sapphires, small rubies, small emeralds, and small amethysts."})
keywordHandler:addKeyword({'pearl'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There are white and black pearls you can buy or sell."})
keywordHandler:addKeyword({'jewel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Currently you can purchase wedding rings, golden amulets, and ruby necklaces."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It should be |TIME| right now."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())