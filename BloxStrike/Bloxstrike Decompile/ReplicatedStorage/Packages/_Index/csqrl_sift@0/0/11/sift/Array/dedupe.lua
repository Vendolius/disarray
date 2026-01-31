local v_u_1 = require(script.Parent.Parent.Set.fromArray)
local v_u_2 = require(script.Parent.Parent.Set.toArray)
return function(p3)
    return v_u_2(v_u_1(p3))
end