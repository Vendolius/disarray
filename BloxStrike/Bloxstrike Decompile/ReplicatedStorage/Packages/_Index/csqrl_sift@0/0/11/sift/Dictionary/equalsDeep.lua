local v1 = script.Parent.Parent
local v_u_2 = require(v1.Util)
require(v1.Types)
local function v_u_9(p3, p4)
    if type(p3) ~= "table" or type(p4) ~= "table" then
        return p3 == p4
    end
    for v5, v6 in pairs(p3) do
        if not v_u_9(v6, p4[v5]) then
            return false
        end
    end
    for v7, v8 in pairs(p4) do
        if not v_u_9(v8, p3[v7]) then
            return false
        end
    end
    return true
end
return function(...)
    if v_u_2.equalObjects(...) then
        return true
    end
    local v10 = select("#", ...)
    local v11 = select(1, ...)
    for v12 = 2, v10 do
        if not v_u_9(v11, (select(v12, ...))) then
            return false
        end
    end
    return true
end