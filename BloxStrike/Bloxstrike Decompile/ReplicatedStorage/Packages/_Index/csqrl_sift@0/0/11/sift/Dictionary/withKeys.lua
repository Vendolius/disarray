return function(p1, ...)
    local v2 = {}
    for _, v3 in ipairs({ ... }) do
        v2[v3] = p1[v3]
    end
    return v2
end