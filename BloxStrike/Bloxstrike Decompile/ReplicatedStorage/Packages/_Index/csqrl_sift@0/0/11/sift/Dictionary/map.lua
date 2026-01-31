return function(p1, p2)
    local v3 = {}
    for v4, v5 in pairs(p1) do
        local v6, v7 = p2(v5, v4, p1)
        v3[v7 or v4] = v6
    end
    return v3
end