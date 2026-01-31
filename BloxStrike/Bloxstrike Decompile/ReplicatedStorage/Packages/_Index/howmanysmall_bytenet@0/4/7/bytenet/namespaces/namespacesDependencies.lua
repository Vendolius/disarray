local v_u_1 = nil
local v_u_2 = nil
return {
    ["start"] = function(p3)
        v_u_1 = {}
        v_u_2 = p3
    end,
    ["add"] = function(p4)
        if v_u_1 then
            local v5 = v_u_1
            table.insert(v5, p4)
        end
    end,
    ["currentLength"] = function()
        return v_u_1 and #v_u_1 or 0
    end,
    ["currentName"] = function()
        return v_u_2
    end,
    ["empty"] = function()
        if v_u_1 == nil then
            return {}
        end
        local v6 = v_u_1
        v_u_1 = nil
        return v6
    end
}