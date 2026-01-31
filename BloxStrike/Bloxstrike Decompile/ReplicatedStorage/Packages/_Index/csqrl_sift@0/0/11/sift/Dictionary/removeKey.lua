local v_u_1 = require(script.Parent.copy)
return function(p2, p3)
    local v4 = v_u_1(p2)
    v4[p3] = nil
    return v4
end