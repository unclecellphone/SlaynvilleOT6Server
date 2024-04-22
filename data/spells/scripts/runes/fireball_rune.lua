local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

local area = createCombatArea(AREA_CIRCLE2X2)
combat:setArea(area)

function onGetFormulaValues(player, level, magicLevel)
	local min = (level * 2 + magicLevel * 3) * 0.16
	local max = (level * 2 + magicLevel * 3) * 0.33
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant, isHotkey)
	return combat:execute(creature, variant)
end
