local function v_u_1(_)
    return true
end
return function(p_u_2, p_u_3, p_u_4, p_u_5)
    local v_u_6 = nil
    local v_u_7 = nil
    local v_u_8 = 0
    if p_u_5 == nil then
        p_u_5 = v_u_1
    end
    local function v_u_12()
        if v_u_6 ~= nil then
            task.spawn(v_u_6)
            v_u_6 = nil
        end
        v_u_8 = v_u_8 + 1
        local v_u_9 = v_u_8
        local v_u_10 = p_u_2:GetAttribute(p_u_3)
        if v_u_10 ~= nil and p_u_5(v_u_10) then
            task.spawn(function()
                local v11 = p_u_4(v_u_10)
                if v_u_9 == v_u_8 and v_u_7.Connected then
                    v_u_6 = v11
                else
                    task.spawn(v11)
                end
            end)
        end
    end
    local v_u_13 = p_u_2:GetAttributeChangedSignal(p_u_3):Connect(v_u_12)
    task.defer(function()
        if v_u_13.Connected then
            v_u_12()
        end
    end)
    return function()
        v_u_13:Disconnect()
        if v_u_6 ~= nil then
            task.spawn(v_u_6)
            v_u_6 = nil
        end
    end
end