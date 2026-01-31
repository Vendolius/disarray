return function(p1, p2, p3)
    local v4
    if p3 == nil then
        p3 = p1[1]
        v4 = 2
    else
        v4 = 1
    end
    for v5 = v4, #p1 do
        p3 = p2(p3, p1[v5], v5, p1)
    end
    return p3
end