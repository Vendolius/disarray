local v_u_1 = require(script.Parent.copy)
return function(p2, p3)
    local v4 = v_u_1(p2)
    table.sort(v4, p3)
    return v4
end