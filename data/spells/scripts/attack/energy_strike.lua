local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_TELEPORT)

function onGetFormulaValues(cid, level, maglevel)
	local min = (level * 2 + maglevel * 3) * 0.25
	local max = (level * 2 + maglevel * 3) * 0.55
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end