local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_TELEPORT)

local area = createCombatArea(AREA_SQUAREWAVE5, AREADIAGONAL_SQUAREWAVE5)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, maglevel)
	local min = (level * 2 + maglevel * 3) * 1.34
	local max = (level * 2 + maglevel * 3) * 2.33
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end
