local v_u_1 = require(script.Parent.toSet)
return function(p2, ...)
    local v3 = v_u_1({ ... })
    local v4 = {}
    for _, v5 in ipairs(p2) do
        if not v3[v5] then
            table.insert(v4, v5)
        end
    end
    return v4
end