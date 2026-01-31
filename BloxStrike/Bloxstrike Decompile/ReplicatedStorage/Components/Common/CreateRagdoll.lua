local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Debris")
local v_u_4 = workspace:WaitForChild("Debris")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Database.Components.GameState)
local v_u_6 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_7 = require(script.Common.CustomPhysicalProperties)
local v_u_8 = require(script.Common.MaxFrictionTorque)
local v_u_9 = require(script.Common.PartMultipliers)
local v_u_10 = require(script.Common.Constraints)
local v_u_11 = {}
local v_u_12 = {}
function v_u_1.EnforceLimit()
    while #v_u_11 >= 8 do
        local v13 = table.remove(v_u_11, 1)
        if v13 then
            v13:Destroy()
        end
    end
end
function v_u_1.Track(p_u_14)
    local v15 = v_u_11
    table.insert(v15, p_u_14)
    v_u_12[p_u_14.Name] = p_u_14
    p_u_14.Destroying:Once(function()
        v_u_12[p_u_14.Name] = nil
        local v16 = table.find(v_u_11, p_u_14)
        if v16 then
            table.remove(v_u_11, v16)
        end
    end)
end
function v_u_1.Impulse(p17, p18)
    local v19 = p17:FindFirstChild(p18.Part)
    if v19 then
        local v20 = v_u_6(p18.Weapon)
        if v20 then
            local v21 = v20.RagdollMultiplier * 1.2
            local v22 = v_u_9[p18.Part]
            if v22 then
                v21 = v21 * (math.random(v22.Minimum, v22.Maximum) / 100)
            end
            local v23 = p18.Direction.Unit * v21 * (1 + p18.DirectionMultiplier)
            local v24 = math.random(-20, 20)
            local v25 = math.random(10, 25)
            local v26 = math.random
            v19.AssemblyLinearVelocity = v23 + Vector3.new(v24, v25, v26(-20, 20))
            for _, v27 in ipairs(p17:GetDescendants()) do
                if v27:IsA("BasePart") then
                    local v28 = math.random(-10, 10)
                    local v29 = math.random(-10, 10)
                    local v30 = math.random
                    v27.AssemblyAngularVelocity = Vector3.new(v28, v29, v30(-10, 10))
                end
            end
        end
    else
        return
    end
end
function v_u_1.CreateJoint(p31)
    local v32 = p31.Part0
    local v33 = p31.Part1
    if v32 and v33 then
        if not (v32:HasTag("CharacterAccessory") or v33:HasTag("CharacterAccessory")) then
            local v34 = Instance.new("Attachment")
            v34.CFrame = p31.C0
            v34.Parent = v32
            local v35 = Instance.new("Attachment")
            v35.CFrame = p31.C1
            v35.Parent = v33
            local v36 = Instance.new("BallSocketConstraint")
            v36.Attachment0 = v34
            v36.Attachment1 = v35
            v36.Parent = v32
            local v37 = v_u_10[v33.Name] or v_u_10.Default
            v36.MaxFrictionTorque = (v_u_8[v33.Name] or 0) * 0.1
            v36.TwistLimitsEnabled = v37.TwistLimitsEnabled
            v36.TwistLowerAngle = v37.TwistLowerAngle
            v36.TwistUpperAngle = v37.TwistUpperAngle
            v36.LimitsEnabled = v37.LimitsEnabled
            v36.Restitution = v37.Restitution
            v36.UpperAngle = v37.UpperAngle
            p31:Destroy()
        end
    else
        return
    end
end
return function(p_u_38)
    debug.profilebegin("CreateRagdoll")
    local v39 = p_u_38.Character
    if v39 then
        debug.profilebegin("DestroySection")
        local v40 = v_u_12[v39.Name]
        if v40 then
            v40:Destroy()
        end
        debug.profileend()
        v_u_1.EnforceLimit()
        v39.Archivable = true
        debug.profilebegin("CloneSection")
        local v_u_41 = v39:Clone()
        if v_u_41 then
            debug.profileend()
            v_u_1.Track(v_u_41)
            v_u_41.Name = v39.Name
            debug.profilebegin("CleanupSection")
            local v42 = v_u_41:FindFirstChild("WeaponModel")
            if v42 then
                v42:Destroy()
            end
            local v43 = v_u_41:FindFirstChild("WeaponAttachments")
            if v43 then
                v43:Destroy()
            end
            local v44 = v_u_4:FindFirstChild(v39.Name .. "_Weapon")
            if v44 then
                v44:Destroy()
            end
            local v45 = v_u_4:FindFirstChild(v39.Name .. "_WeaponAttachments")
            if v45 then
                v45:Destroy()
            end
            local v46 = v_u_41:FindFirstChild("CharacterModel")
            if v46 then
                v46:Destroy()
            end
            if v39.PrimaryPart and v_u_41.PrimaryPart then
                v_u_41:PivotTo(v39.PrimaryPart.CFrame)
            end
            v_u_41.Parent = v_u_4
            v_u_41:AddTag("Ragdoll")
            if v39.Parent then
                v39:Destroy()
            end
            debug.profileend()
            debug.profilebegin("SetupSection")
            for _, v47 in ipairs(v_u_41:GetDescendants()) do
                if v47:IsA("BasePart") then
                    if v47.Name == "CollisionCapsule" or v47.Name == "HumanoidRootPart" then
                        if v47.Name == "CollisionCapsule" then
                            v47:Destroy()
                        else
                            v47.Transparency = 1
                            v47.CanCollide = false
                            v47.Massless = true
                        end
                    elseif v47.Name == "Hitbox" or v47.Name == "Insert" then
                        v47.CanCollide = false
                        v47.Transparency = 1
                    else
                        v47.CustomPhysicalProperties = v_u_7[v47.Name] or v_u_7.Default
                        v47.CollisionGroup = "Debris"
                        v47.CastShadow = false
                        v47.CanCollide = true
                        v47.Transparency = 0
                        v47.Anchored = false
                        v47.Massless = false
                    end
                elseif v47:IsA("Motor6D") then
                    v_u_1.CreateJoint(v47)
                elseif v47:IsA("Humanoid") then
                    v47:Destroy()
                elseif v47:IsA("Script") or v47:IsA("LocalScript") then
                    v47:Destroy()
                elseif v47:IsA("BillboardGui") or (v47:IsA("Sound") or v47:IsA("ParticleEmitter")) then
                    v47:Destroy()
                elseif v47:IsA("Decal") then
                    v47.Transparency = 0
                end
            end
            task.defer(function()
                v_u_2.Assets.Other.Ragdoll.Humanoid:Clone().Parent = v_u_41
                for _, v_u_48 in ipairs(v_u_41:GetChildren()) do
                    if v_u_48:IsA("Clothing") or v_u_48:IsA("ShirtGraphic") then
                        v_u_48.Parent = nil
                        task.defer(function()
                            v_u_48.Parent = v_u_41
                        end)
                    end
                end
                v_u_1.Impulse(v_u_41, p_u_38)
            end)
            debug.profileend()
            debug.profileend()
            if v_u_5.GetState() == "Warmup" and workspace:GetAttribute("Gamemode") == "Deathmatch" then
                v_u_3:AddItem(v_u_41, 10)
            else
                v_u_3:AddItem(v_u_41, 15)
            end
        else
            return
        end
    else
        return
    end
end