local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
local v_u_3 = require(script.Parent.copy)
return function(p4, p5, p6, p7)
    local v8 = #p4
    local v9 = v_u_3(p4)
    if p5 < 1 then
        p5 = p5 + v8
    end
    if type(p6) ~= "function" then
        p6 = v_u_2.func.returned
    end
    if v9[p5] ~= nil then
        v9[p5] = p6(v9[p5], p5)
        return v9
    end
    local v10
    if type(p7) == "function" then
        v10 = p7(p5)
    else
        v10 = nil
    end
    v9[p5] = v10
    return v9
end