return function(p1, p2, ...)
    local v3 = #p1
    if p2 < 1 then
        p2 = p2 + (v3 + 1)
    end
    if v3 < p2 then
        if v3 + 1 < p2 then
            return p1
        end
        p2 = v3 + 1
        v3 = v3 + 1
    end
    local v4 = {}
    for v5 = 1, v3 do
        if v5 == p2 then
            for _, v6 in ipairs({ ... }) do
                table.insert(v4, v6)
            end
        end
        local v7 = p1[v5]
        table.insert(v4, v7)
    end
    return v4
end