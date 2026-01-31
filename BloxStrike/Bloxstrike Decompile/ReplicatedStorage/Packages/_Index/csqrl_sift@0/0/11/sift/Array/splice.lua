return function(p1, p2, p3, ...)
    local v4 = #p1
    local v5 = {}
    local v6 = type(p2) ~= "number" and 1 or p2
    if type(p3) ~= "number" then
        p3 = v4
    end
    if v6 < 1 then
        v6 = v6 + v4
    end
    if p3 < 1 then
        p3 = p3 + v4
    end
    for v7 = 1, v6 - 1 do
        local v8 = p1[v7]
        table.insert(v5, v8)
    end
    for _, v9 in ipairs({ ... }) do
        table.insert(v5, v9)
    end
    for v10 = p3 + 1, v4 do
        local v11 = p1[v10]
        table.insert(v5, v11)
    end
    return v5
end