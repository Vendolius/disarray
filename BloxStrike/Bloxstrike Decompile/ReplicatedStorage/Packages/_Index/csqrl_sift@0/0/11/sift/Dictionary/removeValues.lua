local v1 = script.Parent.Parent
local v_u_2 = require(v1.Array.toSet)
return function(p3, ...)
    local v4 = v_u_2({ ... })
    local v5 = {}
    for v6, v7 in pairs(p3) do
        if not v4[v7] then
            v5[v6] = v7
        end
    end
    return v5
end