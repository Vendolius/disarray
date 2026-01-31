local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Interface.Screens.Menu.Top)
return table.freeze({
    ["Name"] = "Main Menu",
    ["Group"] = "Default",
    ["Category"] = "UI Keys",
    ["Callback"] = function(p5, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        else
            local v6 = v_u_3:GetAttribute("IsSpectating")
            local v7 = v_u_3:GetAttribute("Team")
            if (v7 == "Counter-Terrorists" or v7 == "Terrorists") and true or v6 == true then
                if p5 == Enum.UserInputState.Begin then
                    v_u_4.ToggleMenu()
                end
            end
        end
    end
})