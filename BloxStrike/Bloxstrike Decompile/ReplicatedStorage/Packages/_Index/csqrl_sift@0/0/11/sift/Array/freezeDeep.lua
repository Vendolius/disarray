local function v_u_6(p1)
    local v2 = {}
    for v3 = 1, #p1 do
        local v4 = p1[v3]
        if type(v4) == "table" then
            local v5 = v_u_6
            table.insert(v2, v5(v4))
        else
            table.insert(v2, v4)
        end
    end
    table.freeze(v2)
    return v2
end
return v_u_6