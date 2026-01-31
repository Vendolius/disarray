require(script.Parent.Parent.Types)
local v_u_1 = require(script.Parent.copy)
return function(p2)
    local v3 = v_u_1(p2)
    table.freeze(v3)
    return v3
end