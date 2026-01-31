return function(p1)
    local v2 = {}
    for v3, v4 in pairs(p1) do
        table.insert(v2, { v3, v4 })
    end
    return v2
end