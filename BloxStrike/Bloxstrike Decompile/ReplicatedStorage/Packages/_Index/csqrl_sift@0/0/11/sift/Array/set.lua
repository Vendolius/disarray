return function(p1, p2, p3)
    local v4 = #p1
    local v5 = {}
    if p2 < 1 then
        p2 = p2 + v4
    end
    for v6, v7 in ipairs(p1) do
        if v6 == p2 then
            table.insert(v5, p3)
        else
            table.insert(v5, v7)
        end
    end
    return v5
end