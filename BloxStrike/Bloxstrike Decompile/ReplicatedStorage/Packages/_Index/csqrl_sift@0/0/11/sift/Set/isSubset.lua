return function(p1, p2)
    for v3, v4 in pairs(p1) do
        if p2[v3] ~= v4 then
            return false
        end
    end
    return true
end