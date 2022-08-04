--[[
    ZionsReturn
    Last Updated 08/05/22
    This is a ModuleScript!
--]]

-- << Variables >> --

local Click = {}
Click.__index = Click
Click.__newindex = function()
	return error("Click__newindex is being locked")
end
Click.__metatable = function()
	return error("Click__metatable is being locked")
end

-- << Functions >> --

function Click.Effect(UI, Mouse, Duration, Color)
	local function Tween(Obj, Goal)
		game:GetService("TweenService"):Create(Obj, TweenInfo.new(Duration), Goal):Play()
	end
	local ASX, ASY = UI.AbsoluteSize.X, UI.AbsoluteSize.Y
	local APX, APY = UI.AbsolutePosition.X, UI.AbsolutePosition.Y
	local MX, MY = Mouse.X, Mouse.Y
	local Pos = UDim2.new(0, MX - APX, 0, MY - APY)
	local UBC3 = UI.BackgroundColor3
	local UR, UG, UB = UBC3.R, UBC3.G, UBC3.B
	local ui = Instance.new("Frame", UI)
	ui.BackgroundColor3 = Color
	ui.Name = "Ripple"
	ui.ZIndex = 100001
	local Corner = Instance.new("UICorner", ui)
	Corner.CornerRadius = UDim.new(1, 0)
	ui.AnchorPoint = Vector2.new(0.5, 0.5)
	ui.Position = Pos
	local MS = UDim2.fromOffset(math.max(ASX, ASY), math.max(ASX, ASY))
	ui:TweenSize(MS, "Out", "Sine", Duration)
	Tween(ui, {BackgroundTransparency = 1})
	task.wait(Duration)
	ui:Destroy()
end

return Click
