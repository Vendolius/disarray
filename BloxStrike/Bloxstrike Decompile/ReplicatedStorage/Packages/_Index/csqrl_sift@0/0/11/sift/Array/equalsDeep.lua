local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
local function v_u_7(p3, p4)
    if type(p3) ~= "table" or type(p4) ~= "table" then
        return p3 == p4
    end
    local v5 = #p3
    if #p4 ~= v5 then
        return false
    end
    for v6 = 1, v5 do
        if not v_u_7(p3[v6], p4[v6]) then
            return false
        end
    end
    return true
end
return function(...)
    if v_u_2.equalObjects(...) then
        return true
    end
    local v8 = select("#", ...)
    local v9 = select(1, ...)
    for v10 = 2, v8 do
        if not v_u_7(v9, (select(v10, ...))) then
            return false
        end
    end
    return true
end