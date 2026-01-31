local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u_3 = require(v2.Shared.Janitor)
local v_u_4 = v2:WaitForChild("Assets"):WaitForChild("CharacterAnimations")
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
        return v13
    end
    local v14 = {}
    for v15, _ in pairs(p11.Animations) do
        table.insert(v14, v15)
    end
    return nil
end
function v_u_1.stop(p16, p17, ...)
    local v18 = p16:getAnimation(p17)
    if v18 and v18.IsPlaying then
        v18:Stop(...)
    end
end
function v_u_1.stopAnimations(p19)
    for _, v20 in pairs(p19.Animations) do
        if v20.IsPlaying then
            v20:Stop()
        end
    end
end
function v_u_1.unregister(p21, p22)
    if p21.Animations[p22] then
        local v23 = p21.Animations[p22]
        if v23.IsPlaying then
            v23:Stop()
        end
        if p21.Janitor then
            p21.Janitor:Remove(p22)
        end
        v23:Destroy()
        p21.Animations[p22] = nil
    end
end
function v_u_1.unregisterGroup(p24, ...)
    for _, v25 in ipairs({ ... }) do
        p24:unregister(v25)
    end
end
function v_u_1.register(p_u_26, p27, p_u_28)
    p_u_26:unregister(p27)
    local v29, v30 = pcall(function()
        return p_u_26.Animator:LoadAnimation(p_u_28)
    end)
    if v29 then
        p_u_26.Animations[p27] = v30
        p_u_26.Janitor:Add(v30, "Destroy", p27)
    end
end
function v_u_1.construct(p31, p32)
    local v33 = p32:FindFirstChildOfClass("Humanoid")
    if not v33 then
        local v34 = tick()
        repeat
            task.wait(0.1)
            v33 = p32:FindFirstChildOfClass("Humanoid")
        until v33 or tick() - v34 > 5
    end
    if v33 then
        p31.Animator = v33:WaitForChild("Animator")
        for _, v35 in ipairs(v_u_4:GetDescendants()) do
            if v35:IsA("Animation") then
                p31:register(v35.Name, v35)
            end
        end
    end
end
function v_u_1.new(p36)
    local v37 = v_u_1
    local v38 = setmetatable({}, v37)
    v38.Janitor = v_u_3.new()
    v38.IsDestroyed = false
    v38.Animator = nil
    v38.CurrentAnimation = nil
    v38.Animations = {}
    v38:construct(p36)
    return v38
end
function v_u_1.destroy(p39)
    if not p39.IsDestroyed then
        p39.IsDestroyed = true
        p39:stopAnimations()
        local v40 = {}
        for v41, _ in pairs(p39.Animations) do
            table.insert(v40, v41)
        end
        for _, v42 in ipairs(v40) do
            p39:unregister(v42)
        end
        for v43, v_u_44 in pairs(p39.Animations) do
            if v_u_44 then
                if v_u_44.IsPlaying then
                    v_u_44:Stop()
                end
                pcall(function()
                    v_u_44:Destroy()
                end)
            end
            p39.Animations[v43] = nil
        end
        table.clear(p39.Animations)
        if p39.Janitor then
            p39.Janitor:Destroy()
            p39.Janitor = nil
        end
        p39.CurrentAnimation = nil
        p39.Animator = nil
    end
end
return v_u_1