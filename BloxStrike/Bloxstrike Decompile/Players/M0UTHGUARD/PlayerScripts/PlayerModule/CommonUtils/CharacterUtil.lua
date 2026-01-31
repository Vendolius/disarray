local v_u_1 = game:GetService("Players")
local v2 = script.Parent
local v_u_3 = {
    ["LOCAL_PLAYER"] = "LOCAL_PLAYER",
    ["ON_LOCAL_PLAYER"] = "ON_LOCAL_PLAYER",
    ["CHARACTER_ADDED"] = "CHARACTER_ADDED",
    ["ON_CHARACTER"] = "ON_CHARACTER",
    ["CHARACTER_CHILD_ADDED"] = "CHARACTER_CHILD_ADDED"
}
local v_u_23 = {
    ["_connectionUtil"] = require(v2:WaitForChild("ConnectionUtil")).new(),
    ["_boundEvents"] = {},
    ["getLocalPlayer"] = function()
        return v_u_1.LocalPlayer
    end,
    ["onLocalPlayer"] = function(p4)
        local v5 = v_u_23.getLocalPlayer()
        if v5 then
            p4(v5)
        end
        v_u_23._connectionUtil:trackConnection(v_u_3.LOCAL_PLAYER, v_u_1:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
            local v6 = v_u_23.getLocalPlayer()
            assert(v6)
            v_u_23._getOrCreateBoundEvent(v_u_3.LOCAL_PLAYER):Fire(v6)
        end))
        return v_u_23._getOrCreateBoundEvent(v_u_3.LOCAL_PLAYER).Event:Connect(p4)
    end,
    ["getCharacter"] = function()
        local v7 = v_u_23.getLocalPlayer()
        if v7 then
            return v7.Character
        else
            return nil
        end
    end,
    ["onCharacter"] = function(p_u_8)
        v_u_23._connectionUtil:trackConnection(v_u_3.ON_LOCAL_PLAYER, v_u_23.onLocalPlayer(function(p9)
            local v10 = v_u_23.getCharacter()
            if v10 then
                p_u_8(v10)
            end
            v_u_23._connectionUtil:trackConnection(v_u_3.CHARACTER_ADDED, p9.CharacterAdded:Connect(function(p11)
                assert(p11)
                v_u_23._getOrCreateBoundEvent(v_u_3.CHARACTER_ADDED):Fire(p11)
            end))
        end))
        return v_u_23._getOrCreateBoundEvent(v_u_3.CHARACTER_ADDED).Event:Connect(p_u_8)
    end,
    ["getChild"] = function(p12, p13)
        local v14 = v_u_23.getCharacter()
        if v14 then
            local v15 = v14:FindFirstChild(p12)
            if v15 and v15:IsA(p13) then
                return v15
            else
                return nil
            end
        else
            return nil
        end
    end,
    ["onChild"] = function(p_u_16, p_u_17, p_u_18)
        v_u_23._connectionUtil:trackConnection(v_u_3.ON_CHARACTER, v_u_23.onCharacter(function(p19)
            local v20 = v_u_23.getChild(p_u_16, p_u_17)
            if v20 then
                p_u_18(v20)
            end
            v_u_23._connectionUtil:trackConnection(v_u_3.CHARACTER_CHILD_ADDED, p19.ChildAdded:Connect(function(p21)
                if p21.Name == p_u_16 and p21:IsA(p_u_17) then
                    v_u_23._getOrCreateBoundEvent(v_u_3.CHARACTER_CHILD_ADDED .. p_u_16 .. p_u_17):Fire(p21)
                end
            end))
        end))
        return v_u_23._getOrCreateBoundEvent(v_u_3.CHARACTER_CHILD_ADDED .. p_u_16 .. p_u_17).Event:Connect(p_u_18)
    end,
    ["_getOrCreateBoundEvent"] = function(p22)
        if not v_u_23._boundEvents[p22] then
            v_u_23._boundEvents[p22] = Instance.new("BindableEvent")
        end
        return v_u_23._boundEvents[p22]
    end
}
return v_u_23