return function(p1, p2, p3)
    local v4 = #p1
    if type(p3) == "number" then
        if p3 < 1 then
            p3 = v4 + p3
        end
    else
        p3 = 1
    end
    return table.find(p1, p2, p3)
end