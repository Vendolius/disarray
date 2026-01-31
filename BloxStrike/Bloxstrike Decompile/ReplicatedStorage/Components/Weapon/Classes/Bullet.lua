local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetRayIgnore)
local v_u_7 = require(v2.Shared.Raycast)
local v_u_8 = require(v2.Shared.Janitor)
local v_u_9 = require(v2.Shared.Spring)
local v_u_10 = workspace.CurrentCamera
local function v_u_18(p11, p12, p13)
    local v14 = Random.new(p13)
    local v15 = v14:NextNumber(-3.141592653589793, 3.141592653589793)
    local v16 = p12 / 2
    local v17 = v14:NextNumber(0, (math.rad(v16)))
    return (CFrame.lookAlong(Vector3.new(0, 0, 0), p11) * CFrame.Angles(0, 0, v15) * CFrame.Angles(v17, 0, 0)).LookVector
end
function v_u_1._performRaycast(p19, p20)
    local v21 = v_u_6()
    local v22 = v_u_10.ViewportSize / 2
    local v23 = v_u_10:ViewportPointToRay(v22.X, v22.Y)
    local v24 = math.min(p20, 140)
    local v25 = v_u_18(v23.Direction, v24)
    local v26 = v23.Origin
    local v27 = p19.Properties.Penetration or 0
    local v28 = p19.Properties.Range or 500
    local v29 = {
        ["Origin"] = v26,
        ["Direction"] = v25,
        ["Distance"] = 0,
        ["Hits"] = {}
    }
    local v30 = v25 * v28
    local v31 = v_u_7.cast(v26, v30, nil, v21)
    if not v31.instance then
        v29.Distance = v28
        return v29
    end
    local v32 = v31.position
    v29.Distance = (v32 - v26).Magnitude
    local v33 = v_u_7.castThrough(v32 - v25 * 0.001, v25 * (v27 + 0.001), v27, v21)
    for v34, v35 in ipairs(v33) do
        if v35.instance and v35.material then
            local v36 = {
                ["Position"] = v35.position,
                ["Instance"] = v35.instance,
                ["Material"] = v35.material.Name,
                ["Normal"] = v35.normal or Vector3.new(0, 0, 0),
                ["Exit"] = v34 % 2 == 0
            }
            local v37 = v29.Hits
            table.insert(v37, v36)
        end
    end
    return v29
end
function v_u_1.create(p38, p39, p40)
    p38.LastShotTick = tick()
    if p39 == "SniperScope" and not p40 then
        local v41 = p38.Properties.Spread
        local v42 = v41 and v41.MovementMultiplier or 1
        local v43 = v42 == 2 and 6 or (v42 == 3 and 12 or 15)
        local v44 = p38.Spread:getPosition()
        if (type(v44) ~= "number" and 0 or v44) < v43 then
            p38.Spread:setPosition(v43)
        end
    end
    local v45
    if p39 == "SniperScope" and p40 then
        local v46 = p38.Weapon
        if v46.Name == "AWP" then
            local v47 = v46.ScopeStartTick or 0
            if tick() - v47 < 0.2 then
                v45 = false
            else
                v45 = p40
            end
        else
            v45 = p40
        end
    else
        v45 = p40
    end
    local v48 = p38:getTrueSpread()
    if p39 == "SniperScope" and (p40 and (not v45 and p38.Weapon.Name == "AWP")) then
        local v49 = p38.Properties.Spread
        local v50 = v49 and v49.MovementMultiplier or 1
        local v51 = v50 == 2 and 6 or (v50 == 3 and 12 or 15)
        v48 = math.max(v48, v51)
    end
    p38:_updateShotSpread(p39, v45)
    return p38:_performRaycast(v48)
end
function v_u_1.getTrueSpread(p52)
    local v53 = p52.CharacterSpeed < 6.4 and 0 or p52.CharacterSpeed
    local v54 = p52.Properties.Spread
    local v55 = v53 * (not v54 and 1 or v54.MovementMultiplier)
    local v56 = p52.Spread:getPosition()
    return (type(v56) ~= "number" and 0 or v56) + v55
end
function v_u_1.getBaseSpread(p57)
    local v58 = p57.Spread:getPosition()
    return type(v58) ~= "number" and 0 or v58
end
function v_u_1.updateSpread(p59, p60)
    p59.Spread:update(p60)
end
function v_u_1._updateShotSpread(p61, p62, p63)
    local v64 = p61.Properties.Spread
    assert(v64, "Weapon properties missing spread configuration")
    local v65 = v64.Range
    local v66 = v65.Min
    local v67 = v65.Max
    if p62 == "SniperScope" then
        if p63 then
            v66 = 0
        else
            local v68 = v64.MovementMultiplier or 1
            v66 = v68 == 2 and 6 or (v68 == 3 and 12 or 15)
        end
    end
    local v69 = p61.Spread:getPosition()
    local v70 = (type(v69) ~= "number" and 0 or v69) + v64.PerShot
    local v71 = math.clamp(v70, v66, v67)
    p61.Spread:setPosition(v71)
end
function v_u_1.new(p72, p73)
    local v74 = v_u_1
    local v_u_75 = setmetatable({}, v74)
    v_u_75.Janitor = v_u_8.new()
    v_u_75.IsDestroyed = false
    v_u_75.Properties = p73
    v_u_75.Weapon = p72
    v_u_75.CharacterSpeed = 0
    v_u_75.isInAir = false
    v_u_75.jumpStartSpeed = nil
    v_u_75.verticalVelocity = 0
    v_u_75.isAtJumpPeak = false
    local v76 = p73.Spread
    assert(v76, "Weapon properties missing spread configuration")
    v_u_75.Spread = v_u_9.new(1, v76.RecoverySpeed, v76.Range.Min)
    v_u_75.LastShotTick = 0
    local v_u_77 = p73.AimingOptions
    local v_u_78 = p73.MuzzleType
    local v_u_79 = p73.Spread
    local v_u_80
    if v_u_79 then
        v_u_80 = v_u_79.Range
    else
        v_u_80 = v_u_79
    end
    if v_u_80 then
        v_u_80 = v_u_80.Min
    end
    local v_u_81
    if v_u_79 then
        v_u_81 = v_u_79.PerShot
    else
        v_u_81 = v_u_79
    end
    local v_u_82
    if v_u_79 then
        v_u_82 = v_u_79.MovementMultiplier
    else
        v_u_82 = v_u_79
    end
    if v_u_79 then
        v_u_79 = v_u_79.JumpShotMinimum
    end
    local v_u_83 = v_u_5
    v_u_75.Janitor:Add(v_u_3.Heartbeat:Connect(function(_)
        local v84 = v_u_83
        if v84 then
            v84 = v_u_83.Character
        end
        if v84 then
            local v85 = v84.PrimaryPart
            if v85 then
                local v86 = v84:FindFirstChildOfClass("Humanoid")
                if v86 then
                    local v87 = v85.AssemblyLinearVelocity
                    local v88 = v86:GetState()
                    v_u_75.verticalVelocity = v87.Y
                    local v89 = v_u_75.isInAir
                    v_u_75.isInAir = v88 == Enum.HumanoidStateType.Jumping and true or v88 == Enum.HumanoidStateType.Freefall
                    local v90
                    if v_u_77 == "SniperScope" and (v_u_78 == "Sniper" and (v_u_80 == 0 and v_u_81 == 0)) then
                        v90 = v_u_82 == 2
                    else
                        v90 = false
                    end
                    if v90 and v_u_75.isInAir then
                        local v91 = v_u_75
                        local v92 = v_u_75.verticalVelocity
                        v91.isAtJumpPeak = math.abs(v92) <= 3
                    else
                        v_u_75.isAtJumpPeak = false
                    end
                    if v_u_75.isInAir and not v89 then
                        local v93 = v_u_79 or 100
                        v_u_75.jumpStartSpeed = v87.Magnitude + v93
                    elseif not v_u_75.isInAir and v89 then
                        v_u_75.jumpStartSpeed = nil
                        v_u_75.isAtJumpPeak = false
                    end
                    if v_u_75.isInAir and v_u_75.jumpStartSpeed then
                        if v90 and v_u_75.isAtJumpPeak then
                            local v94 = v87.X
                            local v95 = v87.Z
                            v_u_75.CharacterSpeed = Vector3.new(v94, 0, v95).Magnitude
                        else
                            v_u_75.CharacterSpeed = v_u_75.jumpStartSpeed
                        end
                    else
                        v_u_75.CharacterSpeed = v87.Magnitude
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    end))
    v_u_75.Janitor:Add(v_u_3.Stepped:Connect(function(_, p96)
        v_u_75:updateSpread(p96)
    end))
    return v_u_75
end
function v_u_1.destroy(p97)
    if not p97.IsDestroyed then
        p97.IsDestroyed = true
        p97.Janitor:Destroy()
        p97.Properties = nil
        p97.Weapon = nil
        p97.Spread = nil
        p97.Janitor = nil
    end
end
return v_u_1