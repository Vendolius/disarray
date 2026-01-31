return function(p1, p2)
    local v3 = {}
    for v4 = 1, #p1 - (type(p2) ~= "number" and 1 or p2) do
        local v5 = p1[v4]
        table.insert(v3, v5)
    end
    return v3
end