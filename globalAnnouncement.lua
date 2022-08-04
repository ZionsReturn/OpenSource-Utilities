--[[
    ZionsReturn
    Last Updated 08/05/22
    Requirements:
    Create a RemoteEvent in ReplicatedStorage with the Name "GlobalAnnouncement"
    Then you can create a Custom Gui for the Announcement and put it in ReplicatedStorage
    You need to enable Studio API Access in game settings for it to work, also it won't work when trying in studio because roblox actually blocked that
--]]

--[[ This is the ServerScript, put it in 'ServerScriptService' --]]

--// Vars
local MessagingService = game:GetService("MessagingService")
local AdminList = {} -- Put any UserId in here, and as many as you want
--// Functions
game:GetService("Players").PlayerAdded:Connect(function(Player)
    Player.Chatted:Connect(function(Message)
        local SplitMessage = string.split(Message, " ")
        if SplitMessage[1] == "/global" then
           if table.find(AdminList, Player.UserId) then
              Message = string.gsub(Message, "/global ", "")
              local MessageData = {Sender = Player.Name, Message = Message}
              MessagingService:PublishAsync("Announcement", MessageData)
           end
        end
    end)
end)
MessagingService:SubscribeAsync("Announcement", function(SentData)
    local Data = SentData.Data
    game:GetService("ReplicatedStorage"):FindFirstChild("GlobalAnnouncement"):FireAllClients(Data.Sender, Data.Message)
end)

--[[ This is the LocalScript put it in like 'StarterGui' or smth --]]

--// Vars
local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("GlobalAnnouncement")
local Gui = game:GetService("ReplicatedStorage"):FindFirstChild("AnnouncementGui")
--// Functions
Remote.OnClientEvent:Connect(function(Sender, Message)
    if Sender and Message then
       local Clone = Gui:Clone()
       Clone.Parent = game:GetService("Players").LocalPlayer.PlayerGui
       Clone.Message.Text = Message
       Clone.Sender.Text = "@" .. Sender
    end
end)
