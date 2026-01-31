local function v_u_8(p1, p2)
    local v3 = type(p2) ~= "number" and (1 / 0) or p2
    local v4 = {}
    for _, v5 in ipairs(p1) do
        if type(v5) == "table" and v3 > 0 then
            local v6 = v_u_8(v5, v3 - 1)
            for _, v7 in ipairs(v6) do
                table.insert(v4, v7)
            end
        else
            table.insert(v4, v5)
        end
    end
    return v4
end
return v_u_8