return function(p1, p2)
    local v3 = {}
    for v4 = 1, #p1 do
        v3[p1[v4]] = p2[v4]
    end
    return v3
end