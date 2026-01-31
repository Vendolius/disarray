local v_u_1 = require(script.Parent.copy)
return function(p2, p3, p4)
    local v5 = v_u_1(p2)
    v5[p3] = p4
    return v5
end