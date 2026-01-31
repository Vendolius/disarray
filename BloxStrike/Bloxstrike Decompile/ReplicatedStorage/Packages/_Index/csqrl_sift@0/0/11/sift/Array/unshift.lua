return function(p1, ...)
    local v2 = { ... }
    for _, v3 in ipairs(p1) do
        table.insert(v2, v3)
    end
    return v2
end