local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_4 = require(v2.Classes.WeaponComponent)
local v_u_5 = require(v2.Database.Components.GameState)
local v_u_6 = require(v2.Database.Security.Remotes)
local v_u_7 = workspace.CurrentCamera
local v_u_8 = game:GetService("Players").LocalPlayer
function v_u_1.stopAllAnimations(p9)
    if p9.CharacterAnimator then
        if p9.Viewmodel and p9.Viewmodel.Animation then
            for v10, v11 in pairs(p9.CharacterAnimator.Animations) do
                if v11.IsPlaying and v11.Name ~= "Idle" then
                    p9.CharacterAnimator:stop(v10)
                end
            end
            for v12, v13 in pairs(p9.Viewmodel.Animation.Animations) do
                if v13.IsPlaying and v13.Name ~= "Idle" then
                    p9.Viewmodel.Animation:stop(v12)
                end
            end
        end
    else
        return
    end
end
function v_u_1.StartThrow(p14)
    if p14.IsDestroyed then
        return
    else
        local v15 = tick()
        if p14.LastThrowTime > 0 and v15 - p14.LastThrowTime < 0.7 then
            return
        elseif p14.ThrowStarted and not p14.ThrowFinished then
            return
        else
            if p14.ThrowFinished then
                p14.ThrowFinished = false
                p14.ThrowStarted = false
                if p14.Janitor:Get("ThrowGrenadeFinished") then
                    p14.Janitor:Remove("ThrowGrenadeFinished")
                end
                if p14.Janitor:Get("ThrowGrenadeStoppedFallback") then
                    p14.Janitor:Remove("ThrowGrenadeStoppedFallback")
                end
            end
            local v16 = tick()
            if p14.LastThrowTime > 0 and v16 - p14.LastThrowTime < 0.7 then
                return
            elseif v_u_8 and (v_u_8.Character and v_u_8.Character:GetAttribute("Dead")) then
                return
            else
                p14.ThrowStarted = true
                if p14.Viewmodel then
                    if p14.Viewmodel.IsDestroyed then
                        return
                    elseif p14.Viewmodel.Model then
                        if p14.Viewmodel.Model.Parent ~= v_u_7 then
                            if p14.Viewmodel.IsDestroyed or not p14.Viewmodel.equip then
                                return
                            end
                            p14.Viewmodel:equip(false)
                        end
                        if p14.Viewmodel.Hidden then
                            p14.Viewmodel:unhide()
                        end
                        local v17 = tick()
                        if p14.LastThrowTime > 0 and v17 - p14.LastThrowTime < 0.7 then
                            p14.ThrowStarted = false
                            return
                        elseif not p14.Viewmodel.IsDestroyed then
                            local v18 = p14.Viewmodel.Animation.Animations.Equip
                            if v18 then
                                v18 = v18.IsPlaying
                            end
                            if v18 then
                                for v19, v20 in pairs(p14.Viewmodel.Animation.Animations) do
                                    if v20.IsPlaying and (v20.Name ~= "Idle" and v20.Name ~= "Equip") then
                                        p14.Viewmodel.Animation:stop(v19)
                                    end
                                end
                                for v21, v22 in pairs(p14.CharacterAnimator.Animations) do
                                    if v22.IsPlaying and (v22.Name ~= "Idle" and v22.Name ~= "Equip") then
                                        p14.CharacterAnimator:stop(v21)
                                    end
                                end
                            else
                                p14:stopAllAnimations()
                            end
                            p14.CharacterAnimator:play("StartThrow")
                            p14.CharacterAnimator:play("ThrowIdle")
                            if p14.Viewmodel and (not p14.Viewmodel.IsDestroyed and (p14.Viewmodel.Model and p14.Viewmodel.Model.Parent == v_u_7)) then
                                p14.Viewmodel.Animation:play("StartThrow")
                                p14.Viewmodel.Animation:play("ThrowIdle")
                            end
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
        end
    end
end
function v_u_1.Throw(p_u_23, p_u_24)
    if p_u_23.ThrowFinished then
        return
    elseif v_u_8 and (v_u_8.Character and v_u_8.Character:GetAttribute("Dead")) then
        return
    elseif p_u_23.Viewmodel and (not p_u_23.Viewmodel.IsDestroyed and p_u_23.Viewmodel.Model) then
        if p_u_23.Viewmodel.Model.Parent ~= v_u_7 then
            if p_u_23.Viewmodel.IsDestroyed or not p_u_23.Viewmodel.equip then
                p_u_23.ThrowStarted = false
                return
            end
            p_u_23.Viewmodel:equip(false)
            v_u_3.Heartbeat:Wait()
            if p_u_23.Viewmodel.Model.Parent ~= v_u_7 then
                p_u_23.ThrowStarted = false
                return
            end
        end
        if p_u_23.Viewmodel.Hidden then
            p_u_23.Viewmodel:unhide()
        end
        if p_u_23.Viewmodel.Animation then
            if p_u_23.Janitor:Get("ThrowGrenadeFinished") then
                p_u_23.Janitor:Remove("ThrowGrenadeFinished")
            end
            if p_u_23.Janitor:Get("ThrowGrenadeStoppedFallback") then
                p_u_23.Janitor:Remove("ThrowGrenadeStoppedFallback")
            end
            local v25 = p_u_23.Viewmodel.Animation.Animations.Equip
            if v25 then
                v25 = v25.IsPlaying
            end
            if v25 then
                p_u_23.Viewmodel.Animation:stop("Equip")
                p_u_23.CharacterAnimator:stop("Equip")
                for v26, v27 in pairs(p_u_23.Viewmodel.Animation.Animations) do
                    if v27.IsPlaying and v27.Name ~= "Idle" then
                        p_u_23.Viewmodel.Animation:stop(v26)
                    end
                end
                for v28, v29 in pairs(p_u_23.CharacterAnimator.Animations) do
                    if v29.IsPlaying and v29.Name ~= "Idle" then
                        p_u_23.CharacterAnimator:stop(v28)
                    end
                end
                v_u_3.Heartbeat:Wait()
            else
                if p_u_23.Viewmodel.Animation.Animations.StartThrow then
                    p_u_23.Viewmodel.Animation:stop("StartThrow")
                end
                if p_u_23.CharacterAnimator.Animations.StartThrow then
                    p_u_23.CharacterAnimator:stop("StartThrow")
                end
            end
            if p_u_23.Viewmodel and (not p_u_23.Viewmodel.IsDestroyed and p_u_23.Viewmodel.Animation) then
                local v30 = p_u_23.Viewmodel.Animation:play(p_u_24)
                if v30 then
                    local v31 = tick()
                    while v30.Length == 0 and tick() - v31 < 0.5 do
                        v_u_3.Heartbeat:Wait()
                    end
                    if p_u_23.IsDestroyed or (not p_u_23.Viewmodel or p_u_23.Viewmodel.IsDestroyed) then
                        p_u_23.ThrowStarted = false
                        return
                    else
                        p_u_23.CharacterAnimator:play("Throw")
                        p_u_23.ThrowCompleted = false
                        local function v_u_36()
                            if p_u_23.ThrowCompleted then
                                return
                            else
                                p_u_23.ThrowCompleted = true
                                if not p_u_23.IsDestroyed and p_u_23.Identifier then
                                    p_u_23.ThrowFinished = true
                                    p_u_23.ThrowStarted = false
                                    p_u_23.LastThrowTime = tick()
                                    local v32 = Vector3.new(0, 0, 0)
                                    local v33 = false
                                    if v_u_8 and v_u_8.Character then
                                        local v34 = v_u_8.Character:FindFirstChild("HumanoidRootPart")
                                        if v34 and v34:IsA("BasePart") then
                                            v32 = v34.AssemblyLinearVelocity
                                        end
                                        local v35 = v_u_8.Character:FindFirstChild("Humanoid")
                                        if v35 then
                                            if v35:GetAttribute("Crouching") == true then
                                                v33 = true
                                            else
                                                v33 = false
                                            end
                                        end
                                    end
                                    v_u_6.Inventory.ThrowGrenade.Send({
                                        ["Direction"] = v_u_7.CFrame.LookVector,
                                        ["Position"] = v_u_7.CFrame.Position,
                                        ["Identifier"] = p_u_23.Identifier,
                                        ["Animation"] = p_u_24,
                                        ["CharacterVelocity"] = v32,
                                        ["IsCrouching"] = v33
                                    })
                                end
                            end
                        end
                        if v30 and v30.IsPlaying then
                            p_u_23.Janitor:Add(v30:GetMarkerReachedSignal("Throw"):Once(function()
                                v_u_36()
                            end), "Disconnect", "ThrowGrenadeFinished")
                            p_u_23.Janitor:Add(v30.Stopped:Once(function()
                                task.delay(0.05, function()
                                    if not (p_u_23.ThrowCompleted or p_u_23.IsDestroyed) then
                                        v_u_36()
                                    end
                                end)
                            end), "Disconnect", "ThrowGrenadeStoppedFallback")
                            if v30.Length > 0 then
                                local v37 = v30.Length * 0.7
                                task.delay(v37, function()
                                    if not p_u_23.ThrowCompleted and (not p_u_23.IsDestroyed and (p_u_23.ThrowStarted and not p_u_23.ThrowFinished)) then
                                        v_u_36()
                                    end
                                end)
                            end
                            task.delay(2, function()
                                if not p_u_23.ThrowCompleted and (not p_u_23.IsDestroyed and (p_u_23.ThrowStarted and not p_u_23.ThrowFinished)) then
                                    v_u_36()
                                end
                            end)
                        else
                            p_u_23.ThrowStarted = false
                        end
                    end
                else
                    p_u_23.ThrowStarted = false
                    return
                end
            else
                p_u_23.ThrowStarted = false
                return
            end
        else
            p_u_23.ThrowStarted = false
            return
        end
    else
        p_u_23.ThrowStarted = false
        return
    end
end
function v_u_1.Cancel(p38)
    if not p38.ThrowFinished then
        if p38.Janitor:Get("ThrowGrenadeFinished") then
            p38.Janitor:Remove("ThrowGrenadeFinished")
        end
        if p38.Janitor:Get("ThrowGrenadeStoppedFallback") then
            p38.Janitor:Remove("ThrowGrenadeStoppedFallback")
        end
        p38.ThrowFinished = false
        p38.ThrowStarted = false
        p38.ThrowCompleted = false
        p38:stopAllAnimations()
    end
end
function v_u_1.inspect(p_u_39)
    if not p_u_39.IsInspecting then
        if p_u_39.ThrowStarted and not p_u_39.ThrowFinished then
            p_u_39:Cancel()
        end
        p_u_39.IsInspecting = true
        p_u_39:stopAllAnimations()
        local v40 = p_u_39.Viewmodel.Animation:play("Inspect")
        v_u_6.Spectate.ReplicateSpectateEvent.Send("Inspect")
        task.delay(v40.Length, function()
            p_u_39.IsInspecting = false
        end)
    end
end
function v_u_1.reload(_) end
function v_u_1.drop(p41)
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_5.GetState() == "Warmup" then
        return false
    end
    if not p41.Properties.Droppable then
        return false
    end
    p41:unequip()
    v_u_6.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_7.CFrame.LookVector,
        ["Identifier"] = p41.Identifier
    })
    return true
end
function v_u_1.equip(p42)
    p42.Viewmodel.Animation:stopAnimations()
    p42.CharacterAnimator:stopAnimations()
    p42.ThrowStarted = false
    p42.ThrowFinished = false
    p42.ThrowCompleted = false
    p42.CharacterAnimator:play("Idle")
    p42.CharacterAnimator:play("Equip")
    p42.Viewmodel:equip(false)
end
function v_u_1.unequip(p43)
    p43.CharacterAnimator:stopAnimations()
    p43.Viewmodel:unequip()
    p43.IsInspecting = false
    if p43.ThrowStarted and not p43.ThrowFinished then
        p43:Cancel()
    end
end
function v_u_1.new(p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, _)
    local v56 = v_u_4.new(p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55)
    local v57 = v_u_1
    local v58 = setmetatable(v56, v57)
    v58.IsInspecting = false
    v58.ThrowStarted = false
    v58.ThrowFinished = false
    v58.ThrowCompleted = false
    v58.LastThrowTime = 0
    return v58
end
function v_u_1.destroy(p59)
    if not p59.IsDestroyed then
        p59.IsDestroyed = true
        if p59.Janitor then
            p59.Janitor:Destroy()
            p59.Janitor = nil
        end
        p59.ThrowFinished = nil
        p59.ThrowStarted = nil
        p59.ThrowCompleted = nil
        p59.IsInspecting = nil
        v_u_4.destroy(p59)
    end
end
return v_u_1