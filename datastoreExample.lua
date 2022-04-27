--[[
    This Code is working perfectly fine cause I created it like 1 Week ago
    Automated the Folder creation of the PlayerData Folder so you don't have to add it
    Also this prevents Dataloss if you are saving alot of PlayerData in your game this is perfect!
    This is NOT for Auto Save Systems because you will easily be at the max limit of data cache
    Last Updated: 04/27/22
    Cynica™
--]]

--// Vars
local DataStoreService = game:getService("DataStoreService")
local PlayerStats = DataStoreService:GetDataStore("PlayerStats")
local DefValues = {
  Coins = 0; -- Those are just examples you can put in here what your Game wants to save
  Bounty = 0;
}
--// Functions
function CreateServerStorageFolder()
   if not game:GetService("ServerStorage"):FindFirstChild("PlayerData") then
      local NewFolder = Instance.new("Folder", game:GetService("ServerStorage"))
      NewFolder.Name = "PlayerData"
   end
end
game:GetService("Players").PlayerAdded:Connect(function(Player)
    CreateServerStorageFolder()
    if not game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name) then
       local PlayerData = Instance.new("Folder", game:GetService("ServerStorage").PlayerData)
       PlayerData.Name = Player.Name
       local Coins = Instance.new("IntValue", PlayerData)
       Coins.Name = "Coins"
       Coins.Value = DefValues.Coins
       local Bounty = Instance.new("IntValue", PlayerData)
       Bounty.Name = "Bounty"
       Bounty.Value = DefValues.Bounty
       local Weapons = Instance.new("Folder", PlayerData)
       Weapons.Name = "Weapons"
    end
    local Success, Returned = pcall(function()
        return PlayerStats:GetAsync(Player.UserId)
    end)
    if Success and Returned then
       game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Coins.Value = Returned["Coins"]
       game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Bounty.Value = Returned["Bounty"]
       local WeaponCount = 0
       for _, _ in pairs(Returned["Weapons"]) do
          WeaponCount += 1
          break
       end
       if WeaponCount > 0 then
          for _, v in pairs(Returned["Weapons"]) do
             local Weapon = Instance.new("BoolValue")
             Weapon.Name = v
             Weapon.Parent = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Weapons
          end
       else
           print("[Server]: " .. Player.Name .. " has no Weapons")
       end
       print("[Server]: Loaded " .. Player.Name .. "'s Data")
    end
end)
game:GetService("Players").PlayerRemoving:Connect(function(Player) -- We will only save PlayerData when the Player leaves because we are limited to 4MB cache per Player
   local Coins = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Coins.Value
   local Bounty = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Bounty.Value
   local Weapons = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Weapons:GetChildren()
   local WeaponTable = {}
   for i, v in ipairs(Weapons) do
      table.insert(WeaponsTable, i, v.Name)  
   end
   local PlayerTable = {
        ["Coins"] = Coins;
        ["Bounty"] = Bounty;
        ["Weapons"] = WeaponsTable
   }
   PlayerStats:SetAsync(Player.UserId, PlayerTable)
   print("[Server]: Successfully saved " .. Player.Name .. "'s Data")
   game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name):Destroy()
end)
function ShutdownSave(Player) -- It's just the same function when the Player leaves but this is for if the Developers are shutting down Servers
   local Coins = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Coins.Value
   local Bounty = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Bounty.Value
   local Weapons = game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name).Weapons:GetChildren()
   local WeaponTable = {}
   for i, v in ipairs(Weapons) do
      table.insert(WeaponsTable, i, v.Name)
   end
   local PlayerTable = {
        ["Coins"] = Coins;
        ["Bounty"] = Bounty;
        ["Weapons"] = WeaponsTable
   }
   PlayerStats:SetAsync(Player.UserId, PlayerTable)
   print("[Server]: Successfully saved " .. Player.Name .. "'s Data")
   game:GetService("ServerStorage").PlayerData:FindFirstChild(Player.Name):Destroy()
end
game:BindToClose(function()
   for _, Player in pairs(game:GetService("Players"):GetPlayers()) do
      task.spawn(function()
         ShutdownSave(Player)
      end)  
   end
   task.wait(3.5) -- We wait 3 seconds because Studio shuts down really fast
end)
