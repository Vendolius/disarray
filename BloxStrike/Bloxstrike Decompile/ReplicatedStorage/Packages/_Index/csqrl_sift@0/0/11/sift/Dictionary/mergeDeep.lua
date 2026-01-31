local v1 = script.Parent.Parent
local v_u_2 = require(v1.None)
local v_u_3 = require(script.Parent.copyDeep)
local function v_u_10(...)
    local v4 = {}
    for v5 = 1, select("#", ...) do
        local v6 = select(v5, ...)
        if type(v6) == "table" then
            for v7, v8 in pairs(v6) do
                if v8 == v_u_2 then
                    v4[v7] = nil
                elseif type(v8) == "table" then
                    if v4[v7] == nil then
                        ::l12::
                        v4[v7] = v_u_3(v8)
                    else
                        local v9 = v4[v7]
                        if type(v9) ~= "table" then
                            goto l12
                        end
                        v4[v7] = v_u_10(v4[v7], v8)
                    end
                else
                    v4[v7] = v8
                end
            end
        end
    end
    return v4
end
return v_u_10