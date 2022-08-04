--[[
    ZionsReturn
    Last Updated 08/05/22
    This is a ModuleScript!
    Script returns any value given rounded
--]]

-- << Functions >> --

return function(n)
	n = (n + 0.5) - (n + 0.5) % 1
	return n
end
