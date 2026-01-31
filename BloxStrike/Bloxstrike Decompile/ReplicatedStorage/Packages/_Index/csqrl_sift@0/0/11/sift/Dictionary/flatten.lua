require(script.Parent.Parent.Types)
local function v_u_10(p1, p2)
    local v3 = type(p2) ~= "number" and (1 / 0) or p2
    local v4 = {}
    for v5, v6 in pairs(p1) do
        if type(v6) == "table" and v3 > 0 then
            local v7 = v_u_10(v6, v3 - 1)
            for v8, v9 in pairs(v4) do
                v7[v8] = v9
            end
            v4 = v7
        else
            v4[v5] = v6
        end
    end
    return v4
end
return v_u_10