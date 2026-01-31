local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Controllers.EndScreenController)
local v_u_6 = require(v_u_2.Controllers.CameraController)
local v_u_7 = require(v_u_2.Database.Components.GameState)
local v_u_8 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_9 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_10 = require(v_u_2.Packages.Observers)
local v_u_11 = require(v_u_2.Database.Security.Remotes)
local v_u_12 = require(v_u_2.Interface.MenuState)
local v_u_13 = v_u_4.LocalPlayer
local v_u_14 = false
local v_u_15 = 0
local v_u_16 = nil
local v_u_17 = nil
local function v_u_22(p18, p19)
    local v20 = 0
    for _, v21 in ipairs(v_u_4:GetPlayers()) do
        if v21 ~= p19 and v21:GetAttribute("Team") == p18 then
            v20 = v20 + 1
        end
    end
    return v20
end
local function v_u_24(p_u_23)
    p_u_23.MouseEnter:Connect(function()
        v_u_3:Create(p_u_23, TweenInfo.new(0.1), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_23.MouseLeave:Connect(function()
        v_u_3:Create(p_u_23, TweenInfo.new(0.1), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
end
function v_u_1.ToggleTeamSelection()
    if v_u_5.IsActive() then
        return
    elseif v_u_16.Visible then
        v_u_1.closeFrame()
    else
        v_u_1.openFrame()
    end
end
function v_u_1.openFrame()
    if v_u_5.IsActive() then
        return
    elseif v_u_12.IsCaseSceneActive() or v_u_12.IsInspectActive() then
        return
    elseif not v_u_16.Visible then
        local v25 = v_u_17.Menu.Visible and v_u_12.GetCurrentScreen()
        if v25 and (v25 == "Loadout" or (v25 == "Inventory" or v25 == "Settings") or v25 == "Store") then
            local v26 = v_u_17.Menu:FindFirstChild(v25)
            if v26 and v26.Visible then
                return
            end
        end
        local v27 = require(v_u_2.Controllers.MenuSceneController)
        if v27.IsActive() then
            v27.HideMenuScene(true, false)
        end
        if v_u_17.Menu.Visible then
            v_u_6.setForceLockOverride("Menu", false)
            v_u_12.SetBlurEnabled(false)
        end
        local v28 = v_u_17.Gameplay.Middle:FindFirstChild("BuyMenu")
        v_u_14 = v28 and v28.Visible or false
        if v_u_14 then
            require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
        end
        v_u_6.setForceLockOverride("TeamSelection", true)
        if not v_u_13:GetAttribute("IsSpectating") then
            v_u_6.setPerspective(true, true)
        end
        v_u_17.Gameplay.Bottom.Visible = false
        v_u_17.Gameplay.Top.Visible = true
        v_u_17.Gameplay.Visible = true
        v_u_17.Menu.Visible = false
        for _, v29 in ipairs(v_u_17.Gameplay.Middle:GetChildren()) do
            local v30 = table.find(v_u_9(), "Mobile")
            if v29.Name == "Chat" then
                v29.Visible = not v30
            elseif v29.Name == "MobileButtons" then
                local v31 = v_u_13.Character
                if v31 and v31:IsDescendantOf(workspace) then
                    v29.Visible = v30
                else
                    v29.Visible = false
                end
            else
                v29.Visible = v29.Name == "Notification" and true or v29.Name == "TeamSelection"
            end
        end
    end
end
function v_u_1.closeFrame()
    v_u_6.setForceLockOverride("TeamSelection", false)
    if v_u_13.Character then
        v_u_6.setForceLockOverride("Menu", false)
    end
    if not v_u_13:GetAttribute("IsSpectating") then
        v_u_6.setPerspective(true, false)
    end
    v_u_16.Visible = false
    v_u_17.Gameplay.Middle.Crosshair.Visible = true
    v_u_17.Gameplay.Top.Visible = true
    v_u_17.Gameplay.Bottom.Visible = true
    local v32 = table.find(v_u_9(), "Mobile")
    local v33 = v_u_13.Character
    local v34 = v_u_13:GetAttribute("IsSpectating") == true
    for _, v35 in ipairs(v_u_17.Gameplay.Middle:GetChildren()) do
        local v36
        if v33 then
            v36 = v33:IsDescendantOf(workspace)
        else
            v36 = v33
        end
        local v37 = v35.Name
        if v37 == "Chat" then
            v35.Visible = not v32
        elseif v37 == "MobileButtons" then
            local v38
            if v32 then
                v38 = v36 or (v34 or false)
            else
                v38 = false
            end
            v35.Visible = v38
        elseif v37 == "Votekick" then
            v35.Visible = v35:GetAttribute("IsVoteKickActive") == true
        elseif v37 == "Notification" then
            v35.Visible = true
        elseif v37 == "SessionStats" then
            v35.Visible = not v32
        elseif v37 == "Radar" or v37 == "Crosshair" then
            v35.Visible = v36
        else
            v35.Visible = false
        end
    end
    if v_u_14 then
        local v39 = require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu)
        v_u_14 = false
        v39.openFrame()
    end
end
function v_u_1.chooseTeam(p40)
    if v_u_13:GetAttribute("Team") == p40 then
        v_u_1.closeFrame()
        return
    end
    local v41 = v_u_13
    local v42 = v_u_22("Counter-Terrorists", v41)
    local v43 = v_u_22("Terrorists", v41)
    local v44
    if p40 == "Terrorists" then
        if v43 >= v42 then
            ::l6::
            v44 = p40 == "Spectators" and true or v42 == v43
            goto l8
        end
        v44 = true
    else
        if p40 ~= "Counter-Terrorists" or v42 >= v43 then
            goto l6
        end
        v44 = true
    end
    ::l8::
    if v44 and tick() - v_u_15 >= 1 then
        v_u_11.TeamSelection.SelectTeam.Send(p40)
        v_u_15 = tick()
    end
end
function v_u_1.createTeamButtonAnimation(p45, p_u_46)
    local v_u_47 = v_u_16:FindFirstChild(p_u_46)
    if v_u_47 then
        p45.MouseEnter:Connect(function()
            local v48 = v_u_47.Icon.Outline
            local v49 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
            if not v49 then
                if p_u_46 == "Terrorists" then
                    v49 = Color3.fromRGB(219, 199, 126)
                else
                    v49 = false
                end
            end
            v48.ImageColor3 = v49
            local v50 = v_u_47.Icon.Team.Icon
            local v51 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(255, 255, 255)
            if not v51 then
                if p_u_46 == "Terrorists" then
                    v51 = Color3.fromRGB(255, 255, 255)
                else
                    v51 = false
                end
            end
            v50.ImageColor3 = v51
            local v52 = v_u_47.Icon.Team
            local v53 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(36, 41, 47)
            if not v53 then
                if p_u_46 == "Terrorists" then
                    v53 = Color3.fromRGB(89, 79, 50)
                else
                    v53 = false
                end
            end
            v52.ImageColor3 = v53
            v_u_47.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.318, 1), NumberSequenceKeypoint.new(1, 1) })
            for _, v54 in ipairs(v_u_47.Container:GetChildren()) do
                if v54:IsA("Frame") then
                    local v55 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(126, 140, 187)
                    if not v55 then
                        if p_u_46 == "Terrorists" then
                            v55 = Color3.fromRGB(219, 188, 110)
                        else
                            v55 = false
                        end
                    end
                    v54.BackgroundColor3 = v55
                    local v56 = v54.Player.UIStroke
                    local v57 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
                    if not v57 then
                        if p_u_46 == "Terrorists" then
                            v57 = Color3.fromRGB(219, 199, 126)
                        else
                            v57 = false
                        end
                    end
                    v56.Color = v57
                    v54.Player.Avatar.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
        end)
        p45.MouseLeave:Connect(function()
            local v58 = v_u_47.Icon.Outline
            local v59 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(107, 119, 138)
            if not v59 then
                if p_u_46 == "Terrorists" then
                    v59 = Color3.fromRGB(127, 115, 73)
                else
                    v59 = false
                end
            end
            v58.ImageColor3 = v59
            local v60 = v_u_47.Icon.Team.Icon
            local v61 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(131, 131, 131)
            if not v61 then
                if p_u_46 == "Terrorists" then
                    v61 = Color3.fromRGB(182, 182, 182)
                else
                    v61 = false
                end
            end
            v60.ImageColor3 = v61
            local v62 = v_u_47.Icon.Team
            local v63 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(20, 24, 27)
            if not v63 then
                if p_u_46 == "Terrorists" then
                    v63 = Color3.fromRGB(58, 51, 33)
                else
                    v63 = false
                end
            end
            v62.ImageColor3 = v63
            v_u_47.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.183193, 1), NumberSequenceKeypoint.new(1, 1) })
            for _, v64 in ipairs(v_u_47.Container:GetChildren()) do
                if v64:IsA("Frame") then
                    local v65 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(109, 121, 140)
                    if not v65 then
                        if p_u_46 == "Terrorists" then
                            v65 = Color3.fromRGB(131, 111, 66)
                        else
                            v65 = false
                        end
                    end
                    v64.BackgroundColor3 = v65
                    local v66 = v64.Player.UIStroke
                    local v67 = p_u_46 == "Counter-Terrorists" and Color3.fromRGB(50, 56, 65)
                    if not v67 then
                        if p_u_46 == "Terrorists" then
                            v67 = Color3.fromRGB(94, 85, 54)
                        else
                            v67 = false
                        end
                    end
                    v66.Color = v67
                    v64.Player.Avatar.ImageColor3 = Color3.fromRGB(138, 138, 138)
                end
            end
        end)
    end
end
function v_u_1.updatePlayerList(p_u_68, p69)
    local v70 = p_u_68:GetAttribute("Team")
    if v70 == "Counter-Terrorists" or v70 == "Terrorists" then
        local v71 = v_u_16
        local v72 = p_u_68.UserId
        local v73 = v71:FindFirstChild(tostring(v72), true)
        if v73 then
            v73:Destroy()
        end
        local v74 = v_u_2.Assets.UI.TeamSelection:FindFirstChild(v70)
        if v74 and not p69 then
            local v75 = v_u_16:WaitForChild(v70)
            local _, v76 = pcall(function()
                return v_u_4:GetUserThumbnailAsync(p_u_68.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            end)
            local v77 = v74:Clone()
            v77.Parent = v75.Container
            v77.Team.Text = p_u_68.DisplayName
            v77.Player.Avatar.Image = v76
            local v78 = p_u_68.UserId
            v77.Name = tostring(v78)
            v77.Visible = true
        end
    else
        local v79 = v_u_16
        local v80 = p_u_68.UserId
        local v81 = v79:FindFirstChild(tostring(v80), true)
        if v81 then
            v81:Destroy()
        end
    end
    v_u_16["Counter-Terrorists"].Players.Text = ("%* Player(s)"):format((v_u_22("Counter-Terrorists")))
    v_u_16.Terrorists.Players.Text = ("%* Player(s)"):format((v_u_22("Terrorists")))
end
function v_u_1.Initialize(p82, p83)
    v_u_16 = p83
    v_u_17 = p82
    v_u_10.observePlayer(function(p_u_84)
        v_u_1.updatePlayerList(p_u_84)
        local v_u_88 = v_u_10.observeAttribute(p_u_84, "Team", function(_)
            v_u_1.updatePlayerList(p_u_84)
            if v_u_13 == p_u_84 then
                v_u_1.closeFrame()
            end
            return function()
                local v85 = v_u_16
                local v86 = p_u_84.UserId
                local v87 = v85:FindFirstChild(tostring(v86), true)
                if v87 then
                    v87:Destroy()
                end
            end
        end)
        return function()
            v_u_1.updatePlayerList(p_u_84, true)
            v_u_88()
        end
    end)
    v_u_10.observeAttribute(v_u_13, "Team", function(_)
        if v_u_7.GetState() == "Round In Progress" then
            v_u_1.closeFrame()
        end
    end)
    v_u_10.observeAttribute(workspace, "Timer", function(p89)
        v_u_16.ProgressBar.Timer.Text = v_u_8(p89)
    end)
    v_u_13.CharacterAdded:Connect(function()
        if v_u_16.Visible then
            v_u_1.closeFrame()
        end
    end)
end
function v_u_1.Start()
    local v90 = v_u_16["Counter-Terrorists"].Button
    local v_u_91 = "Counter-Terrorists"
    v90.MouseButton1Click:Connect(function()
        v_u_1.chooseTeam(v_u_91)
    end)
    v_u_1.createTeamButtonAnimation(v90, "Counter-Terrorists")
    local v92 = v_u_16.Bottom.Buttons.Spectate
    local v_u_93 = "Spectators"
    v92.MouseButton1Click:Connect(function()
        v_u_1.chooseTeam(v_u_93)
    end)
    v_u_24(v92)
    local v94 = v_u_16.Terrorists.Button
    local v_u_95 = "Terrorists"
    v94.MouseButton1Click:Connect(function()
        v_u_1.chooseTeam(v_u_95)
    end)
    v_u_1.createTeamButtonAnimation(v94, "Terrorists")
    v_u_24(v_u_16.Bottom.Buttons.AutoSelect)
    v_u_16.Bottom.Buttons.AutoSelect.MouseButton1Click:Connect(function()
        local v96 = v_u_1.chooseTeam
        local v97 = v_u_13
        local v98 = v_u_22("Counter-Terrorists", v97)
        local v99 = v_u_22("Terrorists", v97)
        local v100
        if v98 == v99 then
            local v101 = v97:GetAttribute("Team")
            v100 = v101 == "Counter-Terrorists" and "Terrorists" or (v101 == "Terrorists" and "Counter-Terrorists" or "Terrorists")
        else
            v100 = v98 < v99 and "Counter-Terrorists" or "Terrorists"
        end
        v96(v100)
    end)
    v_u_24(v_u_16.Bottom.Buttons.BackHome)
    v_u_16.Bottom.Buttons.BackHome.MouseButton1Click:Connect(function()
        if v_u_13:GetAttribute("IsSpectating") ~= true then
            local v102 = v_u_13.Character
            local v103
            if v102 and v102:IsDescendantOf(workspace) then
                local v104 = v102:FindFirstChild("Humanoid")
                if v104 == nil then
                    v103 = false
                else
                    v103 = v104.Health > 0
                end
            else
                v103 = false
            end
            if not v103 then
                v_u_1.closeFrame()
                local v105 = require(v_u_2.Interface.Screens.Menu.Top)
                local v106 = require(v_u_2.Controllers.MenuSceneController)
                v_u_6.setForceLockOverride("Menu", true)
                v_u_6.setPerspective(true, true)
                v_u_17.Gameplay.Visible = false
                v_u_17.Gameplay.Bottom.Visible = false
                v_u_17.Menu.Visible = true
                v105.ResetToMainMenu()
                v106.ShowMenuScene()
                return
            end
        end
        v_u_1.closeFrame()
    end)
end
return v_u_1