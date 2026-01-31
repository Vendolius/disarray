local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.HapticsController)
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Classes.Sound)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Shared.Janitor)
local v_u_12 = workspace.CurrentCamera
function v_u_1.updateHeartbeat(p13, p14)
    if p13.Model:GetAttribute("IsGettingDefused") then
        return
    elseif p14.PrimaryPart and p13.Model.PrimaryPart then
        if (p14.PrimaryPart.Position - p13.Model.PrimaryPart.Position).Magnitude > 5 then
            p13.Model:SetAttribute("CanDefuse", false)
            return
        else
            local v15 = v_u_12.CFrame.Position
            local v16 = p13.Model.PrimaryPart.Position - v15
            local v17 = v16.Magnitude
            if v17 > 0 then
                local v18 = v16 / v17
                if v_u_12.CFrame.LookVector:Dot(v18) >= 0.966 then
                    p13.Model:SetAttribute("CanDefuse", true)
                else
                    p13.Model:SetAttribute("CanDefuse", false)
                end
            else
                p13.Model:SetAttribute("CanDefuse", false)
                return
            end
        end
    else
        return
    end
end
function v_u_1.new(p19)
    local v20 = v_u_1
    local v_u_21 = setmetatable({}, v20)
    v_u_21.Janitor = v_u_11.new()
    v_u_21.Sound = v_u_9.new("C4")
    v_u_21.Janitor:Add(function()
        v_u_21.Sound:destroy()
    end)
    v_u_21.Model = p19
    v_u_21.Data = v_u_3:JSONDecode(p19:GetAttribute("BombPlanted"))
    v_u_21.ExplodeAt = v_u_21.Data.Time + v_u_21.Data.TimeUntilExplode
    v_u_21.TimeUntilExplode = v_u_21.Data.TimeUntilExplode
    v_u_21.MinimumInterval = 0.15
    v_u_21.NextBeepAt = 0
    v_u_21.Elapsed = 0
    v_u_21.IsDefused = false
    v_u_10.broadcastRouter("CreateNotification", "Bomb", "The bomb has been planted.", 2.5)
    for _, v22 in ipairs(v_u_21.Model:GetDescendants()) do
        if v22:IsA("BasePart") then
            v22.CanQuery = true
        end
    end
    v_u_21.Janitor:Add(v_u_21.Model:GetAttributeChangedSignal("Defused"):Connect(function()
        v_u_10.broadcastRouter("CreateNotification", "Bomb", "The bomb has been defused.", 2.5)
        v_u_21.IsDefused = true
    end))
    v_u_21.Janitor:Add(v_u_21.Model:GetAttributeChangedSignal("Exploding"):Connect(function()
        v_u_10.broadcastRouter("Cancel Defuse Bomb")
        local v23 = require(v_u_2.Interface.Screens.Gameplay.Middle.DefuseBomb)
        if v23 and v23.SetDefuseBlockedUntil then
            local v24 = workspace:GetServerTimeNow()
            v23.SetDefuseBlockedUntil(v24 + 5)
        end
    end))
    v_u_21.Janitor:Add(v_u_21.Model:GetAttributeChangedSignal("Exploded"):Connect(function()
        local v25 = v_u_6.Character
        if v25 and v25:IsDescendantOf(workspace) then
            local v26 = v25:FindFirstChild("Humanoid")
            if v26 and v26.Health > 0 then
                v_u_8.BombExploded((v_u_21.Model.PrimaryPart.Position - v25.PrimaryPart.Position).Magnitude)
                v_u_7.vibrate(Enum.VibrationMotor.Large, 1.5, 0.25)
            end
        end
    end))
    v_u_21.Janitor:Add(v_u_4.Heartbeat:Connect(function(_)
        local v27 = v_u_6.Character
        if v27 and v27:IsDescendantOf(workspace) then
            local v28 = v27:FindFirstChild("Humanoid")
            if v28 and (v28.Health > 0 and v_u_6:GetAttribute("Team") == "Counter-Terrorists") then
                v_u_21:updateHeartbeat(v27)
            end
        end
    end))
    v_u_21.Janitor:Add(v_u_4.Heartbeat:Connect(function(p29)
        local v30 = v_u_21
        v30.Elapsed = v30.Elapsed + p29
        local v31 = v_u_21.Model:FindFirstChild("Weapon")
        if v31 then
            v31 = v_u_21.Model.Weapon:FindFirstChild("FlashingLight")
        end
        if v_u_21.IsDefused or v_u_21.Elapsed >= v_u_21.TimeUntilExplode then
            if v31 and (v31:FindFirstChild("Attachment") and v31.Attachment:FindFirstChild("PointLight")) then
                v31.Attachment.PointLight.Enabled = not v31.Attachment.PointLight.Enabled
            end
        elseif v_u_21.Elapsed >= v_u_21.NextBeepAt then
            local v32 = v_u_21
            local v33 = v_u_21.Elapsed
            local v34 = v_u_21.TimeUntilExplode - v_u_21.Elapsed
            local v35 = math.max(v34, 0)
            local v36 = v_u_21.TimeUntilExplode
            local v37 = v_u_21.MinimumInterval
            local v38 = v35 / v36 * 0.9 + 0.1
            if v38 > v37 then
                v37 = v38
            end
            v32.NextBeepAt = v33 + v37
            if v31 and (v31:FindFirstChild("Attachment") and v31.Attachment:FindFirstChild("PointLight")) then
                v31.Attachment.PointLight.Enabled = not v31.Attachment.PointLight.Enabled
            end
            local v39 = v_u_21.Model
            if v39 then
                v39 = v_u_21.Model.PrimaryPart
            end
            if not v39 then
                return
            end
            v_u_21.Sound:play({
                ["Parent"] = v39,
                ["Name"] = "Beep"
            })
        end
    end))
    return v_u_21
end
function v_u_1.destroy(p40)
    p40.Janitor:Destroy()
end
return v_u_1