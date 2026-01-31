local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
return function(p3, p4)
    local v5 = 0
    if type(p4) ~= "function" then
        p4 = v_u_2.func.truthy
    end
    for v6, v7 in ipairs(p3) do
        if p4(v7, v6, p3) then
            v5 = v5 + 1
        end
    end
    return v5
end