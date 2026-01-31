require(script.Parent.Parent.types)
local v_u_1 = {
    ["Write"] = function() end,
    ["Read"] = function()
        return nil, 0
    end
}
return function()
    return v_u_1
end