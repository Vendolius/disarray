local v1 = script.Parent.Parent
local v_u_2 = require(v1.None)
return function(...)
    local v3 = {}
    for v4 = 1, select("#", ...) do
        local v5 = select(v4, ...)
        if type(v5) == "table" then
            for v6, v8 in pairs(v5) do
                if v8 == v_u_2 then
                    local v8 = nil
                end
                v3[v6] = v8
            end
        end
    end
    return v3
end