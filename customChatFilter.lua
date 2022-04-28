--[[
    How does this work?
    First start your game in studio then go to explorer and chat, then copy the 'ChatModules' Folder and click on stop
    After that just paste the copied Folder into 'Chat' (when not ingame)
    Then create a 'ModuleScript' and paste this Code in there, place it in the copied 'ChatModules'
    Cynica™
--]]

--[[ Remember this is a 'ModuleScript' --]]
local FilterList = { -- Put your message in the first arg for what to replace in the second arg
  {"TOREPLACE", "Made by Cynica™"},
  {"bad", "well played mate!"}
}
local function Filter(SpeakerName, MessageObj)
  for i, FilterWord in pairs(FilterList) do
    if string.lower(MessageObj.Message):match(FilterWord[1]) then
      MessageObj.Message = FilterWord[2]
    end
  end
end
local function Run(ChatService)
  ChatService:RegisterFilterMessageFunction("CustomFilter", Filter)
end
return Run
