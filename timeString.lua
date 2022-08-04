--[[
    ZionsReturn
    Last Updated: 08/05/22
    This is a ModuleScript!
    Script will return a string with the number given converted in time
    Requires the round.lua script
--]]

-- << Variables >> --

local Round = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Modules"):WaitForChild("Round"))

-- << Functions >> --

return function(t)
	local Days = Round(t / 60 / 60 / 24 - 0.5)
	local Hours = Round(t / 60 / 60 % 24 - 0.5)
	local Minutes = Round(t / 60 % 60 - 0.5)
	local Seconds = Round(t % 60)
	local String = ""
	if Days >= 1 then
		String = Days .. (Days > 1 and " Days" or " Day")
	elseif Hours >= 1 then
		String = Hours .. (Hours > 1 and " Hours" or " Hour")
	elseif Minutes >= 1 then
		String = Minutes .. (Minutes > 1 and " Minutes" or " Minute")
	else
		String = Seconds .. (Seconds > 1 and " Seconds" or " Second")
	end
	return String
end
