local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("Debris")
require(v1.Database.Custom.Types)
local v_u_5 = require(v1.Classes.Sound)
local v_u_6 = require(v1.Shared.DebugFlags)
local v_u_7 = require(v1.Components.Common.VFXLibary.FlashEffect)
local v_u_8 = require(script.Components.Materials)
local v_u_9 = v1:WaitForChild("Assets"):WaitForChild("Impacts")
local v_u_10 = workspace:WaitForChild("Debris")
return function(p11, p12, p13, p14, p15, p16, p17, _, p18)
    local v19 = v_u_9:FindFirstChild(v_u_8[p12] or p12)
    if v19 then
        if p11 then
            local v20 = v19.Name
            if p11.Name == "Head" and p12 == "Blood Splatter" then
                local v21 = p11.Parent
                if v21 and (v21:FindFirstChildOfClass("Humanoid") and v21:IsDescendantOf(workspace)) then
                    local v22 = v_u_3:GetPlayerFromCharacter(v21)
                    if v22 and v22:IsDescendantOf(v_u_3) then
                        local v23 = v22:GetAttribute("Armor")
                        if v23 then
                            v23 = v_u_2:JSONDecode(v23)
                        end
                        if p16 or (not v23 or v23.Type ~= "Kevlar + Helmet") then
                            v20 = "Headshot"
                        else
                            v19 = v_u_9:FindFirstChild("Helmet Headshot")
                            v20 = "Helmet Headshot"
                        end
                    end
                end
            end
            if p15 then
                if v_u_6.IsEnabled("WeaponFX") then
                    warn(("[WeaponFX][Client][ImpactSound] skipped (exit shot) material=%s pos=%s"):format(tostring(p12), (tostring(p13))))
                end
            else
                local v24 = v_u_7.IsFlashed()
                local v25 = v24 and 0 or 1
                if v_u_6.IsEnabled("WeaponFX") then
                    warn(("[WeaponFX][Client][ImpactSound] play material=%s sound=%s pos=%s flashed=%s exit=%s melee=%s volumeMult=%s"):format(tostring(p12), tostring(v20), tostring(p13), tostring(v24), tostring(p15), tostring(p16), (tostring(v25))))
                end
                v_u_5.new("Bullet"):PlaySoundAtPosition({
                    ["Position"] = p13,
                    ["Class"] = "Bullet",
                    ["Name"] = v20
                }, nil, v25, p17 == true, p18 == true)
            end
        end
        if p12 == "Blood Splatter" or not p16 then
            local v26 = v19:GetChildren()
            local v27 = v26[math.random(1, #v26)]:Clone()
            v27.CollisionGroup = "Debris"
            v27.CanCollide = false
            v27.CanQuery = false
            v27.CanTouch = false
            v27.Anchored = true
            v27.CFrame = CFrame.new(p13, p13 + p14) + p14 * 0.1
            v27.Parent = v_u_10
            v27.Transparency = 1
            for _, v_u_28 in ipairs(v27:GetDescendants()) do
                if v_u_28:IsA("ParticleEmitter") then
                    task.delay(v_u_28:GetAttribute("EmitDelay") or 0, function()
                        v_u_28:Emit(v_u_28:GetAttribute("EmitCount") or 1)
                    end)
                end
            end
            v_u_4:AddItem(v27, 5)
        end
    end
end