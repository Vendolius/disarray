local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writebool
return function(p3)
    local v_u_4 = p3.Read
    local v_u_5 = p3.Write
    return {
        ["Read"] = function(p6, p7)
            if buffer.readu8(p6, p7) == 0 then
                return nil, 1
            end
            local v8, v9 = v_u_4(p6, p7 + 1)
            return v8, v9 + 1
        end,
        ["Write"] = function(p10)
            local v11 = p10 ~= nil
            v_u_2(v11)
            if v11 then
                v_u_5(p10)
            end
        end
    }
end