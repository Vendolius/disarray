local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
require(v_u_1.Database.Custom.Types)
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v_u_1.Controllers.SpectateController)
local v_u_8 = require(v_u_1.Controllers.CameraController)
local v_u_9 = require(v_u_1.Controllers.InputController)
local v_u_10 = require(v_u_1.Packages.Observers)
local v_u_11 = require(v_u_1.Shared.Janitor)
local v_u_12 = require(v_u_1.Classes.CharacterHighlight)
local v_u_13 = require(v_u_1.Components.Common.GetWeaponProperties)
local v_u_14 = require(script.Components.CharacterKinematics)
local v_u_15 = {
    ["Counter-Terrorists"] = Color3.fromRGB(25, 80, 170),
    ["Terrorists"] = Color3.fromRGB(255, 215, 70)
}
local v_u_16 = {}
local v_u_17 = {}
local v_u_18 = {}
local function v_u_24(p19, p20)
    local v21 = p19:FindFirstChildOfClass("Humanoid")
    if v21 then
        return v21
    end
    local v22 = tick()
    while p19.Parent do
        task.wait(0.1)
        local v23 = p19:FindFirstChildOfClass("Humanoid")
        if v23 then
            return v23
        end
        if p20 and p20 <= tick() - v22 then
            return nil
        end
    end
    return nil
end
local function v_u_48(p_u_25, p26, p27)
    local v_u_28 = v_u_24(p26)
    if not v_u_28 then
        return nil
    end
    local v29 = p26:WaitForChild("Head")
    if not (v29 and (v_u_28 and p26:IsDescendantOf(workspace))) then
        return nil
    end
    if v_u_17[p_u_25] then
        v_u_17[p_u_25]:Destroy()
        v_u_17[p_u_25] = nil
    end
    local v30 = v_u_11.new()
    local v31 = v30:Add(v_u_1.Assets.Other.Character.Arrow:Clone())
    v31.Arrow.ImageColor3 = v_u_15[p27]
    v31.Adornee = v29
    v31.Parent = v_u_6
    local v_u_32 = v30:Add(v_u_1.Assets.Other.Character.NameTag:Clone())
    v_u_32.Info.PlayerName.Text = ("%*"):format(p_u_25.DisplayName)
    v_u_32.Info.Weapons.Bomb.Visible = false
    v_u_32.Adornee = v29
    v_u_32.Parent = v_u_6
    v_u_32.Info.PlayerName.TextColor3 = v_u_15[p27]
    v_u_32.Info.Health.TextColor3 = v_u_15[p27]
    v_u_32.Info.Money.TextColor3 = v_u_15[p27]
    local v33 = v_u_32.Info.Health
    local v34 = v_u_28.Health / v_u_28.MaxHealth * 100
    v33.Text = ("%*%%"):format((math.ceil(v34)))
    v30:Add(v_u_28:GetPropertyChangedSignal("Health"):Connect(function()
        if v_u_32 and (v_u_32.Parent and v_u_32:FindFirstChild("Info")) then
            local v35 = v_u_32.Info.Health
            local v36 = v_u_28.Health / v_u_28.MaxHealth * 100
            v35.Text = ("%*%%"):format((math.ceil(v36)))
        end
    end))
    v30:Add(v_u_10.observeAttribute(p_u_25, "CurrentEquipped", function(p37)
        if not (v_u_32 and (v_u_32.Parent and v_u_32:FindFirstChild("Info"))) then
            return function() end
        end
        local v38 = v_u_2:JSONDecode(p37 or "[]")
        if v38 and v38.Name then
            local v39 = v_u_13(v38.Name)
            if v_u_32.Info and (v_u_32.Info.Weapons and v_u_32.Info.Weapons.Gun) then
                v_u_32.Info.Weapons.Gun.Image = v39 and (v39.Icon or "") or ""
                v_u_32.Info.Weapons.Gun.Visible = v39 or false
            end
        elseif v_u_32.Info and (v_u_32.Info.Weapons and v_u_32.Info.Weapons.Gun) then
            v_u_32.Info.Weapons.Gun.Visible = false
        end
        if v38 then
            v38 = v38.Name == "C4"
        end
        if v_u_32.Info and (v_u_32.Info.Weapons and v_u_32.Info.Weapons.Bomb) then
            local v40 = p_u_25:GetAttribute("Slot5")
            local v41
            if v40 then
                v41 = v_u_2:JSONDecode(v40)
                if v41 then
                    v41 = v41.Weapon == "C4"
                end
            else
                v41 = false
            end
            local v42 = v_u_32.Info.Weapons.Bomb
            if v41 then
                v41 = not v38
            end
            v42.Visible = v41
        end
        return function()
            if v_u_32 and (v_u_32:FindFirstChild("Info") and (v_u_32.Info.Weapons and v_u_32.Info.Weapons.Gun)) then
                v_u_32.Info.Weapons.Gun.Visible = false
            end
        end
    end))
    v30:Add(v_u_10.observeAttribute(p_u_25, "Slot5", function(p43)
        if not (v_u_32 and (v_u_32.Parent and v_u_32:FindFirstChild("Info"))) then
            return function() end
        end
        local v44 = v_u_2:JSONDecode(p43 or "[]")
        if v44 then
            v44 = v44.Weapon == "C4"
        end
        local v45 = p_u_25:GetAttribute("CurrentEquipped")
        local v46
        if v45 then
            v46 = v_u_2:JSONDecode(v45)
            if v46 then
                v46 = v46.Name == "C4"
            end
        else
            v46 = false
        end
        if v_u_32.Info and (v_u_32.Info.Weapons and v_u_32.Info.Weapons.Bomb) then
            local v47 = v_u_32.Info.Weapons.Bomb
            if v44 then
                v44 = not v46
            end
            v47.Visible = v44
        end
        return function()
            if v_u_32 and (v_u_32:FindFirstChild("Info") and (v_u_32.Info.Weapons and v_u_32.Info.Weapons.Bomb)) then
                v_u_32.Info.Weapons.Bomb.Visible = false
            end
        end
    end))
    v_u_17[p_u_25] = v30
    v_u_18[p_u_25] = {
        ["Arrow"] = v31,
        ["NameTag"] = v_u_32
    }
    v30:Add(function()
        v_u_18[p_u_25] = nil
    end)
    return v30
end
local function v_u_55(_, p49, p50)
    local v51 = p49:FindFirstChildOfClass("Humanoid")
    if not v51 then
        local v52 = tick()
        repeat
            task.wait(0.1)
            v51 = p49:FindFirstChildOfClass("Humanoid")
        until v51 or tick() - v52 > 5
    end
    if v51 then
        v_u_8.setPerspective(true, false)
        p50:Add(function()
            v_u_8.setPerspective(false, true)
        end)
        v_u_9.enableGroup("Gameplay")
        p50:Add(function()
            v_u_9.disableGroup("Gameplay")
        end)
        p50:Add(v51.StateChanged:Connect(function(p53, p54)
            v_u_8.StateChanged(p53, p54)
        end))
    end
end
local function v_u_58(p56)
    for _, v57 in pairs(v_u_18) do
        if v57.Arrow then
            v57.Arrow.Enabled = p56
        end
        if v57.NameTag then
            v57.NameTag.Enabled = p56
        end
    end
end
v_u_7.ListenToSpectate:Connect(function(p59)
    v_u_58(p59 == nil)
end)
return v_u_10.observeCharacter(function(p_u_60, p_u_61)
    if v_u_16[p_u_60] then
        v_u_16[p_u_60]:Destroy()
        v_u_16[p_u_60] = nil
    end
    local v_u_62 = v_u_11.new()
    v_u_16[p_u_60] = v_u_62
    if v_u_17[p_u_60] then
        v_u_17[p_u_60]:Destroy()
        v_u_17[p_u_60] = nil
    end
    if v_u_5 == p_u_60 then
        v_u_55(p_u_60, p_u_61, v_u_62)
        for v63, _ in pairs(v_u_17) do
            if v_u_17[v63] then
                v_u_17[v63]:Destroy()
                v_u_17[v63] = nil
            end
        end
        for _, v_u_64 in ipairs(v_u_4:GetPlayers()) do
            if v_u_64 ~= v_u_5 then
                local v65 = v_u_64.Character
                if v65 and v65:IsDescendantOf(workspace) then
                    local v66 = v_u_5:GetAttribute("Team")
                    local v67 = v_u_64:GetAttribute("Team")
                    if v66 == v67 and workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                        v_u_48(v_u_64, v65, v67)
                        if v_u_16[v_u_64] then
                            v_u_16[v_u_64]:Add(function()
                                local v68 = v_u_64
                                if v_u_17[v68] then
                                    v_u_17[v68]:Destroy()
                                    v_u_17[v68] = nil
                                end
                            end)
                        end
                    end
                end
            end
        end
    else
        local v69 = p_u_60:GetAttribute("Team")
        local v70 = v69 == "Counter-Terrorists" and Color3.fromRGB(0, 75, 200) or (v69 == "Terrorists" and Color3.fromRGB(255, 220, 50) or Color3.fromRGB(255, 255, 255))
        v_u_62:Add(function()
            v_u_14.cleanup(p_u_60)
        end)
        local v71 = workspace:GetAttribute("Gamemode")
        if v_u_5:GetAttribute("Team") == v69 and v71 ~= "Deathmatch" then
            local v_u_72 = v_u_62:Add(v_u_12.new(p_u_61, {
                ["DepthMode"] = Enum.HighlightDepthMode.Occluded,
                ["FillColor"] = Color3.fromRGB(255, 255, 255),
                ["OutlineColor"] = v70,
                ["OutlineTransparency"] = 0.75,
                ["FillTransparency"] = 0.95
            }))
            v_u_62:Add(v_u_10.observeAttribute(p_u_61, "Invincible", function(p73)
                v_u_72:UpdateState(p73 or false)
                return function()
                    v_u_72:UpdateState(false)
                    v_u_72:Destroy()
                end
            end))
            v_u_72.Janitor:Add(v_u_3.Heartbeat:Connect(function()
                if p_u_61 and p_u_61:IsDescendantOf(workspace) then
                    local v74 = p_u_61:GetAttribute("Invincible")
                    v_u_72:UpdateState(v74 or false)
                    if not v74 then
                        v_u_72:Destroy()
                    end
                end
            end))
            v_u_48(p_u_60, p_u_61, v69)
            v_u_62:Add(function()
                local v75 = p_u_60
                if v_u_17[v75] then
                    v_u_17[v75]:Destroy()
                    v_u_17[v75] = nil
                end
            end)
        end
        if v_u_5:GetAttribute("IsSpectating") and not v_u_7.GetCurrentSpectateInstance() then
            v_u_7.Next()
        end
    end
    return function()
        v_u_62:Destroy()
    end
end)