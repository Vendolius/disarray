local v1 = script.Parent.Parent
local v_u_2 = require(v1.None)
return function(...)
    local v3 = {}
    for v4 = 1, select("#", ...) do
        local v5 = select(v4, ...)
        if type(v5) == "table" then
            for _, v6 in ipairs(v5) do
                if v6 ~= v_u_2 then
                    table.insert(v3, v6)
                end
            end
        end
    end
    return v3
end