require(script.Parent.Parent.Types)
local function v_u_5(p1)
    local v2 = {}
    for v3, v4 in pairs(p1) do
        if type(v4) == "table" then
            v2[v3] = v_u_5(v4)
        else
            v2[v3] = v4
        end
    end
    table.freeze(v2)
    return v2
end
return v_u_5