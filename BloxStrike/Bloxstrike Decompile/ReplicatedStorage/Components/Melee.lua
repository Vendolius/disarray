local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Controllers.HapticsController)
local v_u_6 = require(v2.Controllers.SoundController)
local v_u_7 = require(v2.Controllers.InputController)
local v_u_8 = require(v2.Components.Common.GetRayIgnore)
local v_u_9 = require(v2.Components.Common.VFXLibary.CreateMarker)
local v_u_10 = require(v2.Components.Common.VFXLibary.CreateImpact)
local v_u_11 = require(v2.Components.Common.VFXLibary.BreakGlass)
local v_u_12 = require(v2.Classes.WeaponComponent)
local v_u_13 = require(v2.Database.Security.Remotes)
local v_u_14 = require(v2.Database.Security.Router)
local v_u_15 = v4.LocalPlayer
local v_u_16 = workspace.CurrentCamera
local function v_u_23(p17, p18)
    local v19 = p17:WaitForChild("HumanoidRootPart")
    local v20 = p18:WaitForChild("HumanoidRootPart")
    if not (v19 and v20) then
        return nil
    end
    local v21 = v20.CFrame.LookVector:Dot((v19.Position - v20.Position).Unit)
    local v22 = math.acos(v21)
    return math.deg(v22) > 100
end
function v_u_1.stopAllAnimations(p24)
    if p24.CharacterAnimator then
        if p24.Viewmodel and p24.Viewmodel.Animation then
            p24.Viewmodel.Animation:cancelCrossfade()
            for v25, v26 in pairs(p24.CharacterAnimator.Animations) do
                if v26.IsPlaying and v26.Name ~= "Idle" then
                    p24.CharacterAnimator:stop(v25)
                end
            end
            for v27, v28 in pairs(p24.Viewmodel.Animation.Animations) do
                if v28.IsPlaying and v28.Name ~= "Idle" then
                    p24.Viewmodel.Animation:stop(v27)
                end
            end
        end
    else
        return
    end
end
function v_u_1.reload(p29)
    if p29.IsInspecting or p29.IsInspectFadingOut then
        p29:cancelInspect(0.25)
    end
end
function v_u_1.shoot(p_u_30, p31)
    if tick() - p_u_30.WeaponEquippedTick <= 1 or v_u_15:GetAttribute("Dead") then
        return
    elseif p_u_30.Properties.FireRate then
        if p_u_30.IsShooting then
            return
        else
            local v32 = p_u_30.Player
            if v32 then
                v32 = p_u_30.Player.Character
            end
            if v32 then
                if p_u_30.IsInspecting or p_u_30.IsInspectFadingOut then
                    p_u_30:cancelInspect(0.25)
                end
                p_u_30:stopAllAnimations()
                p_u_30.IsInspecting = false
                p_u_30.IsInspectFadingOut = false
                p_u_30.IsShooting = true
                v_u_14.broadcastRouter("UpdatePlayerNoiseCone", "Melee", v32.PrimaryPart.Position, v_u_6.GetMeleeRange(p_u_30.Name), nil)
                local v33 = RaycastParams.new()
                v33.FilterType = Enum.RaycastFilterType.Exclude
                v33.FilterDescendantsInstances = v_u_8()
                v33.IgnoreWater = true
                local v34 = v_u_16.CFrame.LookVector * p_u_30.Properties.Range
                local v35 = v_u_16.CFrame.Position
                local v36 = workspace:Raycast(v35, v34, v33) or workspace:Spherecast(v35, 1.5, v34, v33)
                local v37 = p31 and "Heavy Swing" or ("Swing%*"):format((math.random(1, 2)))
                v_u_13.Spectate.ReplicateSpectateEvent.Send(v37)
                if v36 then
                    local v38 = v36.Instance
                    local v39 = v36.Position
                    local v40 = v36.Material
                    local v41 = v36.Normal
                    local v42 = v38 and v38.Parent
                    if v42 then
                        v42 = v38.Parent:FindFirstChildOfClass("Humanoid")
                    end
                    if v42 then
                        v_u_10(v38, "Blood Splatter", v39, v41, false, true, true)
                        v37 = p31 and v_u_23(v_u_15.Character, v38.Parent) and "BackStab" or v37
                    else
                        local v43 = v38.Parent
                        v_u_10(v38, v40.Name, v39, v41, false, true, true)
                        if v43 and v43:HasTag("BreakableGlass") then
                            v_u_11(v38, v39, v34.Unit)
                        elseif not (v38:HasTag("BreakableGlass") or v43 and v43:HasTag("BreakableGlass")) then
                            v_u_9(v38, "Melee", v39, v41)
                        end
                    end
                    v_u_13.Melee.MeleeAttack.Send({
                        ["Direction"] = v_u_16.CFrame.LookVector * p_u_30.Properties.Range,
                        ["Material"] = v36.Material.Name,
                        ["Distance"] = v36.Distance,
                        ["Instance"] = v36.Instance,
                        ["Position"] = v36.Position,
                        ["Normal"] = v36.Normal,
                        ["MeleeAttack"] = v37,
                        ["Identifier"] = p_u_30.Identifier
                    })
                end
                local v44 = p_u_30.Viewmodel.Animation:play(v37)
                local v45 = (v37 == "Swing1" or v37 == "Swing") and "Swing" or v37
                local v46 = p_u_30.Properties.FireRate * (p31 and 2.05 or 1)
                v_u_5.vibrate(Enum.VibrationMotor.Small, 1.15, 0.2)
                p_u_30.CharacterAnimator:play(v45)
                local v47 = v46 or (v44 and v44.Length or 0.3)
                task.delay(v47, function()
                    if not p_u_30.IsDestroyed then
                        p_u_30.IsShooting = false
                        if p_u_30.Identifier ~= v_u_3:JSONDecode(v_u_15:GetAttribute("CurrentEquipped") or "[]").Identifier then
                            return
                        end
                        local v48 = v_u_7.isActionPressed("Fire", { Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2 }) or p_u_30.IsFireHeld
                        local v49 = v_u_7.isActionPressed("Secondary Fire", { Enum.UserInputType.MouseButton2, Enum.KeyCode.ButtonL2 })
                        if v48 or v49 then
                            p_u_30:shoot(v49)
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
function v_u_1.cancelInspect(p_u_50, p51, p52)
    if p_u_50.IsInspecting or p_u_50.IsInspectFadingOut then
        if p_u_50.InspectDelayThread then
            task.cancel(p_u_50.InspectDelayThread)
            p_u_50.InspectDelayThread = nil
        end
        local v53 = p52 or 0.3
        local v_u_54 = p51 or 1.2
        p_u_50.IsInspectFadingOut = true
        p_u_50.IsInspecting = false
        if p_u_50.CancelDelayThread then
            task.cancel(p_u_50.CancelDelayThread)
            p_u_50.CancelDelayThread = nil
        end
        if p_u_50.FadeCompleteThread then
            task.cancel(p_u_50.FadeCompleteThread)
            p_u_50.FadeCompleteThread = nil
        end
        p_u_50.CancelDelayThread = task.delay(v53, function()
            if p_u_50.IsDestroyed then
                return
            elseif p_u_50.IsInspectFadingOut then
                p_u_50.Viewmodel.Animation:crossfadeTo("Idle", v_u_54)
                p_u_50.FadeCompleteThread = task.delay(v_u_54, function()
                    if not p_u_50.IsDestroyed then
                        p_u_50.FadeCompleteThread = nil
                        p_u_50.IsInspectFadingOut = false
                    end
                end)
            end
        end)
    end
end
function v_u_1.inspect(p_u_55)
    if p_u_55.IsShooting then
        return
    elseif p_u_55.IsInspecting and not p_u_55.IsInspectFadingOut then
        return
    else
        local v56 = p_u_55.IsInspectFadingOut == true
        if v56 then
            p_u_55.IsInspectFadingOut = false
            if p_u_55.CancelDelayThread then
                task.cancel(p_u_55.CancelDelayThread)
                p_u_55.CancelDelayThread = nil
            end
            if p_u_55.FadeCompleteThread then
                task.cancel(p_u_55.FadeCompleteThread)
                p_u_55.FadeCompleteThread = nil
            end
            p_u_55.Viewmodel.Animation:cancelCrossfade()
        end
        p_u_55.IsInspecting = true
        p_u_55.IsShooting = false
        if p_u_55.InspectDelayThread then
            task.cancel(p_u_55.InspectDelayThread)
            p_u_55.InspectDelayThread = nil
        end
        if v56 then
            if not p_u_55.Viewmodel.Animation:crossfadeRestart("Inspect", 0.25) then
                p_u_55:stopAllAnimations()
                p_u_55.Viewmodel.Animation:play("Inspect")
            end
            v_u_13.Spectate.ReplicateSpectateEvent.Send("Inspect")
            local v57 = p_u_55.Viewmodel.Animation:getAnimation("Inspect")
            if v57 then
                p_u_55.InspectDelayThread = task.delay(v57.Length, function()
                    if not p_u_55.IsDestroyed then
                        p_u_55.InspectDelayThread = nil
                        p_u_55.IsInspecting = false
                    end
                end)
            end
        else
            p_u_55:stopAllAnimations()
            local v58 = p_u_55.Viewmodel.Animation:play("Inspect")
            v_u_13.Spectate.ReplicateSpectateEvent.Send("Inspect")
            p_u_55.InspectDelayThread = task.delay(v58.Length, function()
                if not p_u_55.IsDestroyed then
                    p_u_55.InspectDelayThread = nil
                    p_u_55.IsInspecting = false
                end
            end)
        end
    end
end
function v_u_1.drop(_)
    return false
end
function v_u_1.equip(p59)
    p59.Viewmodel.Animation:stopAnimations()
    p59.CharacterAnimator:stopAnimations()
    p59.CharacterAnimator:play("Idle")
    p59.CharacterAnimator:play("Equip")
    p59.WeaponEquippedTick = tick()
    p59.Viewmodel:equip(false)
    p59.IsInspectFadingOut = false
    p59.IsInspecting = false
    p59.IsShooting = false
    p59.IsFireHeld = false
end
function v_u_1.unequip(p60)
    p60.CharacterAnimator:stopAnimations()
    p60.Viewmodel:unequip()
    p60.IsInspectFadingOut = false
    p60.IsInspecting = false
    p60.IsShooting = false
    p60.IsFireHeld = false
end
function v_u_1.new(p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, _)
    local v73 = v_u_12.new(p61, p62, p63, p64, p65, p66, p67, p68, p69, p70, p71, p72)
    local v74 = v_u_1
    local v75 = setmetatable(v73, v74)
    v75.IsInspectFadingOut = false
    v75.IsInspecting = false
    v75.IsShooting = false
    v75.IsFireHeld = false
    v75.InspectDelayThread = nil
    v75.CancelDelayThread = nil
    v75.FadeCompleteThread = nil
    v75.AlternativeSwitchTick = 0
    v75.WeaponEquippedTick = 0
    return v75
end
function v_u_1.destroy(p76)
    if not p76.IsDestroyed then
        p76.IsDestroyed = true
        if p76.InspectDelayThread then
            task.cancel(p76.InspectDelayThread)
            p76.InspectDelayThread = nil
        end
        if p76.CancelDelayThread then
            task.cancel(p76.CancelDelayThread)
            p76.CancelDelayThread = nil
        end
        if p76.FadeCompleteThread then
            task.cancel(p76.FadeCompleteThread)
            p76.FadeCompleteThread = nil
        end
        if p76.Janitor then
            p76.Janitor:Destroy()
            p76.Janitor = nil
        end
        p76.IsInspectFadingOut = nil
        p76.IsInspecting = nil
        p76.IsShooting = nil
        p76.IsFireHeld = nil
        p76.AlternativeSwitchTick = nil
        p76.WeaponEquippedTick = nil
        v_u_12.destroy(p76)
    end
end
return v_u_1