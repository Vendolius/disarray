return function(p1, p2)
    local v3 = {}
    for v4, v5 in ipairs(p1) do
        local v6 = p2(v5, v4, p1)
        if v6 ~= nil then
            table.insert(v3, v6)
        end
    end
    return v3
end