spells = {
	"exevo gran mas vis", 2281
	"utevo res", 2264
}

function onCastSpell(creature, variant)
	if not creature:getGroup():getAccess() then
		return false
	end

	local spellName = variant:getString()
	local spell = Spell()
	if not spell then
		return false
	end

	-- spell name utevo res
	local spellName = variant;

	--
	local itemNumber = spells[spellName]

	if not itemNumber then
		return false

	return creature:conjureItem(2260, itemNumber, 1)
end
