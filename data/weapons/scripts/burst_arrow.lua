local area = createCombatArea({
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
})

local combat = Combat()
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 0)
combat:setParameter(COMBAT_PARAM_BLOCKSHIELD, 0)
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
-- level 20 ml 30 does 40+90 / 5 to 40+90/ 2.5  ==>  130 / 5 to 130/2.5  ==>  26 to 52
-- level 100 ml 70 does 200+210 / 5 to 200+210 / 2.5  ==>  410 / 5 to 410 / 2.5 ==> 82 to 164
combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, -0.2, 0, -0.4, 0)
combat:setArea(area)

function onUseWeapon(player, variant)
	return combat:execute(player, variant)
end
