--[[
    This is a 'Script' located in 'ServerScriptService'
    It also comes with a DataStore (not well coded), look at my dataStoreExample.lua it is better
    I was too lazy to code a good DataStore for this right here :(
    Cynica™
--]]

--// Vars
local DataStoreService = game:GetService("DataStoreService")
local MoneyData = DataStoreService:GetDataStore("DataStoreNameHere")
local TimePerCheck = 60 -- This is in seconds and when a new PayCheck should be awarded to a player would recommend like 600
local MoneyPerCheck = 100
--// Functions
function SaveData(Player)
  local Success, Returned = pcall(function()
    local Money = Player.leaderstats.Money.Value
    MoneyData:SetAsync(Player.UserId .. "-Money", Money)
  end)
  if not Success then
    warn(Returned)
   else
    print("[Server]: Successfully saved " .. Player.Name .. "'s Data")
  end
end
game:GetService("Players").PlayerAdded:Connect(function(Player)
  local leaderstats = Instance.new("Folder", Player)
  leaderstats.Name = "leaderstats"
  local Money = Instance.new("IntValue", leaderstats)
  Money.Name = "Money"
  pcall(function()
    local MoneyData = MoneyData:GetAsync(Player.UserId .. "-Money") or 0
    Money.Value = MoneyData
  end)
  while wait(TimePerCheck) do
    Money.Value += MoneyPerCheck
  end
end)
game:GetService("Players").PlayerRemoving:Connect(SaveData)
game:BindToClose(function()
  for i, Player in pairs(game:GetService("Players"):GetPlayers()) do
    task.spawn(SaveData(Player))
  end
end)
