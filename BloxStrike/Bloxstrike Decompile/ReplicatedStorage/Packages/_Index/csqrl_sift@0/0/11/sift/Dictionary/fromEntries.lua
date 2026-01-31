return function(p1)
    local v2 = {}
    for _, v3 in ipairs(p1) do
        v2[v3[1]] = v3[2]
    end
    return v2
end