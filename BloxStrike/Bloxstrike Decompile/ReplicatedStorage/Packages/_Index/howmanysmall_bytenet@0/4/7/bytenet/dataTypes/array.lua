local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writeu16
return function(p3)
    local v_u_4 = p3.Write
    local v_u_5 = p3.Read
    return {
        ["Read"] = function(p6, p7)
            local v8 = buffer.readu16(p6, p7)
            local v9 = p7 + 2
            local v10 = table.create(v8)
            for v11 = 1, v8 do
                local v12, v13 = v_u_5(p6, v9)
                v10[v11] = v12
                v9 = v9 + v13
            end
            return v10, v9 - p7
        end,
        ["Write"] = function(p14)
            v_u_2(#p14)
            for _, v15 in p14 do
                v_u_4(v15)
            end
        end
    }
end