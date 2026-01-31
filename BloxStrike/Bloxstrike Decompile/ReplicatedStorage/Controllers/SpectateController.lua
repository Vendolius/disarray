local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v_u_5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.InventoryController)
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Interface.MenuState)
local v_u_10 = require(v_u_2.Classes.Spectate)
local v_u_11 = require(v_u_2.Classes.Freecam)
local v_u_12 = require(v_u_2.Packages.Observers)
local v_u_13 = require(v_u_2.Shared.Promise)
local v14 = require(v_u_2.Packages.Signal)
local v_u_15 = require(v_u_2.Database.Security.Remotes)
local v_u_16 = require(v_u_2.Database.Security.Router)
local v_u_17 = workspace.CurrentCamera
local v_u_18 = v14.new()
v_u_1.ListenToSpectate = v_u_18
local v_u_19 = require(v_u_2.Database.Custom.Constants)
local v_u_20 = "First-Person"
local v_u_21 = {}
local v_u_22 = 0
local v_u_23 = false
local v_u_24 = 1
local v_u_25 = 1
local v_u_26 = 0
local v_u_27 = { "First-Person", "Third-Person", "Free-Cam" }
local v_u_28 = nil
local v_u_29 = nil
local function v_u_34(p30)
    local v31 = p30:GetAttribute("Team")
    if v31 ~= "Counter-Terrorists" and v31 ~= "Terrorists" then
        return false
    end
    if p30 == v_u_6 and v_u_23 then
        return false
    end
    local v32 = p30.Character
    if v32 and v32:IsDescendantOf(workspace) then
        if v32:GetAttribute("Dead") then
            return false
        end
        local v33 = v32:FindFirstChildWhichIsA("Humanoid", true)
        if v33 and v33.Health > 0 then
            return true
        end
    end
    return false
end
local function v_u_37()
    if v_u_9.IsCaseSceneActive() then
        return false
    end
    if require(v_u_2.Controllers.EndScreenController).IsActive() then
        return false
    end
    if v_u_34(v_u_6) then
        return false
    end
    local v35 = v_u_6:GetAttribute("Team")
    if v35 ~= "Counter-Terrorists" and v35 ~= "Terrorists" then
        return false
    end
    local v36 = require(v_u_2.Database.Components.GameState).GetState()
    return v36 ~= "Game Ending" and v36 ~= "Map Voting"
end
local function v_u_40()
    if v_u_37() then
        if v_u_28 or v_u_29 then
            return
        else
            v_u_8.updateCameraFOV(v_u_19.DEFAULT_CAMERA_FOV)
            v_u_8.setPerspective(true, false)
            local v38 = v_u_6:GetAttribute("LastKiller")
            local v39
            if v38 then
                v_u_6:SetAttribute("LastKiller", nil)
                v39 = v_u_5:FindFirstChild(v38)
                if not (v39 and v_u_34(v39)) then
                    v39 = nil
                end
            else
                v39 = nil
            end
            if v39 then
                v_u_1.SetNextPlayer(v39)
            else
                v_u_1.Next()
            end
        end
    else
        return
    end
end
local function v_u_43()
    table.clear(v_u_21)
    for _, v41 in ipairs(v_u_5:GetPlayers()) do
        if v41 ~= v_u_6 and v_u_34(v41) then
            local v42 = v_u_21
            table.insert(v42, v41)
        end
    end
end
function v_u_1.GetCurrentSpectateInstance()
    return v_u_28
end
function v_u_1.IsLocalPlayerDead()
    return v_u_23
end
function v_u_1.GetPlayer()
    if v_u_34(v_u_6) then
        return v_u_6
    else
        local v44 = v_u_1.GetCurrentSpectateInstance()
        if v44 then
            return v44.Player
        else
            return nil
        end
    end
end
function v_u_1.SetNextPlayer(p45)
    local v46 = v_u_28
    if v46 then
        v46 = v_u_28.Player
    end
    if p45 == v_u_6 then
        v_u_1.Next()
    else
        local v47 = p45.Character
        local v48 = v46 == p45
        local v49 = v_u_28
        if v49 then
            v49 = v_u_28.Character == v47
        end
        local v50 = v_u_34(p45)
        if not (v48 and (v49 and v50)) then
            v_u_1.Stop(false, true)
            local v51 = v47 and (v50 and v47:FindFirstChildWhichIsA("Humanoid", true))
            if v51 then
                local v52 = v_u_10.new(p45, v47, v51)
                v_u_28 = v52
                v_u_1.ListenToSpectate:Fire(p45)
                v52.StopSpectating:Once(function()
                    v_u_1.Stop(false, true)
                    v_u_1.Next()
                end)
                v_u_15.Spectate.SpectatePlayer.Send(p45.Name)
                return
            end
            v_u_1.Next()
        end
    end
end
function v_u_1.Switch()
    local v53 = v_u_24 + 1
    if #v_u_27 < v53 then
        v_u_20 = v_u_27[1]
        v_u_24 = 1
    elseif v53 <= #v_u_27 then
        v_u_20 = v_u_27[v53]
        v_u_24 = v53
    end
    if v_u_28 then
        v_u_28:Switch(v_u_20)
    end
end
function v_u_1.UpdateIndex(p54)
    v_u_43()
    if #v_u_21 > 0 then
        v_u_25 = v_u_25 + p54
        if v_u_25 <= 0 then
            v_u_25 = #v_u_21
        elseif v_u_25 > #v_u_21 then
            v_u_25 = 1
        end
    end
    return v_u_13.new(function(p55, p56)
        local v57 = v_u_21[v_u_25]
        if v57 and v_u_34(v57) then
            p55(v57)
            return
        else
            v_u_43()
            if #v_u_21 > 0 then
                v_u_25 = 1
                p55(v_u_21[1])
            else
                v_u_1.Stop(false, false)
                p56("No players alive to spectate")
            end
        end
    end)
end
function v_u_1.Next()
    return v_u_1.UpdateIndex(1):andThen(function(p58)
        v_u_1.SetNextPlayer(p58)
    end):catch(function() end)
end
function v_u_1.Previous()
    return v_u_1.UpdateIndex(-1):andThen(function(p59)
        v_u_1.SetNextPlayer(p59)
    end):catch(function() end)
end
function v_u_1.Stop(p60, p61)
    if v_u_28 then
        v_u_28:Destroy()
        v_u_28 = nil
        if p60 then
            v_u_15.Spectate.StopSpectating.Send()
        end
    end
    if p61 and v_u_29 then
        v_u_29:Destroy()
        v_u_29 = nil
    end
    v_u_18:Fire()
end
function v_u_1.Broadcast()
    local v62 = v_u_6:GetAttribute("Spectators")
    local v63 = v62 and v62 > 0 and 0.016666666666666666 or 0.2
    if v63 <= v_u_26 then
        local v64 = v_u_7.getCurrentEquipped()
        v_u_26 = v_u_26 - v63
        if v64 then
            local v65 = v_u_6.PlayerGui:FindFirstChild("MainGui")
            if v65 then
                v65 = v_u_6.PlayerGui.MainGui:FindFirstChild("Menu")
            end
            if v65 then
                v65 = v65:FindFirstChild("Inspect")
            end
            if v65 and v65.Visible then
                return
            elseif not v_u_9.IsCaseSceneActive() then
                v_u_15.Spectate.UpdateCameraCFrame.Send(v_u_17.CFrame)
            end
        end
    end
end
function v_u_1.Render(p66)
    v_u_22 = v_u_22 + p66
    v_u_26 = v_u_26 + p66
    if v_u_34(v_u_6) then
        v_u_1.Broadcast()
        if v_u_28 then
            v_u_1.Stop(true, true)
        end
        if v_u_29 then
            v_u_29:Destroy()
            v_u_29 = nil
        end
        if v_u_34(v_u_6) then
            local v67 = v_u_6.Character:FindFirstChild("Humanoid")
            if v67 then
                v_u_17.CameraType = Enum.CameraType.Custom
                v_u_17.CameraSubject = v67
            end
            v_u_8.setPerspective(true, false)
            return
        end
    elseif v_u_37() or v_u_6:GetAttribute("IsSpectating") then
        if v_u_9.IsCaseSceneActive() then
            return
        end
        if v_u_28 then
            if v_u_16.broadcastRouter("IsInspectActive") then
                return
            end
            v_u_28:Render(p66)
            if v_u_29 then
                v_u_29:Destroy()
                v_u_29 = nil
                return
            end
        else
            if v_u_22 >= 0.2 then
                v_u_22 = 0
                v_u_43()
                if #v_u_21 > 0 then
                    v_u_25 = v_u_25 + 1
                    if v_u_25 <= 0 then
                        v_u_25 = #v_u_21
                    elseif v_u_25 > #v_u_21 then
                        v_u_25 = 1
                    end
                end
            end
            if v_u_21[v_u_25] then
                v_u_1.Next()
                return
            end
            v_u_29 = not v_u_29 and v_u_11.new()
            if v_u_29 then
                v_u_29:Start()
                return
            end
        end
    elseif v_u_28 then
        v_u_1.Stop(false, true)
        return
    end
end
function v_u_1.Initialize()
    v_u_12.observeAttribute(v_u_6, "IsSpectating", function(p68)
        if p68 then
            if v_u_9.IsCaseSceneActive() then
                return function()
                    v_u_1.Stop(false, true)
                end
            end
            v_u_8.updateCameraFOV(v_u_19.DEFAULT_CAMERA_FOV)
            v_u_8.setPerspective(true, false)
            if not v_u_28 then
                local v69 = v_u_6:GetAttribute("LastKiller")
                local v70
                if v69 then
                    v_u_6:SetAttribute("LastKiller", nil)
                    v70 = v_u_5:FindFirstChild(v69)
                    if not (v70 and v_u_34(v70)) then
                        v70 = nil
                    end
                else
                    v70 = nil
                end
                if v70 then
                    v_u_1.SetNextPlayer(v70)
                else
                    v_u_1.Next()
                end
            end
        end
        return function()
            v_u_1.Stop(false, true)
        end
    end)
    v_u_15.Character.CharacterDied.Listen(function()
        v_u_23 = true
        v_u_40()
    end)
    v_u_6.CharacterAdded:Connect(function(p_u_71)
        v_u_23 = false
        local v72 = v_u_6:GetAttribute("Team")
        local v73 = v72 == "Counter-Terrorists" and true or v72 == "Terrorists"
        local v74 = p_u_71:FindFirstChildWhichIsA("Humanoid", true)
        if v74 then
            if v74.Health > 0 then
                v74 = not p_u_71:GetAttribute("Dead")
            else
                v74 = false
            end
        end
        if v73 and v74 then
            v_u_1.Stop(true, true)
            if v_u_6:GetAttribute("IsSpectating") then
                v_u_15.Spectate.StopSpectating.Send()
            end
        elseif v_u_28 and v_u_28.Player then
            v_u_15.Spectate.SpectatePlayer.Send(v_u_28.Player.Name)
        end
        local v_u_75 = p_u_71:GetAttributeChangedSignal("Dead"):Connect(function()
            if p_u_71:GetAttribute("Dead") then
                v_u_40()
            end
        end)
        local v_u_76 = nil
        v_u_76 = p_u_71.AncestryChanged:Connect(function(_, p77)
            if not p77 then
                if v_u_75 then
                    v_u_75:Disconnect()
                    v_u_75 = nil
                end
                if v_u_76 then
                    v_u_76:Disconnect()
                    v_u_76 = nil
                end
            end
        end)
    end)
    require(v_u_2.Database.Components.GameState).ListenToState(function(_, p78)
        if p78 == "Game Ending" or p78 == "Map Voting" then
            v_u_1.Stop(false, true)
        end
    end)
    v_u_4.RenderStepped:Connect(function(p79)
        v_u_1.Render(p79)
    end)
end
function v_u_1.Start()
    v_u_15.Spectate.ReplicateSpectateEvent.Listen(function(...)
        if v_u_28 then
            v_u_28:AddSpectateEvent(...)
        end
    end)
    v_u_3.InputBegan:Connect(function(p80)
        if v_u_6:GetAttribute("IsSpectating") and (p80.KeyCode == Enum.KeyCode.Space and not v_u_6:GetAttribute("IsPlayerChatting")) then
            v_u_1.Switch()
        end
    end)
    if v_u_3.TouchEnabled then
        v_u_3.TouchStarted:Connect(function(p81, p82)
            if p82 or v_u_6:GetAttribute("IsPlayerChatting") then
                return
            elseif v_u_6:GetAttribute("IsSpectating") then
                local v83 = p81.Position
                if v_u_17.ViewportSize.X / 2 > v83.X then
                    v_u_1.Previous()
                else
                    v_u_1.Next()
                end
            else
                return
            end
        end)
    end
end
return v_u_1