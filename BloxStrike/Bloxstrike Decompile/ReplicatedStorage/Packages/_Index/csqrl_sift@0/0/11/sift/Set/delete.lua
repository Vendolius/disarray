return function(p1, ...)
    local v2 = {}
    for v3, _ in pairs(p1) do
        v2[v3] = true
    end
    for _, v4 in ipairs({ ... }) do
        v2[v4] = nil
    end
    return v2
end