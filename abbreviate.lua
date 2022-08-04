--[[
    ZionsReturn
    Last Updated 08/05/22
--]]

-- << Variables >> --

local _abbreviations = {"K", "M", "B", "T", "QD", "QT", "SXT", "SEPT", "OCT", "NON", "DEC", "UDEC", "DDEC"}

-- << Functions >> --

return function(x, decimals)
	if decimals == nil then decimals = 0 end
	local visible = false
	local suffix = false
	if x < 1000 then
		visible = x * math.pow(10, decimals)
		suffix = ""
	else
		local digits = math.floor(math.log10(x)) + 1
		local index = math.min(#_abbreviations, math.floor((digits - 1) / 3))
		visible = x / math.pow(10, index * 3 - decimals)
		suffix = _abbreviations[index] .. "+"
	end
	local front = visible / math.pow(10, decimals)
	local back = visible % math.pow(10, decimals)
	if decimals > 0 then
		return string.format("%i.%0." .. tostring(decimals) .. "i%s", front, back, suffix)
	else
		return string.format("%i%s", front, suffix)
	end
end
