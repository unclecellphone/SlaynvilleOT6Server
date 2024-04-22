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

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Aneus, the storyteller."})
keywordHandler:addKeyword({'bruno'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know much about him. I only know that he is selling fish in the village."})
keywordHandler:addKeyword({'marlene'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A lovely woman. But I give you a hint: Better keep away from her. *grin*"})
keywordHandler:addKeyword({'graubart'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know much about him. But he sails much and has seen nearly the whole world."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm a storyteller."})
keywordHandler:addKeyword({'storyteller'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Well, if you wish I can tell you the story about this place here. The story about the Fields of Glory!"})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
if msgcontains(msg, 'story') and npcHandler.focus == cid then
	npcHandler:say("Ok, sit down and listen. Back in the early days, one of the ancestors of our king Tibianus III wanted to build the best city in whole of Tibia.", cid)
	talk_state = 2
			
elseif msgcontains(msg, 'fields of glory') and npcHandler.focus == cid then
	npcHandler:say("Ok, sit down and listen. Back in the early days, one of the ancestors of our king Tibianus III wanted to build the best city in whole of Tibia.", cid)
	talk_state = 2
	
elseif talk_state == 2 and msgcontains(msg, 'ancestor') and npcHandler.focus == cid then
npcHandler:say("Please forgive me. I forgot his name. I'm not that young anymore.", cid)
talk_state = 2

elseif talk_state == 2 and msgcontains(msg, 'city') and npcHandler.focus == cid then
npcHandler:say("The works on this new city began and the king sent his best soldiers to protect the workers from orcs and to make them work harder.", cid)
talk_state = 3

elseif talk_state == 3 and msgcontains(msg, 'soldier') and npcHandler.focus == cid then
npcHandler:say("It was the elite of the whole army. They were called the Red Legion (also known as the Bloody Legion).", cid)
talk_state = 3

elseif talk_state == 3 and msgcontains(msg, 'orc') and npcHandler.focus == cid then
npcHandler:say("The orcs attacked the workers from time to time and so they disturbed the works on the city.", cid)
talk_state = 4

elseif talk_state == 3 and msgcontains(msg, 'work harder') and npcHandler.focus == cid then
npcHandler:say("The soldiers treated them like slaves.", cid)
talk_state = 4

elseif talk_state == 4 and msgcontains(msg, 'slave') and npcHandler.focus == cid then
npcHandler:say("You dont know what a slave is? I really hope that you will never have to make this experience.", cid)
talk_state = 3

elseif talk_state == 4 and msgcontains(msg, 'works') and npcHandler.focus == cid then
npcHandler:say("The development of the city was fine. Also a giant castle was build northeast of the city. ...", cid)
npcHandler:say("But more and more workers started to rebel because of the bad conditions.", cid)
talk_state = 5

elseif talk_state == 5 and msgcontains(msg, 'rebel') and npcHandler.focus == cid then
npcHandler:say("All rebels were brought to the giant castle. Guarded by the Red Legion, they had to work and live in even worse conditions. ...", cid)
npcHandler:say("Also some friends of the king's sister were brought there.", 5)
talk_state = 6

elseif talk_state == 6 and msgcontains(msg, 'friends') and npcHandler.focus == cid then
npcHandler:say("The king's sister was pretty upset about the situation there but her brother didn't want to do anything about this matter. ...", cid)
npcHandler:say("So she made a plan to destroy the Red Legion for their cruelty forever.", 5)
talk_state = 7

elseif talk_state == 7 and msgcontains(msg, 'cruelty') and npcHandler.focus == cid then
npcHandler:say("The soldiers treated the workers like slaves.", cid)
talk_state = 7

elseif talk_state == 7 and msgcontains(msg, 'plan') and npcHandler.focus == cid then
npcHandler:say("She ordered her loyal druids and hunters to disguise themselves as orcs from the near island and to attack the Red Legion by night over and over again.", cid)
talk_state = 8

elseif talk_state == 8 and msgcontains(msg, 'island') and npcHandler.focus == cid then
npcHandler:say("The General of the Red Legion became very angry about these attacks and after some months he stroke back!", cid)
talk_state = 9

elseif talk_state == 8 and msgcontains(msg, 'attack') and npcHandler.focus == cid then
npcHandler:say("The General of the Red Legion became very angry about these attacks and after some months he stroke back!", cid)
talk_state = 9

elseif talk_state == 9 and msgcontains(msg, 'stroke') and npcHandler.focus == cid then
npcHandler:say("Most of the Red Legion went to the island by night. The orcs were not prepared and the Red Legion killed hundreds of orcs with nearly no loss. ...", cid)
npcHandler:say("After they were satisfied they walked back to the castle.", 5)
talk_state = 10

elseif talk_state == 10 and msgcontains(msg, 'back') and npcHandler.focus == cid then
npcHandler:say("It is said that the orcish shamans cursed the Red Legion. ...", cid)
npcHandler:say("Nobody knows. But one third of the soldiers died by a disease on the way back. ...", cid)
npcHandler:say("And the orcs wanted to take revenge, and after some days they stroke back! ...", cid)
npcHandler:say("The orcs and many allied cyclopses and minotaurs from all over Tibia came to avenge their friends, and they killed nearly all workers and soldiers in the castle. ...", cid)
npcHandler:say("The help of the king's sister came too late.", 17)
talk_state = 11

elseif talk_state == 10 and  msgcontains(msg, 'walk') and npcHandler.focus == cid then
npcHandler:say("It is said that the orcish shamans cursed the Red Legion. ...", cid)
npcHandler:say("Nobody knows. But one third of the soldiers died by a disease on the way back. ...", cid)
npcHandler:say("And the orcs wanted to take revenge, and after some days they stroke back! ...", cid)
npcHandler:say("The orcs and many allied cyclopses and minotaurs from all over Tibia came to avenge their friends, and they killed nearly all workers and soldiers in the castle. ...", cid)
npcHandler:say("The help of the king's sister came too late.", 17)
talk_state = 11

elseif talk_state == 11 and  msgcontains(msg, 'help') and npcHandler.focus == cid then
npcHandler:say("She tried to rescue the workers but it was too late. The orcs started immediately to attack her troops, too. ...", cid)
npcHandler:say("Her royal troops went back to the city. A trick saved the city from destruction.", 5)
talk_state = 12

elseif talk_state == 12 and  msgcontains(msg, 'trick') and npcHandler.focus == cid then
npcHandler:say("They used the same trick as against the Red Legion and the orcs started to fight their non-orcish-allies. ...", cid)
npcHandler:say("After a bloody long fight the orcs went back to their cities. The city of Carlin was rescued. ...", cid)
npcHandler:say("Since then, a woman has always been ruling over Carlin and this statue was made to remind us of their great tactics against the orcs and the Red Legion. ...", cid)
npcHandler:say("So that was the story of Carlin and these Fields of Glory. I hope you liked it. *smiles*", 13)

elseif talk_state == 12 and  msgcontains(msg, 'destruction') and npcHandler.focus == cid then
npcHandler:say("They used the same trick as against the Red Legion and the orcs started to fight their non-orcish-allies. ...", cid)
npcHandler:say("After a bloody long fight the orcs went back to their cities. The city of Carlin was rescued. ...", cid)
npcHandler:say("Since then, a woman has always been ruling over Carlin and this statue was made to remind us of their great tactics against the orcs and the Red Legion. ...", cid)
npcHandler:say("So that was the story of Carlin and these Fields of Glory. I hope you liked it. *smiles*", 13)

end		
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())