return function(p1, p2)
    local v3 = {}
    for _, v4 in ipairs(p1) do
        if v4 ~= p2 then
            table.insert(v3, v4)
        end
    end
    return v3
end