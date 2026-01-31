return function(p1, p2)
    for _, v3 in pairs(p1) do
        if v3 == p2 then
            return true
        end
    end
    return false
end