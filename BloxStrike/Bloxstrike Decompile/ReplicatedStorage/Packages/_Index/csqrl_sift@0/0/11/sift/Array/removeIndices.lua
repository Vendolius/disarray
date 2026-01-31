return function(p1, ...)
    local v2 = #p1
    local v3 = {}
    local v4 = {}
    for _, v6 in ipairs({ ... }) do
        if v6 < 1 then
            local v6 = v6 + v2
        end
        v3[v6] = true
    end
    for v7, v8 in ipairs(p1) do
        if not v3[v7] then
            table.insert(v4, v8)
        end
    end
    return v4
end