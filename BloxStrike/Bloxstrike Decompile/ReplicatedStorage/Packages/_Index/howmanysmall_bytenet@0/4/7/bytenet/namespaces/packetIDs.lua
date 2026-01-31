local v_u_1 = {}
return {
    ["set"] = function(p2, p3)
        v_u_1[p2] = p3
    end,
    ["ref"] = function()
        return v_u_1
    end
}