return function(p1, p2)
    local v3 = #p1
    local v4 = {}
    if p2 < 1 then
        p2 = p2 + v3
    end
    for v5, v6 in ipairs(p1) do
        if v5 ~= p2 then
            table.insert(v4, v6)
        end
    end
    return v4
end