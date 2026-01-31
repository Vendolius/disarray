local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u_3 = require(v2.Components.Common.GetWeaponProperties)
local v_u_4 = require(v2.Shared.Janitor)
function v_u_1.getAnimation(p5, p6)
    return p5.Animations[p6]
end
function v_u_1.adjustAnimationSpeed(p7, p8, p9)
    local v10 = p7:getAnimation(p8)
    if v10 then
        v10:AdjustSpeed(v10.Length / p9)
    end
end
function v_u_1.play(p11, p12, ...)
    local v13 = p11:getAnimation(p12)
    p11.CurrentAnimation = p12
    if v13 then
        v13:Play(...)
    end
    return v13
end
function v_u_1.stop(p14, p15, p16)
    local v17 = p14:getAnimation(p15)
    if v17 and v17.IsPlaying then
        v17:Stop(p16)
    end
end
function v_u_1.stopAnimations(p18, p19)
    for _, v20 in pairs(p18.Animations) do
        if v20.IsPlaying then
            v20:Stop(p19 or 0)
        end
    end
end
function v_u_1.unregister(p21, p22)
    if p21.Animations[p22] then
        local v23 = p21.Animations[p22]
        if v23 then
            if v23.IsPlaying then
                v23:Stop()
            end
            v23:Destroy()
            p21.Animations[p22] = nil
        end
        p21.Janitor:Remove(p22)
    end
end
function v_u_1.unregisterGroup(p24, ...)
    for _, v25 in ipairs({ ... }) do
        p24:unregister(v25)
    end
end
function v_u_1.register(p_u_26, p_u_27, p_u_28)
    p_u_26:unregister(p_u_27)
    local v29, v30 = pcall(function()
        return p_u_26.Animator:LoadAnimation(p_u_28)
    end)
    if v29 then
        p_u_26.Animations[p_u_27] = v30
        p_u_26.Janitor:Add(function()
            if not p_u_26.IsDestroyed then
                p_u_26:unregister(p_u_27)
            end
        end, true, p_u_27)
    end
end
function v_u_1.construct(p31)
    if p31.Animator then
        p31:stopAnimations()
        table.clear(p31.Animations)
        p31.Animator = nil
    end
    local v32 = p31.Player.Character
    if v32 and v32:IsDescendantOf(workspace) then
        local v33 = v32:FindFirstChildWhichIsA("Humanoid", true)
        if not v33 then
            warn((("[CharacterAnimator] Failed to find Humanoid for %*"):format(p31.Player.Name)))
            return
        end
        p31.Animator = v33:WaitForChild("Animator", 3)
        if not p31.Animator then
            warn((("[CharacterAnimator] Failed to find Animator for %*"):format(p31.Player.Name)))
            return
        end
        local v34 = v_u_3(p31.Weapon).CharacterAnimations
        for _, v35 in ipairs(v34:GetChildren()) do
            if v35:IsA("Animation") then
                p31:register(v35.Name, v35)
            end
        end
    end
end
function v_u_1.new(p36, p37)
    local v38 = v_u_1
    local v_u_39 = setmetatable({}, v38)
    v_u_39.Janitor = v_u_4.new()
    v_u_39.IsDestroyed = false
    v_u_39.Player = p36
    v_u_39.Animator = nil
    v_u_39.CurrentAnimation = nil
    v_u_39.Weapon = p37
    v_u_39.Animations = {}
    if p36.Character and p36.Character:IsDescendantOf(workspace) then
        v_u_39:construct()
    end
    v_u_39.Janitor:Add(p36.CharacterAdded:Connect(function()
        v_u_39:construct()
    end))
    return v_u_39
end
function v_u_1.destroy(p40)
    if not p40.IsDestroyed then
        p40.IsDestroyed = true
        p40:stopAnimations()
        local v41 = {}
        for v42, _ in pairs(p40.Animations) do
            table.insert(v41, v42)
        end
        for _, v43 in ipairs(v41) do
            p40:unregister(v43)
        end
        for v44, v_u_45 in pairs(p40.Animations) do
            if v_u_45 then
                if v_u_45.IsPlaying then
                    v_u_45:Stop()
                end
                pcall(function()
                    v_u_45:Destroy()
                end)
            end
            p40.Animations[v44] = nil
        end
        table.clear(p40.Animations)
        p40.Player = nil
        p40.Animator = nil
        p40.CurrentAnimation = nil
        p40.Weapon = nil
        p40.Janitor:Destroy()
        p40.Janitor = nil
    end
end
return v_u_1