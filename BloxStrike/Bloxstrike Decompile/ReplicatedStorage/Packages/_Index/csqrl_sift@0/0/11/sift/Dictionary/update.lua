local v_u_1 = require(script.Parent.copy)
return function(p2, p3, p4, p5)
    local v6 = v_u_1(p2)
    if v6[p3] then
        if p4 then
            v6[p3] = p4(v6[p3], p3)
            return v6
        end
    elseif typeof(p5) == "function" then
        v6[p3] = p5(p3)
    end
    return v6
end