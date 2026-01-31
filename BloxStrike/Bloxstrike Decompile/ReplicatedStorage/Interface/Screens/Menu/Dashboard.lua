local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("PolicyService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_9 = require(v_u_2.Database.Security.Remotes)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Database.Custom.GameStats.Missions)
local v12 = require(v_u_2.Database.Custom.Constants)
local v_u_13 = v6.LocalPlayer
local v_u_14 = { "News", "RedeemCode", "Verify" }
local v_u_15 = { "Container" }
local v_u_16 = {
    ["isLinked"] = false,
    ["hasClipped"] = false
}
local v_u_17 = {}
local v_u_18 = 0
local v_u_19 = nil
local v_u_20 = false
local v_u_21 = v12.EVENT_END_TIMES["MEDAL.TV"]
local v_u_22 = v12.ACTIVE_EVENTS["MEDAL.TV"]
local v_u_23 = nil
local function v_u_28(p24, p25)
    local v26 = p24:GetChildren()
    for _, v27 in ipairs(v26) do
        if v27:IsA("Frame") and not table.find(p25, v27.ClassName) then
            v27:Destroy()
        end
    end
end
local function v_u_35(p29)
    if not p29 then
        return nil
    end
    local v30 = v_u_7.Get(v_u_13, "Missions")
    if not v30 then
        return nil
    end
    local v31 = os.time() * 1000
    local v32 = nil
    for _, v33 in ipairs(v30) do
        local v34 = v_u_11.GetMissionDefinition(v33.MissionId)
        if v34 and (v34.Type == p29 and (v33.ExpiresAt > 0 and (v31 < v33.ExpiresAt and (not v32 or v33.ExpiresAt < v32)))) then
            v32 = v33.ExpiresAt
        end
    end
    return v32
end
local function v_u_44(p36, p37, p38)
    local v39 = p36:FindFirstChild("Bar")
    local v40 = v39 and v39:FindFirstChild("Frame")
    if v40 then
        local v41 = UDim2.fromScale(p37 and 1 or 0, 1)
        if p38 and p37 then
            v40.Size = UDim2.fromScale(0, 1)
            v_u_4:Create(v40, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = v41
            }):Play()
        else
            v40.Size = v41
        end
    end
    local v42 = p36:FindFirstChild("Button")
    if v42 then
        local v43 = v42:FindFirstChild("Title")
        if v43 then
            v43.Text = p37 and "COMPLETED" or "REFRESH"
        end
        v42.Active = not p37
    end
end
local function v_u_55(p45, p46, p47, p48, p49)
    local v50 = v_u_23.Holder.MedalEvent.Container.Frame.Rewards.Item.Frame.Progress.Content
    local v51 = v50:FindFirstChild("1")
    local v52 = v50:FindFirstChild("2")
    if v51 then
        local v53 = p45 and 0 or 0.75
        if p47 and p48 then
            v_u_4:Create(v51, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = v53
            }):Play()
        else
            v51.BackgroundTransparency = v53
        end
    end
    if v52 then
        local v54 = p46 and 0 or 0.75
        if p47 and p49 then
            v_u_4:Create(v52, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = v54
            }):Play()
            return
        end
        v52.BackgroundTransparency = v54
    end
end
local function v_u_75(p56)
    local v57 = v_u_23.Holder.MedalEvent.Container.Frame.ScrollingFrame
    local v58 = v_u_2.Assets.UI.MedalAssets
    local v59 = v_u_7.Get(v_u_13, "HasClaimedExclusiveMedalReward") == true
    local v_u_60 = v59 or v_u_13:GetAttribute("RobloxAccountLinkedToMedal") == true
    local v_u_61 = v59 or v_u_13:GetAttribute("HasClippedBloxStrike") == true
    local v62 = v_u_60 ~= v_u_16.isLinked
    local v63 = v_u_61 ~= v_u_16.hasClipped
    v_u_16.isLinked = v_u_60
    v_u_16.hasClipped = v_u_61
    v_u_55(v_u_60, v_u_61, p56, v62, v63)
    for _, v64 in ipairs(v57:GetChildren()) do
        if v64:IsA("Frame") then
            v64:Destroy()
        end
    end
    v_u_17 = {}
    local v65 = v58.Unlocked:Clone()
    v65.TextLabel.Text = "Link your Roblox account to your Medal account"
    v65.Name = "LinkAccount"
    v65.LayoutOrder = 1
    v65.Parent = v57
    v_u_17.LinkAccount = v65
    local v66 = v65.Button
    local function v_u_67()
        return v_u_60
    end
    v_u_8(v66)
    local v_u_68 = "link"
    v66.MouseButton1Click:Connect(function()
        if v_u_67() then
            return
        else
            local v69 = tick()
            if v69 - v_u_18 < 5 then
                v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Please wait before refreshing again.")
            else
                v_u_18 = v69
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_9.Collaborations.RefreshMedalStatus.Send(v_u_68)
            end
        end
    end)
    v_u_44(v65, v_u_60, p56 and v62)
    local v70
    if v_u_60 then
        v70 = v58.Unlocked:Clone()
        v70.TextLabel.Text = "Clip and upload your best BloxStrike moment"
        local v71 = v70.Button
        local function v_u_72()
            return v_u_61
        end
        v_u_8(v71)
        local v_u_73 = "clip"
        v71.MouseButton1Click:Connect(function()
            if v_u_72() then
                return
            else
                local v74 = tick()
                if v74 - v_u_18 < 5 then
                    v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Please wait before refreshing again.")
                else
                    v_u_18 = v74
                    v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                    v_u_9.Collaborations.RefreshMedalStatus.Send(v_u_73)
                end
            end
        end)
        v_u_44(v70, v_u_61, p56 and v63)
    else
        v70 = v58.Locked:Clone()
    end
    v70.Name = "ClipKill"
    v70.LayoutOrder = 2
    v70.Parent = v57
    v_u_17.ClipKill = v70
end
function v_u_1.CreateMissionTemplate(p76, p_u_77)
    local v78 = v_u_2.Assets.UI.Missions.Template:Clone()
    local v79 = v78.Bar.Progress
    local v80 = UDim2.fromScale
    local v81 = p_u_77.Progress / p_u_77.Target
    v79.Size = v80(math.min(v81, 1), 1)
    local v82 = v78.Progress
    local v83 = p_u_77.Progress
    local v84 = tostring(v83):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    local v85 = p_u_77.Target
    v82.Text = v84 .. "/" .. tostring(v85):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    v78.Parent = v_u_23.Holder.Missions.Container.Frame.Container
    v78.Button.Title.Text = p_u_77.IsClaimed and "CLAIMED" or "CLAIM"
    v78.Progress.Visible = p_u_77.Progress < p_u_77.Target
    v78.Button.Visible = p_u_77.Progress >= p_u_77.Target
    v78.Title.Text = p76.MissionId
    v78.Name = p_u_77.MissionId
    v78:SetAttribute("Progress", p_u_77.Progress)
    v78:SetAttribute("Target", p_u_77.Target)
    if p76.Rewards[1].type == "Credits" then
        local v86 = v78.ItemTemplate.Amount
        local v87 = p76.Rewards[1].amount
        v86.Text = tostring(v87):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v78.ItemTemplate.Frame.Icon.Image = "rbxassetid://129921992230064"
    end
    v_u_8(v78.Button)
    v78.Button.MouseButton1Click:Connect(function()
        local v88 = p_u_77.MissionId
        local v89 = v_u_7.Get(v_u_13, "Missions")
        local v91
        if v89 then
            for _, v91 in ipairs(v89) do
                if v91.MissionId == v88 then
                    goto l3
                end
            end
            v91 = nil
        else
            v91 = nil
        end
        ::l3::
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v91 and not v91.IsClaimed then
            v_u_9.Dashboard.MissionCompleted.Send(v91.MissionId)
        end
    end)
end
function v_u_1.UpdateCurrentMissions(_)
    if not v_u_7.Get(v_u_13, "Missions") then
        return
    end
    for _, v92 in ipairs(v_u_23.Holder.Missions.Container.Frame.Container:GetChildren()) do
        if v92:IsA("Frame") then
            local v93 = v92.Name
            local v94 = v_u_7.Get(v_u_13, "Missions")
            local v96
            if v94 then
                for _, v96 in ipairs(v94) do
                    if v96.MissionId == v93 then
                        goto l8
                    end
                end
                v96 = nil
            else
                v96 = nil
            end
            ::l8::
            if v96 then
                local v97 = v92:GetAttribute("Progress")
                local v98 = v92.Progress
                local v99 = v96.Progress
                local v100 = tostring(v99):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                local v101 = v96.Target
                v98.Text = v100 .. "/" .. tostring(v101):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                v92.Button.Title.Text = v96.IsClaimed and "CLAIMED" or "CLAIM"
                v92.Progress.Visible = v96.Progress < v96.Target
                v92.Button.Visible = v96.Progress >= v96.Target
                v92.Visible = true
                v92:SetAttribute("Progress", v96.Progress)
                v92:SetAttribute("Target", v96.Target)
                if v_u_23.Visible and v97 < v96.Progress then
                    local v102 = v_u_4
                    local v103 = v92.Bar.Progress
                    local v104 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v105 = {}
                    local v106 = UDim2.fromScale
                    local v107 = v96.Progress / v96.Target
                    v105.Size = v106(math.min(v107, 1), 1)
                    v102:Create(v103, v104, v105):Play()
                else
                    local v108 = v92.Bar.Progress
                    local v109 = UDim2.fromScale
                    local v110 = v96.Progress / v96.Target
                    v108.Size = v109(math.min(v110, 1), 1)
                end
            else
                v92:Destroy()
            end
        end
    end
end
function v_u_1.OpenMissionFrame(p111)
    local v112 = v_u_7.Get(v_u_13, "Missions")
    if v_u_19 ~= p111 then
        v_u_19 = p111
        if v112 then
            v_u_28(v_u_23.Holder.Missions.Container.Frame.Container, { "UIListLayout" })
            for _, v113 in ipairs(v112) do
                local v114 = v_u_11.GetMissionDefinition(v113.MissionId)
                if v114 and v114.Type == p111 then
                    v_u_1.CreateMissionTemplate(v114, v113)
                end
            end
        end
    end
end
function v_u_1.Initialize(p_u_115, p116)
    v_u_23 = p116
    v_u_23.Holder.Advertisement.Visible = false
    local v117, v118 = pcall(function(...)
        return v_u_3:GetPolicyInfoForPlayerAsync(v_u_13)
    end)
    if v117 and (v118 and v118.AllowedExternalLinkReferences) then
        local v_u_119 = table.find(v118.AllowedExternalLinkReferences, "Discord") ~= nil
        v_u_23.Holder.Advertisement.Visible = v_u_119 or false
        v_u_23.Holder.Advertisement:GetPropertyChangedSignal("Visible"):Connect(function()
            if not v_u_23.Holder.Advertisement.Visible then
                local v120 = v_u_23.Holder.Advertisement
                local v121 = v_u_119
                if v121 then
                    v121 = p_u_115.Menu.Dashboard.Visible
                end
                v120.Visible = v121
            end
        end)
        p_u_115.Menu.Dashboard:GetPropertyChangedSignal("Visible"):Connect(function()
            local v122 = v_u_119
            if v122 then
                v122 = p_u_115.Menu.Dashboard.Visible
            end
            if v_u_23.Holder.Advertisement.Visible ~= v122 then
                v_u_23.Holder.Advertisement.Visible = v122
            end
        end)
    end
    if v_u_22 then
        v_u_23.Holder.MedalEvent.Visible = true
    else
        v_u_23.Holder.MedalEvent.Visible = false
    end
    local v_u_123 = v_u_23.Holder.MedalEvent
    local v_u_124 = v_u_123.Container.Hide
    local v_u_125 = v_u_123.Position
    local v_u_126 = UDim2.new(1.46, v_u_125.X.Offset, v_u_125.Y.Scale, v_u_125.Y.Offset)
    local v_u_127 = false
    v_u_123.Position = v_u_125
    v_u_124.Rotation = 180
    v_u_124.MouseButton1Click:Connect(function()
        v_u_127 = not v_u_127
        if v_u_127 then
            local v128 = {
                ["Position"] = v_u_126
            }
            v_u_4:Create(v_u_123, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v128):Play()
            v_u_124.Rotation = 0
        else
            local v129 = {
                ["Position"] = v_u_125
            }
            v_u_4:Create(v_u_123, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v129):Play()
            v_u_124.Rotation = 180
        end
    end)
    v_u_8(v_u_23.Container.Reward.Frame.Button)
    v_u_23.Container.Reward.Frame.Button.MouseButton1Click:Connect(function()
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_9.Dashboard.RedeemLikeAndFavoriteReward.Send()
    end)
    v_u_8(v_u_23.Container.RedeemCode.Frame.Button)
    v_u_23.Container.RedeemCode.Frame.Button.MouseButton1Click:Connect(function()
        local v130 = v_u_7.Get(v_u_13, "Level")
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v130.Level >= 5 then
            local v131 = v_u_23.Container.RedeemCode.Frame.Container.Holder.TextBox.Text
            if tostring(v131) == "" then
                v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Invalid code. Please try again.")
            else
                v_u_23.Container.RedeemCode.Frame.Container.Holder.TextBox.Text = ""
                v_u_9.Dashboard.RedeemCode.Send(v131)
            end
        else
            v_u_10.broadcastRouter("CreateMenuNotification", "Error", "You need to be atleast level 5 to redeem codes.")
            return
        end
    end)
    for _, v132 in ipairs(v_u_23.Container:GetChildren()) do
        if v132:IsA("Frame") then
            v132.Visible = table.find(v_u_14, v132.Name)
        end
    end
    local v_u_133 = v_u_23.Holder.Missions.Container
    local v_u_134 = v_u_133.Hide
    local v_u_135 = v_u_133.Position
    local v_u_136 = UDim2.new(1.49, v_u_135.X.Offset, v_u_135.Y.Scale, v_u_135.Y.Offset)
    local v_u_137 = false
    v_u_133.Position = v_u_135
    v_u_134.Rotation = 180
    v_u_134.MouseButton1Click:Connect(function()
        v_u_137 = not v_u_137
        if v_u_137 then
            local v138 = {
                ["Position"] = v_u_136
            }
            v_u_4:Create(v_u_133, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v138):Play()
            v_u_134.Rotation = 0
        else
            local v139 = {
                ["Position"] = v_u_135
            }
            v_u_4:Create(v_u_133, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v139):Play()
            v_u_134.Rotation = 180
        end
    end)
end
function v_u_1.Start()
    for _, v_u_140 in ipairs(v_u_23.Holder.Missions.Container.Frame.Bottom.Container:GetChildren()) do
        if v_u_140:IsA("TextButton") then
            v_u_8(v_u_140)
            v_u_140.MouseButton1Click:Connect(function()
                v_u_1.OpenMissionFrame(v_u_140.Name)
            end)
        end
    end
    for _, v141 in ipairs(v_u_23.Holder:GetChildren()) do
        if v141:IsA("Frame") and (v141.Name ~= "Advertisement" and v141.Name ~= "MedalEvent") then
            v141.Visible = table.find(v_u_15, v141.Name)
        end
    end
    v_u_5.Heartbeat:Connect(function(_)
        if v_u_19 then
            local v142 = v_u_35(v_u_19)
            v_u_23.Holder.Missions.Container.Frame.Header.Title.Text = ("%* MISSIONS"):format((string.upper(v_u_19)))
            if v142 then
                local v143 = v142 - os.time() * 1000
                local v144 = math.max(0, v143) / 1000
                local v145 = math.floor(v144)
                v_u_23.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = v145 > 600 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 85, 85)
                local v146 = v_u_23.Holder.Missions.Container.Frame.Header.Timer
                local v147 = string.format
                local v148 = v145 / 86400
                local v149 = math.floor(v148)
                local v150 = v145 % 86400 / 3600
                local v151 = math.floor(v150)
                local v152 = v145 % 3600 / 60
                v146.Text = v147("%i:%02i:%02i:%02i", v149, v151, math.floor(v152), v145 % 60)
            else
                v_u_23.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = Color3.fromRGB(255, 85, 85)
                v_u_23.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", 0, 0, 0, 0)
            end
        else
            v_u_23.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
            v_u_23.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", 0, 0, 0, 0)
            v_u_23.Holder.Missions.Container.Frame.Header.Title.Text = "MISSIONS"
            return
        end
    end)
    v_u_7.CreateListener(v_u_13, "Missions", function(p153)
        if v_u_20 then
            v_u_1.UpdateCurrentMissions(p153)
        else
            v_u_1.OpenMissionFrame("hourly")
            v_u_20 = true
        end
    end)
    v_u_7.CreateListener(v_u_13, "LikeAndFavoriteReward", function(p154)
        v_u_23.Container.Reward.Visible = not p154
    end)
    if v_u_22 then
        if v_u_21 <= os.time() then
            v_u_23.Holder.MedalEvent.Visible = false
            return
        end
        v_u_75(false)
        v_u_13:GetAttributeChangedSignal("RobloxAccountLinkedToMedal"):Connect(function()
            v_u_75(true)
        end)
        v_u_13:GetAttributeChangedSignal("HasClippedBloxStrike"):Connect(function()
            v_u_75(true)
        end)
        v_u_7.CreateListener(v_u_13, "HasClaimedExclusiveMedalReward", function()
            v_u_75(false)
        end)
        local v_u_155 = v_u_23.Holder.MedalEvent.Container.Frame.Header.Timer
        v_u_5.Heartbeat:Connect(function(p156)
            local v157 = v_u_21 - os.time()
            local v158 = math.max(0, v157)
            if v158 <= 0 then
                v_u_23.Holder.MedalEvent.Visible = false
                return
            else
                local v159 = v158 / 86400
                local v160 = math.floor(v159)
                local v161 = v158 % 86400 / 3600
                local v162 = math.floor(v161)
                local v163 = v158 % 3600 / 60
                local v164 = math.floor(v163)
                local v165 = v158 % 60
                local v166 = v_u_23.Holder.MedalEvent.Container.Frame.Rewards.Item.Frame.Content.Outer.Icon.Glow
                v166.Rotation = v166.Rotation + p156 * 6.7
                if v160 >= 1 then
                    v_u_155.Text = string.format("%02i:%02i:%02i:%02i", v160, v162, v164, v165)
                else
                    v_u_155.Text = string.format("%02i:%02i:%02i", v162, v164, v165)
                end
            end
        end)
    end
end
return v_u_1