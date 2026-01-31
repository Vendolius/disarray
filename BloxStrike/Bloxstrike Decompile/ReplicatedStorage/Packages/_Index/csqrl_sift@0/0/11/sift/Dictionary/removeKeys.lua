local v_u_1 = require(script.Parent.copy)
return function(p2, ...)
    local v3 = v_u_1(p2)
    for _, v4 in ipairs({ ... }) do
        v3[v4] = nil
    end
    return v3
end