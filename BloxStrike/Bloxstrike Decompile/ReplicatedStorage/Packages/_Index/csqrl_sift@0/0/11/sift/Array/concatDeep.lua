local v1 = script.Parent.Parent
local v_u_2 = require(script.Parent.copyDeep)
local v_u_3 = require(v1.None)
return function(...)
    local v4 = {}
    for v5 = 1, select("#", ...) do
        local v6 = select(v5, ...)
        if type(v6) == "table" then
            for _, v7 in ipairs(v6) do
                if v7 ~= v_u_3 then
                    if type(v7) == "table" then
                        local v8 = v_u_2
                        table.insert(v4, v8(v7))
                    else
                        table.insert(v4, v7)
                    end
                end
            end
        end
    end
    return v4
end