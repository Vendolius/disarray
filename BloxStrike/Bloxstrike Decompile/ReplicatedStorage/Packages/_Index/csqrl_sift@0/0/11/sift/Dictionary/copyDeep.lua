local function v_u_5(p1)
    local v2 = table.clone(p1)
    for v3, v4 in pairs(p1) do
        if type(v4) == "table" then
            v2[v3] = v_u_5(v4)
        end
    end
    return v2
end
return v_u_5