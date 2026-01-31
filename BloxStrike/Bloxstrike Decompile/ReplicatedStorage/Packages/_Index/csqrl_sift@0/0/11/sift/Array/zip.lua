local v_u_1 = require(script.Parent.reduce)
return function(...)
    local v2 = { ... }
    local v3 = {}
    if select("#", ...) == 0 then
        return v3
    end
    for v7 = 1, v_u_1(v2, function(p4, p5)
        local v6 = #p5
        return math.min(p4, v6)
    end, #v2[1]) do
        local v8 = {}
        for _, v9 in ipairs(v2) do
            local v10 = v9[v7]
            table.insert(v8, v10)
        end
        table.insert(v3, v8)
    end
    return v3
end