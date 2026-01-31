return function(p1, p2)
    local v3 = #p1
    local v4 = {}
    for v5 = type(p2) ~= "number" and 2 or p2 + 1, v3 do
        local v6 = p1[v5]
        table.insert(v4, v6)
    end
    return v4
end