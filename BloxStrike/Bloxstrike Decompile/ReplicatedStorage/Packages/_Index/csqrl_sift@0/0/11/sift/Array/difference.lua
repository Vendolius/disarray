require(script.Parent.Parent.Types)
local v_u_1 = require(script.Parent.toSet)
local v_u_2 = require(script.Parent.Parent.Set.toArray)
local v_u_3 = require(script.Parent.Parent.Set.difference)
return function(p4, ...)
    local v5 = v_u_1(p4)
    local v6 = {}
    for _, v7 in { ... } do
        if typeof(v7) == "table" then
            local v8 = v_u_1
            table.insert(v6, v8(v7))
        end
    end
    return v_u_2((v_u_3(v5, unpack(v6))))
end