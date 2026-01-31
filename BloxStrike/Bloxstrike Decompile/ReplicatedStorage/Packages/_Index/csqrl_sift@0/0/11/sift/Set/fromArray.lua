return function(p1)
    local v2 = table.create(#p1)
    for _, v3 in ipairs(p1) do
        v2[v3] = true
    end
    return v2
end