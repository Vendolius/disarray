local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Classes.WeaponComponent)
local v7 = require(v_u_2.Classes.Sound)
local v_u_8 = require(v_u_2.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u_9 = require(v_u_2.Components.Common.VFXLibary.CreateMarker)
local v_u_10 = require(v_u_2.Components.Common.VFXLibary.CreateImpact)
local v_u_11 = require(v_u_2.Components.Common.VFXLibary.CreateTracer)
local v_u_12 = require(v_u_2.Components.Common.VFXLibary.BreakGlass)
local v_u_13 = require(v_u_2.Controllers.HapticsController)
local v_u_14 = require(v_u_2.Controllers.CameraController)
local v_u_15 = require(v_u_2.Controllers.SoundController)
local v_u_16 = require(v_u_2.Controllers.InputController)
local v_u_17 = require(v_u_2.Controllers.HintController)
local v_u_18 = require(v_u_2.Controllers.DataController)
local v_u_19 = require(v_u_2.Database.Components.GameState)
local v_u_20 = require(v_u_2.Database.Security.Remotes)
local v_u_21 = require(v_u_2.Database.Security.Router)
local v_u_22 = require(v_u_2.Database.Custom.Constants)
local v_u_23 = require(script.Classes.Bullet)
local v_u_24 = workspace.CurrentCamera
local v_u_25 = v5.LocalPlayer
local v_u_26 = v7.new("Other")
local v_u_27 = {}
local v_u_28 = { 37, 60 }
for _, v29 in ipairs(v_u_2.Database.Custom.Weapons:GetChildren()) do
    if v29:IsA("ModuleScript") then
        v_u_27[v29.Name] = require(v29)
    end
end
local function v_u_48(p30)
    local v31 = p30.Rotation
    local v32 = p30.Position
    local v33 = v31.RotationDampen.Value
    local v34 = v31.RotationSpeed.Value
    local v35 = v34 >= 30 and 25 or v34
    local v36 = v31.RotationX.Value
    local v37 = v31.RotationY.Value
    local v38 = v31.RotationZ.Value
    local v39 = v33 >= 5 and 1 or v33
    local v40 = v36 < 0.1 and 1 or v36
    local v41 = v37 < 0.1 and 25 or v37
    local v42 = v38 < 0.1 and 1 or v38
    local v43 = {
        ["Value"] = Vector3.new(v40, v41, v42),
        ["Damper"] = v39,
        ["Speed"] = v35
    }
    local v44 = {}
    local v45 = v32.PositionX.Value
    local v46 = v32.PositionY.Value
    local v47 = v32.PositionZ.Value
    v44.Value = Vector3.new(v45, v46, v47)
    v44.Damper = v32.PositionDampen.Value
    v44.Speed = v32.PositionSpeed.Value
    v_u_14.weaponKick(v43, v44)
end
function v_u_1.isJumping(_)
    return false
end
function v_u_1.getSpread(p49)
    local v50 = p49.Bullet:getTrueSpread()
    if p49:isJumping() then
        return v50 + 0
    else
        return v50
    end
end
function v_u_1.getBaseSpread(p51)
    local v52 = p51.Bullet:getBaseSpread()
    if p51:isJumping() then
        return v52 + 0
    else
        return v52
    end
end
function v_u_1.stopAllAnimations(p53)
    if p53.CharacterAnimator then
        if p53.Viewmodel and p53.Viewmodel.Animation then
            p53.Viewmodel.Animation:cancelCrossfade()
            for v54, v55 in pairs(p53.CharacterAnimator.Animations) do
                if v55.IsPlaying and v55.Name ~= "Idle" then
                    p53.CharacterAnimator:stop(v54)
                end
            end
            for v56, v57 in pairs(p53.Viewmodel.Animation.Animations) do
                if v57.IsPlaying and v57.Name ~= "Idle" then
                    p53.Viewmodel.Animation:stop(v56)
                end
            end
        end
    else
        return
    end
end
function v_u_1.removeSuppressor(p58)
    if tick() - p58.WeaponEquippedTick <= 1 then
        return
    elseif not (p58.IsAdjustingSuppressor or (p58.IsShooting or (p58.IsReloading or p58.IsAiming))) then
        p58.IsAdjustingSuppressor = true
        p58.IsBurstShooting = false
        p58.IsInspecting = false
        p58.IsReloading = false
        p58.IsShooting = false
        p58.IsAiming = false
        p58.ScopeStartTick = 0
        p58:stopAllAnimations()
        p58.Viewmodel.Animation:play("RemoveSuppressor")
        p58.CharacterAnimator:play("RemoveSuppressor")
        v_u_20.Spectate.ReplicateSpectateEvent.Send("Remove Suppressor")
    end
end
function v_u_1.addSuppressor(p59)
    if tick() - p59.WeaponEquippedTick <= 1 then
        return
    elseif not (p59.IsAdjustingSuppressor or (p59.IsShooting or (p59.IsReloading or p59.IsAiming))) then
        p59.IsAdjustingSuppressor = true
        p59.IsBurstShooting = false
        p59.IsInspecting = false
        p59.IsReloading = false
        p59.IsShooting = false
        p59.IsAiming = false
        p59:stopAllAnimations()
        p59.Viewmodel.Animation:play("AddSuppressor")
        p59.CharacterAnimator:play("AddSuppressor")
        v_u_20.Spectate.ReplicateSpectateEvent.Send("Add Suppressor")
    end
end
function v_u_1.scope(p60, p61)
    if p60.Viewmodel then
        if tick() - p60.WeaponEquippedTick <= 1 then
            return
        else
            local v62 = p60.Properties.AimingOptions == "AutomaticScope"
            if p60.IsAdjustingSuppressor or (p60.IsReloading or p60.IsShooting and not v62) then
                return
            elseif not p60.IsDestroyed then
                if p60.Properties.HasScope then
                    if not p60.IsAiming then
                        p60:stopAllAnimations()
                    end
                    p60.IsBurstShooting = false
                    p60.IsInspecting = false
                    p60.IsReloading = false
                    p60.IsShooting = false
                    if not p60.IsAiming then
                        p60.ScopeStartTick = tick()
                    end
                    p60.IsAiming = true
                    local v63 = p60.Name
                    if v63 == "SSG 08" and true or v63 == "AWP" then
                        p60.IsSniperScoped = true
                        if p60.Name == "AWP" and p60.Player then
                            p60.Player:SetAttribute("IsSniperScoped", true)
                        end
                    end
                    if p60.Properties.AimingOptions == "SniperScope" then
                        if not p60.Viewmodel.Hidden then
                            p60.Viewmodel:hide()
                        end
                        v_u_26:play({
                            ["Parent"] = v_u_25.PlayerGui,
                            ["Name"] = "Toggle Scope"
                        })
                        if p61 then
                            p60.CurrentScopeIncrement = p60.CurrentScopeIncrement + 1
                            if p60.CurrentScopeIncrement >= 3 then
                                p60:unscope()
                            else
                                v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - v_u_28[p60.CurrentScopeIncrement])
                                v_u_20.Inventory.UpdateScopeIncrement.Send(p60.CurrentScopeIncrement)
                            end
                        else
                            v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - v_u_28[1])
                            v_u_20.Inventory.UpdateScopeIncrement.Send(1)
                            return
                        end
                    end
                    if p60.Properties.AimingOptions == "AutomaticScope" then
                        if p60.CurrentScopeIncrement == 1 then
                            p60:unscope()
                            return
                        end
                        p60.CurrentScopeIncrement = 1
                        if not p60.Viewmodel.Hidden then
                            p60.Viewmodel:hide()
                        end
                        p60.Viewmodel:aim()
                        v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - 15 * p60.CurrentScopeIncrement)
                        v_u_20.Inventory.UpdateScopeIncrement.Send(p60.CurrentScopeIncrement)
                        v_u_26:play({
                            ["Parent"] = v_u_25.PlayerGui,
                            ["Name"] = "Scope In"
                        })
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.unscope(p64, p65)
    if tick() - p64.WeaponEquippedTick <= 1 then
        return
    elseif p64.IsAdjustingSuppressor then
        return
    elseif tick() - p64.WeaponEquippedTick > 1 then
        if p64.Properties.HasScope then
            if p64.IsAiming then
                p64:stopAllAnimations()
            end
            if p64.CurrentScopeIncrement > 0 or p64.IsAiming then
                v_u_20.Inventory.UpdateScopeIncrement.Send(0)
            end
            if not p65 then
                p64.CurrentScopeIncrement = 0
            end
            p64.IsInspecting = false
            p64.IsReloading = false
            p64.IsAiming = false
            p64.ScopeStartTick = 0
            local v66 = p64.Name
            if v66 == "SSG 08" and true or v66 == "AWP" then
                p64.IsSniperScoped = false
                if p64.Name == "AWP" and p64.Player then
                    p64.Player:SetAttribute("IsSniperScoped", false)
                end
            end
            if p64.Properties.AimingOptions == "SniperScope" then
                if p64.Viewmodel.Hidden then
                    p64.Viewmodel:unhide()
                end
                local v67 = require(v_u_2.Controllers.CaseSceneController)
                local v68 = require(v_u_2.Controllers.MenuSceneController)
                if not (v67.IsActive() or v68.IsActive()) then
                    v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV)
                end
                if p65 then
                    local v69 = p64.CurrentScopeIncrement - 1
                    p64.CurrentScopeIncrement = math.clamp(v69, 0, 3)
                    return
                end
            elseif p64.Properties.AimingOptions == "AutomaticScope" then
                p64.CurrentScopeIncrement = 0
                p64.Viewmodel:unaim()
                if p64.Viewmodel.Hidden then
                    p64.Viewmodel:unhide()
                end
                v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - 15 * p64.CurrentScopeIncrement)
                v_u_26:play({
                    ["Parent"] = v_u_25.PlayerGui,
                    ["Name"] = "Scope Out"
                })
            end
        end
    end
end
function v_u_1.cancelInspect(p_u_70, p71, p72, p73)
    if p_u_70.IsInspecting or p_u_70.IsInspectFadingOut then
        if p_u_70.InspectDelayThread then
            task.cancel(p_u_70.InspectDelayThread)
            p_u_70.InspectDelayThread = nil
        end
        if p_u_70.CancelDelayThread then
            task.cancel(p_u_70.CancelDelayThread)
            p_u_70.CancelDelayThread = nil
        end
        if p_u_70.FadeCompleteThread then
            task.cancel(p_u_70.FadeCompleteThread)
            p_u_70.FadeCompleteThread = nil
        end
        if p73 then
            p_u_70.IsInspecting = false
            p_u_70.IsInspectFadingOut = false
            p_u_70.Viewmodel.Animation:cancelCrossfade()
        else
            local v_u_74 = p71 or 0.25
            p_u_70.IsInspectFadingOut = true
            p_u_70.IsInspecting = false
            p_u_70.CancelDelayThread = task.delay(p72 or 0.3, function()
                if p_u_70.IsDestroyed then
                    return
                elseif p_u_70.IsInspectFadingOut then
                    p_u_70.Viewmodel.Animation:crossfadeTo("Idle", v_u_74)
                    p_u_70.FadeCompleteThread = task.delay(v_u_74, function()
                        if not p_u_70.IsDestroyed then
                            p_u_70.FadeCompleteThread = nil
                            p_u_70.IsInspectFadingOut = false
                        end
                    end)
                end
            end)
        end
    else
        return
    end
end
function v_u_1.inspect(p_u_75)
    if tick() - p_u_75.WeaponEquippedTick <= 1 then
        return
    elseif p_u_75.IsAdjustingSuppressor or (p_u_75.IsShooting or (p_u_75.IsReloading or p_u_75.IsAiming)) then
        return
    elseif p_u_75.IsInspecting and not p_u_75.IsInspectFadingOut then
        return
    else
        local v76 = p_u_75.IsInspectFadingOut == true
        if v76 then
            p_u_75.IsInspectFadingOut = false
            if p_u_75.CancelDelayThread then
                task.cancel(p_u_75.CancelDelayThread)
                p_u_75.CancelDelayThread = nil
            end
            if p_u_75.FadeCompleteThread then
                task.cancel(p_u_75.FadeCompleteThread)
                p_u_75.FadeCompleteThread = nil
            end
            p_u_75.Viewmodel.Animation:cancelCrossfade()
        end
        p_u_75.IsBurstShooting = false
        p_u_75.IsInspecting = true
        p_u_75.IsReloading = false
        p_u_75.IsShooting = false
        p_u_75.ScopeStartTick = 0
        p_u_75.IsAiming = false
        if p_u_75.InspectDelayThread then
            task.cancel(p_u_75.InspectDelayThread)
            p_u_75.InspectDelayThread = nil
        end
        if v76 then
            if not p_u_75.Viewmodel.Animation:crossfadeRestart("Inspect", 0.25) then
                p_u_75:stopAllAnimations()
                p_u_75.Viewmodel.Animation:play("Inspect")
            end
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Inspect")
            local v77 = p_u_75.Viewmodel.Animation:getAnimation("Inspect")
            if v77 then
                p_u_75.InspectDelayThread = task.delay(v77.Length, function()
                    if not p_u_75.IsDestroyed then
                        p_u_75.InspectDelayThread = nil
                        p_u_75.IsInspecting = false
                    end
                end)
            end
        else
            p_u_75:stopAllAnimations()
            local v78 = p_u_75.Viewmodel.Animation:play("Inspect")
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Inspect")
            p_u_75.InspectDelayThread = task.delay(v78.Length, function()
                if not p_u_75.IsDestroyed then
                    p_u_75.InspectDelayThread = nil
                    p_u_75.IsInspecting = false
                end
            end)
        end
    end
end
function v_u_1.updateFireMode(p79)
    if tick() - p79.WeaponEquippedTick <= 1 then
        return
    elseif not (p79.IsShooting or (p79.IsReloading or p79.IsBurstShooting)) then
        v_u_26:play({
            ["Name"] = "Switch Fire Mode",
            ["Parent"] = v_u_25.PlayerGui
        })
        p79:stopAllAnimations()
        p79.Viewmodel.Animation:play("Switch")
        p79.AlternativeSwitchTick = tick()
        p79.AlternativeShootingOption = p79.AlternativeShootingOption == "Burst" and "Default" or "Burst"
        v_u_20.Spectate.ReplicateSpectateEvent.Send("Switch Fire Mode")
        local v80 = p79.Properties.Automatic and "Switched to automatic" or "Switched to semi-automatic"
        v_u_21.broadcastRouter("CreateNotification", "Switched Fire Mode", p79.AlternativeShootingOption == "Default" and v80 and v80 or "Switched to burst-fire mode", 2.5)
    end
end
function v_u_1.drop(p81)
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_19.GetState() == "Warmup" then
        return false
    end
    if not p81.Properties.Droppable then
        return false
    end
    p81:unequip()
    v_u_20.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_24.CFrame.LookVector,
        ["Identifier"] = p81.Identifier
    })
    return true
end
function v_u_1.reload(p_u_82)
    if tick() - p_u_82.WeaponEquippedTick <= 1 then
        return
    end
    if p_u_82.IsAdjustingSuppressor or (p_u_82.IsReloading or p_u_82.IsShooting) then
        return
    end
    if p_u_82.Properties.Rounds == p_u_82.Rounds then
        if p_u_82.IsInspecting or p_u_82.IsInspectFadingOut then
            p_u_82:cancelInspect(0.25)
        end
        return
    end
    if p_u_82.Capacity <= 0 then
        if p_u_82.IsInspecting or p_u_82.IsInspectFadingOut then
            p_u_82:cancelInspect(0.25)
        end
        return v_u_26:play({
            ["Parent"] = v_u_25.PlayerGui,
            ["Name"] = "No Ammo"
        })
    end
    if p_u_82.IsAiming then
        p_u_82:unscope()
    end
    if not (p_u_82.Properties.Rounds and p_u_82.Properties.ReloadAnimationCount) then
        return
    end
    if p_u_82.IsInspecting or p_u_82.IsInspectFadingOut then
        p_u_82:cancelInspect(nil, nil, true)
    end
    p_u_82:stopAllAnimations()
    p_u_82.ReloadStartTick = tick()
    p_u_82.IsBurstShooting = false
    p_u_82.IsInspecting = false
    p_u_82.IsReloading = true
    p_u_82.IsShooting = false
    if p_u_82.Properties.ReloadAnimationCount > 1 then
        local v_u_83 = p_u_82.Properties.Rounds / p_u_82.Properties.ReloadAnimationCount
        local v84 = p_u_82.Viewmodel.Animation:play("ReloadStart")
        task.wait(v84.Length * 0.75)
        local v85 = p_u_82.Properties.Rounds - p_u_82.Rounds / v_u_83
        for _ = 1, math.ceil(v85) do
            if not p_u_82.IsReloading then
                break
            end
            local v86 = p_u_82.Viewmodel.Animation:play("ReloadAction")
            if not v86 then
                error((("Client failed to fetch reload animation for %*."):format(p_u_82.Name)))
            end
            local v_u_87 = v_u_3:GenerateGUID(false)
            p_u_82.CurrentReloadIdentity = v_u_87
            p_u_82.CharacterAnimator:play("Reload")
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Reload")
            v86:GetMarkerReachedSignal("MagOut"):Once(function()
                v_u_20.Inventory.CreateMagazine.Send(p_u_82.Identifier)
            end)
            v86:GetMarkerReachedSignal("MagIn"):Once(function()
                local v88 = p_u_82
                local v89 = not v88.IsDestroyed
                if v89 then
                    v89 = v88.IsEquipped == true
                end
                if v89 then
                    local v90 = v_u_83
                    local v91 = p_u_82.Capacity
                    local v92 = math.clamp(v90, 0, v91)
                    if p_u_82.CurrentReloadIdentity == v_u_87 and v92 <= p_u_82.Capacity then
                        v_u_20.Inventory.ReloadWeapon.Send({
                            ["Identifier"] = p_u_82.Identifier,
                            ["Capacity"] = p_u_82.Capacity,
                            ["Rounds"] = p_u_82.Rounds
                        })
                        p_u_82.Rounds = p_u_82.Rounds + v92
                        if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                            p_u_82.Capacity = p_u_82.Capacity - v92
                        end
                    end
                end
            end)
            task.wait(v86.Length * 0.8)
        end
        if p_u_82.IsReloading then
            p_u_82.Viewmodel.Animation:play("ReloadEnd").Ended:Once(function()
                p_u_82.IsReloading = false
            end)
        end
    else
        local v_u_93 = v_u_3:GenerateGUID(false)
        p_u_82.CurrentReloadIdentity = v_u_93
        local v_u_94 = p_u_82.Viewmodel.Animation:play("Reload")
        local v95 = ("Client failed to fetch reload animation for %*."):format(p_u_82.Name)
        assert(v_u_94, v95)
        if v_u_94 then
            p_u_82.CharacterAnimator:play("Reload")
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Reload")
            v_u_94:GetMarkerReachedSignal("MagOut"):Once(function()
                v_u_20.Inventory.CreateMagazine.Send(p_u_82.Identifier)
            end)
            v_u_94:GetMarkerReachedSignal("MagIn"):Once(function()
                local v96 = p_u_82
                local v97 = not v96.IsDestroyed
                if v97 then
                    v97 = v96.IsEquipped == true
                end
                if v97 then
                    local v98 = p_u_82.Properties.Rounds - p_u_82.Rounds
                    local v99 = math.abs(v98)
                    if p_u_82.CurrentReloadIdentity == v_u_93 then
                        v_u_20.Inventory.ReloadWeapon.Send({
                            ["Identifier"] = p_u_82.Identifier,
                            ["Rounds"] = p_u_82.Rounds,
                            ["Capacity"] = p_u_82.Capacity
                        })
                        v_u_17:clearHint("Reload")
                        if p_u_82.Capacity - v99 > 0 then
                            p_u_82.Rounds = p_u_82.Properties.Rounds
                            if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                                local v100 = p_u_82
                                local v101 = p_u_82.Capacity - v99
                                v100.Capacity = math.max(0, v101)
                                return
                            end
                        elseif p_u_82.Capacity - v99 <= 0 then
                            p_u_82.Rounds = p_u_82.Rounds + p_u_82.Capacity
                            p_u_82.Capacity = 0
                        end
                    end
                end
            end)
            if p_u_82.ReloadTrackFinishedConnection and p_u_82.ReloadTrackFinishedConnection.Connected then
                p_u_82.ReloadTrackFinishedConnection:Disconnect()
            end
            p_u_82.ReloadTrackFinishedConnection = v_u_94:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                if not p_u_82.IsDestroyed then
                    if not v_u_94.IsPlaying and p_u_82.WeaponEquippedTick < p_u_82.ReloadStartTick then
                        p_u_82.IsReloading = false
                    end
                    if p_u_82.ReloadTrackFinishedConnection and p_u_82.ReloadTrackFinishedConnection.Connected then
                        p_u_82.ReloadTrackFinishedConnection:Disconnect()
                    end
                    p_u_82.ReloadTrackFinishedConnection = nil
                end
            end)
        end
    end
    return nil
end
function v_u_1.shoot(p_u_102)
    local v103 = p_u_102.Viewmodel.Animation:getAnimation("Equip")
    if tick() - p_u_102.WeaponEquippedTick <= v103.Length * 0.925 or v_u_25 and (v_u_25.Character and v_u_25.Character:GetAttribute("Dead")) then
        return
    elseif pcall(function()
        local v104 = p_u_102.Properties
        v104.FireRate = v104.FireRate + 1e-7
    end) then
        v_u_1 = {}
        while true do

        end
    else
        if v_u_27 and v_u_27[p_u_102.Name] then
            local v105 = v_u_27[p_u_102.Name]
            if p_u_102.Properties.FireRate < v105.FireRate or (p_u_102.Properties.BulletsPerShot > v105.BulletsPerShot or (p_u_102.Properties.Range > v105.Range or p_u_102.Properties.Penetration > v105.Penetration)) then
                v_u_1 = {}
                while true do

                end
            end
        end
        if p_u_102.Properties.FireRate and p_u_102.Properties.BulletsPerShot then
            if p_u_102.IsAdjustingSuppressor then
                return
            elseif p_u_102.IsReloading and p_u_102.Properties.MuzzleType ~= "ShotGun" then
                return
            else
                local v106 = p_u_102.Player
                if v106 then
                    v106 = p_u_102.Player.Character
                end
                if v106 then
                    if p_u_102.CharacterAnimator then
                        p_u_102.CharacterAnimator:adjustAnimationSpeed("Shoot", p_u_102.Properties.FireRate)
                        if p_u_102.AlternativeShootingOption ~= "Burst" then
                            p_u_102.ShootRequestTick = tick()
                        end
                        if p_u_102.IsShooting and p_u_102.AlternativeShootingOption == "Default" then
                            return
                        else
                            local v107 = p_u_102.Viewmodel.Model:FindFirstChild("Interactables")
                            if v107 then
                                if p_u_102.Rounds <= 0 then
                                    p_u_102:reload()
                                    return
                                else
                                    local v108 = p_u_102.IsAiming and p_u_102.Properties.AimingOptions == "AutomaticScope" and "AimShoot" or "Shoot"
                                    local v109 = p_u_102.Properties.HasSuppressor and not p_u_102.IsSuppressed and "NoSuppressorShoot" or "Shoot"
                                    v_u_14.toWeaponFirePosition()
                                    if p_u_102.IsInspecting or p_u_102.IsInspectFadingOut then
                                        p_u_102:cancelInspect(nil, nil, true)
                                    end
                                    p_u_102:stopAllAnimations()
                                    p_u_102.CurrentReloadIdentity = nil
                                    p_u_102.IsInspecting = false
                                    p_u_102.IsInspectFadingOut = false
                                    p_u_102.IsReloading = false
                                    p_u_102.IsShooting = true
                                    p_u_102.Rounds = p_u_102.Rounds - 1
                                    if p_u_102.Properties.ShootingOptions == "Dual" then
                                        p_u_102.ShootingHand = p_u_102.ShootingHand == "Left" and "Right" or "Left"
                                        v108 = "Shoot" .. p_u_102.ShootingHand
                                        v109 = "Shoot" .. p_u_102.ShootingHand
                                    end
                                    if p_u_102.Rounds <= 150 then
                                        local v110 = v106.PrimaryPart.Position
                                        local v111 = p_u_102.Properties.HasSuppressor
                                        if v111 then
                                            v111 = p_u_102.IsSuppressed
                                        end
                                        local v112 = v111 == true
                                        local v113 = v_u_15.GetWeaponShootRange(p_u_102.Name, v112)
                                        v_u_21.broadcastRouter("UpdatePlayerNoiseCone", "Weapon", v110, v113, nil)
                                        local v114 = p_u_102.Properties.ShootingOptions == "Dual" and (p_u_102.ShootingHand == "Left" and v107:FindFirstChild("MuzzlePartL") or v107:FindFirstChild("MuzzlePartR")) or v107.MuzzlePart
                                        local v115 = v114.Position
                                        local v116 = {}
                                        for _ = 1, p_u_102.Properties.BulletsPerShot do
                                            local v117 = p_u_102.Bullet:create(p_u_102.Properties.AimingOptions, p_u_102.IsAiming)
                                            if v117 then
                                                if v_u_18.Get(v_u_25, "Settings.Video.Presets.First Person Tracers") ~= false then
                                                    v_u_11(v117.Distance, v115, v117.Direction)
                                                end
                                                local v118 = v_u_18.Get(v_u_25, "Settings.Video.Presets.Muzzle Flash") ~= false
                                                if v118 then
                                                    local v119
                                                    if p_u_102.Properties.AimingOptions == "AutomaticScope" then
                                                        v119 = p_u_102.IsAiming
                                                    else
                                                        v119 = false
                                                    end
                                                    v118 = not v119
                                                end
                                                if v118 then
                                                    v_u_8(v114, p_u_102.Name, p_u_102.Properties.HasSuppressor and p_u_102.IsSuppressed and "Suppressor" or nil)
                                                end
                                                local v120 = false
                                                for _, v121 in ipairs(v117.Hits) do
                                                    local v122 = v121.Instance
                                                    local v123 = v121.Position
                                                    local v124 = v121.Material
                                                    local v125 = v121.Normal
                                                    local v126 = v121.Exit
                                                    local v127 = v122 and v122.Parent
                                                    if v127 then
                                                        v127 = v122.Parent:FindFirstChildOfClass("Humanoid")
                                                    end
                                                    if v127 then
                                                        v_u_10(v122, "Blood Splatter", v123, v125, v126, false, true, nil, v120)
                                                    else
                                                        v120 = not v126 and true or v120
                                                        v_u_10(v122, v124, v123, v125, v126, false, true)
                                                        local v128 = v122.Parent
                                                        if v128 and (v128:HasTag("BreakableGlass") and not v126) then
                                                            v_u_12(v122, v123, v117.Direction)
                                                        elseif not v122:HasTag("BreakableGlass") then
                                                            if not (v128 and v128:HasTag("BreakableGlass")) then
                                                                v_u_9(v122, "Bullet", v123, v125)
                                                            end
                                                        end
                                                    end
                                                end
                                                table.insert(v116, v117)
                                            end
                                        end
                                        if p_u_102.Viewmodel.Model.CameraShake then
                                            v_u_48(p_u_102.Viewmodel.Model.CameraShake)
                                        end
                                        p_u_102.Viewmodel.Bobble:addScopeKick()
                                        if p_u_102.Viewmodel.applyCharmImpulse then
                                            local v129 = p_u_102.Viewmodel.Model.WorldPivot.LookVector
                                            local v130 = p_u_102.Viewmodel.Model.WorldPivot.UpVector
                                            local v131 = v129 * -1 + v130 * 0.3
                                            p_u_102.Viewmodel:applyCharmImpulse(v131)
                                        end
                                        if p_u_102.Recoil then
                                            local v132 = p_u_102.Recoil
                                            v132.Time = v132.Time + p_u_102.Properties.FireRate
                                        end
                                        v_u_20.Spectate.ReplicateSpectateEvent.Send(v109)
                                        local v133 = {}
                                        for _, v134 in ipairs(v116) do
                                            local v135 = v134.Origin
                                            local v136 = {}
                                            for _, v137 in ipairs(v134.Hits) do
                                                local v138 = {
                                                    ["Distance"] = (v137.Position - v135).Magnitude,
                                                    ["Instance"] = v137.Instance,
                                                    ["Position"] = v137.Position,
                                                    ["Normal"] = v137.Normal,
                                                    ["Material"] = v137.Material,
                                                    ["Exit"] = v137.Exit
                                                }
                                                table.insert(v136, v138)
                                                v135 = v137.Position
                                            end
                                            local v139 = {
                                                ["Direction"] = v134.Direction,
                                                ["Origin"] = v134.Origin,
                                                ["Hits"] = v136
                                            }
                                            table.insert(v133, v139)
                                        end
                                        v_u_20.Inventory.ShootWeapon.Send({
                                            ["IsSniperScoped"] = p_u_102.IsSniperScoped,
                                            ["ShootingHand"] = p_u_102.ShootingHand,
                                            ["Identifier"] = p_u_102.Identifier,
                                            ["Capacity"] = p_u_102.Capacity,
                                            ["Bullets"] = v133,
                                            ["Rounds"] = p_u_102.Rounds
                                        })
                                        local v_u_140 = p_u_102.IsAiming
                                        if v_u_140 then
                                            v_u_140 = p_u_102.Properties.AimingOptions == "SniperScope"
                                        end
                                        if v_u_140 then
                                            p_u_102:unscope(true)
                                        end
                                        local v141 = p_u_102.Viewmodel.Animation:play(v109)
                                        p_u_102.CharacterAnimator:play(v108)
                                        v_u_13.vibrate(Enum.VibrationMotor.Small, 1.25, 0.225)
                                        if p_u_102.ShootDelayThread then
                                            task.cancel(p_u_102.ShootDelayThread)
                                            p_u_102.ShootDelayThread = nil
                                        end
                                        local v142 = p_u_102.Properties.FireRate or (v141 and v141.Length or 0.1)
                                        p_u_102.ShootDelayThread = task.delay(v142, function()
                                            if p_u_102.IsDestroyed then
                                                return
                                            else
                                                p_u_102.IsShooting = false
                                                p_u_102.ShootDelayThread = nil
                                                local v143 = p_u_102
                                                local v144 = not v143.IsDestroyed
                                                if v144 then
                                                    v144 = v143.IsEquipped == true
                                                end
                                                if v144 then
                                                    if v_u_140 and (p_u_102.ShootRequestTick > p_u_102.WeaponEquippedTick and (p_u_102.Rounds > 0 and v_u_18.Get(v_u_25, "Settings.Game.Item.Auto Re-Zoom Sniper Rifle after Shot") == true)) then
                                                        p_u_102:scope(true)
                                                    end
                                                    local v145 = tick()
                                                    local v146 = p_u_102.Properties.FireRate
                                                    local v147 = math.min(0.15, v146) >= v145 - p_u_102.ShootRequestTick
                                                    local v148 = p_u_102.IsFireHeld == true
                                                    if v148 and not v_u_16.isActionPressed("Fire") then
                                                        p_u_102.IsFireHeld = false
                                                        v148 = false
                                                    end
                                                    if p_u_102.Properties.Automatic and v148 and v148 or (not p_u_102.Properties.Automatic and (v147 and not v148) or false) then
                                                        if p_u_102.Properties.ShootingOptions == "Burst" and p_u_102.AlternativeShootingOption == "Burst" then
                                                            return
                                                        elseif p_u_102.Rounds > 0 then
                                                            p_u_102:shoot()
                                                        else
                                                            p_u_102:reload()
                                                        end
                                                    else
                                                        return
                                                    end
                                                else
                                                    return
                                                end
                                            end
                                        end)
                                    end
                                end
                            else
                                return
                            end
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
end
function v_u_1.equip(p149)
    p149.IsEquipped = true
    if p149.Viewmodel.Hidden then
        p149.Viewmodel:unhide()
    end
    p149.Viewmodel.Animation:stopAnimations()
    p149.CharacterAnimator:stopAnimations()
    p149.CharacterAnimator:play("Idle")
    p149.CharacterAnimator:play("Equip")
    p149.WeaponEquippedTick = tick()
    p149.Viewmodel:equip(false)
    p149.CurrentScopeIncrement = 0
    p149.IsBurstShooting = false
    p149.IsInspectFadingOut = false
    p149.IsInspecting = false
    p149.IsReloading = false
    p149.IsShooting = false
    p149.IsFireHeld = false
    p149.IsAiming = false
    p149.ScopeStartTick = 0
    p149.IsAdjustingSuppressor = false
    local v150 = p149.Name
    if v150 == "SSG 08" and true or v150 == "AWP" then
        p149.IsSniperScoped = false
        if p149.Name == "AWP" and p149.Player then
            p149.Player:SetAttribute("IsSniperScoped", false)
        end
    end
end
function v_u_1.unequip(p151)
    p151.IsEquipped = false
    if p151.ShootDelayThread then
        task.cancel(p151.ShootDelayThread)
        p151.ShootDelayThread = nil
    end
    local v152 = require(v_u_2.Controllers.CaseSceneController)
    local v153 = require(v_u_2.Controllers.MenuSceneController)
    if not (v152.IsActive() or v153.IsActive()) then
        v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV)
    end
    p151.CharacterAnimator:stopAnimations()
    p151.Viewmodel:unequip()
    if p151.IsAiming then
        p151:unscope()
    end
    if p151.Viewmodel.Hidden then
        p151.Viewmodel:unhide()
    end
    p151.IsBurstShooting = false
    p151.IsInspectFadingOut = false
    p151.IsInspecting = false
    p151.IsReloading = false
    p151.IsShooting = false
    p151.IsFireHeld = false
    p151.IsAiming = false
    p151.IsAdjustingSuppressor = false
    local v154 = p151.Name
    if v154 == "SSG 08" and true or v154 == "AWP" then
        p151.IsSniperScoped = false
        if p151.Name == "AWP" and p151.Player then
            p151.Player:SetAttribute("IsSniperScoped", false)
        end
    end
    if p151.Recoil then
        p151.Recoil.Value = Vector2.zero
        p151.Recoil.RecoveryStartTime = 0
        p151.Recoil.Time = 0
    end
end
function v_u_1.createSuppressor(p_u_155)
    local v_u_156 = p_u_155.Viewmodel.Model:FindFirstChild("Silencer", true)
    if v_u_156 then
        v_u_156.Transparency = p_u_155.IsSuppressed and 0 or 1
        local v_u_157 = p_u_155.Identifier
        local v162 = table.freeze({
            {
                ["AnimationTrack"] = p_u_155.Viewmodel.Animation:getAnimation("RemoveSuppressor"),
                ["State"] = false,
                ["Event"] = function(p158)
                    return p158:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
                        if not p_u_155.IsDestroyed then
                            v_u_156.Transparency = 1
                            local v159 = {
                                ["Identifier"] = v_u_157,
                                ["State"] = false
                            }
                            v_u_20.Inventory.UpdateWeaponSuppressor.Send(v159)
                        end
                    end)
                end
            },
            {
                ["AnimationTrack"] = p_u_155.Viewmodel.Animation:getAnimation("AddSuppressor"),
                ["State"] = true,
                ["Event"] = function(p_u_160)
                    return p_u_160:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                        if p_u_160.IsPlaying then
                            if p_u_155.IsDestroyed then
                                return
                            end
                            v_u_156.Transparency = 0
                            local v161 = {
                                ["Identifier"] = v_u_157,
                                ["State"] = true
                            }
                            v_u_20.Inventory.UpdateWeaponSuppressor.Send(v161)
                        end
                    end)
                end
            }
        })
        for _, v_u_163 in ipairs(v162) do
            p_u_155.Janitor:Add(v_u_163.Event(v_u_163.AnimationTrack))
            p_u_155.Janitor:Add(v_u_163.AnimationTrack.Ended:Connect(function()
                local v164 = v_u_156.Transparency < 1
                p_u_155.IsAdjustingSuppressor = false
                if v_u_163.State == v164 then
                    local v165 = v_u_163.State and 0 or 1
                    if not p_u_155.IsDestroyed then
                        v_u_156.Transparency = v165
                        v_u_20.Inventory.UpdateWeaponSuppressor.Send({
                            ["Identifier"] = v_u_157,
                            ["State"] = v165 == 0
                        })
                    end
                    p_u_155.IsSuppressed = v_u_163.State
                end
            end))
        end
    end
end
function v_u_1.setupRecoil(p_u_166)
    local v167 = p_u_166.Properties.Recoil
    if p_u_166.Properties.Recoil then
        local v_u_168 = v167.RecoverySpeed
        local v_u_169 = v167.Scale
        local v_u_170 = v167.Damper
        local v_u_171 = v167.Speed
        local v_u_172 = v167.CameraScale
        local v_u_173 = p_u_166.Identifier
        p_u_166.Recoil = {
            ["Function"] = v167.Pattern(p_u_166.Properties),
            ["Value"] = Vector2.zero,
            ["RotationValue"] = Vector3.new(0, 0, 0),
            ["Time"] = 0,
            ["RecoveryValue"] = Vector2.zero,
            ["RecoveryTime"] = 0,
            ["RecoveryStartTime"] = 0
        }
        local v_u_174 = p_u_166.Recoil
        p_u_166.Janitor:Add(v_u_4.Stepped:Connect(function(_, p175)
            if not p_u_166.IsDestroyed and v_u_174 then
                local v176 = v_u_174.Function(v_u_174.Time)
                if p_u_166.IsShooting then
                    v_u_174.Value = v176
                    v_u_174.RecoveryValue = v176
                    v_u_174.RecoveryTime = v_u_174.Time
                    v_u_174.RecoveryStartTime = os.clock()
                else
                    local v177 = v_u_174.RecoveryValue.Magnitude / v_u_168
                    if v_u_174.Value.Magnitude > 0 and v177 > 0 then
                        local v178 = os.clock() - v_u_174.RecoveryStartTime
                        local v179 = v_u_174
                        local v180 = v_u_174.RecoveryValue
                        local v181 = Vector2.zero
                        local v182 = v178 / v177
                        v179.Value = v180:Lerp(v181, (math.clamp(v182, 0, 1)))
                    end
                    if v_u_174.Time > 0 then
                        local v183 = v_u_174
                        local v184 = v_u_174.Time - v_u_174.RecoveryTime * v_u_168 * p175
                        v183.Time = math.max(v184, 0)
                    end
                end
                local v185 = v_u_174.Value.Y
                local v186 = v_u_174.Value.X
                local v187 = Vector3.new(v185, v186, 0)
                local v188 = v_u_169
                local v189 = v187 * math.rad(v188)
                v_u_174.RotationValue = v189
                if not p_u_166.IsDestroyed and (p_u_166.IsEquipped and p_u_166.Identifier == v_u_173) then
                    local v190 = {
                        ["Value"] = v189,
                        ["Damper"] = v_u_170,
                        ["Speed"] = v_u_171
                    }
                    v_u_14.setWeaponRecoil(v190, v_u_172)
                end
            end
        end), "Disconnect", "RecoilConnection")
    end
end
function v_u_1.new(p191, p192, p193, p194, p195, p196, p197, p198, p199, p200, p201, p202, p203)
    local v204 = v_u_6.new(p191, p192, p193, p194, p195, p196, p197, p198, p199, p200, p201, p202)
    local v205 = v_u_1
    local v_u_206 = setmetatable(v204, v205)
    v_u_206.IsEquipped = false
    local v207 = p203 or {}
    v_u_206.Bullet = v_u_23.new(v_u_206, v_u_206.Properties)
    v_u_206.Capacity = v207.Capacity or v_u_206.Properties.Capacity
    v_u_206.Rounds = v207.Rounds or v_u_206.Properties.Rounds
    v_u_206.CurrentReloadIdentity = nil
    v_u_206.AlternativeShootingOption = "Default"
    v_u_206.AlternativeSwitchTick = 0
    v_u_206.IsBurstShooting = false
    v_u_206.ShootingHand = "Right"
    v_u_206.IsAdjustingSuppressor = false
    v_u_206.IsInspectFadingOut = false
    v_u_206.IsInspecting = false
    v_u_206.IsReloading = false
    v_u_206.IsShooting = false
    v_u_206.IsAiming = false
    v_u_206.IsFireHeld = false
    v_u_206.ScopeStartTick = 0
    if v207.IsSuppressed == nil then
        v_u_206.IsSuppressed = v_u_206.Properties.HasSuppressor
    else
        v_u_206.IsSuppressed = v207.IsSuppressed
    end
    v_u_206.IsSniperScoped = false
    v_u_206.ReloadTrackFinishedConnection = nil
    v_u_206.ShootDelayThread = nil
    v_u_206.InspectDelayThread = nil
    v_u_206.CancelDelayThread = nil
    v_u_206.FadeCompleteThread = nil
    v_u_206.CurrentScopeIncrement = 0
    v_u_206.WeaponEquippedTick = 0
    v_u_206.ShootRequestTick = 0
    v_u_206.ReloadStartTick = 0
    v_u_206.ScopeStartTick = 0
    v_u_206:setupRecoil()
    v_u_206.Janitor:Add(function()
        if v_u_206.Bullet then
            v_u_206.Bullet:destroy()
            v_u_206.Bullet = nil
        end
        if v_u_206.IsAiming then
            local v208 = require(v_u_2.Controllers.CaseSceneController)
            local v209 = require(v_u_2.Controllers.MenuSceneController)
            if not (v208.IsActive() or v209.IsActive()) then
                v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV)
            end
        end
    end)
    if v_u_206.Properties.HasSuppressor then
        v_u_206:createSuppressor()
    end
    return v_u_206
end
function v_u_1.destroy(p210)
    if not p210.IsDestroyed then
        p210.IsDestroyed = true
        if p210.ReloadTrackFinishedConnection and p210.ReloadTrackFinishedConnection.Connected then
            p210.ReloadTrackFinishedConnection:Disconnect()
            p210.ReloadTrackFinishedConnection = nil
        end
        if p210.ShootDelayThread then
            task.cancel(p210.ShootDelayThread)
            p210.ShootDelayThread = nil
        end
        if p210.InspectDelayThread then
            task.cancel(p210.InspectDelayThread)
            p210.InspectDelayThread = nil
        end
        if p210.CancelDelayThread then
            task.cancel(p210.CancelDelayThread)
            p210.CancelDelayThread = nil
        end
        if p210.FadeCompleteThread then
            task.cancel(p210.FadeCompleteThread)
            p210.FadeCompleteThread = nil
        end
        if p210.Recoil then
            p210.Recoil.RecoveryStartTime = nil
            p210.Recoil.RotationValue = nil
            p210.Recoil.RecoveryValue = nil
            p210.Recoil.RecoveryTime = nil
            p210.Recoil.Function = nil
            p210.Recoil.Value = nil
            p210.Recoil.Time = nil
            p210.Recoil = nil
        end
        if p210.Bullet then
            p210.Bullet:destroy()
            p210.Bullet = nil
        end
        p210.Janitor:Destroy()
        p210.Janitor = nil
        p210.AlternativeShootingOption = nil
        p210.AlternativeSwitchTick = nil
        p210.CurrentReloadIdentity = nil
        p210.CurrentScopeIncrement = nil
        p210.WeaponEquippedTick = nil
        p210.ShootRequestTick = nil
        p210.ReloadStartTick = nil
        p210.ShootingHand = nil
        v_u_6.destroy(p210)
    end
end
return v_u_1