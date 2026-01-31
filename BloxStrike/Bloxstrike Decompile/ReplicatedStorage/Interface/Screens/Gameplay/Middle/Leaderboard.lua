local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_6 = v_u_4.LocalPlayer
local v_u_7 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_8 = require(v_u_2.Components.Common.GetBadgeIcon)
local v_u_9 = require(v_u_2.Controllers.EndScreenController)
local v_u_10 = require(v_u_2.Controllers.DataController)
local v_u_11 = require(v_u_2.Packages.Observers)
local v_u_12 = require(v_u_2.Shared.Janitor)
local v_u_13 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_14 = UDim2.fromScale(0.582, 0.782)
local v_u_15 = UDim2.fromScale(0.582, 0.355)
local v_u_16 = UDim2.fromScale(0.282, 0.85)
local v_u_17 = UDim2.fromScale(0.82, 0.9)
local v_u_18 = UDim2.fromScale(0.758, 0.9)
local v_u_19 = UDim2.fromScale(0.638, 0.9)
local v_u_20 = UDim2.fromScale(0.937, 0.9)
local v_u_21 = UDim2.fromScale(0.702, 0.9)
local v_u_22 = UDim2.fromScale(0.882, 0.9)
local v_u_23 = UDim2.fromScale(0.762, 0.365)
local v_u_24 = UDim2.fromScale(0.503, 0.785)
local v_u_25 = UDim2.fromScale(0.503, 0.364)
local v_u_26 = UDim2.fromScale(0.135, 0.85)
local v_u_27 = UDim2.fromScale(0.79, 0.9)
local v_u_28 = UDim2.fromScale(0.715, 0.9)
local v_u_29 = UDim2.fromScale(0.57, 0.9)
local v_u_30 = UDim2.fromScale(0.932, 0.9)
local v_u_31 = UDim2.fromScale(0.648, 0.9)
local v_u_32 = UDim2.fromScale(0.866, 0.9)
local v_u_33 = UDim2.fromScale(0.921, 0.365)
local v_u_34 = nil
local v_u_35 = {}
local function v_u_39(p36)
    local v37 = p36:GetChildren()
    for _, v38 in ipairs(v37) do
        if v38.ClassName == "Frame" then
            v38:Destroy()
        end
    end
end
local function v_u_43(p40)
    local v41 = {}
    for _, v42 in ipairs(v_u_4:GetPlayers()) do
        if v42:GetAttribute("Team") == p40 then
            table.insert(v41, v42)
        end
    end
    return v41
end
local function v_u_46()
    local v44 = workspace:GetAttribute("Gamemode")
    v_u_34.Team.CT.Score.Visible = v44 ~= "Deathmatch"
    v_u_34.Team.T.Score.Visible = v44 ~= "Deathmatch"
    local v45 = workspace:GetAttribute("Map")
    v_u_34.TopInfo.Gamemode.Text = ("%* | %*"):format(v44, v45)
    if v44 == "Deathmatch" then
        v_u_34["Counter-Terrorists"].Position = v_u_24
        v_u_34.Terrorists.Position = v_u_25
        v_u_34.TopInfo.Assists.Position = v_u_27
        v_u_34.TopInfo.Deaths.Position = v_u_28
        v_u_34.TopInfo.Money.Position = v_u_29
        v_u_34.TopInfo.Score.Position = v_u_30
        v_u_34.TopInfo.Kills.Position = v_u_31
        v_u_34.TopInfo.MVPs.Position = v_u_32
        v_u_34.TopInfo.Ping.Position = v_u_26
        v_u_34["Counter-Terrorists"].Size = v_u_33
        v_u_34.Terrorists.Size = v_u_33
        v_u_34.DeathmatchDivider.Visible = true
        v_u_34.Team.Visible = false
    elseif v44 == "Bomb Defusal" or v44 == "Hostage Rescue" then
        v_u_34["Counter-Terrorists"].Position = v_u_14
        v_u_34.Terrorists.Position = v_u_15
        v_u_34.TopInfo.Assists.Position = v_u_17
        v_u_34.TopInfo.Deaths.Position = v_u_18
        v_u_34.TopInfo.Score.Position = v_u_20
        v_u_34.TopInfo.Kills.Position = v_u_21
        v_u_34.TopInfo.Money.Position = v_u_19
        v_u_34.TopInfo.MVPs.Position = v_u_22
        v_u_34.TopInfo.Ping.Position = v_u_16
        v_u_34["Counter-Terrorists"].Size = v_u_23
        v_u_34.Terrorists.Size = v_u_23
        v_u_34.DeathmatchDivider.Visible = false
        v_u_34.Team.Visible = true
    end
end
function v_u_1.createTemplate(p_u_47, p_u_48, p_u_49)
    local v_u_50 = v_u_2.Assets.UI.Leaderboard[p_u_48]:Clone()
    v_u_50.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(p_u_47.UserId)
    v_u_50.PlayerName.Text = ("%* (@%*)"):format(p_u_47.DisplayName, p_u_47.Name)
    local v51 = v_u_8(p_u_47, p_u_48)
    v_u_50.Badge.Visible = v51 ~= ""
    v_u_50.Badge.Image = v51
    v_u_50.LayoutOrder = 0
    v_u_50.Assists.Amount.Text = "0"
    v_u_50.Deaths.Amount.Text = "0"
    v_u_50.Score.Amount.Text = "0"
    v_u_50.Kills.Amount.Text = "0"
    v_u_50.MVPs.Amount.Text = "0"
    v_u_50.Money.Amount.Text = ""
    v_u_50.LayoutOrder = 1
    v_u_50.Ping.Text = "0"
    local v_u_52 = {}
    local function v_u_55(p53)
        if p53:IsA("Frame") then
            v_u_52[p53] = {
                ["BackgroundTransparency"] = p53.BackgroundTransparency
            }
        elseif p53:IsA("TextLabel") then
            v_u_52[p53] = {
                ["BackgroundTransparency"] = p53.BackgroundTransparency,
                ["TextTransparency"] = p53.TextTransparency
            }
        elseif p53:IsA("TextButton") then
            v_u_52[p53] = {
                ["BackgroundTransparency"] = p53.BackgroundTransparency,
                ["TextTransparency"] = p53.TextTransparency
            }
        elseif p53:IsA("ImageLabel") then
            v_u_52[p53] = {
                ["BackgroundTransparency"] = p53.BackgroundTransparency,
                ["ImageTransparency"] = p53.ImageTransparency
            }
        elseif p53:IsA("ImageButton") then
            v_u_52[p53] = {
                ["BackgroundTransparency"] = p53.BackgroundTransparency,
                ["ImageTransparency"] = p53.ImageTransparency
            }
        end
        for _, v54 in ipairs(p53:GetChildren()) do
            v_u_55(v54)
        end
    end
    v_u_52[v_u_50] = {
        ["BackgroundTransparency"] = v_u_50.BackgroundTransparency
    }
    for _, v56 in ipairs(v_u_50:GetChildren()) do
        v_u_55(v56)
    end
    if p_u_47 == v_u_6 then
        v_u_50.BackgroundColor3 = Color3.fromRGB(139, 128, 98)
    end
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Money", function(p57)
        local v58 = workspace:GetAttribute("Gamemode")
        if p_u_47:GetAttribute("Team") == v_u_6:GetAttribute("Team") or v58 == "Deathmatch" then
            v_u_50.Money.Amount.Text = ("$%*"):format((tostring(p57):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        else
            v_u_50.Money.Amount.Text = ""
        end
    end))
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Kills", function(p59)
        v_u_50.Kills.Amount.Text = tostring(p59):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_50.LayoutOrder = -p59
    end))
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Deaths", function(p60)
        v_u_50.Deaths.Amount.Text = tostring(p60):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Assists", function(p61)
        v_u_50.Assists.Amount.Text = tostring(p61):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Score", function(p62)
        v_u_50.Score.Amount.Text = tostring(p62):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "MVPs", function(p63)
        v_u_50.MVPs.Amount.Text = tostring(p63):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Ping", function(p64)
        v_u_50.Ping.Text = p64
    end))
    local function v_u_78()
        local v65 = p_u_47.Character
        if v65 then
            v65 = v65:GetAttribute("Dead") == true
        end
        local v66 = p_u_47:GetAttribute("IsSpectating") == true
        local v67 = v65 == true and true or v66 == true
        if v_u_50 and v_u_50:FindFirstChild("Dead") then
            v_u_50.Dead.Visible = v67
        end
        if v67 then
            if v_u_50:FindFirstChild("Bomb") then
                v_u_50.Bomb.Visible = false
            end
            if v_u_50:FindFirstChild("DefuseKit") then
                v_u_50.DefuseKit.Visible = false
            end
        end
        if v67 then
            v_u_50.BackgroundTransparency = 1
            local function v_u_70(p68)
                if p68:IsA("Frame") then
                    p68.BackgroundTransparency = 1
                elseif p68:IsA("TextLabel") then
                    p68.TextTransparency = 0.5
                    p68.BackgroundTransparency = 1
                elseif p68:IsA("TextButton") then
                    p68.TextTransparency = 0.5
                    p68.BackgroundTransparency = 1
                elseif p68:IsA("ImageLabel") then
                    p68.ImageTransparency = 0.5
                    p68.BackgroundTransparency = 1
                elseif p68:IsA("ImageButton") then
                    p68.ImageTransparency = 0.5
                    p68.BackgroundTransparency = 1
                end
                for _, v69 in ipairs(p68:GetChildren()) do
                    v_u_70(v69)
                end
            end
            for _, v71 in ipairs(v_u_50:GetChildren()) do
                v_u_70(v71)
            end
        else
            local function v_u_75(p72)
                local v73 = v_u_52[p72]
                if v73 then
                    if p72:IsA("Frame") then
                        p72.BackgroundTransparency = v73.BackgroundTransparency
                    elseif p72:IsA("TextLabel") then
                        p72.TextTransparency = v73.TextTransparency
                        p72.BackgroundTransparency = v73.BackgroundTransparency
                    elseif p72:IsA("TextButton") then
                        p72.TextTransparency = v73.TextTransparency
                        p72.BackgroundTransparency = v73.BackgroundTransparency
                    elseif p72:IsA("ImageLabel") then
                        p72.ImageTransparency = v73.ImageTransparency
                        p72.BackgroundTransparency = v73.BackgroundTransparency
                    elseif p72:IsA("ImageButton") then
                        p72.ImageTransparency = v73.ImageTransparency
                        p72.BackgroundTransparency = v73.BackgroundTransparency
                    end
                end
                for _, v74 in ipairs(p72:GetChildren()) do
                    v_u_75(v74)
                end
            end
            local v76 = v_u_52[v_u_50]
            if v76 then
                v_u_50.BackgroundTransparency = v76.BackgroundTransparency
            end
            for _, v77 in ipairs(v_u_50:GetChildren()) do
                v_u_75(v77)
            end
        end
    end
    local v_u_79 = nil
    local function v_u_81()
        local v80 = p_u_47.Character
        if v80 then
            v_u_78()
            return v80:GetAttributeChangedSignal("Dead"):Connect(function()
                v_u_78()
                if v_u_79 then
                    v_u_79()
                end
            end)
        else
            v_u_78()
            return nil
        end
    end
    p_u_49:Add(v_u_11.observeAttribute(p_u_47, "IsSpectating", function(_)
        v_u_78()
    end))
    local v83 = p_u_47.CharacterAdded:Connect(function(_)
        task.wait(0.1)
        local v82 = v_u_81()
        if v82 then
            p_u_49:Add(v82)
        end
        if v_u_79 then
            v_u_79()
        end
    end)
    local v84 = p_u_47.CharacterRemoving:Connect(function(_)
        v_u_78()
    end)
    p_u_49:Add(v83)
    p_u_49:Add(v84)
    if p_u_47.Character then
        local v85 = v_u_81()
        if v85 then
            p_u_49:Add(v85)
        end
    else
        v_u_78()
    end
    local v_u_87 = v_u_10.CreateListener(p_u_47, ("Loadout.%*.Equipped.Equipped Badge"):format(p_u_48), function()
        local v86 = v_u_8(p_u_47, p_u_48)
        v_u_50.Badge.Image = v86
        v_u_50.Badge.Visible = v86 ~= ""
    end)
    p_u_49:Add(function()
        v_u_10.RemoveListener(p_u_47, ("Loadout.%*.Equipped.Equipped Badge"):format(p_u_48), v_u_87)
    end)
    v_u_79 = function()
        local v88 = p_u_47:GetAttribute("Team") == v_u_6:GetAttribute("Team")
        local v89 = p_u_47.Character
        if v89 then
            v89 = v89:GetAttribute("Dead") == true
        end
        local v90 = p_u_47:GetAttribute("IsSpectating") == true
        local v91 = not v89
        if v91 then
            v91 = not v90
        end
        if p_u_48 == "Terrorists" then
            local v92 = v_u_50:FindFirstChild("Bomb")
            if v92 then
                local v93 = p_u_47:GetAttribute("Slot5")
                if v93 then
                    local v94 = v_u_5:JSONDecode(v93 or "[]")
                    if v88 then
                        if v91 then
                            if v94 then
                                v94 = v94.Weapon == "C4"
                            end
                        else
                            v94 = v91
                        end
                    else
                        v94 = v88
                    end
                    v92.Visible = v94
                else
                    v92.Visible = false
                end
            end
        else
            local v95 = p_u_48 == "Counter-Terrorists" and v_u_50:FindFirstChild("DefuseKit")
            if v95 then
                local v96 = p_u_47:GetAttribute("HasDefuseKit")
                if v88 then
                    if v91 then
                        v91 = v96 == true
                    end
                else
                    v91 = v88
                end
                v95.Visible = v91
            end
        end
    end
    if p_u_48 == "Terrorists" then
        p_u_49:Add(v_u_11.observeAttribute(p_u_47, "Slot5", function(_)
            v_u_79()
            return function()
                if v_u_50 and v_u_50:FindFirstChild("Bomb") then
                    v_u_50.Bomb.Visible = false
                end
            end
        end))
    elseif p_u_48 == "Counter-Terrorists" then
        p_u_49:Add(v_u_11.observeAttribute(p_u_47, "HasDefuseKit", function(_)
            v_u_79()
            return function()
                if v_u_50 and v_u_50:FindFirstChild("DefuseKit") then
                    v_u_50.DefuseKit.Visible = false
                end
            end
        end))
    end
    p_u_49:Add(v_u_11.observeAttribute(v_u_6, "Team", function()
        v_u_79()
    end))
    v_u_79()
    return v_u_50
end
function v_u_1.openFrame()
    if not v_u_9.IsActive() then
        v_u_34.Visible = true
    end
end
function v_u_1.closeFrame()
    v_u_34.Visible = false
end
function v_u_1.characterAdded(p97, p98)
    local v99 = v_u_12.new()
    v_u_1.cleanup(p97)
    local v_u_100 = v_u_1.createTemplate(p97, p98, v99)
    v_u_100.Parent = v_u_34:FindFirstChild(p98)
    v99:Add(function()
        v_u_100:Destroy()
    end)
    v_u_35[p97] = v99
end
function v_u_1.observePlayer(p_u_101)
    v_u_11.observeAttribute(p_u_101, "Team", function(p102)
        if p102 == "Terrorists" or p102 == "Counter-Terrorists" then
            v_u_1.characterAdded(p_u_101, p102)
        end
        return function()
            v_u_1.cleanup(p_u_101)
        end
    end)
end
function v_u_1.cleanup(p103)
    local v104 = v_u_35[p103]
    v_u_35[p103] = nil
    if v104 then
        v104:Destroy()
    end
end
function v_u_1.Initialize(_, p105)
    v_u_34 = p105
    v_u_11.observeAttribute(workspace, "Gamemode", v_u_46)
    v_u_11.observeAttribute(workspace, "Map", v_u_46)
    v_u_11.observeAttribute(workspace, "CTScore", function(p106)
        v_u_34.Team.CT.Score.Text = tostring(p106)
        return function()
            v_u_34.Team.CT.Score.Text = ""
        end
    end)
    v_u_11.observeAttribute(workspace, "TScore", function(p107)
        v_u_34.Team.T.Score.Text = tostring(p107)
        return function()
            v_u_34.Team.T.Score.Text = ""
        end
    end)
    v_u_11.observeAttribute(workspace, "Timer", function(p108)
        v_u_34.TopInfo.Timer.Text = v_u_13(p108)
    end)
    v_u_11.observePlayer(function(p_u_109)
        v_u_1.observePlayer(p_u_109)
        return function()
            v_u_1.cleanup(p_u_109)
        end
    end)
end
function v_u_1.Start()
    v_u_39((v_u_34:WaitForChild("Counter-Terrorists")))
    v_u_39((v_u_34:WaitForChild("Terrorists")))
    v_u_3.Heartbeat:Connect(function()
        local v110 = workspace:GetAttribute("Gamemode")
        if v110 == "Bomb Defusal" or v110 == "Hostage Rescue" then
            local v111 = v_u_43("Counter-Terrorists")
            local v112 = v_u_43("Terrorists")
            local v113 = #v111
            local v114 = #v112
            local v118 = v_u_7(v111, function(_, p115)
                local v116 = p115.Character
                if v116 and v116:IsDescendantOf(workspace) then
                    local v117 = v116:FindFirstChildOfClass("Humanoid")
                    if v117 and v117.Health > 0 then
                        return false
                    end
                end
                return true
            end)
            local v122 = v_u_7(v112, function(_, p119)
                local v120 = p119.Character
                if v120 and v120:IsDescendantOf(workspace) then
                    local v121 = v120:FindFirstChildOfClass("Humanoid")
                    if v121 and v121.Health > 0 then
                        return false
                    end
                end
                return true
            end)
            local v123 = v_u_34.Team.CT.Alive
            local v124 = #v118
            v123.Text = ("ALIVE %*/%*"):format(tostring(v124), (tostring(v113)))
            local v125 = v_u_34.Team.T.Alive
            local v126 = #v122
            v125.Text = ("ALIVE %*/%*"):format(tostring(v126), (tostring(v114)))
        end
    end)
end
return v_u_1