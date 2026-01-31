local v1 = script.Parent.Parent
local v_u_2 = require(script.Parent.reduce)
local v_u_3 = require(v1.None)
return function(...)
    local v4 = { ... }
    local v5 = {}
    if select("#", ...) == 0 then
        return v5
    end
    for v9 = 1, v_u_2(v4, function(p6, p7)
        local v8 = #p7
        return math.max(p6, v8)
    end, #v4[1]) do
        local v10 = {}
        for _, v11 in ipairs(v4) do
            local v12 = v11[v9]
            if v12 == nil then
                v12 = v_u_3
            end
            table.insert(v10, v12)
        end
        table.insert(v5, v10)
    end
    return v5
end