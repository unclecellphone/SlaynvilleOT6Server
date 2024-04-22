local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 2 + magicLevel * 3) * 0.1
	local max = (level * 2 + magicLevel * 3) * 0.2
	max = math.min(max, 20)
	min = math.min(min, 20)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end
