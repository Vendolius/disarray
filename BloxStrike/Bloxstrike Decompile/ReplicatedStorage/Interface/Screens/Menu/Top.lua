local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Lighting")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.CameraController)
local v_u_8 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_9 = require(v_u_2.Database.Components.GameState)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Packages.Observers)
local v_u_12 = require(v_u_2.Interface.MenuState)
local v_u_13 = require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_14 = workspace.CurrentCamera
local v_u_15 = Instance.new("BlurEffect", v4)
v_u_15.Enabled = false
v_u_15.Name = "Menu"
v_u_15.Size = 20
local v_u_16 = false
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = Color3.fromRGB(255, 255, 255)
local v_u_20 = Color3.fromRGB(150, 220, 239)
local v_u_21 = Color3.fromRGB(175, 175, 175)
local v_u_22 = nil
local v_u_23 = nil
local function v_u_26(p24, p25)
    if p24:IsA("ImageButton") then
        v_u_3:Create(p24, TweenInfo.new(0.15), {
            ["ImageColor3"] = p25
        }):Play()
    elseif p24:IsA("TextButton") then
        v_u_3:Create(p24.TextLabel, TweenInfo.new(0.15), {
            ["TextColor3"] = p25
        }):Play()
    end
end
local function v_u_30(p_u_27)
    if p_u_27:IsA("ImageButton") then
        p_u_27.ImageColor3 = v_u_19
    elseif p_u_27:IsA("TextButton") then
        p_u_27.TextLabel.TextColor3 = v_u_19
    end
    p_u_27.MouseLeave:Connect(function()
        if v_u_18 ~= p_u_27 then
            v_u_26(p_u_27, v_u_19)
        end
    end)
    p_u_27.MouseEnter:Connect(function()
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Highlight")
        if v_u_18 ~= p_u_27 then
            v_u_26(p_u_27, v_u_21)
        end
    end)
    p_u_27.MouseButton1Click:Connect(function()
        local v28 = v_u_18
        v_u_18 = p_u_27
        if v28 ~= p_u_27 then
            v_u_26(p_u_27, v_u_20)
            if v28 then
                local v29 = v28:FindFirstChild("Alert")
                v_u_26(v28, v_u_19)
                if v29 then
                    v29.Visible = false
                    return
                end
            end
        end
    end)
end
function v_u_1.UpdateBackground(p31)
    if require(v_u_2.Controllers.MenuSceneController).IsActive() then
        return
    elseif v_u_12.IsInspectActive() or v_u_12.IsCaseSceneActive() then
        return
    elseif not v_u_6:GetAttribute("IsSpectating") then
        local v32 = v_u_23.Menu.Visible and (not v_u_6.Character and p31:FindFirstChild("Cameras"))
        if v32 then
            local v33 = v32:GetChildren()
            local v34 = v33[1]
            assert(v34, "Current map doesnt contain any cameras.")
            v_u_14.CameraType = Enum.CameraType.Scriptable
            v_u_14.CameraSubject = nil
            local v35 = v33[math.random(1, #v33)]
            v_u_6.ReplicationFocus = v35
            v_u_14.CFrame = v35.CFrame
            v_u_7.updateCameraFOV(80)
        end
    end
end
function v_u_1.ToggleMenu()
    if v_u_12.IsInspectActive() or v_u_12.IsCaseSceneActive() then
        return
    else
        if workspace:FindFirstChild("Map") then
            v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
        end
        local v36 = v_u_9.GetState()
        if v36 and (v36 ~= "Map Voting" and v36 ~= "Game Ending") then
            if v_u_23.Menu.Visible then
                v_u_7.setForceLockOverride("Menu", false)
                if not v_u_6:GetAttribute("IsSpectating") then
                    v_u_7.setPerspective(true, false)
                end
                v_u_12.SetBlurEnabled(false)
                v_u_23.Gameplay.Visible = true
                v_u_23.Gameplay.Top.Visible = true
                v_u_23.Menu.Visible = false
                v_u_12.SetScreen(nil)
            else
                if v_u_23.Gameplay.Middle.TeamSelection.Visible then
                    v_u_13.closeFrame()
                end
                v_u_7.setForceLockOverride("Menu", true)
                if not v_u_6:GetAttribute("IsSpectating") then
                    v_u_7.setPerspective(true, true)
                end
                v_u_23.Gameplay.Visible = false
                v_u_23.Menu.Visible = true
                if v_u_6.Character then
                    v_u_1.openFrame("GameDashboard")
                end
                if v_u_17 and v_u_17.Name ~= "Dashboard" then
                    v_u_12.SetBlurEnabled(true)
                end
            end
        else
            return
        end
    end
end
function v_u_1.openFrame(p37)
    if v_u_12.IsInspectActive() then
        return
    elseif v_u_12.IsCaseSceneActive() then
        return
    else
        local v38
        if p37 == "Dashboard" then
            v38 = false
        else
            v38 = p37 ~= "Play"
        end
        v_u_12.SetBlurEnabled(v38)
        local v39 = v_u_23.Menu:FindFirstChild("Pattern")
        v_u_23.Menu.BackgroundTransparency = v38 and 0.15 or 1
        if v39 then
            v39.Visible = not v38
        end
        if p37 == "Play" then
            local v40 = v_u_9.GetState()
            if v40 and v40 ~= "Game Ending" then
                local v41 = nil
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Play Click")
                v_u_7.resetForceLockOverride()
                v_u_7.setPerspective(true, false)
                if v_u_17 and v_u_17.Name ~= "Dashboard" then
                    v_u_17.Visible = false
                    local v42 = v_u_23.Menu:FindFirstChild("Dashboard")
                    if v42 then
                        v42.Visible = true
                        v_u_17 = v42
                    end
                end
                v_u_23.Gameplay.Bottom.Visible = false
                v_u_23.Gameplay.Top.Visible = true
                v_u_23.Gameplay.Visible = true
                v_u_23.Menu.Visible = false
                v_u_12.SetScreen(nil)
                local v43
                if v40 == "Map Voting" then
                    v43 = "EndScreen"
                else
                    local v44 = v_u_6:GetAttribute("Team")
                    v43 = (not v_u_6.Character or (not v44 or v44 == "Spectators")) and "TeamSelection" or v41
                end
                if v43 then
                    v_u_7.setForceLockOverride(v43, true)
                    v_u_7.setPerspective(true, true)
                    for _, v45 in ipairs(v_u_23.Gameplay.Middle:GetChildren()) do
                        if v45.Name == "Chat" then
                            v45.Visible = not table.find(v_u_8(), "Mobile")
                        else
                            v45.Visible = (v45.Name == "Notification" or v45.Name == "Votekick" and v45:GetAttribute("IsVoteKickActive") == true) and true or v45.Name == v43
                        end
                    end
                    return
                end
                v_u_23.Gameplay.Middle.SessionStats.Visible = table.find(v_u_8(), "Mobile") == nil
                v_u_23.Gameplay.Middle.TeamSelection.Visible = false
                v_u_23.Gameplay.Middle.Crosshair.Visible = true
                v_u_23.Gameplay.Top.Visible = true
                v_u_23.Gameplay.Bottom.Visible = true
                if v_u_6.Character then
                    v_u_7.setPerspective(true, false)
                    return
                end
            end
            return
        else
            local v46 = v_u_23.Menu:FindFirstChild(p37)
            if v46 and v46 ~= v_u_17 then
                v46.Visible = true
                if v_u_17 then
                    v_u_17.Visible = false
                end
                v_u_17 = v46
                local v47 = v_u_12.SetScreen
                local v48
                if p37 == "Dashboard" or (p37 == "Inventory" or (p37 == "Loadout" or (p37 == "Settings" or (p37 == "Store" or p37 == "GameDashboard")))) then
                    v48 = p37
                else
                    v48 = nil
                end
                v47(v48)
            end
            if v_u_16 then
                v_u_10.broadcastRouter("RunInterfaceSound", (("UI %* Click"):format(p37)))
            else
                v_u_16 = p37 == "Dashboard"
            end
        end
    end
end
function v_u_1.CloseTeamSelection()
    v_u_23.Gameplay.Middle.TeamSelection.Visible = false
    v_u_23.Gameplay.Middle.Crosshair.Visible = true
    v_u_23.Gameplay.Top.Visible = true
    v_u_23.Gameplay.Bottom.Visible = true
    if v_u_15.Enabled then
        v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
    end
end
local function v_u_52()
    if not v_u_23 then
        return false
    end
    local v49 = v_u_12.GetCurrentScreen()
    if not (v_u_23.Menu.Visible and v49) then
        return false
    end
    if v49 ~= "Loadout" and (v49 ~= "Inventory" and v49 ~= "Settings") and v49 ~= "Store" then
        return false
    end
    local v50 = v_u_23.Menu:FindFirstChild(v49)
    local v51
    if v50 == nil then
        v51 = false
    else
        v51 = v50.Visible
    end
    return v51
end
function v_u_1.ResetToMainMenu()
    if v_u_12.IsInspectActive() or v_u_12.IsCaseSceneActive() then
        return
    elseif not v_u_52() then
        for _, v53 in ipairs(v_u_23.Menu:GetChildren()) do
            if v53:IsA("Frame") and (v53.Name ~= "Top" and v53.Name ~= "Dashboard") then
                v53.Visible = false
            end
        end
        local v54 = v_u_23.Menu:FindFirstChild("Dashboard")
        if v54 then
            v54.Visible = true
            v_u_17 = v54
        end
        local v55 = v_u_23.Menu:FindFirstChild("Top")
        if v55 then
            v55.Visible = true
        end
        v_u_12.SetBlurEnabled(false)
        v_u_23.Menu.BackgroundTransparency = 1
        local v56 = v_u_23.Menu:FindFirstChild("Pattern")
        if v56 then
            v56.Visible = true
        end
        v_u_12.SetScreen("Dashboard")
        if v_u_18 then
            v_u_26(v_u_18, v_u_19)
        end
        v_u_18 = v_u_22.Other.Dashboard
        v_u_26(v_u_18, v_u_20)
    end
end
function v_u_1.Initialize(p57, p58)
    v_u_23 = p57
    v_u_22 = p58
    for _, v_u_59 in ipairs(v_u_22.Other:GetChildren()) do
        if v_u_59:IsA("ImageButton") then
            v_u_30(v_u_59)
            v_u_59.MouseButton1Click:Connect(function()
                v_u_1.openFrame(v_u_59.Name)
            end)
        end
    end
    for _, v_u_60 in ipairs(v_u_22.Buttons:GetChildren()) do
        if v_u_60:IsA("TextButton") then
            v_u_30(v_u_60)
            v_u_60.MouseButton1Click:Connect(function()
                v_u_1.openFrame(v_u_60.Name)
            end)
        end
    end
    if workspace:FindFirstChild("Map") then
        v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
    end
    workspace.ChildAdded:Connect(function(p61)
        if p61.Name == "Map" then
            task.delay(0.25, v_u_1.UpdateBackground, p61)
        end
    end)
end
function v_u_1.Start()
    v_u_18 = v_u_22.Other.Dashboard
    v_u_26(v_u_18, v_u_20)
    local v62 = v_u_23.Menu:FindFirstChild("Pattern")
    v_u_23.Menu.BackgroundTransparency = 1
    if v62 then
        v62.Visible = false
    end
    if v_u_23.Menu.Visible then
        v_u_7.setForceLockOverride("Menu", true)
    end
    local v63 = v_u_6:GetAttribute("Team")
    local v64 = v63 == "Counter-Terrorists" and true or v63 == "Terrorists"
    if not (v_u_6.Character or v64) then
        if not v_u_7.isForceLockOverrideActive() then
            v_u_7.setForceLockOverride("Menu", true)
        end
        if not v_u_23.Menu.Visible then
            v_u_23.Menu.Visible = true
        end
    end
    v_u_1.openFrame("Dashboard")
    v_u_12.OnScreenChanged:Connect(function(_, p65)
        if p65 then
            local v66 = v_u_23.Menu:FindFirstChild(p65)
            if v66 and v66:IsA("Frame") then
                v_u_17 = v66
            end
            local v67 = v_u_22.Other:FindFirstChild(p65) or v_u_22.Buttons:FindFirstChild(p65)
            if v67 and (v67:IsA("GuiButton") and v_u_18 ~= v67) then
                local v68 = v_u_18
                v_u_18 = v67
                v_u_26(v67, v_u_20)
                if v68 then
                    v_u_26(v68, v_u_19)
                end
            end
        end
    end)
    v_u_6.CharacterAdded:Connect(function(_)
        task.defer(function()
            if not (v_u_23.Menu.Visible or (v_u_23.Gameplay.Middle.TeamSelection.Visible or (v_u_12.IsCaseSceneActive() or v_u_12.IsInspectActive()))) then
                v_u_7.resetForceLockOverride()
                v_u_7.setPerspective(true, false)
            end
        end)
    end)
    v_u_11.observeAttribute(v_u_6, "Team", function(p69)
        if p69 == "Spectators" then
            v_u_1.CloseTeamSelection()
        end
    end)
    v_u_9.ListenToState(function(p70, p71)
        if v_u_12.IsCaseSceneActive() then
            if p71 == "Game Ending" or p71 == "Map Voting" then
                v_u_23.Gameplay.Bottom.Visible = false
                v_u_23.Gameplay.Visible = false
            end
            return
        elseif v_u_12.IsInspectActive() then
            return
        else
            if p71 == "Game Ending" or p71 == "Map Voting" then
                if require(v_u_2.Controllers.EndScreenController).IsActive() then
                    if v_u_12.IsInspectActive() then
                        v_u_10.broadcastRouter("WeaponInspectCloseForGameEnd")
                    end
                    return
                end
                v_u_23.Gameplay.Visible = false
                v_u_23.Gameplay.Bottom.Visible = false
                if v_u_12.IsInspectActive() then
                    v_u_10.broadcastRouter("WeaponInspectCloseForGameEnd")
                end
                if not v_u_52() then
                    v_u_1.ResetToMainMenu()
                end
                if not v_u_23.Menu.Visible then
                    v_u_7.setForceLockOverride("Menu", true)
                    v_u_23.Menu.Visible = true
                end
            end
            if p71 == "Map Voting" then
                if v_u_6:GetAttribute("FollowGamemode") or v_u_6:GetAttribute("IsSpectating") then
                    v_u_1.openFrame("Play")
                    return
                end
                if not (v_u_23.Menu.Visible or v_u_52()) then
                    v_u_1.openFrame("Dashboard")
                    v_u_1.ToggleMenu()
                end
            end
            if (p70 == "Game Ending" or p70 == "Map Voting") and (p71 ~= "Game Ending" and p71 ~= "Map Voting") then
                if p70 == "Map Voting" then
                    if v_u_23.Menu.Visible then
                        return
                    end
                    local v72 = v_u_6:GetAttribute("Team")
                    if not v_u_6.Character or (not v72 or v72 == "Spectators") then
                        v_u_23.Menu.Visible = false
                        v_u_23.Gameplay.Visible = true
                        v_u_23.Gameplay.Top.Visible = true
                        require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).openFrame()
                        return
                    end
                elseif v_u_23.Menu.Visible and v_u_52() then
                    return
                end
                task.defer(function()
                    if not v_u_12.IsInspectActive() then
                        if require(v_u_2.Controllers.MenuSceneController).IsActive() and not v_u_23.Menu.Visible then
                            if not v_u_52() then
                                v_u_1.ResetToMainMenu()
                            end
                            v_u_7.setForceLockOverride("Menu", true)
                            v_u_23.Gameplay.Visible = false
                            v_u_23.Menu.Visible = true
                        end
                    end
                end)
            end
            if p71 ~= "Game Ending" and (p71 ~= "Map Voting" and (v_u_23.Menu.Visible and v_u_52())) then
            end
        end
    end)
end
return v_u_1