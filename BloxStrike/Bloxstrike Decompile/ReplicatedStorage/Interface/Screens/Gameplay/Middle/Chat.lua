local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("TextChatService")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_5.LocalPlayer
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Controllers.InputController)
local v_u_10 = require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u_11 = require(v_u_2.Interface.MenuState)
local v_u_12 = require(v_u_2.Database.Components.Common.Roblox.CanPlayerUseChatService)
local v_u_13 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_14 = require(v_u_2.Database.Security.Remotes)
local v_u_15 = require(v_u_2.Database.Custom.GameStats.UI.Chat.ChatModes)
local v_u_16 = require(v_u_2.Database.Custom.GameStats.UI.Chat.Platforms)
local v_u_17 = require(v_u_2.Database.Custom.GameStats.UI.Chat.HTML)
local v_u_18 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = { v_u_16.PC }
local v_u_22 = v_u_15.Modes.All
local v_u_23 = false
local v_u_24 = false
local v_u_25 = {}
local v_u_26 = {}
local function v_u_27()
    return table.find(v_u_21, v_u_16.Mobile) and "Tap to chat" or ((table.find(v_u_21, v_u_16.Console) or table.find(v_u_21, v_u_16.VR)) and "" or string.format("Team Chat (%s) | All Chat (%s)", v_u_9.GetActionKeybind("Team Message") or "U", v_u_9.GetActionKeybind("Chat Message") or "Y"))
end
local function v_u_34(p_u_28)
    if p_u_28.frame and p_u_28.frame.Parent then
        if v_u_24 then
            return
        elseif not p_u_28.fadeConnection and p_u_28.frame.Message.TextTransparency < 1 then
            local v_u_29 = p_u_28.frame.Message.TextTransparency
            local v_u_30 = os.clock()
            local v_u_31 = nil
            v_u_31 = v_u_4.Heartbeat:Connect(function()
                if p_u_28.frame and p_u_28.frame.Parent then
                    if v_u_24 then
                        v_u_31:Disconnect()
                        p_u_28.fadeConnection = nil
                        p_u_28.frame.Message.TextTransparency = 0
                    else
                        local v32 = (os.clock() - v_u_30) / 3
                        local v33 = math.min(v32, 1)
                        p_u_28.frame.Message.TextTransparency = v_u_29 + (1 - v_u_29) * v33
                        if v33 >= 1 then
                            v_u_31:Disconnect()
                            p_u_28.fadeConnection = nil
                        end
                    end
                else
                    v_u_31:Disconnect()
                    p_u_28.fadeConnection = nil
                    return
                end
            end)
            p_u_28.fadeConnection = v_u_31
        end
    else
        return
    end
end
local function v_u_40(p35)
    v_u_24 = p35
    v_u_20.Chat.ScrollingFrame.ScrollBarImageTransparency = p35 and 0 or 1
    v_u_20.Chat.BackgroundTransparency = p35 and 0.55 or 1
    v_u_20.Type.BackgroundTransparency = p35 and 0.55 or 1
    v_u_20.BackgroundTransparency = p35 and 0.55 or 1
    v_u_20.Type.TextBox.PlaceholderColor3 = p35 and Color3.fromRGB(141, 141, 141) or Color3.new(1, 1, 1)
    if not p35 then
        v_u_20.Type.TextBox.PlaceholderText = v_u_27()
    end
    local v36 = os.clock()
    for _, v37 in ipairs(v_u_25) do
        if p35 then
            if v37.fadeConnection then
                v37.fadeConnection:Disconnect()
                v37.fadeConnection = nil
            end
            v37.frame.Message.TextTransparency = 0
        else
            local v38 = v36 - v37.timestamp
            if v38 > 10 then
                v37.frame.Message.TextTransparency = 1
            else
                local v39 = 10 - v38
                task.delay(v39, v_u_34, v37)
            end
        end
    end
end
local function v_u_46(p41)
    local v42 = #v_u_25 >= 15 and v_u_25[15]
    if v42 then
        v42.frame:Destroy()
        table.remove(v_u_25, 15)
    end
    local v43 = v_u_25
    table.insert(v43, 1, p41)
    for v44, v45 in ipairs(v_u_25) do
        v45.frame.LayoutOrder = #v_u_25 - v44
    end
    p41.frame.Message.TextTransparency = 0
    if not v_u_24 then
        task.delay(10, v_u_34, p41)
    end
    p41.frame.Parent = v_u_20.Chat.ScrollingFrame
    task.defer(function()
        v_u_20.Chat.ScrollingFrame.CanvasPosition = Vector2.new(0, v_u_20.Chat.ScrollingFrame.AbsoluteCanvasSize.Y)
    end)
end
local function v_u_50()
    if not v_u_23 and #v_u_26 ~= 0 then
        local v47 = 0
        v_u_23 = true
        while #v_u_26 > 0 and v47 < 2 do
            local v48 = table.remove(v_u_26, 1)
            if v48 then
                local v49 = v_u_19:Clone()
                v49.Message.Text = v48.text
                v_u_46({
                    ["frame"] = v49,
                    ["timestamp"] = v48.timestamp,
                    ["text"] = v48.text,
                    ["fadeConnection"] = nil
                })
                v47 = v47 + 1
            end
        end
        v_u_23 = false
    end
end
function v_u_1.OpenChat(p51)
    if v_u_24 then
        return
    elseif v_u_12(v_u_7) then
        if not table.find(v_u_21, v_u_16.Mobile) then
            v_u_10.closeFrame()
            v_u_22 = p51
            v_u_20.Visible = true
            v_u_20.Type.TextBox.PlaceholderText = v_u_15.Labels[p51]
            v_u_20.Type.TextBox.TextTransparency = 0
            v_u_20.Type.TextBox.Text = ""
            v_u_40(true)
            v_u_8.setMouseEnabled(true)
            v_u_7:SetAttribute("IsPlayerChatting", true)
            v_u_20.Type.TextBox:CaptureFocus()
            task.delay(0, function()
                v_u_20.Type.TextBox.Text = ""
            end)
        end
    else
        return
    end
end
function v_u_1.ProcessChatData(p52, p53)
    local v54 = not (p52.role and v_u_17.Roles[p52.role]) and "" or v_u_17.Roles[p52.role]
    local v55
    if p53 then
        v55 = v_u_17.Prefixes.Team
    else
        v55 = v_u_17.Prefixes.All
    end
    local v56 = v_u_17.TeamColors[p52.team] or ""
    local v57 = v_u_26
    local v58 = {
        ["text"] = v54 .. v55 .. string.format(v56, p52.displayName) .. (not p52.verified and "" or v_u_17.Badges.Verified .. " ") .. (p52.alive and "" or v_u_17.Suffixes.Dead) .. ": " .. p52.message,
        ["timestamp"] = os.clock()
    }
    table.insert(v57, v58)
    if not v_u_23 then
        v_u_50()
    end
end
function v_u_1.ProcessTeamJoin(p59, p60)
    local v61 = v_u_17.TeamJoinMessages[p60]
    if v61 then
        local v62 = v_u_26
        local v63 = {
            ["text"] = string.format(v61, p59),
            ["timestamp"] = os.clock()
        }
        table.insert(v62, v63)
        if not v_u_23 then
            v_u_50()
        end
    end
end
function v_u_1.ProcessPlayerLeave(p64)
    local v65 = v_u_26
    local v66 = {
        ["text"] = string.format(v_u_17.PlayerLeave, p64),
        ["timestamp"] = os.clock()
    }
    table.insert(v65, v66)
    if not v_u_23 then
        v_u_50()
    end
end
function v_u_1.ProcessPlayerBanned(p67)
    local v68 = v_u_26
    local v69 = {
        ["text"] = string.format(v_u_17.PlayerBanned, p67),
        ["timestamp"] = os.clock()
    }
    table.insert(v68, v69)
    if not v_u_23 then
        v_u_50()
    end
end
function v_u_1.ProcessKillMessage(p70)
    if p70.Killer == v_u_7.UserId then
        local v71 = v_u_26
        local v72 = {
            ["text"] = string.format(v_u_17.Points.Deathmatch, 11, p70.Weapon),
            ["timestamp"] = os.clock()
        }
        table.insert(v71, v72)
        if not v_u_23 then
            v_u_50()
        end
    end
end
function v_u_1.ProcessMoneyReward(p73)
    local v74 = v_u_17.Money[p73.source]
    if v74 then
        local v75 = p73.amount
        local v76 = tonumber(v75)
        if v76 then
            if p73.source == "Kill" and p73.weaponName then
                local v77 = (p73.weaponName == "Knife" or v76 > 300) and " (bonus)" or ""
                local v78 = v_u_26
                local v79 = {
                    ["text"] = string.format(v74, tostring(v76), p73.weaponName, v77),
                    ["timestamp"] = os.clock()
                }
                table.insert(v78, v79)
                if not v_u_23 then
                    v_u_50()
                end
            else
                local v80 = string.format
                local v81 = math.abs(v76)
                local v82 = v_u_26
                local v83 = {
                    ["text"] = v80(v74, (tostring(v81))),
                    ["timestamp"] = os.clock()
                }
                table.insert(v82, v83)
                if not v_u_23 then
                    v_u_50()
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.ProcessCaseOpened(p84)
    local v85 = v_u_17.TeamColors[p84.team] or ""
    local v86 = p84.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v87
    if v85 == "" then
        v87 = v86 .. " "
    else
        v87 = string.format(v85, v86)
    end
    local v88 = (v_u_18[p84.rarity] or v_u_18.Stock).Color
    local v89 = v88.R * 255 + 0.5
    local v90 = math.floor(v89)
    local v91 = v88.G * 255 + 0.5
    local v92 = math.floor(v91)
    local v93 = v88.B * 255 + 0.5
    local v94 = math.floor(v93)
    local v95 = string.format("rgb(%d,%d,%d)", v90, v92, v94)
    local v96 = p84.weaponName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v97 = p84.skinName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
    local v98 = (p84.statTrak and "KillTrak\226\132\162 " or "") .. v96 .. " | " .. v97
    local v99 = v_u_26
    local v100 = {
        ["text"] = v87 .. "<font color=\"rgb(255,255,255)\">opened a case and found: </font>" .. string.format("<font color=\"%s\">%s</font>", v95, v98),
        ["timestamp"] = os.clock()
    }
    table.insert(v99, v100)
    if not v_u_23 then
        v_u_50()
    end
end
function v_u_1.Initialize(_, p101)
    v_u_20 = p101
    v_u_21 = v_u_13()
    v_u_19 = v_u_2.Assets.UI.Chat.Template
    v_u_19.Message.RichText = true
    v_u_19.Parent = nil
    for _, v102 in ipairs(v_u_20.Chat.ScrollingFrame:GetChildren()) do
        if v102:IsA("Frame") then
            v102:Destroy()
        end
    end
    v_u_20.Type.TextBox.ClearTextOnFocus = false
    v_u_20.Type.TextBox.Focused:Connect(function()
        if v_u_24 then
            v_u_10.closeFrame()
            v_u_7:SetAttribute("IsPlayerChatting", true)
            v_u_20.Type.TextBox.TextTransparency = 0
            v_u_40(true)
            task.delay(0, function()
                v_u_20.Type.TextBox.Text = ""
            end)
            if v_u_15.Labels[v_u_22] then
                v_u_20.Type.TextBox.PlaceholderText = v_u_15.Labels[v_u_22]
            end
        else
            v_u_20.Type.TextBox:ReleaseFocus()
        end
    end)
    v_u_20.Type.TextBox.FocusLost:Connect(function(p103)
        v_u_7:SetAttribute("IsPlayerChatting", nil)
        local v104 = v_u_7.PlayerGui:FindFirstChild("MainGui")
        if v104 then
            v104 = v_u_7.PlayerGui.MainGui:FindFirstChild("Menu")
        end
        if v104 then
            v104 = v104.Visible
        end
        if not (v104 or (v_u_11.IsCaseSceneActive() or v_u_11.IsInspectActive())) then
            v_u_8.setMouseEnabled(false)
        end
        if p103 then
            local v105 = v_u_20.Type.TextBox.Text
            if string.len(v105) > 0 then
                local v106 = v_u_20.Type.TextBox.Text
                if #v106 <= 100 and #v106 > 0 then
                    local v107 = v_u_7.Character
                    local v108
                    if v107 then
                        v108 = v107:FindFirstChildOfClass("Humanoid")
                    else
                        v108 = v107
                    end
                    local v109
                    if v107 then
                        v109 = v107:GetAttribute("Dead") ~= true
                        if v109 then
                            v109 = v108 and v108.Health > 0 and true or false
                        end
                    else
                        v109 = false
                    end
                    local v110 = v_u_7:GetAttribute("Team")
                    local v111 = not v110 or v110 == "Spectators"
                    local v112
                    if v_u_22 == v_u_15.Modes.All then
                        v112 = (v109 or v111) and "All" or "AllDead"
                    else
                        v112 = v109 and "Team" or "TeamDead"
                    end
                    local v113 = v_u_6:FindFirstChild(v112)
                    if v113 then
                        v113:SendAsync(v106)
                    end
                end
            end
        end
        v_u_20.Type.TextBox.TextTransparency = 1
        v_u_20.Type.TextBox.Text = ""
        v_u_40(false)
    end)
    v_u_40(false)
    local v114 = v_u_12(v_u_7)
    local v115 = v_u_20
    if v114 then
        v114 = not table.find(v_u_21, v_u_16.Mobile)
    end
    v115.Visible = v114
end
function v_u_1.Start()
    local v116 = v_u_6:WaitForChild("All", 10)
    local v117 = v_u_6:WaitForChild("AllDead", 10)
    local v118 = v_u_6:WaitForChild("Team", 10)
    local v119 = v_u_6:WaitForChild("TeamDead", 10)
    local v_u_120 = true
    local v121 = v_u_7.Character
    v121 = v121
    local v122
    if v121 then
        v122 = v121:FindFirstChildOfClass("Humanoid")
    else
        v122 = v121
    end
    if v121 then
        local v123 = v121:GetAttribute("Dead") ~= true
        if v123 then
            v123 = v122 and v122.Health > 0 and true or false
        end
        v_u_120 = v123
    else
        v_u_120 = false
    end
    v_u_7.CharacterAdded:Connect(function(p124)
        local v125 = v_u_7.Character
        local v126
        if v125 then
            v126 = v125:FindFirstChildOfClass("Humanoid")
        else
            v126 = v125
        end
        if v125 then
            local v127 = v125:GetAttribute("Dead") ~= true
            if v127 then
                v127 = v126 and v126.Health > 0 and true or false
            end
            v_u_120 = v127
        else
            v_u_120 = false
        end
        p124:GetAttributeChangedSignal("Dead"):Connect(function()
            local v128 = v_u_7.Character
            local v129
            if v128 then
                v129 = v128:FindFirstChildOfClass("Humanoid")
            else
                v129 = v128
            end
            if v128 then
                local v130 = v128:GetAttribute("Dead") ~= true
                if v130 then
                    v130 = v129 and v129.Health > 0 and true or false
                end
                v_u_120 = v130
            else
                v_u_120 = false
            end
        end)
    end)
    local function v_u_136(p131)
        local v132 = v_u_5:GetPlayerByUserId(p131)
        if not (v132 and v132.Character) then
            return false
        end
        local v133 = v132.Character
        local v134 = v133:FindFirstChildOfClass("Humanoid")
        local v135 = v133:GetAttribute("Dead") ~= true
        if v135 then
            v135 = v134 and v134.Health > 0 and true or false
        end
        return v135
    end
    local v_u_137 = {}
    local function v_u_153(p138, p139, p140)
        if p138.Status == Enum.TextChatMessageStatus.Success then
            local v141 = p138.MessageId
            if v141 and v_u_137[v141] then
                return
            else
                if v141 then
                    v_u_137[v141] = true
                    local v142 = 0
                    for _ in v_u_137 do
                        v142 = v142 + 1
                    end
                    if v142 > 100 then
                        v_u_137 = {
                            [v141] = true
                        }
                    end
                end
                local v143 = p138.TextSource
                if v143 then
                    local v144 = v143.UserId
                    if v144 then
                        local v_u_145 = v_u_5:GetPlayerByUserId(v144)
                        if v_u_145 then
                            local v146 = v_u_136(v144)
                            local v147 = v_u_145:GetAttribute("Team")
                            local v148 = v_u_7:GetAttribute("Team")
                            if p139 == "All" or p139 == "AllDead" then
                                if v_u_120 and (not v146 and p139 == "All") then
                                    return
                                end
                            elseif p139 == "Team" or p139 == "TeamDead" then
                                if v147 ~= v148 then
                                    return
                                end
                                if p139 == "Team" and (v_u_120 and not v146) then
                                    return
                                end
                            end
                            local v149 = 0
                            local v150, v151 = pcall(function()
                                return v_u_145:GetRankInGroup(33751825)
                            end)
                            if v150 then
                                v149 = v151 or v149
                            end
                            local v152 = {
                                ["verified"] = v_u_145.HasVerifiedBadge,
                                ["displayName"] = v_u_145.DisplayName,
                                ["team"] = v147 or "Spectators",
                                ["message"] = p138.Text,
                                ["alive"] = v146,
                                ["role"] = v149
                            }
                            v_u_1.ProcessChatData(v152, p140)
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
        else
            return
        end
    end
    if v116 then
        function v116.OnIncomingMessage(p154)
            v_u_153(p154, "All", false)
            return nil
        end
    end
    if v117 then
        function v117.OnIncomingMessage(p155)
            v_u_153(p155, "AllDead", false)
            return nil
        end
    end
    if v118 then
        function v118.OnIncomingMessage(p156)
            v_u_153(p156, "Team", true)
            return nil
        end
    end
    if v119 then
        function v119.OnIncomingMessage(p157)
            v_u_153(p157, "TeamDead", true)
            return nil
        end
    end
    v_u_14.Chat.ChatTeamJoin.Listen(function(p158)
        v_u_1.ProcessTeamJoin(p158.name, p158.team)
    end)
    v_u_14.Chat.ChatPlayerLeave.Listen(function(p159)
        v_u_1.ProcessPlayerLeave(p159.name)
    end)
    v_u_14.Chat.ChatPlayerBanned.Listen(function(p160)
        v_u_1.ProcessPlayerBanned(p160.name)
    end)
    v_u_14.Chat.ChatPlayerKilled.Listen(function(p161)
        v_u_1.ProcessKillMessage(p161)
    end)
    v_u_14.Chat.ChatMoneyReward.Listen(function(p162)
        v_u_1.ProcessMoneyReward(p162)
    end)
    v_u_14.Chat.ChatCaseOpened.Listen(function(p163)
        v_u_1.ProcessCaseOpened(p163)
    end)
    v_u_4.Heartbeat:Connect(function()
        if #v_u_26 > 0 then
            v_u_50()
        end
    end)
    v_u_3.InputBegan:Connect(function(p164, p165)
        if not p165 and (p164.UserInputType == Enum.UserInputType.Keyboard and p164.KeyCode == Enum.KeyCode.Slash) then
            v_u_1.OpenChat(v_u_15.Modes.All)
        end
    end)
end
return v_u_1