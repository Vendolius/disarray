local v_u_1 = nil
return {
    ["set"] = function(p2)
        v_u_1 = p2
    end,
    ["get"] = function()
        return v_u_1
    end
}