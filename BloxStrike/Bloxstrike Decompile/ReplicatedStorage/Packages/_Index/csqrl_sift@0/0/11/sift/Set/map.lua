return function(p1, p2)
    local v3 = {}
    for v4, _ in pairs(p1) do
        local v5 = p2(v4, p1)
        if v5 ~= nil then
            v3[v5] = true
        end
    end
    return v3
end